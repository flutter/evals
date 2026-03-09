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
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals create task', () {
    // CreateTaskCommand uses howdy interactive widgets (Form, Prompt, Select)
    // which require a real TTY — they call stdin.lineMode = false internally,
    // which throws a StdinException when stdin is a pipe.
    test(
      'creates a task with path workspace',
      skip:
          'howdy widgets require a real TTY — run `devals create task` manually to verify',
      () async {
        // Stdin sequence for CreateTaskCommand:
        // 1. Task name (TextInputPrompt)
        // 2. Task function (SelectPrompt, 1-indexed)
        // 3. Variants (MultiSelectPrompt, "1" for baseline)
        // 4. Workspace type (SelectPrompt: 1=path, 2=git, 3=create)
        // 5. Relative path (TextInputPrompt, for path workspace)
        // 6. System message (TextInputPrompt, optional — empty for skip)
        // 7. Confirm (YesNoPrompt)
        final result = await runDevals(
          ['create', 'task'],
          stdinLines: [
            'my_test_task', // 1. task name
            '1', // 2. select "analyze_codebase" (first task func)
            '1', // 3. select "baseline" variant
            '1', // 4. workspace type: "path"
            '../../app', // 5. relative path
            '', // 6. system message: skip (optional)
            'y', // 7. confirm
          ],
          workingDirectory: tempDir.path,
        );

        expect(
          result.exitCode,
          0,
          reason: 'stdout: ${result.stdout}\nstderr: ${result.stderr}',
        );

        // Verify the task file was created
        final taskYaml = io.File(
          p.join(tempDir.path, 'evals', 'tasks', 'my_test_task', 'task.yaml'),
        );
        expect(
          taskYaml.existsSync(),
          isTrue,
          reason: 'tasks/my_test_task/task.yaml should exist',
        );

        // Verify the task.yaml has expected content
        final content = taskYaml.readAsStringSync();
        expect(content, contains('analyze_codebase'));

        // Verify output
        expect(result.stdout, contains('Created task'));
      },
    );

    test(
      'creates a task with create workspace',
      skip:
          'howdy widgets require a real TTY — run `devals create task` manually to verify',
      () async {
        final result = await runDevals(
          ['create', 'task'],
          stdinLines: [
            'create_ws_task', // 1. task name
            '2', // 2. select "flutter_bug_fix"
            '', // 3. variants: skip (optional)
            '3', // 4. workspace type: "create"
            '', // 5. creation command (use default)
            '', // 6. system message: skip
            'y', // 7. confirm
          ],
          workingDirectory: tempDir.path,
        );

        // This may fail because `flutter create` command isn't available
        // in all test environments. We test the input flow reaches confirmation.
        // The important thing is it gets past the prompts without hanging.
        final combined = result.stdout + result.stderr;
        expect(
          combined,
          isNotEmpty,
          reason: 'Command should produce output, not hang',
        );
      },
    );
  });
}
