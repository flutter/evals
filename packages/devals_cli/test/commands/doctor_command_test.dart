import 'dart:io';

import 'package:devals/src/commands/doctor_command.dart';
import 'package:test/test.dart';

/// Creates a mock [ProcessRunner] that returns predefined results.
///
/// [responses] maps `'executable args'` keys to [ProcessResult] values.
/// Any unmatched call throws a [ProcessException].
ProcessRunner mockProcessRunner(Map<String, ProcessResult> responses) {
  return (String executable, List<String> args) async {
    final key = '$executable ${args.join(' ')}'.trim();
    if (responses.containsKey(key)) {
      return responses[key]!;
    }
    throw ProcessException(executable, args, 'not found', -1);
  };
}

ProcessResult _ok(String stdout) => ProcessResult(0, 0, stdout, '');

ProcessResult _fail([String stderr = '']) => ProcessResult(0, 1, '', stderr);

void main() {
  final mockRunner = mockProcessRunner({});

  group('buildChecks', () {
    test('returns 8 checks', () {
      final checks = buildChecks(processRunner: mockRunner);
      expect(checks.length, 8);
    });
  });

  group('Dart SDK check', () {
    test('succeeds with version', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'dart --version': _ok('Dart SDK version: 3.10.1 (stable)'),
        }),
      );
      final result = await checks[0].check();
      expect(result.status, CheckStatus.ok);
      expect(result.version, '3.10.1');
    });

    test('fails when not found', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[0].check();
      expect(result.status, CheckStatus.error);
      expect(result.fix, contains('dart.dev'));
    });
  });

  group('Python check', () {
    test('succeeds with 3.13', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'python3 --version': _ok('Python 3.13.2'),
        }),
      );
      final result = await checks[1].check();
      expect(result.status, CheckStatus.ok);
      expect(result.version, '3.13.2');
    });

    test('fails with old version', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'python3 --version': _ok('Python 3.12.1'),
        }),
      );
      final result = await checks[1].check();
      expect(result.status, CheckStatus.error);
      expect(result.message, contains('3.13+'));
    });

    test('fails when not found', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[1].check();
      expect(result.status, CheckStatus.error);
    });
  });

  group('dash_evals check', () {
    test('succeeds when installed', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'run-evals --help': _ok('usage: run-evals ...'),
        }),
      );
      final result = await checks[2].check();
      expect(result.status, CheckStatus.ok);
    });

    test('fails when not installed', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[2].check();
      expect(result.status, CheckStatus.error);
      expect(result.fix, contains('pip install'));
    });
  });

  group('Podman check', () {
    test('succeeds with version', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'podman --version': _ok('podman version 5.3.1'),
        }),
      );
      final result = await checks[3].check();
      expect(result.status, CheckStatus.ok);
      expect(result.version, '5.3.1');
    });

    test('warns when not found (optional)', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[3].check();
      expect(result.status, CheckStatus.warning);
      expect(result.message, contains('optional'));
    });
  });

  group('Flutter SDK check', () {
    test('succeeds with version', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'flutter --version': _ok('Flutter 3.41.0 • channel stable'),
        }),
      );
      final result = await checks[4].check();
      expect(result.status, CheckStatus.ok);
      expect(result.version, '3.41.0');
    });

    test('fails when not found', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[4].check();
      expect(result.status, CheckStatus.error);
    });
  });

  group('Serverpod CLI check', () {
    test('succeeds with version', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({
          'serverpod version': _ok('Serverpod version: 2.3.0'),
        }),
      );
      final result = await checks[5].check();
      expect(result.status, CheckStatus.ok);
      expect(result.version, '2.3.0');
    });

    test('fails when not found', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[5].check();
      expect(result.status, CheckStatus.error);
      expect(result.fix, contains('serverpod_cli'));
    });
  });

  group('API keys check', () {
    // Note: We can't easily mock Platform.environment, so the API key check
    // results depend on the actual environment. We test the check runs
    // without error and returns a valid status.
    test('returns a valid status', () async {
      final checks = buildChecks(
        processRunner: mockProcessRunner({}),
      );
      final result = await checks[6].check();
      expect(
        result.status,
        isIn([CheckStatus.ok, CheckStatus.warning, CheckStatus.error]),
      );
    });
  });

  group('CheckResult', () {
    test('supports all statuses', () {
      for (final status in CheckStatus.values) {
        final result = CheckResult(status: status);
        expect(result.status, status);
        expect(result.version, isNull);
        expect(result.message, isNull);
        expect(result.fix, isNull);
      }
    });

    test('stores all fields', () {
      const result = CheckResult(
        status: CheckStatus.warning,
        version: '1.2.3',
        message: 'some message',
        fix: 'some fix',
      );
      expect(result.version, '1.2.3');
      expect(result.message, 'some message');
      expect(result.fix, 'some fix');
    });
  });

  group('exit code logic', () {
    test('exits 0 when all pass', () async {
      final allPass = mockProcessRunner({
        'dart --version': _ok('Dart SDK version: 3.10.1'),
        'python3 --version': _ok('Python 3.13.2'),
        'run-evals --help': _ok('usage'),
        'podman --version': _ok('podman version 5.3.1'),
        'flutter --version': _ok('Flutter 3.41.0'),
        'serverpod version': _ok('Serverpod version: 2.3.0'),
      });
      final checks = buildChecks(processRunner: allPass);
      // Run all checks and verify none are errors
      // (API keys depend on env, filter it out for this test)
      final results = <CheckResult>[];
      for (final check in checks) {
        if (check.name != 'API keys') {
          results.add(await check.check());
        }
      }
      final hasErrors = results.any((r) => r.status == CheckStatus.error);
      expect(hasErrors, false);
    });

    test('process exit code 1 treated as failure', () async {
      final failRunner = mockProcessRunner({
        'dart --version': _fail('not found'),
      });
      final checks = buildChecks(processRunner: failRunner);
      final result = await checks[0].check();
      expect(result.status, CheckStatus.error);
    });
  });
}
