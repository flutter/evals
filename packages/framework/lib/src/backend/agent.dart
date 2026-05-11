import 'package:ai/ai.dart' as ai;
import 'package:ai/agents.dart' as ai show Result;

// Re-export ai types that are part of the public agent API.
export 'package:ai/agents.dart' show AgentConfig, AgentStatus, Result;
export 'package:ai/ai.dart' show Usage;

/// Contract for an agent that can be run in the eval framework.
///
/// The two primary strategies are:
/// - [SdkAgentAdapter] — wraps an [ai.Agent] that calls a model SDK directly
///   and owns the tool-calling loop. Runs *outside* the sandbox.
/// - Process agents (e.g. [GeminiCliAgent]) — spawn a CLI process *inside*
///   the sandbox and delegate the full agent loop to it.
///
/// Both strategies implement the same [run] contract. The eval framework
/// (matrix runner, scoring, logging) is identical regardless of which
/// strategy is used.
///
/// ## Construction
///
/// Eval authors do **not** construct agents directly. The [Backend]
/// builds the appropriate agent for each matrix cell via
/// [Backend.buildCellAgent].
abstract class Agent {
  const Agent();

  /// The model identifier (e.g. `'googleai/gemini-2.5-flash'`).
  ///
  /// Used by [EvalSet] to stamp the correct model per matrix cell and by
  /// [EvalResult] for identification.
  String get model;

  /// Returns a copy of this agent with [model] replaced.
  ///
  /// Used internally by connectors to stamp in a per-cell model without
  /// mutating the original instance — keeping [Agent] immutable.
  Agent copyWith({String? model});

  /// Run the agent.
  ///
  /// [task] is the user's coding task.
  /// [systemMessage] is the system prompt.
  /// [additionalTools] are tools available to SDK-based agents;
  ///   process-based agents that manage their own tool access may ignore this.
  ///
  /// Returns a [Result] with the trajectory, exit status, and usage.
  Future<ai.Result> run({
    required String task,
    String systemMessage = '',
    List<ai.Tool> additionalTools = const [],
  });
}
