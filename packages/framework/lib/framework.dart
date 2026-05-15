/// The dart-evals framework — run LLM evaluations across models, scenarios,
/// and sandboxed environments.
///
/// Import this library to access [Eval], [EvalSet], [EvalState], [Scenario],
/// [Evaluator], and the built-in sandbox tools.
///
/// ## Quick start
///
/// ```dart
/// import 'package:framework/framework.dart';
///
/// class MyEval extends Eval {
///   @override String get name => 'my_eval';
///   @override String get input => 'What is 2 + 2?';
///   @override List<Evaluator> get evaluators => [MyEvaluator()];
/// }
///
/// void main() async {
///   final result = await runEvals(EvalSet(
///     models: [Model('googleai', 'gemini-2.5-flash')],
///     evals: [MyEval()],
///     config: EvalConfig(cacheDir: '.devals-cache'),
///   ));
/// }
/// ```
library;

// Agent — re-exported from package:ai.
export 'package:ai/agents.dart';
export 'src/util/observation.dart';

// Backends — the integration points.
// Most authors don't need these; EvalSet auto-resolves from Model.provider.
export 'src/backend/backend.dart';
export 'src/backend/genkit_backend/genkit_backend.dart';
export 'src/backend/cli_backend/gemini_cli_backend.dart';

// Core
export 'src/eval.dart';
export 'src/eval_config.dart';
export 'src/eval_context.dart';
export 'src/eval_set.dart';
export 'src/eval_state.dart';
export 'src/run_evals.dart';
export 'src/scenario.dart';
export 'src/evaluator.dart';

// Built-in evaluators
export 'src/evaluators/exec_evaluator.dart';
export 'src/evaluators/grading_templates.dart';
export 'src/evaluators/includes_evaluator.dart';
export 'src/evaluators/majority_vote_evaluator.dart';
export 'src/evaluators/mcp_tool_usage_evaluator.dart';
export 'src/evaluators/model_graded_evaluator.dart';

// Tools
export 'src/tools/mcp_tools.dart';
export 'src/tools/sandbox_tools.dart';

// Logging
export 'src/logging/ansi.dart';
export 'src/logging/eval_log.dart';

// Output
export 'src/output/result_writer.dart';
export 'src/output/sandbox_code_saver.dart';

// Re-export the ai package for framework-agnostic primitives.
export 'package:ai/ai.dart';
