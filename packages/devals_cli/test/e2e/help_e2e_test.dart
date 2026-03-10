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

  group('devals --help', () {
    test('exits 0 and shows usage', () async {
      final result = await runDevals(
        ['--help'],
        workingDirectory: tempDir.path,
      );
      expect(result.exitCode, 0);
      expect(result.stdout, contains('Available commands'));
      expect(result.stdout, contains('create'));
      expect(result.stdout, contains('doctor'));
      expect(result.stdout, contains('init'));
      expect(result.stdout, contains('run'));
    });
  });

  group('devals help create', () {
    test('exits 0 and shows create subcommands', () async {
      final result = await runDevals(
        ['help', 'create'],
        workingDirectory: tempDir.path,
      );
      expect(result.exitCode, 0);
      expect(result.stdout, contains('task'));
      expect(result.stdout, contains('job'));
      expect(result.stdout, contains('sample'));
    });
  });

  group('devals <invalid command>', () {
    test('exits with error for unknown command', () async {
      final result = await runDevals(
        ['nonexistent'],
        workingDirectory: tempDir.path,
      );
      expect(result.exitCode, isNot(0));
    });
  });
}
