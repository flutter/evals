import '../agent.dart';
import '../ai.dart';
import '../message.dart';
import '../role.dart';
import '../tool.dart';
import 'prompts.dart';

/// A single-turn agent — sends the task and returns the response.
///
/// Unlike [MiniSweAgent], this agent does not run a tool-calling loop.
/// It makes one `generate()` call and returns the result. Useful for
/// evaluating single-turn capabilities (e.g. code generation without
/// iteration).
class BasicAgent extends Agent {
  /// The AI provider for model calls.
  final AI ai;

  /// The model identifier (e.g. `'googleai/gemini-2.5-flash'`).
  @override
  final String model;

  /// Tools to provide to the model.
  final List<Tool> tools;

  /// Configuration for this agent run.
  final AgentConfig config;

  /// Creates a [BasicAgent].
  const BasicAgent({
    required this.ai,
    required this.model,
    required this.tools,
    this.config = const AgentConfig(),
  });

  @override
  BasicAgent copyWith({String? model}) =>
      BasicAgent(
        ai: ai,
        model: model ?? this.model,
        tools: tools,
        config: config,
      );

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

    final response = await ai.generate(
      model: model,
      messages: messages,
      tools: [...tools, ...additionalTools],
    );

    // Append the model's response to the conversation history.
    if (response.message != null) {
      messages.add(response.message!);
    }

    return Result(
      messages: messages,
      status: AgentStatus.completed,
      steps: 1,
      usage: response.usage,
    );
  }
}
