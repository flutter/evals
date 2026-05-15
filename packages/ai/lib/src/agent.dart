import 'message.dart';
import 'result.dart';
import 'tool.dart';

export 'agent_config.dart';
export 'agent_status.dart';
export 'result.dart';

/// Base class for agents that can be run in the eval framework.
///
/// Provides the minimal contract needed by the eval matrix runner:
/// a [model] identifier, [copyWith] for per-cell stamping, and [run]
/// to execute the agent.
///
/// ## Implementations
///
/// - [BasicAgent] — single-turn: sends the task, returns the response.
/// - [MiniSweAgent] — multi-turn: runs a full tool-calling loop.
/// - `GeminiCliAgent` — process-based: spawns a CLI inside a sandbox.
abstract class Agent {
  const Agent();

  /// The model identifier (e.g. `'googleai/gemini-2.5-flash'`).
  String get model;

  /// Returns a copy of this agent with [model] replaced.
  ///
  /// Used by `EvalSet` to stamp in a per-cell model without mutating the
  /// original instance — keeping [Agent] immutable.
  Agent copyWith({String? model});

  /// Run the agent.
  ///
  /// [task] is the user's coding task.
  /// [systemMessage] is the system prompt.
  /// [additionalTools] are tools available to SDK-based agents;
  ///   process-based agents that manage their own tool access may ignore this.
  /// [history] is a list of previous messages (e.g. from previous steps)
  ///   that should be prepended to this run's conversation.
  ///
  /// Returns a [Result] with the trajectory, exit status, and usage.
  Future<Result> run({
    required String task,
    String systemMessage,
    List<Tool> additionalTools = const [],
    List<Message> history = const [],
  });
}
