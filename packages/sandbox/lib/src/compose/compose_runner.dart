import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../exec_result.dart';
import '../sandbox_exception.dart';
import 'compose_project.dart';

final _log = Logger('ComposeRunner');

/// Thin wrapper around the `docker compose` CLI.
///
/// Each method constructs and executes a `docker compose` command with the
/// appropriate project name and config file from a [ComposeProject].
class ComposeRunner {
  const ComposeRunner();

  /// Bring up services in detached mode, waiting for health checks.
  Future<ExecResult> up(
    ComposeProject project, {
    Duration timeout = const Duration(seconds: 120),
  }) async {
    return _compose(
      ['up', '--detach', '--wait', '--wait-timeout', '${timeout.inSeconds}'],
      project: project,
      timeout: timeout + const Duration(seconds: 10), // extra grace
    );
  }

  /// Shut down services and remove volumes.
  Future<ExecResult> down(
    ComposeProject project, {
    Duration timeout = const Duration(seconds: 60),
  }) async {
    return _compose(
      ['down', '--volumes'],
      project: project,
      timeout: timeout,
    );
  }

  /// Execute a command in a running service container.
  ///
  /// [args] should include the service name and the command, e.g.:
  /// `['--workdir', '/app', 'default', 'echo', 'hello']`
  ///
  /// [input] is optional stdin to send to the command.
  Future<ExecResult> exec(
    List<String> args, {
    required ComposeProject project,
    String? input,
    Duration? timeout,
  }) async {
    // -T disables pseudo-tty allocation (needed for non-interactive exec)
    return _compose(
      ['exec', '-T', ...args],
      project: project,
      input: input,
      timeout: timeout,
    );
  }

  /// Copy a file into a service container.
  ///
  /// [src] and [dest] follow `docker compose cp` syntax:
  /// - Host to container: `./local_file service:/path/in/container`
  /// - The `-L` flag follows symlinks.
  Future<ExecResult> cp(
    String src,
    String dest, {
    required ComposeProject project,
    Duration timeout = const Duration(seconds: 120),
  }) async {
    return _compose(
      ['cp', '-L', '--', src, dest],
      project: project,
      timeout: timeout,
    );
  }

  /// List running services as JSON.
  Future<List<Map<String, dynamic>>> ps(
    ComposeProject project, {
    String? status,
  }) async {
    final args = ['ps', '--format', 'json'];
    if (status != null) {
      args.addAll(['--status', status]);
    }
    final result = await _compose(args, project: project);
    if (!result.success) {
      throw SandboxException(
        'Failed to query services: ${result.stderr}',
      );
    }

    final output = result.stdout.trim();
    if (output.isEmpty) return [];

    // Docker compose ps --format json outputs one JSON object per line
    // (NDJSON) or a JSON array depending on version.
    try {
      if (output.startsWith('[')) {
        return (jsonDecode(output) as List).cast<Map<String, dynamic>>();
      }
      return output
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => jsonDecode(line) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      _log.warning('Failed to parse docker compose ps output: $e');
      return [];
    }
  }

  /// Build images defined in the compose file.
  Future<ExecResult> build(
    ComposeProject project, {
    Duration timeout = const Duration(seconds: 300),
  }) async {
    return _compose(['build'], project: project, timeout: timeout);
  }

  /// Pull images for a specific service.
  Future<ExecResult> pull(
    ComposeProject project,
    String service, {
    Duration timeout = const Duration(seconds: 120),
  }) async {
    return _compose(['pull', service], project: project, timeout: timeout);
  }

  /// Get the list of service names from the compose config.
  Future<List<String>> serviceNames(ComposeProject project) async {
    final result = await _compose(
      ['config', '--services'],
      project: project,
    );
    if (!result.success) {
      throw SandboxException(
        'Failed to list services: ${result.stderr}',
      );
    }
    return result.stdout
        .trim()
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();
  }

  /// Get the full config as JSON.
  Future<Map<String, dynamic>> config(ComposeProject project) async {
    final result = await _compose(
      ['config', '--format', 'json'],
      project: project,
    );
    if (!result.success) {
      throw SandboxException(
        'Failed to read compose config: ${result.stderr}',
      );
    }
    return jsonDecode(result.stdout) as Map<String, dynamic>;
  }

  /// Get the working directory of a running container.
  Future<String> containerWorkingDir(
    ComposeProject project,
    String service,
  ) async {
    final result = await exec(
      [service, 'pwd'],
      project: project,
    );
    if (result.success) {
      return result.stdout.trim();
    }
    // Fallback to root
    return '/';
  }

  // -- Internal --

  /// Build and run a `docker compose` command.
  Future<ExecResult> _compose(
    List<String> args, {
    required ComposeProject project,
    String? input,
    Duration? timeout,
    String? cwd,
  }) async {
    final command = [
      'docker',
      'compose',
      '-p',
      project.name,
      '-f',
      project.configFile,
      ...args,
    ];

    final workingDir = cwd ?? p.dirname(project.configFile);

    _log.fine('Running: ${command.join(' ')}');

    return _runProcess(
      command,
      workingDir: workingDir,
      input: input,
      timeout: timeout,
      env: project.env.isNotEmpty ? project.env : null,
    );
  }

  /// Run a process and capture output.
  Future<ExecResult> _runProcess(
    List<String> command, {
    String? workingDir,
    String? input,
    Duration? timeout,
    Map<String, String>? env,
  }) async {
    try {
      final process = await Process.start(
        command.first,
        command.skip(1).toList(),
        workingDirectory: workingDir,
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
          process.exitCode.then((code) => code.toString()),
        ]);
        return ExecResult(
          exitCode: int.parse(results[2]),
          stdout: results[0],
          stderr: results[1],
        );
      }();

      if (timeout != null) {
        return await resultFuture.timeout(
          timeout,
          onTimeout: () {
            process.kill(ProcessSignal.sigterm);
            throw SandboxTimeoutException(
              'Command timed out: ${command.join(' ')}',
              timeout: timeout,
            );
          },
        );
      }

      return await resultFuture;
    } on ProcessException catch (e) {
      throw SandboxException(
        'Failed to start process: ${command.join(' ')}',
        cause: e,
      );
    }
  }
}
