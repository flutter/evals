import 'package:ai/ai.dart' as ai;

import 'backend/agent.dart';
import 'eval_context.dart';

/// Mutable execution state for a single eval run.
///
/// Passed through every lifecycle method: [Eval.setUp], [Eval.run],
/// and [Eval.cleanUp]. Eval authors access the pre-configured agent via
/// [agent], record results into [output], and use [store]
/// for arbitrary per-run metadata.
class EvalState {
  EvalState({required this.context}) : startedAt = DateTime.now();

  /// The immutable configuration for this run (agent, scenario, sandbox, etc.)
  final EvalContext context;

  /// The agent for this run, pre-stamped with the correct model.
  Agent get agent => context.agent;

  /// All tools available to this eval run.
  ///
  /// Populated by [Eval.execute] before [Eval.run] with the merged set of:
  /// - Eval-level static tools
  /// - Scenario-level static tools
  /// - MCP server tools (from [Scenario.mcpServers])
  /// - Sandbox tools (auto-injected when a sandbox is present)
  ///
  /// The default [Eval.run] passes these to [Agent.run] automatically.
  List<ai.Tool> tools = [];

  /// Conversation history, pre-seeded by [Eval.execute] with system + user messages.
  final List<ai.Message> messages = [];

  /// The result of an agentic run (multi-turn).
  ///
  /// Set this from inside [Eval.run] when using an [Agent] subclass.
  Result? output;

  final DateTime startedAt;

  /// Arbitrary per-eval key-value store.
  final Map<String, dynamic> store = {};

  /// The text of the model's final response.
  String? get outputText => output?.outputText;
}
