import 'eval_result.dart';
import 'eval_set_result.dart';
import 'evaluator_summary.dart';
import 'utils/string_util.dart';

/// Builds an [EvalSetResult] from a list of [EvalResult]s.
///
/// Aggregates results, computes evaluator summaries, and produces a
/// serialisable [EvalSetResult].
///
/// ```dart
/// final setResult = buildEvalSetResult(results, startedAt, completedAt);
/// ```
EvalSetResult buildEvalSetResult(
  List<EvalResult> results,
  DateTime startedAt,
  DateTime completedAt,
) {
  final summaries = _aggregateScores(results);
  final evalNames = results.map((e) => e.evalName).toSet().join(', ');
  final models = results.map((e) => e.model).toList();

  return EvalSetResult(
    name: evalNames,
    runId: randomId(),
    models: models,
    evaluators: results.expand((e) => e.scores.keys).toSet().toList(),
    results: results,
    summaries: summaries,
    startedAt: startedAt,
    completedAt: completedAt,
  );
}

/// Aggregate per-eval scores into per-evaluator summary metrics.
List<EvaluatorSummary> _aggregateScores(List<EvalResult> results) {
  final byEvaluator = <String, List<double>>{};
  for (final result in results) {
    result.scores.forEach((key, score) {
      byEvaluator.putIfAbsent(key, () => []).add(score.value);
    });
  }

  return [
    for (final entry in byEvaluator.entries)
      EvaluatorSummary(
        name: entry.key,
        scored: entry.value.length,
        metrics: [
          EvaluatorMetric(
            name: 'mean',
            value: entry.value.reduce((a, b) => a + b) / entry.value.length,
          ),
        ],
      ),
  ];
}
