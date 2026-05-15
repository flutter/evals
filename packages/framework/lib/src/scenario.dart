import 'package:ai/ai.dart' as ai;
import 'package:equatable/equatable.dart';

import 'backend/backend.dart' show McpServerConfig;
import 'evaluator.dart';

/// Default [Scenario] used when no scenario is configured.
const baselineScenario = Scenario(name: 'baseline');

/// A named variation axis for evaluation runs.
///
/// A [Scenario] represents a specific configuration of tools and skills
/// that evals are run under. When an [EvalSet] defines multiple scenarios,
/// each eval is run once per scenario, allowing comparison of how different
/// capabilities affect performance.
///
/// ## Tools
///
/// Tools can be provided statically via [tools] or lazily via [mcpServers].
/// MCP servers are started by the framework before each eval cell and their
/// tools are merged into the same pool — the eval never sees the difference.
///
/// ## Evaluators
///
/// Scenario-level [evaluators] are merged with eval-level evaluators at
/// scoring time. Use this for capability-specific scoring (e.g. "did the
/// model call the MCP tool?") that only makes sense under certain scenarios.
///
/// ```dart
/// final scenarios = [
///   const Scenario(name: 'baseline'),
///   Scenario(
///     name: 'with_mcp',
///     mcpServers: [McpServerConfig(command: 'dart', args: ['mcp-server'])],
///     evaluators: [McpToolUsageEvaluator(requiredTools: ['dart-mcp-server/pub_dev_search'])],
///   ),
/// ];
/// ```
class Scenario extends Equatable {
  /// Display name for this scenario (used in logs and directory names).
  final String name;

  /// Paths to agent skill directories available in this scenario.
  final List<String> skillPaths;

  /// Additional tools available in this scenario.
  final List<ai.Tool> tools;

  /// MCP server configurations to start for this scenario.
  ///
  /// The framework starts each server before the eval runs, collects the
  /// tools, and closes the server after the eval completes. The resulting
  /// tools are merged with [tools] and any eval-level tools onto
  /// [EvalState.tools].
  final List<McpServerConfig> mcpServers;

  /// Evaluators that grade capability-specific concerns.
  ///
  /// Merged with [Eval.evaluators] at scoring time. Use this for scorers
  /// that are only relevant when certain tools are available (e.g.
  /// [McpToolUsageEvaluator]).
  final List<Evaluator> evaluators;

  /// Tags for filtering or grouping scenarios in analysis.
  final List<String> tags;

  const Scenario({
    required this.name,
    this.skillPaths = const [],
    this.tools = const [],
    this.mcpServers = const [],
    this.evaluators = const [],
    this.tags = const [],
  });

  @override
  List<Object?> get props => [name];

  @override
  String toString() => 'Scenario($name)';
}
