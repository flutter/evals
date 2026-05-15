import 'dart:io';

import 'package:path/path.dart' as p;

import '../eval_set.dart';
import 'string_util.dart';

/// Recursively copies [source] to [dest], creating [dest] if needed.
Future<void> copyDirectory(Directory source, Directory dest) async {
  await dest.create(recursive: true);
  await for (final entity in source.list(recursive: false)) {
    final relativePath = p.relative(entity.path, from: source.path);
    final destPath = p.join(dest.path, relativePath);
    if (entity is Directory) {
      await copyDirectory(entity, Directory(destPath));
    } else if (entity is File) {
      await entity.copy(destPath);
    }
  }
}

/// Build the run directory path without creating it yet (EvalLog.init handles
/// creation via the log file).
String buildRunDirPath(
  EvalSet evalSet,
  DateTime startedAt,
  String baseOutputDir,
) {
  final timestamp = formatDirTimestamp(startedAt);
  final dirName = '${timestamp}_evals';
  return p.join(p.absolute(baseOutputDir), dirName);
}

/// Runs [executable] with [args] in [workingDir], ignoring any errors.
///
/// This is a best-effort helper — failures are silently swallowed so that
/// non-critical post-processing (formatting, pub get) doesn't halt the
/// logging pipeline.
Future<void> runCommand(
  String executable,
  List<String> args, {
  required String workingDir,
}) async {
  try {
    await Process.run(executable, args, workingDirectory: workingDir);
  } catch (_) {
    // Best-effort; ignore failures.
  }
}

/// Runs `dart format` on [filePath] in-place.
///
/// Silently ignores errors so that even syntactically invalid generated code
/// is still saved (just unformatted).
Future<void> formatDartFile(String filePath) async {
  try {
    await Process.run('dart', ['format', filePath]);
  } catch (_) {
    // Formatting is best-effort; ignore failures.
  }
}
