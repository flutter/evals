import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dataset_config/dataset_config.dart';
import 'package:devals/src/dataset/dry_run.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:howdy/howdy.dart';
import 'package:path/path.dart' as p;

/// Command to run evaluations using the Python eval_runner.
///
/// Config resolution and dry-run happen entirely in Dart. For actual runs,
/// Dart writes an EvalSet JSON file, then Python reads it and calls
/// `eval_set()` directly.
class RunCommand extends Command<int> {
  RunCommand() {
    argParser.addFlag(
      'dry-run',
      help: 'Preview what would be run without executing.',
      negatable: false,
    );
  }

  @override
  String get name => 'run';

  @override
  String get description => 'Run evaluations using the eval_runner.';

  @override
  String get invocation => '${runner?.executableName} run <job_name>';

  @override
  Future<int> run() async {
    if (argResults?.rest.isEmpty ?? true) {
      Text.error(
        'Missing required argument: <job_name>\n'
        'Usage: devals run <job_name>\n'
        'Example: devals run local_dev',
      );
      return 1;
    }
    final jobName = argResults!.rest.first;

    final datasetPath = findDatasetDirectory();

    // Resolve config in Dart
    Text.body('📋 Resolving config for job "$jobName"...');
    final resolver = ConfigResolver();
    final configs = resolver.resolve(datasetPath, [jobName]);

    if (configs.isEmpty) {
      Text.error('No configs resolved for job: $jobName');
      return 1;
    }

    // Handle --dry-run entirely in Dart
    if (argResults?['dry-run'] == true) {
      final isValid = dryRun(configs);
      return isValid ? 0 : 1;
    }

    // Write EvalSet JSON to the .devals-tool directory
    final outputDir = p.join(datasetPath, '.devals-tool', jobName);

    final writer = EvalSetWriter();
    final evalSetPath = writer.write(configs, outputDir);

    Text.body('🚀 Running: run-evals --json $evalSetPath');
    Text.body('   Working directory: $datasetPath\n');

    // Use inheritStdio to preserve inspect-ai's interactive terminal display
    try {
      final process = await Process.start(
        'run-evals',
        ['--json', evalSetPath],
        mode: ProcessStartMode.inheritStdio,
        workingDirectory: datasetPath,
      );
      return process.exitCode;
    } on ProcessException catch (e) {
      if (e.errorCode == 2) {
        Text.error(
          'Command "run-evals" not found.\n'
          'Please install the eval_runner Python package:\n'
          '  pip install -e <path-to-dash-evals>/pkgs/eval_runner',
        );
        return 1;
      }
      rethrow;
    }
  }
}
