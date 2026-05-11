import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import '../exec_result.dart';
import '../sandbox_exception.dart';
import '../sandbox_manager.dart';
import '../sandbox_session.dart';
import 'podman_sandbox_environment.dart';
import 'podman_sandbox_session.dart';

final _log = Logger('PodmanSandboxManager');

/// Manages Podman-based sandbox sessions for eval workloads.
///
/// Uses the `podman` CLI directly (not `podman-compose`) for maximum
/// compatibility and reliability. Each session owns a single container
/// that is cleaned up on [SandboxSession.dispose].
///
/// ## Usage
///
/// ```dart
/// final manager = PodmanSandboxManager(
///   dockerfilePath: 'example/docker/Dockerfile',
///   buildContext: 'example',
/// );
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// try {
///   final result = await session.sandbox.exec(['echo', 'hello']);
///   print(result.stdout);
/// } finally {
///   await session.dispose();
/// }
/// ```
class PodmanSandboxManager implements SandboxManager {
  /// Path to the Dockerfile to build.
  final String dockerfilePath;

  /// Build context directory.
  final String buildContext;

  /// Image name to use. Built once and reused across sessions.
  final String imageName;

  /// Working directory inside the container.
  final String workingDir;

  /// Command to keep the container alive.
  final List<String> keepAliveCommand;

  /// Memory limit (e.g. '4g').
  final String? memLimit;

  /// CPU limit (e.g. '2.0').
  final String? cpuLimit;

  /// Optional default setup script (inline bash).
  final String? defaultSetupScript;

  bool _prerequisitesValidated = false;
  bool _imageBuilt = false;

  /// Creates a Podman sandbox manager.
  ///
  /// [dockerfilePath] and [buildContext] are used to build the image.
  /// [imageName] is the tag for the built image (defaults to
  /// `devals-sandbox`).
  PodmanSandboxManager({
    required this.dockerfilePath,
    required this.buildContext,
    this.imageName = 'devals-sandbox',
    this.workingDir = '/workspace',
    this.keepAliveCommand = const ['sleep', 'infinity'],
    this.memLimit,
    this.cpuLimit,
    this.defaultSetupScript,
  });

  /// Validate that Podman is available.
  ///
  /// Throws [ContainerPrerequisiteException] if Podman is not installed.
  Future<void> validatePrerequisites() async {
    try {
      final result = await Process.run('podman', ['version', '--format', 'json']);
      if (result.exitCode != 0) {
        throw ContainerPrerequisiteException(
          'Podman is not available. stderr: ${result.stderr}',
        );
      }
      _log.info('Podman is available');
    } on ProcessException catch (e) {
      throw ContainerPrerequisiteException(
        'Podman is not installed or not in PATH: $e',
      );
    }
  }

  Future<void> _ensurePrerequisites() async {
    if (_prerequisitesValidated) return;
    await validatePrerequisites();
    _prerequisitesValidated = true;
  }

  /// Build the image if it hasn't been built yet.
  Future<void> _ensureImageBuilt() async {
    if (_imageBuilt) return;

    _log.info('Building image "$imageName" from $dockerfilePath...');
    final result = await _run(
      [
        'podman', 'build',
        '-t', imageName,
        '-f', dockerfilePath,
        buildContext,
      ],
      timeout: const Duration(minutes: 10),
    );

    if (!result.success) {
      throw SandboxException(
        'Failed to build Podman image: ${result.stderr}',
      );
    }

    _imageBuilt = true;
    _log.info('Image "$imageName" built successfully');
  }

