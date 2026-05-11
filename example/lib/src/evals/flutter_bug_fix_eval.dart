import 'package:framework/framework.dart';
import 'package:example/src/evaluators/trajectory_evaluator.dart';

/// Agentic eval: fix a BLoC state-mutation bug in a Flutter shopping cart app.
///
/// Ported from `dash_evals/dataset/tasks/flutter_bug_fix` sample
/// `flutter_bloc_cart_mutation_001`. The buggy project is a Flutter BLoC app
/// where `CartBloc` mutates the internal list of an Equatable state object
/// instead of creating a new copy, causing the UI to not update.
///
/// The agent must:
/// 1. Explore the codebase
/// 2. Identify the mutable-list mutation in `cart_bloc.dart`
/// 3. Fix it (emit new state with a new list)
/// 4. Verify with `flutter test` and `dart analyze`
class FlutterBugFixEval extends Eval {
  @override
  String get name => 'flutter_bug_fix';

  @override
  String get input =>
      'Users report that the shopping cart total displays \$0.00 even after '
      'adding items to the cart. The add-to-cart button seems to work (no '
      'crash), but the UI never updates to reflect the new items or total.\n\n'
      'The project is at /workspace/app. Please find and fix the bug.';

  @override
  String get target =>
      'Fix is to create new state objects instead of mutating the list in-place.';

  @override
  String get systemMessage => '''
You are an expert Flutter developer debugging a production issue.

Your task is to:

1. Explore the codebase to understand the structure
2. Identify the root cause of the bug
3. Fix the bug by editing the necessary file(s)
4. Verify your fix passes any tests and static analysis. Be sure to run
   dart analyze in the directory containing the pubspec.yaml for the
   package you modified, not the workspace root.
5. If there are any errors or warnings at all, fix them.
6. When done, provide a brief explanation of what you fixed.
''';

  @override
  List<Evaluator> get evaluators => [
    ExecEvaluator.flutterTest(),
    ExecEvaluator.dartAnalyze(),
    const TrajectoryEvaluator(),
  ];

  /// Provisions the buggy cart project into the sandbox.
  @override
  Future<EvalState> setUp(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      throw StateError(
        '$name requires a sandbox. Configure a SandboxManager in your EvalSet.',
      );
    }

    // Copy fixture files into the sandbox workspace.
    // The fixture is at example/fixtures/flutter_bug_fix_project/ on the host.
    // We assume the Docker image pre-copies fixtures to /fixtures/ (see Dockerfile).
    await sandbox.exec(
      ['bash', '-c', 'cp -r /fixtures/flutter_bug_fix_project/* /workspace/app/'],
      timeout: const Duration(seconds: 30),
    );

    // Install dependencies.
    await sandbox.exec(
      ['flutter', 'pub', 'get'],
      cwd: '/workspace/app',
      timeout: const Duration(minutes: 2),
    );

    return state;
  }

  @override
  Future<EvalState> run(EvalState state) async {
    // state.tools already has sandbox tools — auto-injected by the framework.
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
}
