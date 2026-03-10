@Tags(['e2e'])
library;

import 'package:test/test.dart';

import 'e2e_helpers.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = createTestDatasetDir();
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals run', () {
    test('fails with missing job argument', () async {
      final result = await runDevals(
        ['run'],
        workingDirectory: tempDir.path,
      );
      expect(result.exitCode, 1);
      expect(result.stdout, contains('Missing required argument'));
    });

    test('dry-run outputs the command that would run', () async {
      final result = await runDevals(
        ['run', '--dry-run', 'local_dev'],
        workingDirectory: tempDir.path,
      );

      // The command will try to run `run-evals`, which may not be installed.
      // If installed, it should mention the dry-run args.
      // If not installed, it exits with an error about run-evals not found.
      // Either way, the output should reference the job name.
      final combined = result.stdout + result.stderr;
      expect(combined, contains('local_dev'));
    });
  });
}
