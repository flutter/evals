import 'dart:io';

import 'package:logging/logging.dart';

import '../sandbox_exception.dart';
import '../sandbox_manager.dart';
import '../sandbox_session.dart';
import '../compose/compose_config.dart';
import '../compose/compose_project.dart';
import '../compose/compose_runner.dart';
import 'docker_sandbox_environment.dart';
import 'docker_sandbox_session.dart';

final _log = Logger('DockerSandboxManager');

/// Manages Docker-based sandbox sessions for eval workloads.
///
/// Creates isolated [SandboxSession]s backed by Docker Compose projects.
/// Each session owns its containers and cleans them up on [SandboxSession.dispose].
///
/// The manager itself is **stateless** — it does not track active sessions.
/// This makes it safe to instantiate per-isolate without shared mutable state.
///
/// ## Usage
///
/// ```dart
/// final manager = DockerSandboxManager();
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// try {
///   final result = await session.sandbox.exec(['echo', 'hello']);
///   print(result.stdout);
/// } finally {
///   await session.dispose();
/// }
/// ```
///
/// For batch workloads, call [warmUp] first to pre-build/pull images:
///
/// ```dart
/// await manager.warmUp('my_eval', configFile: 'docker-compose.yml');
/// for (final evalId in evalIds) {
///   final session = await manager.createSession('my_eval', evalId: evalId);
///   // ...
/// }
/// ```
class DockerSandboxManager implements SandboxManager {
  final ComposeRunner _runner;

  /// Optional default compose config file.
  final String? defaultConfigFile;

  /// Optional default setup script (inline bash).
  final String? defaultSetupScript;

  bool _prerequisitesValidated = false;

  DockerSandboxManager({
    ComposeRunner runner = const ComposeRunner(),
    this.defaultConfigFile,
    this.defaultSetupScript,
  }) : _runner = runner;

  /// Validate that Docker is available and ready.
  ///
  /// Throws [ContainerPrerequisiteException] if Docker is not installed or
  /// the daemon is not running.
  Future<void> validatePrerequisites() async {
    // Check Docker is installed
    try {
      final result = await Process.run('docker', ['version', '--format', 'json']);
      if (result.exitCode != 0) {
        throw ContainerPrerequisiteException(
          'Docker is not available. stderr: ${result.stderr}',
        );
      }
      _log.info('Docker is available');
    } on ProcessException catch (e) {
      throw ContainerPrerequisiteException(
        'Docker is not installed or not in PATH: $e',
      );
    }

    // Check Docker Compose is available
    try {
      final result = await Process.run('docker', ['compose', 'version']);
      if (result.exitCode != 0) {
        throw ContainerPrerequisiteException(
          'Docker Compose is not available. stderr: ${result.stderr}',
        );
      }
      _log.info('Docker Compose is available');
    } on ProcessException catch (e) {
      throw ContainerPrerequisiteException(
        'Docker Compose is not available: $e',
      );
    }
  }

  /// Ensures prerequisites are validated (cached per manager instance).
  Future<void> _ensurePrerequisites() async {
    if (_prerequisitesValidated) return;
    await validatePrerequisites();
    _prerequisitesValidated = true;
  }

