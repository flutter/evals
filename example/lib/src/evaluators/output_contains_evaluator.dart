import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';

/// Grades an eval by checking that [EvalContext.outputText] matches a pattern.
///
/// Useful for single-turn evals where the model should acknowledge a specific
/// concept or phrase in its final response.
class OutputContainsEvaluator extends Evaluator {
  /// The pattern to search for in the output text.
  final Pattern pattern;

  /// Human-readable description of what we're looking for.
  final String description;

  const OutputContainsEvaluator(this.pattern, {required this.description});

  @override
  Future<Score> evaluate(EvalState state) async {
    final output = state.outputText ?? '';

    final matched = switch (pattern) {
      RegExp re => re.hasMatch(output),
      String s => output.toLowerCase().contains(s.toLowerCase()),
      _ => false,
    };

    return matched
        ? Score.correct(
            answer: output.length > 100
                ? '${output.substring(0, 100)}…'
                : output,
            explanation: 'Output contains "$description".',
          )
        : Score.incorrect(
            answer: output.length > 100
                ? '${output.substring(0, 100)}…'
                : output,
            explanation: 'Output does NOT contain "$description".',
          );
  }
}
