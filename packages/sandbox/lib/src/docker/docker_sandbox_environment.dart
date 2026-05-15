import 'dart:convert';

import 'package:logging/logging.dart';

import '../exec_result.dart';
import '../sandbox_environment.dart';
import '../sandbox_exception.dart';
import '../compose/compose_project.dart';
import '../compose/compose_runner.dart';

final _log = Logger('DockerSandboxEnvironment');

/// Maximum exec output size (10 MiB).
const _maxExecOutputBytes = 10 * 1024 * 1024;

/// Maximum readable file size (100 MiB).
const _maxReadFileBytes = 100 * 1024 * 1024;

/// Default timeout for file operations.
const _fileOpTimeout = Duration(seconds: 180);

/// Docker-based implementation of [SandboxEnvironment].
///
/// Executes commands and manages files inside a Docker Compose service
/// container. Each instance is bound to a specific service within a
/// [ComposeProject].
class DockerSandboxEnvironment extends SandboxEnvironment {
  /// The compose service name this environment is bound to.
  final String service;

  /// The compose project this environment belongs to.
  final ComposeProject project;

  /// The working directory inside the container.
  final String workingDir;

  final ComposeRunner _runner;

  DockerSandboxEnvironment({
    required this.service,
    required this.project,
    required this.workingDir,
    ComposeRunner runner = const ComposeRunner(),
  }) : _runner = runner;

  @override
  Future<ExecResult> exec(
    List<String> cmd, {
    String? input,
    String? cwd,
    Map<String, String>? env,
    String? user,
    Duration? timeout,
  }) async {
    final args = <String>[];

    // Set working directory
    final effectiveCwd = cwd ?? workingDir;
    args.addAll(['--workdir', effectiveCwd]);

    // Set user
    if (user != null) {
      args.addAll(['--user', user]);
    }

    // Set environment variables
    if (env != null) {
      for (final entry in env.entries) {
        args.addAll(['--env', '${entry.key}=${entry.value}']);
      }
    }

    // Add service name and command
    args.add(service);
    args.addAll(cmd);

    final result = await _runner.exec(
      args,
      project: project,
      input: input,
      timeout: timeout,
    );

    // Check for output limit
    if (result.stdout.length > _maxExecOutputBytes ||
        result.stderr.length > _maxExecOutputBytes) {
      throw OutputLimitExceededException(
        'Command output exceeded limit',
        limitBytes: _maxExecOutputBytes,
      );
    }

    // Check for permission errors
    if (result.exitCode == 126 &&
        result.stdout.toLowerCase().contains('permission denied')) {
      throw SandboxException(
        'Permission denied executing command: $cmd',
      );
    }

    return result;
  }

  @override
  Future<void> writeFile(String path, String contents) async {
    final resolvedPath = _resolvePath(path);
    await _ensureParentDir(resolvedPath);

    final result = await exec(
      [
        'sh',
        '-e',
        '-c',
        'tee -- "\$1" > /dev/null',
        'write_file_script',
        resolvedPath,
      ],
      input: contents,
      timeout: _fileOpTimeout,
    );

    _checkWriteResult(result, path);
    _log.fine('Wrote file: $path');
  }

  @override
  Future<void> writeFileBytes(String path, List<int> bytes) async {
    final resolvedPath = _resolvePath(path);
    await _ensureParentDir(resolvedPath);

    final base64Contents = base64Encode(bytes);
    final result = await exec(
      [
        'sh',
        '-e',
        '-c',
        'base64 -d | tee -- "\$1" > /dev/null',
        'write_file_script',
        resolvedPath,
      ],
      input: base64Contents,
      timeout: _fileOpTimeout,
    );

    _checkWriteResult(result, path);
    _log.fine('Wrote file (bytes): $path');
  }

