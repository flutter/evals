import 'dart:io';

import '../sandbox_environment.dart';
import '../sandbox_session.dart';
import 'podman_sandbox_environment.dart';

/// Podman-based [SandboxSession] implementation.
///
/// Owns a Podman container and cleans it up (stop + rm) when [dispose] is
/// called.
class PodmanSandboxSession implements SandboxSession {
  final String _containerId;
  final PodmanSandboxEnvironment _environment;
  bool _disposed = false;

  PodmanSandboxSession({
    required String containerId,
    required PodmanSandboxEnvironment environment,
  })  : _containerId = containerId,
        _environment = environment;

  @override
  SandboxEnvironment get sandbox => _environment;

  @override
  Map<String, SandboxEnvironment> get environments =>
      Map.unmodifiable({'default': _environment});

  @override
  bool get isDisposed => _disposed;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;

    try {
      // Stop and remove the container.
      await _environment.exec(
        ['true'], // no-op to test if alive
        timeout: const Duration(seconds: 2),
      );
    } catch (_) {
      // Container may already be stopped.
    }

    // Use podman stop + rm directly.
    try {
      await _run(['podman', 'stop', '-t', '5', _containerId]);
    } catch (_) {}
    try {
      await _run(['podman', 'rm', '-f', _containerId]);
    } catch (_) {}
  }

  @override
  Future<SandboxHealth> health() async {
    if (_disposed) {
      return const SandboxHealth({'default': false});
    }

    try {
      final result = await _environment.exec(
        ['echo', 'ok'],
        timeout: const Duration(seconds: 5),
      );
      return SandboxHealth({'default': result.success});
    } catch (_) {
      return const SandboxHealth({'default': false});
    }
  }

  /// Run a host-side process (for stop/rm).
  static Future<void> _run(List<String> command) async {
    final result = await Process.run(command.first, command.skip(1).toList());
    if (result.exitCode != 0) {
      throw Exception('${command.join(' ')} failed: ${result.stderr}');
    }
  }
}
