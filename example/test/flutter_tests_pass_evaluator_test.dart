/// Unit tests for [ExecEvaluator].
///
/// Uses a handwritten [_FakeSandboxEnvironment] that returns a configurable
/// [ExecResult], avoiding any Docker dependency.
///
/// Run:
///   dart test test/flutter_tests_pass_evaluator_test.dart
library;

import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';
import 'package:framework/framework.dart';
import 'package:test/test.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeSandboxEnvironment implements SandboxEnvironment {
  final ExecResult _result;

  _FakeSandboxEnvironment(this._result);

  @override
  Future<ExecResult> exec(
    List<String> cmd, {
    String? input,
    String? cwd,
    Map<String, String>? env,
    String? user,
    Duration? timeout,
  }) async => _result;

  @override
  Future<String> readFile(String path) async => '';

  @override
  Future<List<int>> readFileBytes(String path) async => [];

  @override
  Future<void> writeFile(String path, String contents) async {}

  @override
  Future<void> writeFileBytes(String path, List<int> bytes) async {}

  @override
  Future<bool> fileExists(String path) async => false;

  @override
  Future<List<String>> listDirectory(String path) async => [];

  @override
  Future<void> deleteFile(String path, {bool recursive = false}) async {}

  @override
  Future<void> dispose() async {}
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

// A no-op agent for tests that only care about sandbox state.
class _MockAgent implements Agent {
  @override
  final String model = 'mock/model';

  @override
  _MockAgent copyWith({String? model}) => this;

  @override
  Future<Result> run({
    required String task,
    String systemMessage = '',
    List<ai.Tool> additionalTools = const [],
  }) =>
      throw UnimplementedError();
}

/// Builds an [EvalState] pre-seeded with a model message, with an optional
/// sandbox environment wired into the context.
EvalState _stateWith(SandboxEnvironment? sandbox) {
  final context = EvalContext(
    agent: _MockAgent(),
    sandbox: sandbox,
  );
  final state = EvalState(context: context);
  state.messages.add(
    ai.Message(role: ai.Role.model, content: [ai.TextPart('done')]),
  );
  return state;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  final evaluator = ExecEvaluator.flutterTest();

  group('FlutterTestsPassEvaluator', () {
    test('returns correct (1.0) when flutter test exits 0', () async {
      final state = _stateWith(
        _FakeSandboxEnvironment(
          ExecResult(exitCode: 0, stdout: 'All tests passed.', stderr: ''),
        ),
      );

      final score = await evaluator.evaluate(state);

      expect(score.value, 1.0);
      expect(score.answer, contains('exit 0'));
    });

    test('returns incorrect (0.0) when flutter test exits non-zero', () async {
      final state = _stateWith(
        _FakeSandboxEnvironment(
          ExecResult(exitCode: 1, stdout: 'FAILED: 2 tests', stderr: ''),
        ),
      );

      final score = await evaluator.evaluate(state);

      expect(score.value, 0.0);
      expect(score.answer, contains('exit 1'));
      expect(score.explanation, contains('FAILED'));
    });

    test('returns incorrect (0.0) when no sandbox is available', () async {
      final state = _stateWith(null); // no sandbox

      final score = await evaluator.evaluate(state);

      expect(score.value, 0.0);
      expect(score.explanation, contains('No sandbox'));
    });

    test('includes stdout in explanation on failure', () async {
      const failOutput = 'Expected: "Reset"\n  Actual: <not found>';
      final state = _stateWith(
        _FakeSandboxEnvironment(
          ExecResult(exitCode: 1, stdout: failOutput, stderr: ''),
        ),
      );

      final score = await evaluator.evaluate(state);

      expect(score.explanation, contains('Expected'));
    });
  });
}
