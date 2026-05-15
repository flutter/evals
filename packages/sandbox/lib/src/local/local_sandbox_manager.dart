import 'dart:io';

import 'package:logging/logging.dart';

import '../sandbox_exception.dart';
import '../sandbox_manager.dart';
import '../sandbox_session.dart';
import 'local_sandbox_environment.dart';
import 'local_sandbox_session.dart';

final _log = Logger('LocalSandboxManager');

/// Lifecycle manager for local (host-process) sandbox sessions.
///
/// Unlike [DockerSandboxManager], the local manager has no containers to
/// build or pull. Each session gets an isolated temp directory, but commands
/// run directly on the host with no process isolation.
///
/// The manager is **stateless** — it does not track active sessions.
/// Each [SandboxSession] owns its resources and cleans up on
/// [SandboxSession.dispose].
class LocalSandboxManager implements SandboxManager {
  /// Optional default setup script (inline bash).
  final String? defaultSetupScript;

  LocalSandboxManager({this.defaultSetupScript});

  @override
  Future<SandboxSession> createSession(
    String name, {
    String? evalId,
    int? epoch,
    String? configFile,
    String? configDir,
    Map<String, String>? metadata,
    Map<String, Object>? files,
    String? setupScript,
    String? setupScriptFile,
    Duration? timeout,
  }) async {
    _log.info('Creating session (local): $name (eval=$evalId)');

    final env = await LocalSandboxEnvironment.create();

    // Provision files
    if (files != null && files.isNotEmpty) {
      await _provisionFiles(files, env);
    }

    // Run setup script
    final effectiveSetupScript = setupScript ?? defaultSetupScript;
    if (effectiveSetupScript != null) {
      await _runSetupScript(effectiveSetupScript, env);
    }
    if (setupScriptFile != null) {
      await _runSetupScriptFile(setupScriptFile, env);
    }

    _log.info('Session created (local): 1 environment');
    return LocalSandboxSession(environment: env);
  }

  @override
  Future<void> warmUp(String name, {String? configFile, String? configDir}) async {
    // No-op for local sandbox — nothing to build or pull.
    _log.info('Warm up (local): $name — nothing to do');
  }

  // -- Private helpers --

  Future<void> _provisionFiles(
    Map<String, Object> files,
    LocalSandboxEnvironment env,
  ) async {
    for (final entry in files.entries) {
      var filePath = entry.key;
      final contents = entry.value;

      // Strip service prefix (local only has one environment)
      if (filePath.contains(':') && !filePath.startsWith('/')) {
        filePath = filePath.substring(filePath.indexOf(':') + 1);
      }

      if (contents is String) {
        final file = File(contents);
        if (await file.exists()) {
          await env.writeFileBytes(filePath, await file.readAsBytes());
        } else {
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

  /// Run an inline setup script.
  Future<void> _runSetupScript(
    String script,
    LocalSandboxEnvironment env,
  ) async {
    _log.info('Running setup script (local)...');

    final result = await env.exec(
      ['bash', '-e', '-c', script],
      timeout: const Duration(seconds: 300),
    );

    if (!result.success) {
      throw SandboxException(
        'Setup script failed with exit code ${result.exitCode}: '
        '${result.stderr}',
      );
    }

    _log.info('Setup script (local) completed');
  }

  /// Run a setup script from a host file path.
  Future<void> _runSetupScriptFile(
    String filePath,
    LocalSandboxEnvironment env,
  ) async {
    _log.info('Running setup script file (local): $filePath');

    final file = File(filePath);
    if (!await file.exists()) {
      throw SandboxException('Setup script file not found: $filePath');
    }

    final script = await file.readAsString();
    await _runSetupScript(script, env);
  }
}
