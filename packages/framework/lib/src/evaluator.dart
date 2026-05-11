import 'package:evals_results/evals_results.dart';

import 'eval_state.dart';

/// Base class for evaluation scorers.
///
/// An [Evaluator] grades the [EvalContext] returned by [Eval.run]. It has
/// access to the full conversation history, model output, store data,
/// and sandbox environment.
///
/// Evaluators are declared on [Eval.evaluators] and run by the framework
/// after [Eval.run] completes — do NOT call evaluators from inside `run()`.
///
/// ```dart
/// class ExactMatchEvaluator extends Evaluator {
///   const ExactMatchEvaluator();
///
///   @override
///   Future<Score> evaluate(Context context) async {
///     final output = context.outputText ?? '';
///     final correct = output.trim() == context.target.trim();
///     return correct
///         ? ScoreConstructors.correct()
///         : ScoreConstructors.incorrect();
///   }
/// }
/// ```
abstract class Evaluator {
  const Evaluator();

  /// Evaluate the result captured in [context].
  Future<Score> evaluate(EvalState state);
}
