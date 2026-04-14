import 'dart:io';
import 'package:path/path.dart' as p;

/// Finds the local .venv/bin directory relative to the project root.
String? findLocalVenvBin() {
  try {
    var dir = Directory.current.absolute;
    // Walk up to find devals.yaml and .venv
    for (var i = 0; i < 10; i++) {
      if (File(p.join(dir.path, 'devals.yaml')).existsSync() &&
          Directory(p.join(dir.path, '.venv')).existsSync()) {
        final venvSubdir = Platform.isWindows ? 'Scripts' : 'bin';
        return p.join(dir.path, '.venv', venvSubdir);
      }
      final parent = dir.parent;
      if (parent.path == dir.path) break;
      dir = parent;
    }
  } catch (_) {}
  return null;
}

/// Runs a process, accounting for a local .venv if present.
Future<ProcessResult> runVenvProcess(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  Map<String, String>? environment,
}) async {
  final venvBin = findLocalVenvBin();
  final env = Map<String, String>.from(environment ?? Platform.environment);

  String resolvedExecutable = executable;
  if (venvBin != null) {
    final venvExe = p.join(venvBin, executable);
    if (File(venvExe).existsSync()) {
      resolvedExecutable = venvExe;
    }

    // Also update PATH to ensure sub-processes find other tools in the venv
    final pathKey = Platform.isWindows ? 'Path' : 'PATH';
    final separator = Platform.isWindows ? ';' : ':';
    final currentPath = env[pathKey] ?? '';
    env[pathKey] = '$venvBin$separator$currentPath';
  }

  return Process.run(
    resolvedExecutable,
    arguments,
    workingDirectory: workingDirectory,
    environment: env,
  );
}

/// Starts a process, accounting for a local .venv if present.
Future<Process> startVenvProcess(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  Map<String, String>? environment,
  ProcessStartMode mode = ProcessStartMode.normal,
}) async {
  final venvBin = findLocalVenvBin();
  final env = Map<String, String>.from(environment ?? Platform.environment);

  String resolvedExecutable = executable;
  if (venvBin != null) {
    final venvExe = p.join(venvBin, executable);
    if (File(venvExe).existsSync()) {
      resolvedExecutable = venvExe;
    }

    // Also update PATH to ensure sub-processes find other tools in the venv
    final pathKey = Platform.isWindows ? 'Path' : 'PATH';
    final separator = Platform.isWindows ? ';' : ':';
    final currentPath = env[pathKey] ?? '';
    env[pathKey] = '$venvBin$separator$currentPath';
  }

  return Process.start(
    resolvedExecutable,
    arguments,
    workingDirectory: workingDirectory,
    environment: env,
    mode: mode,
  );
}