  @override
  Future<SandboxSession> createSession(
    String name, {
    String? evalId,
    int? epoch,
    String? configFile, // ignored for Podman
    String? configDir, // ignored for Podman
    Map<String, String>? metadata,
    Map<String, Object>? files,
    String? setupScript,
    String? setupScriptFile,
    Duration? timeout,
  }) async {
    _log.info('Creating session: $name (eval=$evalId, epoch=$epoch)');
    await _ensurePrerequisites();
    await _ensureImageBuilt();

    // Generate a unique container name (must match [a-zA-Z0-9][a-zA-Z0-9_.-]*).
    final suffix = _shortId();
    final rawName = 'devals-$name-${evalId ?? 'x'}-$suffix';
    final containerName = rawName.replaceAll(RegExp(r'[^a-zA-Z0-9_.-]'), '-');

    // Build metadata environment variables.
    final envArgs = <String>[];
    if (metadata != null) {
      for (final entry in metadata.entries) {
        final key =
            'EVAL_METADATA_${entry.key.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9_]'), '_')}';
        envArgs.addAll(['-e', '$key=${entry.value}']);
      }
    }

    // Start the container.
    // Note: Do NOT pass --workdir here. Podman validates the working directory
    // before mounting the image filesystem, causing "workdir does not exist"
    // errors. The WORKDIR from the Dockerfile is used automatically.
    final runArgs = [
      'podman', 'run',
      '-d', // detached
      '--name', containerName,
      if (memLimit != null) ...['--memory', memLimit!],
      if (cpuLimit != null) ...['--cpus', cpuLimit!],
      ...envArgs,
      imageName,
      ...keepAliveCommand,
    ];

    _log.info('Starting container: $containerName');
    final runResult = await _run(runArgs, timeout: const Duration(seconds: 30));

    if (!runResult.success) {
      throw SandboxException(
        'Failed to start container "$containerName": ${runResult.stderr}',
      );
    }

    final containerId = runResult.stdout.trim();
    _log.info('Container started: $containerId');

    // Wait for container to be running.
    await _waitForRunning(containerId);

    final environment = PodmanSandboxEnvironment(
      containerId: containerId,
      workingDir: workingDir,
    );

    try {
      // Provision per-eval files.
      if (files != null && files.isNotEmpty) {
        await _provisionFiles(files, environment);
      }

      // Run setup script.
      final effectiveSetupScript = setupScript ?? defaultSetupScript;
      if (effectiveSetupScript != null) {
        await _runSetupScript(effectiveSetupScript, environment);
      }
      if (setupScriptFile != null) {
        await _runSetupScriptFile(setupScriptFile, environment);
      }

      _log.info('Session created: $containerName');

      return PodmanSandboxSession(
        containerId: containerId,
        environment: environment,
      );
    } catch (e) {
      // Clean up on failure.
      _log.warning('Session creation failed, cleaning up: $e');
      try {
        await _run(['podman', 'stop', '-t', '2', containerId]);
      } catch (_) {}
      try {
        await _run(['podman', 'rm', '-f', containerId]);
      } catch (_) {}
      rethrow;
    }
  }

  @override
  Future<void> warmUp(
    String name, {
    String? configFile,
    String? configDir,
  }) async {
    _log.info('Warming up: $name');
    await _ensurePrerequisites();
    await _ensureImageBuilt();
    _log.info('Warm up complete: $name');
  }

  // -- Private helpers --

  /// Wait for a container to reach the "running" state.
  Future<void> _waitForRunning(
    String containerId, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final result = await _run([
        'podman', 'inspect',
        '--format', '{{.State.Running}}',
        containerId,
      ]);
      if (result.success && result.stdout.trim() == 'true') {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    throw SandboxTimeoutException(
      'Container $containerId did not start within $timeout',
      timeout: timeout,
    );
  }

  /// Provision files into the container.
  Future<void> _provisionFiles(
    Map<String, Object> files,
    PodmanSandboxEnvironment environment,
  ) async {
    for (final entry in files.entries) {
      final filePath = entry.key;
      final contents = entry.value;

      _log.fine('Provisioning file: $filePath');

      if (contents is String) {
        // Check if it's a local file path.
        final file = File(contents);
        if (await file.exists()) {
          final bytes = await file.readAsBytes();
          await environment.writeFileBytes(filePath, bytes);
        } else {
          await environment.writeFile(filePath, contents);
        }
      } else if (contents is List<int>) {
        await environment.writeFileBytes(filePath, contents);
      } else {
        throw ArgumentError(
          'File contents must be String or List<int>, '
          'got ${contents.runtimeType}',
        );
      }
    }
  }

  /// Run an inline setup script.
  Future<void> _runSetupScript(
    String script,
    PodmanSandboxEnvironment env,
  ) async {
    _log.info('Running setup script...');
    final result = await env.exec(
      ['bash', '-e', '-c', script],
      timeout: const Duration(seconds: 300),
    );

    if (!result.success) {
      _log.warning('Setup script failed: ${result.stderr}');
      throw SandboxException(
        'Setup script failed with exit code ${result.exitCode}: '
        '${result.stderr}',
      );
    }
    _log.info('Setup script completed');
  }

  /// Run a setup script from a host file path.
  Future<void> _runSetupScriptFile(
    String filePath,
    PodmanSandboxEnvironment env,
  ) async {
    _log.info('Running setup script file: $filePath');
    final file = File(filePath);
    if (!await file.exists()) {
      throw SandboxException('Setup script file not found: $filePath');
    }
    final script = await file.readAsString();
    await _runSetupScript(script, env);
  }

  /// Generate a short random ID for container naming.
  static String _shortId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return now.toRadixString(36).substring(
          (now.toRadixString(36).length - 6).clamp(0, now.toRadixString(36).length),
        );
  }

  /// Run a host-side process.
  static Future<ExecResult> _run(
    List<String> command, {
    Duration? timeout,
  }) async {
    try {
      final process = await Process.start(
        command.first,
        command.skip(1).toList(),
      );

      await process.stdin.close();

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
