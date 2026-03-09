@Tags(['e2e'])
library;

import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'e2e_helpers.dart';

void main() {
  late io.Directory tempDir;

  setUp(() {
    // Create dataset with tasks so that create job can reference them
    tempDir = createTestDatasetDir();

    // Create an existing task so it shows up in selections
    final taskDir = io.Directory(
      p.join(tempDir.path, 'evals', 'tasks', 'existing_task'),
    );
    taskDir.createSync(recursive: true);
    io.File(p.join(taskDir.path, 'task.yaml')).writeAsStringSync(
      'func: question_answer\nsamples:\n  - id: s1\n    input: test\n    target: test\n',
    );
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals create job', () {
    // The CreateJobCommand now uses howdy interactive widgets (Prompt and
    // Multiselect) which require a real TTY — they call stdin.lineMode = false
    // internally, which throws a StdinException when stdin is a pipe.
    //
    // Because of this, this command cannot be driven via piped stdin in an
    // automated test. Run `devals create job` manually in a real terminal to
    // verify the full interactive flow.
    test(
      'creates a job file interactively',
      skip:
          'howdy widgets require a real TTY — run `devals create job` manually to verify',
      () async {
        final result = await runDevals(
          ['create', 'job'],
          stdinLines: [
            'my_test_job',
            ' ', // space=toggle, \n=submit for Multiselect (models)
            ' ', // variants
            ' ', // tasks
          ],
          workingDirectory: tempDir.path,
        );

        expect(
          result.exitCode,
          0,
          reason: 'stdout: ${result.stdout}\nstderr: ${result.stderr}',
        );

        // Verify the job file was created
        final jobFile = io.File(
          p.join(tempDir.path, 'evals', 'jobs', 'my_test_job.yaml'),
        );
        expect(
          jobFile.existsSync(),
          isTrue,
          reason: 'jobs/my_test_job.yaml should exist',
        );

        // Verify content
        final content = jobFile.readAsStringSync();
        expect(content, contains('my_test_job'));
        expect(content, contains('claude-haiku-4-5'));

        // Verify output
        expect(result.stdout, contains('Created'));
      },
    );
  });
}
