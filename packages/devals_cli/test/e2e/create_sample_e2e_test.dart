@Tags(['e2e'])
library;

import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'e2e_helpers.dart';

void main() {
  late io.Directory tempDir;

  setUp(() {
    tempDir = createTestDatasetDir();

    // Create an existing task with a sample so `create sample` can append to it
    final taskDir = io.Directory(
      p.join(tempDir.path, 'evals', 'tasks', 'my_task'),
    );
    taskDir.createSync(recursive: true);
    io.File(p.join(taskDir.path, 'task.yaml')).writeAsStringSync('''
func: question_answer

samples:
  - id: first_sample
    input: What is Dart?
    target: A programming language
''');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals create sample', () {
    // CreateSampleCommand uses howdy interactive widgets (Form, Select, Prompt)
    // which require a real TTY — they call stdin.lineMode = false internally,
    // which throws a StdinException when stdin is a pipe.
    test(
      'appends a sample to an existing task',
      skip:
          'howdy widgets require a real TTY — run `devals create sample` manually to verify',
      () async {
        // Stdin sequence for CreateSampleCommand:
        // 1. Task selection (SelectPrompt: "1" for first task)
        // 2. Sample ID (TextInputPrompt)
        // 3. Difficulty (SelectPrompt: 1=easy, 2=medium, 3=hard)
        // 4. Confirm (YesNoPrompt)
        final result = await runDevals(
          ['create', 'sample'],
          stdinLines: [
            '1', // 1. select "my_task"
            'new_sample', // 2. sample ID
            '2', // 3. difficulty: medium
            'y', // 4. confirm
          ],
          workingDirectory: tempDir.path,
        );

        expect(
          result.exitCode,
          0,
          reason: 'stdout: ${result.stdout}\nstderr: ${result.stderr}',
        );

        // Verify the task file was modified
        final taskFile = io.File(
          p.join(tempDir.path, 'evals', 'tasks', 'my_task', 'task.yaml'),
        );
        final content = taskFile.readAsStringSync();
        expect(
          content,
          contains('new_sample'),
          reason: 'task.yaml should contain the new sample ID',
        );

        // Verify output
        expect(result.stdout, contains('Added sample'));
      },
    );
  });
}
