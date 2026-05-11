import 'package:framework/framework.dart';

/// Single-turn eval: search pub.dev for a Flutter package.
///
/// Ported from `dash_evals/dataset/tasks/mcp_pub_dev_search` sample
/// `mcp_search_charts`.
///
/// Evaluators are eval-level, not scenario-level:
/// - [IncludesEvaluator] — always active; checks the answer text.
/// - [McpToolUsageEvaluator] — always active; scores 0 in `baseline`
///   (MCP unavailable → model cannot call `pub_dev_search`) and 1 in
///   `with_mcp` (MCP available → model should call `pub_dev_search`).
///
/// The [Scenario] layer is responsible only for supplying the MCP server;
/// it does not own any grading criteria for this eval.
///
/// Under `baseline`, the model answers from training data.
/// Under `with_mcp`, the model has access to `pub_dev_search`.
/// Both scenarios are scored with [IncludesEvaluator]; only `with_mcp`
/// additionally scores with [McpToolUsageEvaluator].
class PubDevSearchEval extends Eval {
  PubDevSearchEval({required this.input, required this.target});

  @override
  String get name => 'pub_dev_search';

  @override
  final String input;

  @override
  final String target;

  @override
  String get systemMessage =>
      'Find the best Flutter package for the described use case. '
      'Use any tools available to you.';

  @override
  List<Evaluator> get evaluators => [
        IncludesEvaluator(target),
        const McpToolUsageEvaluator(requiredTools: ['dart/pub_dev_search']),
      ];

  // No setUp, run, or cleanUp overrides needed.
  // The framework resolves tools and calls agent.run() automatically.
}
