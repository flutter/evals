import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';

import '../eval_state.dart';
import '../evaluator.dart';
import 'grading_templates.dart';
import 'model_graded_evaluator.dart';

/// Runs multiple [ModelGradedEvaluator]s and takes the majority vote.
///
/// This is the dart-evals equivalent of Inspect AI's multi-model grading,
/// where the same grading prompt is sent to N models and the most common
/// grade wins. This reduces grading variance and bias from any single model.
///
/// ## Usage
///
/// ```dart
/// MajorityVoteEvaluator(
///   graders: [
///     (ai: geminiAI, model: 'googleai/gemini-2.5-flash'),
///     (ai: anthropicAI, model: 'anthropic/claude-sonnet-4'),
///   ],
///   rubric: 'Is this idiomatic Dart?',
/// )
/// ```
///
/// ## Aggregation
///
/// The evaluator averages the numeric scores from all valid graders. If
/// [allowPartialCredit] is false, any average below 1.0 is rounded down to 0.0.
class MajorityVoteEvaluator extends Evaluator {
  /// The grading model configurations.
  ///
  /// Each entry specifies an [ai.AI] provider and model identifier.
  /// The same rubric and template are used for all graders.
  final List<({ai.AI ai, String model})> graders;

  /// The grading rubric — see [ModelGradedEvaluator.rubric].
  final String rubric;

  /// The prompt template — see [ModelGradedEvaluator.template].
  final String template;

  /// Whether to allow partial credit.
  ///
  /// If false, an aggregated score < 1.0 will be treated as 0.0.
  final bool allowPartialCredit;

  /// Override for [Evaluator.name].
  final String? evaluatorName;

  const MajorityVoteEvaluator({
    required this.graders,
    required this.rubric,
    this.template = defaultGradingTemplate,
    this.allowPartialCredit = true,
    this.evaluatorName,
  });

  @override
  String get name => evaluatorName ?? 'MajorityVoteEvaluator';

  @override
  Future<Score> evaluate(EvalState state) async {
    if (graders.isEmpty) {
      return Score.error(explanation: 'No graders configured.');
    }

    // Run all graders in parallel.
    final evaluators = graders
        .map(
          (g) => ModelGradedEvaluator(
            graderAI: g.ai,
            model: g.model,
            rubric: rubric,
            template: template,
            allowPartialCredit: allowPartialCredit,
          ),
        )
        .toList();

    final scores = await Future.wait(
      evaluators.map((e) => e.evaluate(state)),
    );

    // Filter out errors — don't let a failed grader veto the result.
    final validScores = scores.where((s) => !s.isError).toList();

    if (validScores.isEmpty) {
      return Score.error(
        explanation: 'All ${scores.length} graders failed. '
            'Errors:\n${scores.map((s) => s.explanation).join('\n')}',
      );
    }

    final total = validScores.length;
    final averageValue =
        validScores.map((s) => s.value).reduce((a, b) => a + b) / total;

    final voteSummary = 'Scores: '
        '${validScores.map((s) => s.value.toStringAsFixed(2)).join(', ')} '
        '→ Average: ${averageValue.toStringAsFixed(2)}';

    // Collect all explanations for transparency.
    final explanations = <String>[];
    for (var i = 0; i < scores.length; i++) {
      final s = scores[i];
      final model = graders[i].model;
      final gradeStr = s.isError ? 'ERROR' : s.value.toStringAsFixed(2);
      explanations.add('[$model → $gradeStr] ${s.explanation ?? ''}');
    }

    var explanation = '$voteSummary\n${explanations.join('\n')}';
    final answer = validScores.first.answer;

    if (!allowPartialCredit && averageValue < 1.0) {
      return Score.incorrect(
        answer: answer,
        explanation: '$explanation\n(Average was $averageValue, but partial '
            'credit is disabled → rounded to 0.0)',
      );
    }

    if (averageValue == 1.0) {
      return Score.correct(answer: answer, explanation: explanation);
    } else if (averageValue == 0.0) {
      return Score.incorrect(answer: answer, explanation: explanation);
    } else {
      return Score.partial(averageValue, answer: answer, explanation: explanation);
    }
  }
}
