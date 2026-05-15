import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';

import '../eval_state.dart';
import '../evaluator.dart';
import 'grading_templates.dart';

/// Uses an LLM to grade the agent's output against a rubric.
///
/// The evaluator sends the eval's input, target, and the agent's output
/// to a grading model and parses a structured score from the response.
///
/// This is the dart-evals equivalent of Inspect AI's `model_graded_qa()`
/// and Harbor RewardKit's `llm_as_judge` criterion.
///
/// ## Basic usage
///
/// ```dart
/// ModelGradedEvaluator(
///   ai: genkitAI,
///   model: 'googleai/gemini-2.5-flash',
///   rubric: 'Is this idiomatic Dart? Consider naming, null safety, and docs.',
/// )
/// ```
///
/// ## Custom template
///
/// ```dart
/// ModelGradedEvaluator(
///   ai: genkitAI,
///   model: 'googleai/gemini-2.5-flash',
///   rubric: 'Does the code correctly implement the feature?',
///   template: codeQualityTemplate,
/// )
/// ```
///
/// ## Partial credit
///
/// When [allowPartialCredit] is `true` (default), the grader can return any
/// score between 0.0 and 1.0 (e.g. `GRADE: 0.7`). When `false`, any score
/// less than 1.0 is treated as `0.0`.
class ModelGradedEvaluator extends Evaluator {
  /// The AI provider used to call the grading model.
  final ai.AI graderAI;

  /// The model identifier for the grader (e.g. `'googleai/gemini-2.5-flash'`).
  ///
  /// This can (and often should) differ from the model being evaluated.
  /// Using a different model avoids self-grading bias.
  final String model;

  /// Free-text instructions for the grading model.
  ///
  /// This is inserted into the prompt template as `{rubric}`. It should
  /// describe what constitutes a correct, partial, or incorrect answer
  /// for this specific eval.
  ///
  /// Example:
  /// ```
  /// 'The answer should recommend fl_chart or syncfusion_flutter_charts.
  ///  It should explain why the package is a good fit for the use case.'
  /// ```
  final String rubric;

  /// The prompt template to use for grading.
  ///
  /// The template should contain the following placeholders:
  /// - `{question}` — the eval's input prompt
  /// - `{target}` — the eval's expected answer
  /// - `{answer}` — the model's actual output
  /// - `{rubric}` — the grading rubric
  ///
  /// Defaults to [defaultGradingTemplate]. See also [factCheckTemplate]
  /// and [codeQualityTemplate] for specialized templates.
  final String template;

  /// Whether to allow partial credit (grades between 0.0 and 1.0).
  ///
  /// When `false`, any grade less than 1.0 is treated as 0.0.
  final bool allowPartialCredit;

  /// Override for [Evaluator.name].
  ///
  /// Useful when using multiple `ModelGradedEvaluator` instances in the
  /// same eval (e.g. one for correctness, one for code quality).
  final String? evaluatorName;

  const ModelGradedEvaluator({
    required this.graderAI,
    required this.model,
    required this.rubric,
    this.template = defaultGradingTemplate,
    this.allowPartialCredit = true,
    this.evaluatorName,
  });

  @override
  String get name => evaluatorName ?? 'ModelGradedEvaluator';

  @override
  Future<Score> evaluate(EvalState state) async {
    final question = state.context.scenario.name != 'baseline'
        ? '${_evalInput(state)} [Scenario: ${state.context.scenario.name}]'
        : _evalInput(state);
    final target = _evalTarget(state);
    final answer = state.outputText ?? '<no output>';

    // Build the grading prompt from the template.
    final prompt = fillTemplate(template, {
      'question': question,
      'target': target.isEmpty ? '(no specific target provided)' : target,
      'answer': answer,
      'rubric': rubric,
    });

    try {
      final response = await graderAI.generate(
        model: model,
        messages: [ai.Message.text(ai.Role.user, prompt)],
      );

      final graderOutput = response.text ?? '';
      return _parseGrade(graderOutput, answer);
    } catch (e) {
      return Score.error(
        explanation: 'Grading model call failed: $e',
      );
    }
  }

  /// Extracts the eval input from state.
  ///
  /// Prefers `state.store['input']` (set by `Eval.execute()`), falling
  /// back to the first user message in the history.
  String _evalInput(EvalState state) {
    // Prefer the stored input (set by Eval.execute before scoring).
    final stored = state.store['input'];
    if (stored is String && stored.isNotEmpty) return stored;

    // Fallback: walk messages.
    for (final message in state.messages) {
      if (message.role == ai.Role.user) {
        return message.text ?? '';
      }
    }
    return '';
  }

  /// Extracts the eval target from state.
  ///
  /// Reads `state.store['target']` which is set by `Eval.execute()`
  /// before the scoring phase.
  String _evalTarget(EvalState state) {
    final stored = state.store['target'];
    return stored is String ? stored : '';
  }

  /// Parses the grading model's response into a [Score].
  ///
  /// Looks for `GRADE: <number>` at the start of a line. Everything after
  /// the grade line is treated as the explanation.
  Score _parseGrade(String graderOutput, String answer) {
    // Match numbers like 1.0, 0.5, 0, 1
    final gradePattern = RegExp(r'GRADE:\s*([0-9]*\.?[0-9]+)', caseSensitive: false);
    final match = gradePattern.firstMatch(graderOutput);

    if (match == null) {
      // The grader didn't follow the format — return an error with the
      // raw output so the user can debug the template.
      return Score.error(
        answer: answer,
        explanation: 'Could not parse grade from grader output. '
            'Raw response:\n$graderOutput',
      );
    }

    final gradeString = match.group(1)!;
    final parsedGrade = double.tryParse(gradeString);

    if (parsedGrade == null || parsedGrade < 0.0 || parsedGrade > 1.0) {
      return Score.error(
        answer: answer,
        explanation: 'Parsed invalid grade "$gradeString". Must be a number '
            'between 0.0 and 1.0. Raw: $graderOutput',
      );
    }

    // Extract explanation: everything after the GRADE line.
    final explanationStart = match.end;
    var explanation = graderOutput.substring(explanationStart).trim();
    if (explanation.isEmpty) {
      explanation = 'Grader assigned score $parsedGrade.';
    }

    if (!allowPartialCredit && parsedGrade < 1.0) {
      return Score.incorrect(
        answer: answer,
        explanation: '$explanation\n(Grade was $parsedGrade, but partial '
            'credit is disabled → rounded to 0.0)',
      );
    }

    if (parsedGrade == 1.0) {
      return Score.correct(answer: answer, explanation: explanation);
    } else if (parsedGrade == 0.0) {
      return Score.incorrect(answer: answer, explanation: explanation);
    } else {
      return Score.partial(parsedGrade, answer: answer, explanation: explanation);
    }
  }
}
