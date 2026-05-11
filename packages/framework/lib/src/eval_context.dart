import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';
import 'package:equatable/equatable.dart';

import 'backend/agent.dart';
import 'scenario.dart';

/// Immutable configuration for a single eval run.
///
/// Built by [EvalSet] before each eval run and passed into [Eval.execute].
/// Holds the resolved resources — agent (pre-stamped with the correct model),
/// scenario, sandbox, and MCP tools — that remain constant throughout the
/// lifecycle.
///
/// Mutable execution state (messages, output, store) lives on [EvalState].
class EvalContext extends Equatable {
  /// The agent for this eval run, pre-stamped with the correct model.
  final Agent agent;

  /// The scenario being run.
  final Scenario scenario;

  /// The sandbox environment for this eval, or `null` for sandbox-free evals.
  final SandboxEnvironment? sandbox;

  /// Tools resolved from [Scenario.mcpServers] by [EvalSet].
  ///
  /// These are merged with scenario/eval/sandbox tools onto [EvalState.tools]
  /// by [Eval.execute]. Eval authors never read this field directly.
  final List<ai.Tool> mcpTools;

  const EvalContext({
    required this.agent,
    this.scenario = baselineScenario,
    this.sandbox,
    this.mcpTools = const [],
  });

  @override
  List<Object?> get props => [agent, scenario, sandbox];
}
