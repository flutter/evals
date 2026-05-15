import 'dart:io';

import 'package:framework/framework.dart';
import 'package:example/src/evaluators/code_quality_evaluator.dart';
import 'package:example/src/evaluators/file_changed_evaluator.dart';
import 'package:example/src/evaluators/output_contains_evaluator.dart';
import 'package:example/src/evaluators/trajectory_evaluator.dart';

/// The original content of `lib/main.dart` in the feature request fixture.
final _originalMainDart = File(
  'fixtures/flutter_feature_request/lib/main.dart',
).readAsStringSync();

/// Agentic eval: add a "Reset" button to a Flutter counter app.
///
/// The fixture at `fixtures/flutter_feature_request` is a standard counter
/// app. Tests exist that expect a reset button with tooltip "Reset" that
/// sets the counter back to 0. The agent must add this feature.
///
/// ## Features exercised:
/// - Feature-addition (not bug-fixing)
/// - `ExecEvaluator.flutterTest()`
/// - `ExecEvaluator.dartAnalyze()`
/// - `OutputContainsEvaluator` — first usage
/// - `FileChangedEvaluator` — new evaluator
/// - `CodeQualityEvaluator` — new graduated scorer
/// - `TrajectoryEvaluator`
/// - Custom `setUp`, `run`, `cleanUp`
/// - `saveCode: true` — verify the saved project is runnable
class FlutterFeatureEval extends Eval {
  @override
  String get name => 'flutter_feature';

  @override
  String get input =>
      'The Flutter counter app at /workspace/app needs a new feature: '
      'a "Reset" button that sets the counter back to 0.\n\n'
      'Requirements:\n'
      '- Add a button with tooltip "Reset"\n'
      '- Tapping it should reset the counter to 0\n'
      '- All existing tests must continue to pass\n'
      '- New tests already exist that validate the reset behavior\n\n'
      'Please implement this feature.';

  @override
  String get target =>
      'Add a FloatingActionButton or IconButton with tooltip "Reset" that '
      'calls setState to set _counter = 0.';

  @override
  String get systemMessage => '''
You are an expert Flutter developer implementing a feature request.

Your task is to:
1. Explore the project at /workspace/app
2. Read the existing tests to understand what's expected
3. Implement the reset button feature
4. Run `flutter test` and `dart analyze` to verify
5. Explain what you implemented
''';

  @override
  List<Evaluator> get evaluators => [
        ExecEvaluator.flutterTest(),
        ExecEvaluator.dartAnalyze(),
        const CodeQualityEvaluator(maxExpectedSteps: 10),
        FileChangedEvaluator(
          filePath: '/workspace/app/lib/main.dart',
          originalContent: _originalMainDart,
        ),
        const OutputContainsEvaluator('reset', description: 'reset button'),
        const TrajectoryEvaluator(maxExpectedSteps: 10),
      ];

  @override
  Future<EvalState> setUp(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      throw StateError(
        '$name requires a sandbox. Configure a SandboxManager in your EvalSet.',
      );
    }

    await sandbox.exec(
      [
        'bash',
        '-c',
        'cp -r /fixtures/flutter_feature_request/* /workspace/app/',
      ],
      timeout: const Duration(seconds: 30),
    );

    await sandbox.exec(
      ['flutter', 'pub', 'get'],
      cwd: '/workspace/app',
      timeout: const Duration(minutes: 2),
    );

    return state;
  }

  @override
  Future<EvalState> run(EvalState state) async {
    final result = await state.agent.run(
      task: input,
      systemMessage: systemMessage,
      additionalTools: state.tools,
    );

    state.store['trajectory'] = result.toJson();
    state.store['steps'] = result.steps;
    state.store['agent_status'] = result.status.name;
    state.store['agent_error'] = result.error;
    state.store['total_tokens'] = result.usage?.totalTokens;

    state.output = result;

    return state;
  }

  @override
  Future<EvalState> cleanUp(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox != null) {
      try {
        final finalContent = await sandbox.readFile(
          '/workspace/app/lib/main.dart',
        );
        state.store['final_main_dart'] = finalContent;
      } catch (_) {
        // Best effort.
      }
    }
    return state;
  }
}
