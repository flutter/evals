import 'agent_config.dart';
import 'ai.dart';
import 'result.dart';
import 'tool.dart';

export 'agent_config.dart';
export 'agent_status.dart';
export 'result.dart';

/// Base class for AI agents that run a generate→execute loop.
///
/// An [Agent] receives a task, uses an [AI] provider to call a model, and
/// optionally executes tool calls in a loop until the model produces a
/// text-only response or hits the step limit.
///
/// ## Implementations
///
/// - [BasicAgent] — single-turn: sends the task, returns the response.
/// - [MiniSweAgent] — multi-turn: runs a full tool-calling loop.
abstract class Agent {
  /// The AI provider for model calls.
  final AI ai;

  /// The model identifier (e.g. `'googleai/gemini-2.5-flash'`).
  final String model;

  /// Tools to provide to the model.
  final List<Tool> tools;

  /// Configuration for this agent run.
  final AgentConfig config;

  /// Creates an [Agent].
  const Agent({
    required this.ai,
    required this.model,
    required this.tools,
    this.config = const AgentConfig(),
  });

  /// Returns a copy of this agent with the given fields replaced.
  ///
  /// Used by `EvalSet` to stamp in a per-cell model without mutating the
  /// original instance — keeping [Agent] immutable.
  Agent copyWith({AI? ai, String? model, AgentConfig? config});

  /// Run the agent loop.
  ///
  /// [task] is the user's coding task (becomes the first user message).
  /// [systemMessage] is the system prompt (defaults to a built-in prompt).
  /// [additionalTools] are appended to [tools] for this run only.
  ///
  /// Returns a [Result] with the full trajectory, exit status, and
  /// token usage.
  Future<Result> run({
    required String task,
    String systemMessage,
    List<Tool> additionalTools = const [],
  });
}
