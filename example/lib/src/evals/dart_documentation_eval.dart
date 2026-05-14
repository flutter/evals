import 'package:framework/framework.dart';

/// Single-turn, non-sandbox eval: explain a Dart language concept.
///
/// This eval exercises the **minimal** framework path:
/// - No sandbox (no setUp, no cleanUp)
/// - No custom `run` override — uses the default [Eval.run]
/// - No tools
/// - Scored with built-in evaluators only
///
/// It runs under all scenarios. Under `baseline`, the model answers from
/// training data. Under `with_mcp`, the model has access to `pub_dev_search`
/// but shouldn't need it for a language question.
///
/// ## Features exercised:
/// - Default [Eval.run] (no override)
/// - [IncludesEvaluator] — checks for key concept
/// - `Eval.target`
/// - No sandbox, no tools
class DartDocumentationEval extends Eval {
  @override
  String get name => 'dart_documentation';

  @override
  String get input =>
      'Explain how Dart\'s sound null safety works. Include an example of '
      'using the `late` keyword and explain when you would use it versus '
      'making a field nullable.';

  @override
  String get target =>
      'Sound null safety ensures variables are non-null by default. '
      'The late keyword defers initialization while preserving non-nullability.';

  @override
  String get systemMessage =>
      'You are a Dart language expert. Provide clear, accurate explanations '
      'with code examples. Be concise but thorough.';

  @override
  List<Evaluator> get evaluators => [
        const IncludesEvaluator('late'),
        const IncludesEvaluator('null safety'),
        const IncludesEvaluator('?'),
      ];

  // No setUp, run, or cleanUp overrides needed.
  // The framework calls agent.run() automatically.
}