  @override
  Future<String> readFile(String path) async {
    final resolvedPath = _resolvePath(path);

    // First check file size
    final sizeResult = await exec(
      ['stat', '-c', '%s', resolvedPath],
      timeout: _fileOpTimeout,
    );
    if (!sizeResult.success) {
      if (sizeResult.stderr.toLowerCase().contains('no such file')) {
        throw FileNotFoundException(path);
      }
      // Try alternative stat format (macOS containers use different flags)
      // Fall through to just reading the file
    } else {
      final size = int.tryParse(sizeResult.stdout.trim());
      if (size != null && size > _maxReadFileBytes) {
        throw OutputLimitExceededException(
          'File $path exceeds read limit',
          limitBytes: _maxReadFileBytes,
        );
      }
    }

    final result = await exec(
      ['cat', resolvedPath],
      timeout: _fileOpTimeout,
    );

    if (!result.success) {
      final stderr = result.stderr.toLowerCase();
      if (stderr.contains('no such file')) {
        throw FileNotFoundException(path);
      }
      if (stderr.contains('is a directory')) {
        throw SandboxException('Path is a directory: $path');
      }
      if (stderr.contains('permission denied')) {
        throw SandboxException('Permission denied reading $path');
      }
      throw SandboxException('Failed to read file $path: ${result.stderr}');
    }

    return result.stdout;
  }

  @override
  Future<List<int>> readFileBytes(String path) async {
    final resolvedPath = _resolvePath(path);

    final result = await exec(
      ['base64', resolvedPath],
      timeout: _fileOpTimeout,
    );

    if (!result.success) {
      final stderr = result.stderr.toLowerCase();
      if (stderr.contains('no such file')) {
        throw FileNotFoundException(path);
      }
      throw SandboxException(
          'Failed to read file $path: ${result.stderr}');
    }

    return base64Decode(result.stdout.trim().replaceAll('\n', ''));
  }

  @override
  Future<bool> fileExists(String path) async {
    final resolvedPath = _resolvePath(path);
    final result = await exec(
      ['test', '-e', resolvedPath],
      timeout: _fileOpTimeout,
    );
    return result.success;
  }

  @override
  Future<List<String>> listDirectory(String path) async {
    final resolvedPath = _resolvePath(path);
    final result = await exec(
      ['ls', '-1', resolvedPath],
      timeout: _fileOpTimeout,
    );

    if (!result.success) {
      final stderr = result.stderr.toLowerCase();
      if (stderr.contains('no such file') ||
          stderr.contains('not a directory')) {
        throw SandboxException('Cannot list directory: $path');
      }
      throw SandboxException(
        'Failed to list directory $path: ${result.stderr}',
      );
    }

    return result.stdout
        .split('\n')
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @override
  Future<void> deleteFile(String path, {bool recursive = false}) async {
    final resolvedPath = _resolvePath(path);
    final args = recursive ? ['rm', '-rf', resolvedPath] : ['rm', resolvedPath];
    final result = await exec(args, timeout: _fileOpTimeout);

    if (!result.success) {
      final stderr = result.stderr.toLowerCase();
      if (stderr.contains('no such file')) {
        throw FileNotFoundException(path);
      }
      if (stderr.contains('is a directory')) {
        throw SandboxException(
          'Path is a directory: $path. Use recursive: true to delete.',
        );
      }
      throw SandboxException('Failed to delete $path: ${result.stderr}');
    }
  }

  @override
  Future<void> dispose() async {
    // Container lifecycle is managed by DockerSandboxSession.
    // Individual environment disposal is a no-op.
  }

  // -- Private helpers --

  /// Resolve a path relative to the working directory.
  String _resolvePath(String path) {
    if (path.startsWith('/')) return path;
    return '$workingDir/$path';
  }

  /// Get the parent directory of a path, or null if it's root.
  String? _parentDir(String path) {
    final lastSlash = path.lastIndexOf('/');
    if (lastSlash <= 0) return null;
    return path.substring(0, lastSlash);
  }

  /// Ensure the parent directory of [resolvedPath] exists.
  Future<void> _ensureParentDir(String resolvedPath) async {
    final parentDir = _parentDir(resolvedPath);
    if (parentDir != null && parentDir != '.') {
      final mkdirResult = await exec(
        ['mkdir', '-p', parentDir],
        timeout: _fileOpTimeout,
      );
      if (!mkdirResult.success) {
        throw SandboxException(
          'Failed to create directory $parentDir: ${mkdirResult.stderr}',
        );
      }
    }
  }

  /// Check a write result and throw descriptive errors.
  void _checkWriteResult(ExecResult result, String path) {
    if (!result.success) {
      final stderr = result.stderr.toLowerCase();
      if (stderr.contains('permission denied')) {
        throw SandboxException('Permission denied writing to $path');
      }
      if (stderr.contains('is a directory')) {
        throw SandboxException('Path is a directory: $path');
      }
      throw SandboxException(
        'Failed to write file $path: ${result.stderr}',
      );
    }
  }
}
