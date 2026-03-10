import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/file_templates/init_templates/init_job_template.dart';
import 'package:devals/src/dataset/file_templates/init_templates/init_sample_template.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:howdy/howdy.dart';
import 'package:path/path.dart' as p;

class InitCommand extends Command<int> {
  @override
  String get name => 'init';

  @override
  String get description =>
      'Initialize a new dataset configuration in the current directory.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();

    final currentDir = Directory.current.path;
    final devalsYaml = File(p.join(currentDir, devalsYamlFilename));

    // Check if already initialized.
    if (devalsYaml.existsSync()) {
      Text.error(
        '$devalsYamlFilename already exists in this directory. '
        'This project appears to be already initialized.',
      );
      return 1;
    }

    final success = await SpinnerTask.send<bool>(
      'Initializing in $currentDir',
      task: () async {
        // Create devals.yaml marker file
        try {
          devalsYaml.writeAsStringSync(
            '# Marks this directory as a project that contains dash evals.\n'
            '# Created by `devals init`.\n'
            'dataset: ./evals\n',
          );
        } catch (e) {
          throw CliException('Failed to create $devalsYamlFilename: $e');
        }

        final evalsDir = p.join(currentDir, 'evals');

        // Create evals/tasks/get_started/task.yaml
        try {
          final taskDir = Directory(p.join(evalsDir, 'tasks', 'get_started'));
          taskDir.createSync(recursive: true);
          final taskPath = p.join(taskDir.path, 'task.yaml');
          File(taskPath).writeAsStringSync(initTaskTemplate());
        } catch (e) {
          throw CliException('Failed to create task: $e');
        }

        // Create evals/jobs/local_dev.yaml
        final jobsDir = p.join(evalsDir, 'jobs');
        try {
          Directory(jobsDir).createSync(recursive: true);
          final jobPath = p.join(jobsDir, 'local_dev.yaml');
          File(jobPath).writeAsStringSync(
            initJobTemplate(
              name: 'local_dev',
              models: ['google/gemini-2.0-flash'],
              tasks: ['get_started'],
            ),
          );
        } catch (e) {
          throw CliException('Failed to create job file: $e');
        }

        return true;
      },
    );

    if (success) {
      Text.success('Initialized — dataset at $currentDir/evals');
      terminal.writeln();
      Text.body('To run your first evaluation:');
      Text.body('  devals run local_dev');
    }

    return success ? 0 : 1;
  }
}
