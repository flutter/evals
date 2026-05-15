import 'package:evals_results/evals_results.dart';

import 'eval_state.dart';

/// Base class for evaluation scorers.
///
/// An [Evaluator] grades the [EvalContext] returned by [Eval.run]. It has
/// access to the full conversation history, model output, store data,
/// and sandbox environment.
///
/// Evaluators are declared on [Eval.evaluators] and/or
/// [Scenario.evaluators]. The framework merges both lists at scoring time
/// and uses [name] as the key in the score map.
///
/// **Important:** If the same `Evaluator` type appears in both eval-level
/// and scenario-level lists, their [name]s must differ — otherwise the
/// framework throws an [ArgumentError] to prevent silent overwrites.
/// Override [name] to disambiguate:
///
/// ```dart
/// class MyEvaluator extends Evaluator {
///   @override
///   String get name => 'my_custom_name';
///   // ...
/// }
/// ```
abstract class Evaluator {
  const Evaluator();

  /// The key used for this evaluator's score in the result map.
  ///
  /// Defaults to `runtimeType.toString()`. Override to disambiguate when
  /// multiple instances of the same evaluator type are used in a single
  /// eval (e.g. one eval-level and one scenario-level).
  String get name => runtimeType.toString();

  /// Evaluate the result captured in [state].
  Future<Score> evaluate(EvalState state);
}
