/// Comprehensive stress-test of the dart-evals framework.
///
/// This library exports all example evals, evaluators, and utilities
/// used in the example evaluation suite.
///
/// ## Evals
/// - [PubDevSearchEval]      — single-turn, tool-agnostic package search
/// - [FlutterBugFixEval]     — agentic sandbox eval (BLoC mutation bug)
/// - [DartBugFixEval]        — agentic sandbox eval (Dart CLI sort bug)
/// - [FlutterFeatureEval]    — agentic sandbox eval (add reset button)
/// - [DartDocumentationEval] — single-turn, no-sandbox knowledge eval
///
/// ## Custom Evaluators
/// - [TrajectoryEvaluator]      — inspect agent trajectory metadata
/// - [OutputContainsEvaluator]  — regex/substring match on outputText
/// - [FileChangedEvaluator]     — verify agent modified a specific file
/// - [CodeQualityEvaluator]     — graduated Score.partial with weighted checks
///
/// ## Framework features exercised
/// - [EvalSet] with multiple models (Google AI + Anthropic)
/// - [Scenario] with and without MCP tools
/// - Scenario-level evaluators
/// - [ExecEvaluator.dartTest], [ExecEvaluator.flutterTest], [ExecEvaluator.dartAnalyze]
/// - [IncludesEvaluator], [McpToolUsageEvaluator]
/// - Custom setUp / run / cleanUp lifecycle
/// - [EvalState.store] metadata for trajectory + file diffs
/// - [Score.partial] for graduated scoring
/// - `saveCode: true` for full project persistence
///
/// Run from the repo root:
///   dart run example/bin/dash_evals_port.dart
library;

// Evals
export 'src/evals/dart_bug_fix_eval.dart';
export 'src/evals/dart_documentation_eval.dart';
export 'src/evals/flutter_bug_fix_eval.dart';
export 'src/evals/flutter_feature_eval.dart';
export 'src/evals/mcp_pub_dev_search_eval.dart';

// Evaluators
export 'src/evaluators/code_quality_evaluator.dart';
export 'src/evaluators/file_changed_evaluator.dart';
export 'src/evaluators/output_contains_evaluator.dart';
export 'src/evaluators/trajectory_evaluator.dart';
