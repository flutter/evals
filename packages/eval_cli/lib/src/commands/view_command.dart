import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:howdy/howdy.dart';
import 'package:path/path.dart' as p;

/// Command to launch the Inspect AI viewer.
class ViewCommand extends Command<int> {
  @override
  String get name => 'view';

  @override
  String get description =>
      'Launch the Inspect AI viewer to view evaluation results.';

  @override
  String get invocation => '${runner?.executableName} view [log_path]';

  @override
  Future<int> run() async {
    final logPath = argResults?.rest.isNotEmpty == true
        ? argResults!.rest.first
        : null;

    // Use tryFindDatasetDirectory to get optional dataset path
    final datasetPath = tryFindDatasetDirectory();

    // Build command arguments
    final args = <String>['view'];
    if (logPath != null) {
      // inspect view expects --log-dir for a directory;
      // if a file path was given, use its parent directory.
      final resolved = File(logPath).existsSync()
          ? p.dirname(logPath)
          : logPath;
      args.addAll(['--log-dir', resolved]);
    } else if (datasetPath != null) {
      // Default to the logs directory if it exists
      final logsDir = findLogsDir(datasetPath);
      if (logsDir != null) {
        args.addAll(['--log-dir', logsDir]);
      }
    }

    Text.body('🔍 Launching: inspect ${args.join(' ')}\n');

    // Use inheritStdio to preserve the interactive viewer
    final process = await Process.start(
      'inspect',
      args,
      mode: ProcessStartMode.inheritStdio,
      workingDirectory: datasetPath != null ? p.dirname(datasetPath) : null,
    );

    return process.exitCode;
  }
}