  @override
  Future<SandboxSession> createSession(
    String name, {
    String? evalId,
    int? epoch,
    String? configFile,
    String? configDir,
    ComposeConfig? config,
    Map<String, String>? metadata,
    Map<String, Object>? files,
    String? setupScript,
    String? setupScriptFile,
    Duration? timeout,
  }) async {
    _log.info('Creating session: $name (eval=$evalId, epoch=$epoch)');
    await _ensurePrerequisites();

    // Resolve defaults
    final effectiveConfigFile = configFile ?? defaultConfigFile;
    final effectiveSetupScript = setupScript ?? defaultSetupScript;

    // Build metadata environment variables
    final env = <String, String>{};
    if (metadata != null) {
      for (final entry in metadata.entries) {
        final key =
            'EVAL_METADATA_${entry.key.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9_]'), '_')}';
        env[key] = entry.value;
      }
    }

    // Create project with unique name
    ComposeProject project;
    if (config != null) {
      project = await ComposeProject.fromConfig(
        name: name,
        config: config,
        evalId: evalId,
        epoch: epoch,
        env: env,
      );
    } else {
      project = await ComposeProject.create(
        name: name,
        configPath: effectiveConfigFile,
        searchDir: configDir,
        evalId: evalId,
        epoch: epoch,
        env: env,
      );
    }

    try {
      // Build images
      _log.info('Building images...');
      final buildResult = await _runner.build(project);
      if (!buildResult.success) {
        _log.warning('Build had warnings: ${buildResult.stderr}');
      }

      // Pull remote images for services that don't have a build context
      final services = await project.parseServices();
      for (final entry in services.entries) {
        final serviceConfig = entry.value;
        final hasBuild = serviceConfig.containsKey('build');
        final isLocal = serviceConfig['x-local'] == true;
        if (!hasBuild && !isLocal) {
          _log.info('Pulling image for service: ${entry.key}');
          final pullResult = await _runner.pull(project, entry.key);
          if (!pullResult.success) {
            final image = serviceConfig['image'] ?? '(unknown)';
            _log.warning(
              'Failed to pull image "$image". If local, add x-local: true.',
            );
          }
        }
      }

      // Start services
      _log.info('Starting services...');
      final upResult = await _runner.up(project);
      if (!upResult.success) {
        _log.warning('Compose up stderr: ${upResult.stderr}');
      }

      // Verify services are running
      final runningServices = await _runner.ps(project, status: 'running');
      if (runningServices.isEmpty) {
        throw SandboxException(
          'No services started. Compose up stderr: ${upResult.stderr}',
        );
      }

      // Parse service definitions
      final serviceConfigs = await project.parseServices();
      if (serviceConfigs.isEmpty) {
        throw SandboxException('No services defined in compose config');
      }

      // Create sandbox environments for each running service
      var environments = <String, DockerSandboxEnvironment>{};
      for (final serviceName in serviceConfigs.keys) {
        final isRunning = runningServices.any(
          (s) => s['Service'] == serviceName,
        );
        if (!isRunning) {
          _log.warning('Service "$serviceName" is not running, skipping');
          continue;
        }

        final workingDir = await _runner.containerWorkingDir(
          project,
          serviceName,
        );

        environments[serviceName] = DockerSandboxEnvironment(
          service: serviceName,
          project: project,
          workingDir: workingDir,
          runner: _runner,
        );
      }

      if (environments.isEmpty) {
        throw SandboxException('No sandbox environments created');
      }

      // Ensure the default service is first
      final defaultService =
          ComposeProject.resolveDefaultService(serviceConfigs);
      if (environments.containsKey(defaultService) &&
          environments.keys.first != defaultService) {
        final defaultEnv = environments.remove(defaultService)!;
        environments = {defaultService: defaultEnv, ...environments};
      }

      // Provision per-eval files
      if (files != null && files.isNotEmpty) {
        await _provisionFiles(files, environments, defaultService);
      }

      // Run setup script
      if (effectiveSetupScript != null) {
        await _runSetupScript(effectiveSetupScript, environments[defaultService]!);
      }
      if (setupScriptFile != null) {
        await _runSetupScriptFile(setupScriptFile, environments[defaultService]!);
      }

      _log.info(
        'Session created: ${environments.length} environments',
      );

      return DockerSandboxSession(
        project: project,
        runner: _runner,
        environments: Map.unmodifiable(environments),
      );
    } catch (e) {
      // Clean up on failure
      _log.warning('Session creation failed, cleaning up: $e');
      try {
        await _runner.down(project);
      } catch (_) {}
      await project.cleanup();
      rethrow;
    }
  }

  @override
  Future<void> warmUp(String name, {String? configFile, String? configDir}) async {
    _log.info('Warming up: $name');
    await _ensurePrerequisites();

    final effectiveConfigFile = configFile ?? defaultConfigFile;

    // Create project
    final project = await ComposeProject.create(
      name: name,
      configPath: effectiveConfigFile,
      searchDir: configDir,
    );

    // Build images
    _log.info('Building images...');
    final buildResult = await _runner.build(project);
    if (!buildResult.success) {
      _log.warning('Build had warnings: ${buildResult.stderr}');
    }

    // Pull remote images for services that don't have a build context
    final services = await project.parseServices();
    for (final entry in services.entries) {
      final serviceConfig = entry.value;
      final hasBuild = serviceConfig.containsKey('build');
      final isLocal = serviceConfig['x-local'] == true;
      if (!hasBuild && !isLocal) {
        _log.info('Pulling image for service: ${entry.key}');
        final pullResult = await _runner.pull(project, entry.key);
        if (!pullResult.success) {
          final image = serviceConfig['image'] ?? '(unknown)';
          _log.warning(
            'Failed to pull image "$image". If local, add x-local: true.',
          );
        }
      }
    }

    await project.cleanup();
    _log.info('Warm up complete: $name');
  }

  // -- Private helpers --

  /// Provision files into containers.
  Future<void> _provisionFiles(
    Map<String, Object> files,
    Map<String, DockerSandboxEnvironment> environments,
    String defaultService,
  ) async {
    for (final entry in files.entries) {
      final key = entry.key;
      final contents = entry.value;

      // Parse the key to determine target service and path
      String targetService = defaultService;
      String filePath = key;
      if (key.contains(':') && !key.startsWith('/')) {
        final colonIdx = key.indexOf(':');
        targetService = key.substring(0, colonIdx);
        filePath = key.substring(colonIdx + 1);
      }

      final env = environments[targetService];
      if (env == null) {
        _log.warning(
          'Cannot provision file "$key": service "$targetService" not found',
        );
        continue;
      }

      _log.fine('Provisioning file: $filePath → $targetService');

      if (contents is String) {
        // Check if it's a local file path (relative, and the file exists)
        final file = File(contents);
        if (await file.exists()) {
          // Read the file and write it into the container
          final bytes = await file.readAsBytes();
          await env.writeFileBytes(filePath, bytes);
        } else {
          // Treat as inline content
          await env.writeFile(filePath, contents);
        }
      } else {
        if (contents is String) {
          await env.writeFile(filePath, contents);
        } else if (contents is List<int>) {
          await env.writeFileBytes(filePath, contents);
        } else {
          throw ArgumentError(
            'File contents must be String or List<int>, '
            'got ${contents.runtimeType}',
          );
        }
      }
    }
  }

  /// Run an inline setup script in the default sandbox.
  Future<void> _runSetupScript(
    String script,
    DockerSandboxEnvironment defaultEnv,
  ) async {
    _log.info('Running setup script...');

    final result = await defaultEnv.exec(
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
    DockerSandboxEnvironment defaultEnv,
  ) async {
    _log.info('Running setup script file: $filePath');

    final file = File(filePath);
    if (!await file.exists()) {
      throw SandboxException('Setup script file not found: $filePath');
    }

    final script = await file.readAsString();
    await _runSetupScript(script, defaultEnv);
  }
}
