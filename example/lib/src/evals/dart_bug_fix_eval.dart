import 'dart:io';

import 'package:framework/framework.dart';
import 'package:example/src/evaluators/code_quality_evaluator.dart';
import 'package:example/src/evaluators/file_changed_evaluator.dart';
import 'package:example/src/evaluators/trajectory_evaluator.dart';

/// The original content of `lib/sort.dart` in the fixture.
///
/// Used by [FileChangedEvaluator] to verify the agent modified this file.
final _originalSortDart = File(
  'fixtures/dart_cli_project/lib/sort.dart',
).readAsStringSync();

/// Agentic eval: fix a duplicate-dropping bug in a Dart CLI sort function.
///
/// The fixture project at `fixtures/dart_cli_project` contains a `sortIntegers`
/// function that converts the input list to a Set (losing duplicates) before
/// sorting. The tests check for duplicate preservation and will fail.
///
/// The agent must:
/// 1. Explore the project
/// 2. Run `dart test` (sees failures)
/// 3. Find the Set-based bug in `lib/sort.dart`
/// 4. Fix it to preserve duplicates
/// 5. Verify with `dart test` + `dart analyze`
///
/// ## Features exercised:
/// - `ExecEvaluator.dartTest()` — first usage in the example
/// - `ExecEvaluator.dartAnalyze()`
/// - `FileChangedEvaluator` — new evaluator
/// - `CodeQualityEvaluator.dart()` — new graduated scorer
/// - `TrajectoryEvaluator` — step budget tracking
/// - Custom `setUp`, `run`, `cleanUp`
/// - `EvalState.store` metadata
class DartBugFixEval extends Eval {
  @override
  String get name => 'dart_bug_fix';

  @override
  String get input =>
      'The project at /workspace/app has a bug in its sort function. '
      'Users report that duplicate values are silently dropped when sorting. '
      'For example, sorting [3, 1, 4, 1, 5] returns [1, 3, 4, 5] instead of '
      '[1, 1, 3, 4, 5].\n\n'
      'Please find and fix the bug, then verify your fix with tests.';

  @override
  String get target =>
      'Replace the Set-based sorting with a List-based sort to preserve duplicates.';

  @override
  String get systemMessage => '''
You are an expert Dart developer debugging a library.

Your task is to:
1. Explore the project structure at /workspace/app
2. Run the tests to see the failures
3. Read the source code to identify the bug
4. Fix the bug
5. Run `dart test` and `dart analyze` to verify your fix
6. When done, explain what you fixed and why
''';

  @override
  List<Evaluator> get evaluators => [
        ExecEvaluator.dartTest(),
        ExecEvaluator.dartAnalyze(),
        const CodeQualityEvaluator.dart(maxExpectedSteps: 10),
        FileChangedEvaluator(
          filePath: '/workspace/app/lib/sort.dart',
          originalContent: _originalSortDart,
        ),
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

    // Copy fixture into sandbox.
    await sandbox.exec(
      ['bash', '-c', 'cp -r /fixtures/dart_cli_project/* /workspace/app/'],
      timeout: const Duration(seconds: 30),
    );

    // Install dependencies.
    await sandbox.exec(
      ['dart', 'pub', 'get'],
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
    // Record the final file content in the store for post-analysis.
    final sandbox = state.context.sandbox;
    if (sandbox != null) {
      try {
        final finalContent = await sandbox.readFile(
          '/workspace/app/lib/sort.dart',
        );
        state.store['final_sort_dart'] = finalContent;
      } catch (_) {
        // Best effort — don't fail cleanUp.
      }
    }
    return state;
  }
}
