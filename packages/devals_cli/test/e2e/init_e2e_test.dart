@Tags(['e2e'])
library;

import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'e2e_helpers.dart';

void main() {
  late io.Directory tempDir;

  setUp(() {
    tempDir = createEmptyTempDir();
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals init', () {
    test('creates dataset structure in empty directory', () async {
      final result = await runDevals(
        ['init'],
        workingDirectory: tempDir.path,
      );

      expect(
        result.exitCode,
        0,
        reason: 'stdout: ${result.stdout}\nstderr: ${result.stderr}',
      );

      // Verify devals.yaml marker file
      expect(
        io.File(p.join(tempDir.path, 'devals.yaml')).existsSync(),
        isTrue,
        reason: 'devals.yaml should be created',
      );

      // Verify created files under evals/
      expect(
        io.Directory(p.join(tempDir.path, 'evals', 'tasks')).existsSync(),
        isTrue,
        reason: 'evals/tasks/ directory should be created',
      );
      expect(
        io.File(
          p.join(tempDir.path, 'evals', 'tasks', 'get_started', 'task.yaml'),
        ).existsSync(),
        isTrue,
        reason: 'evals/tasks/get_started/task.yaml should be created',
      );
      expect(
        io.File(
          p.join(tempDir.path, 'evals', 'jobs', 'local_dev.yaml'),
        ).existsSync(),
        isTrue,
        reason: 'evals/jobs/local_dev.yaml should be created',
      );

      // Verify output messages
      expect(result.stdout, contains('Initialized'));
    });

    test('fails when already initialized (devals.yaml exists)', () async {
      // Create existing devals.yaml
      io.File(
        p.join(tempDir.path, 'devals.yaml'),
      ).writeAsStringSync('dataset: ./evals\n');

      final result = await runDevals(
        ['init'],
        workingDirectory: tempDir.path,
      );

      expect(result.exitCode, 1);
      expect(result.stdout, contains('already'));
    });
  });
}
