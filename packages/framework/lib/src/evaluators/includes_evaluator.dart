import 'package:evals_results/evals_results.dart';

import '../eval_state.dart';
import '../evaluator.dart';

/// Grades an eval by checking whether [EvalState.outputText] contains
/// a [target] string.
///
/// This is the most fundamental "does the model mention X" scorer.
/// Ported from Inspect AI's `includes(ignore_case=True)`.
///
/// ```dart
/// class MyEval extends Eval {
///   @override String get target => 'fl_chart';
///   @override List<Evaluator> get evaluators => [
///     IncludesEvaluator(target),
///   ];
/// }
/// ```
class IncludesEvaluator extends Evaluator {
  /// The target string to search for in the output.
  final String target;

  /// Whether to compare case-insensitively (default: `true`).
  final bool ignoreCase;

  const IncludesEvaluator(this.target, {this.ignoreCase = true});

  @override
  Future<Score> evaluate(EvalState state) async {
    final output = state.outputText ?? '';

    final matched = ignoreCase
        ? output.toLowerCase().contains(target.toLowerCase())
        : output.contains(target);

    final truncated =
        output.length > 200 ? '${output.substring(0, 200)}…' : output;

    return matched
        ? Score.correct(
            answer: truncated,
            explanation: 'Output contains "$target".',
          )
        : Score.incorrect(
            answer: truncated,
            explanation: 'Output does NOT contain "$target".',
          );
  }
}
