import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../exec_result.dart';
import '../sandbox_environment.dart';
import '../sandbox_exception.dart';

final _log = Logger('LocalSandboxEnvironment');

/// Maximum exec output size (10 MiB).
const _maxExecOutputBytes = 10 * 1024 * 1024;

/// Maximum readable file size (100 MiB).
const _maxReadFileBytes = 100 * 1024 * 1024;

/// A sandbox environment that runs commands directly on the host machine
/// in a temporary directory.
///
/// **No isolation is provided.** Commands run as the current user with full
/// host access. This is intended for development and testing, not for
/// running untrusted code.
///
/// Each [LocalSandboxEnvironment] creates its own temporary directory as the
/// per-sample working directory. Relative file paths resolve to this
/// directory.
class LocalSandboxEnvironment extends SandboxEnvironment {
  /// The temporary directory used as the per-sample working directory.
  final Directory directory;

  /// Creates a [LocalSandboxEnvironment] with the given temp [directory].
  LocalSandboxEnvironment(this.directory);

  /// Creates a [LocalSandboxEnvironment] with a new temporary directory.
  static Future<LocalSandboxEnvironment> create() async {
    final dir = await Directory.systemTemp.createTemp('devals_local_sandbox_');
    _log.fine('Created local sandbox directory: ${dir.path}');
    return LocalSandboxEnvironment(dir);
  }

  @override
  Future<ExecResult> exec(
    List<String> cmd, {
    String? input,
    String? cwd,
    Map<String, String>? env,
    String? user,
    Duration? timeout,
  }) async {
    if (user != null) {
      _log.warning(
        'The "user" parameter is ignored in LocalSandboxEnvironment. '
        'Commands run as the current user.',
      );
    }

    // Resolve working directory
    final effectiveCwd = cwd != null
        ? (p.isAbsolute(cwd) ? cwd : p.join(directory.path, cwd))
        : directory.path;

    final stopwatch = Stopwatch()..start();

    try {
      final process = await Process.start(
        cmd.first,
        cmd.skip(1).toList(),
        workingDirectory: effectiveCwd,
        environment: env,
      );

      if (input != null) {
        process.stdin.write(input);
        await process.stdin.close();
      } else {
        await process.stdin.close();
      }

      final Future<ExecResult> resultFuture = () async {
        final results = await Future.wait([
          process.stdout.transform(utf8.decoder).join(),
          process.stderr.transform(utf8.decoder).join(),
          process.exitCode.then((c) => c.toString()),
        ]);

        stopwatch.stop();

        final stdout = results[0];
        final stderr = results[1];

        if (stdout.length > _maxExecOutputBytes ||
            stderr.length > _maxExecOutputBytes) {
          throw OutputLimitExceededException(
            'Command output exceeded limit',
            limitBytes: _maxExecOutputBytes,
          );
        }

        return ExecResult(
          exitCode: int.parse(results[2]),
          stdout: stdout,
          stderr: stderr,
          duration: stopwatch.elapsed,
        );
      }();

      if (timeout != null) {
        return await resultFuture.timeout(
          timeout,
          onTimeout: () async {
            // Graceful shutdown: SIGTERM → wait → SIGKILL
            process.kill(ProcessSignal.sigterm);
            // Give the process 5 seconds to exit gracefully
            final exited = await process.exitCode
                .timeout(const Duration(seconds: 5), onTimeout: () => -1);
            if (exited == -1) {
              // Process didn't respond to SIGTERM — force kill
              process.kill(ProcessSignal.sigkill);
            }
            throw SandboxTimeoutException(
              'Command timed out: ${cmd.join(' ')}',
              timeout: timeout,
            );
          },
        );
      }

      return await resultFuture;
    } on ProcessException catch (e) {
      throw SandboxException(
        'Failed to start process: ${cmd.join(' ')}',
        cause: e,
      );
    }
  }

  @override
  Future<void> writeFile(String path, String contents) async {
    final resolved = _resolvePath(path);
    final file = File(resolved);

    // Create parent directories
    await file.parent.create(recursive: true);
    await file.writeAsString(contents);
    _log.fine('Wrote file: $resolved');
  }

  @override
  Future<void> writeFileBytes(String path, List<int> bytes) async {
    final resolved = _resolvePath(path);
    final file = File(resolved);

    // Create parent directories
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    _log.fine('Wrote file (bytes): $resolved');
  }

  @override
  Future<String> readFile(String path) async {
    final resolved = _resolvePath(path);
    final file = File(resolved);

    if (!await file.exists()) {
      throw FileNotFoundException(path);
    }

    final stat = await file.stat();
    if (stat.size > _maxReadFileBytes) {
      throw OutputLimitExceededException(
        'File $path exceeds read limit',
        limitBytes: _maxReadFileBytes,
      );
    }

    return await file.readAsString();
  }

  @override
  Future<List<int>> readFileBytes(String path) async {
    final resolved = _resolvePath(path);
    final file = File(resolved);

    if (!await file.exists()) {
      throw FileNotFoundException(path);
    }

    final stat = await file.stat();
    if (stat.size > _maxReadFileBytes) {
      throw OutputLimitExceededException(
        'File $path exceeds read limit',
        limitBytes: _maxReadFileBytes,
      );
    }

    return await file.readAsBytes();
  }

  @override
  Future<bool> fileExists(String path) async {
    final resolved = _resolvePath(path);
    return await FileSystemEntity.isFile(resolved) ||
        await FileSystemEntity.isDirectory(resolved);
  }

  @override
  Future<List<String>> listDirectory(String path) async {
    final resolved = _resolvePath(path);
    final dir = Directory(resolved);

    if (!await dir.exists()) {
      throw SandboxException('Cannot list directory: $path');
    }

    final entries = await dir.list().toList();
    return entries.map((e) => p.basename(e.path)).toList();
  }

  @override
  Future<void> deleteFile(String path, {bool recursive = false}) async {
    final resolved = _resolvePath(path);

    if (await FileSystemEntity.isDirectory(resolved)) {
      if (!recursive) {
        throw SandboxException(
          'Path is a directory: $path. Use recursive: true to delete.',
        );
      }
      final dir = Directory(resolved);
      if (!await dir.exists()) {
        throw FileNotFoundException(path);
      }
      await dir.delete(recursive: true);
    } else {
      final file = File(resolved);
      if (!await file.exists()) {
        throw FileNotFoundException(path);
      }
      await file.delete();
    }
  }

  /// Delete the temporary directory.
  Future<void> cleanup() async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      _log.fine('Cleaned up local sandbox: ${directory.path}');
    }
  }

  @override
  Future<void> dispose() async {
    await cleanup();
  }

  /// Resolve a path relative to the sandbox directory.
  String _resolvePath(String path) {
    if (p.isAbsolute(path)) return path;
    return p.join(directory.path, path);
  }
}
