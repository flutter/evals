/// Comprehensive stress-test of the dart-evals framework.
///
/// This file exercises every major surface of the framework in a single,
/// runnable example:
///
/// ## Evals
/// - [FlutterFeatureEval]  — parameterised agent eval graded by `flutter test`
/// - [DartFixEval]         — agent eval graded by `dart analyze`
/// - [ContextReadEval]     — single-turn eval graded by output content
///
/// ## Evaluators
/// - [ExecEvaluator.flutterTest]  — built-in: run `flutter test` in sandbox
/// - [ExecEvaluator.dartAnalyze]  — built-in: run `dart analyze --fatal-warnings`
/// - [TrajectoryEvaluator]        — custom: inspect store metadata (steps, status)
/// - [OutputContainsEvaluator]    — custom: regex/substring match on outputText
///
/// ## Framework features
/// - [EvalSet] with multiple [models], [scenarios], and [evals]
/// - [Scenario] with and without additional tools
/// - [MiniSweAgent] with [AgentConfig] tuning
/// - [SandboxTools.all] wired into the agent
/// - [EvalContext.store] used for trajectory logging and downstream grading
/// - [Score.partial] for graduated scores
/// - Richly documented [main] that prints a formatted result summary
///
/// Run from the `example/` directory:
///   dart run lib/example.dart
library;

import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';
