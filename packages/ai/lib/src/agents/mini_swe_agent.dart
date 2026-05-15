import '../agent.dart';
import '../ai.dart';
import '../message.dart';
import '../parts.dart';
import '../role.dart';
import '../tool.dart';
import '../usage.dart';
import 'prompts.dart';

/// An agent that behaves like mini-swe-agent.
///
/// Runs a generate→execute loop: the model receives a coding task and
/// tools (typically bash, read_file, write_file), generates tool calls to
/// explore and modify the codebase, and continues until it produces a
/// text-only response (no tool calls) or hits the step limit.
///
/// This agent is decoupled from any specific AI provider via the [AI]
/// interface.
///
/// ## Usage with dart-evals
///
/// ```dart
/// @override
/// Future<EvalState> run(EvalState state) async {
///   final agent = MiniSweAgent(
///     ai: state.ai,
///     model: state.model,
///     tools: state.tools,
///   );
///
///   final result = await agent.run(task: state.input);
///
///   state.store['trajectory'] = result.toJson();
///   state.store['steps'] = result.steps;
///   return state;
/// }
/// ```
///
/// ## How the loop works
///
/// 1. Build initial messages (system + user task).
/// 2. Call `ai.generate()` with `returnToolRequests: true` so we control
///    the loop ourselves.
/// 3. If the model returns tool requests → execute them via the registered
///    tools, append results to the message history, and loop.
/// 4. If the model returns a text-only response → the agent is done.
/// 5. If the step limit is reached → stop and report.
class MiniSweAgent extends Agent {
  /// The AI provider for model calls.
  final AI ai;

  /// The model identifier (e.g. `'googleai/gemini-2.5-flash'`).
  @override
  final String model;

  /// Tools to provide to the model.
  final List<Tool> tools;

  /// Configuration for this agent run.
  final AgentConfig config;

  /// Creates a [MiniSweAgent].
  const MiniSweAgent({
    required this.ai,
    required this.model,
    required this.tools,
    this.config = const AgentConfig(),
  });

  @override
  MiniSweAgent copyWith({String? model}) => MiniSweAgent(
    ai: ai,
    model: model ?? this.model,
    tools: tools,
    config: config,
  );

  /// Run the agent loop.
  ///
  /// [task] is the user's coding task (becomes the first user message).
  /// [systemMessage] is the system prompt (defaults to [defaultSystemMessage]).
  /// [additionalTools] are appended to [tools] for this run only.
  /// [history] are previous messages (e.g. from previous steps).
  ///
  /// Returns a [Result] with the full trajectory, exit status, and
  /// token usage.
  @override
  Future<Result> run({
    required String task,
    String systemMessage = defaultSystemMessage,
    List<Tool> additionalTools = const [],
    List<Message> history = const [],
  }) async {
    final messages = <Message>[
      ...history,
      if (systemMessage.isNotEmpty) Message.text(Role.system, systemMessage),
      Message.text(Role.user, task),
    ];

    final allTools = [...tools, ...additionalTools];
    var usage = const Usage.zero();
    var steps = 0;
    var status = AgentStatus.running;
    String? errorMessage;

    while (status == AgentStatus.running) {
      // Check step limit before generating.
      if (config.maxSteps > 0 && steps >= config.maxSteps) {
        status = AgentStatus.maxStepsReached;
        break;
      }

      try {
        steps++;
        final response = await ai.generate(
          model: model,
          messages: messages,
          tools: allTools,
          returnToolRequests: true,
        );

        // Track token usage.
        usage += response.usage;

        // Append the model's response message to history.
        if (response.message != null) {
          messages.add(response.message!);
        }

        // Check if the model made tool requests.
        final toolRequests = response.toolRequests;
        if (toolRequests.isEmpty) {
          // No tool calls → the model is done.
          status = AgentStatus.completed;
          break;
        }

        // Execute each tool request and build tool response messages.
        final toolResponseParts = <ToolResponsePart>[];
        for (final toolRequest in toolRequests) {
          final output = await _executeTool(toolRequest, allTools);
          toolResponseParts.add(
            ToolResponsePart(
              name: toolRequest.name,
              ref: toolRequest.ref,
              output: output,
            ),
          );
        }

        // Append tool responses as a single tool-role message.
        messages.add(Message(role: Role.tool, content: toolResponseParts));
      } catch (e) {
        status = AgentStatus.error;
        errorMessage = e.toString();
        break;
      }
    }

    return Result(
      messages: messages,
      status: status,
      steps: steps,
      usage: usage,
      error: errorMessage,
    );
  }

  /// Execute a single tool request by finding the matching tool and
  /// invoking it.
  ///
  /// If the tool is not found or execution fails, returns an error string
  /// so the model can see the error and recover.
  Future<dynamic> _executeTool(
    ToolRequestPart toolRequest,
    List<Tool> allTools,
  ) async {
    // Find the tool by name.
    final tool = allTools.where((t) => t.name == toolRequest.name).firstOrNull;
    if (tool == null) {
      return 'Error: Unknown tool "${toolRequest.name}". '
          'Available tools: ${allTools.map((t) => t.name).join(', ')}';
    }

    try {
      return await tool.run(toolRequest.input);
    } catch (e) {
      return 'Error executing tool "${toolRequest.name}": $e';
    }
  }
}
