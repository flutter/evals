import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

export 'dart:io' show Directory;

/// Result of running the devals CLI as a subprocess.
class DevalResult {
  final int exitCode;
  final String stdout;
  final String stderr;

  const DevalResult({
    required this.exitCode,
    required this.stdout,
    required this.stderr,
  });

  /// Whether the command exited successfully.
  bool get isSuccess => exitCode == 0;

  @override
  String toString() =>
      'DevalResult(exit: $exitCode, stdout: ${stdout.length} chars, stderr: ${stderr.length} chars)';
}

/// Runs the devals CLI as a subprocess.
///
/// [args] are the command-line arguments (e.g., `['init']`, `['create', 'task']`).
/// [stdinLines] are lines to feed to the process's stdin (for interactive prompts).
/// [workingDirectory] is the directory to run in (defaults to devals_cli package root).
///
/// Returns a [DevalResult] with captured exit code, stdout, and stderr.
Future<DevalResult> runDevals(
  List<String> args, {
  List<String>? stdinLines,
  required String workingDirectory,
}) async {
  // Resolve the path to bin/devals.dart relative to the devals_cli package.
  final evalCliRoot = _findDevalsCliRoot();
  final devalsScript = p.join(evalCliRoot, 'bin', 'devals.dart');

  final process = await Process.start(
    'dart',
    ['run', devalsScript, ...args],
    workingDirectory: workingDirectory,
  );

  // Feed stdin lines if provided, then close stdin.
  if (stdinLines != null) {
    for (final line in stdinLines) {
      process.stdin.writeln(line);
    }
  }
  await process.stdin.close();

  final stdoutFuture = process.stdout.transform(utf8.decoder).join();
  final stderrFuture = process.stderr.transform(utf8.decoder).join();

  final exitCode = await process.exitCode;
  final stdout = await stdoutFuture;
  final stderr = await stderrFuture;

  return DevalResult(exitCode: exitCode, stdout: stdout, stderr: stderr);
}

/// Finds the devals_cli package root by walking up from this test file.
String _findDevalsCliRoot() {
  // This file lives at packages/devals_cli/test/e2e/e2e_helpers.dart
  // We need to find packages/devals_cli/
  var dir = Directory(p.dirname(Platform.script.toFilePath()));

  // Walk up until we find pubspec.yaml with name: devals
  for (var i = 0; i < 10; i++) {
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (pubspec.existsSync() &&
        pubspec.readAsStringSync().contains('name: devals')) {
      return dir.path;
    }
    dir = dir.parent;
  }

  // Fallback: assume we're running from the devals_cli directory
  return Directory.current.path;
}

/// Creates a minimal dataset directory structure in a temp directory.
///
/// The returned directory is the project root, containing:
/// - `devals.yaml` — marker file pointing to `./evals`
/// - `evals/tasks/` — empty tasks directory
/// - `evals/jobs/` — empty jobs directory
///
/// Caller is responsible for deleting the directory when done.
Directory createTestDatasetDir() {
  final tempDir = Directory.systemTemp.createTempSync('devals_e2e_');
  File(
    p.join(tempDir.path, 'devals.yaml'),
  ).writeAsStringSync('dataset: ./evals\n');
  Directory(p.join(tempDir.path, 'evals', 'tasks')).createSync(recursive: true);
  Directory(p.join(tempDir.path, 'evals', 'jobs')).createSync(recursive: true);

  return tempDir;
}

/// Creates a bare temp directory with no dataset structure.
/// Used to test commands that create the structure themselves (e.g., `init`).
Directory createEmptyTempDir() {
  return Directory.systemTemp.createTempSync('devals_e2e_');
}
