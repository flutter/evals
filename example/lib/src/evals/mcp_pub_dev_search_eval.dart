import 'package:framework/framework.dart';

/// Single-turn eval: search pub.dev for a Flutter package.
///
/// Ported from `dash_evals/dataset/tasks/mcp_pub_dev_search` sample
/// `mcp_search_charts`.
///
/// Evaluators:
/// - [IncludesEvaluator] — eval-level; always active; checks the answer text.
/// - [McpToolUsageEvaluator] — scenario-level (on `with_mcp`); verifies the
///   model called `pub_dev_search`. Only applies when MCP is available.
///
/// Under `baseline`, the model answers from training data.
/// Under `with_mcp`, the model has access to `pub_dev_search`.
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
  List<Evaluator> get evaluators => [IncludesEvaluator(target)];

  // No setUp, run, or cleanUp overrides needed.
  // The framework resolves tools and calls agent.run() automatically.
}
