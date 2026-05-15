import 'package:test/test.dart';
import 'package:devals_sandbox/sandbox.dart';

void main() {
  group('ExecResult', () {
    test('success is true when exitCode is 0', () {
      final result = ExecResult(exitCode: 0, stdout: 'ok', stderr: '');
      expect(result.success, isTrue);
    });

    test('success is false when exitCode is non-zero', () {
      final result = ExecResult(exitCode: 1, stdout: '', stderr: 'error');
      expect(result.success, isFalse);
    });

    test('success is false for negative exit code', () {
      final result = ExecResult(exitCode: -1);
      expect(result.success, isFalse);
    });

    test('toString truncates long output', () {
      final longOutput = 'x' * 500;
      final result = ExecResult(exitCode: 0, stdout: longOutput);
      final str = result.toString();
      expect(str, contains('...'));
      expect(str.length, lessThan(longOutput.length));
    });

    test('toString preserves short output', () {
      final result = ExecResult(exitCode: 0, stdout: 'hello');
      expect(result.toString(), contains('hello'));
      expect(result.toString(), isNot(contains('...')));
    });

    test('defaults for stdout and stderr', () {
      final result = ExecResult(exitCode: 0);
      expect(result.stdout, equals(''));
      expect(result.stderr, equals(''));
    });
  });
}
