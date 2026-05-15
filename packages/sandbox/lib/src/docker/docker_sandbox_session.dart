import '../sandbox_environment.dart';
import '../sandbox_session.dart';
import '../compose/compose_project.dart';
import '../compose/compose_runner.dart';
import 'docker_sandbox_environment.dart';

/// Docker-based [SandboxSession] implementation.
///
/// Owns a [ComposeProject] and its associated environments. Disposes
/// of all resources (stops containers, removes volumes, cleans temp files)
/// when [dispose] is called.
class DockerSandboxSession implements SandboxSession {
  final ComposeProject _project;
  final ComposeRunner _runner;
  final Map<String, SandboxEnvironment> _environments;
  bool _disposed = false;

  DockerSandboxSession({
    required ComposeProject project,
    required ComposeRunner runner,
    required Map<String, SandboxEnvironment> environments,
  })  : _project = project,
        _runner = runner,
        _environments = environments;

  @override
  SandboxEnvironment get sandbox => _environments.values.first;

  @override
  Map<String, SandboxEnvironment> get environments =>
      Map.unmodifiable(_environments);

  @override
  bool get isDisposed => _disposed;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;

    try {
      await _runner.down(_project);
    } catch (_) {
      // Best-effort cleanup — don't let failure prevent temp file removal.
    }
    await _project.cleanup();
  }

  @override
  Future<SandboxHealth> health() async {
    if (_disposed) {
      return SandboxHealth({
        for (final key in _environments.keys) key: false,
      });
    }

    final statuses = <String, bool>{};
    for (final entry in _environments.entries) {
      try {
        final env = entry.value as DockerSandboxEnvironment;
        final result = await env.exec(
          ['echo', 'ok'],
          timeout: const Duration(seconds: 5),
        );
        statuses[entry.key] = result.success;
      } catch (_) {
        statuses[entry.key] = false;
      }
    }
    return SandboxHealth(statuses);
  }
}
