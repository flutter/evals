import '../sandbox_environment.dart';
import '../sandbox_session.dart';
import 'local_sandbox_environment.dart';

/// Local (host-process) [SandboxSession] implementation.
///
/// Owns a [LocalSandboxEnvironment] and its temporary directory.
/// Cleans up the temp directory when [dispose] is called.
class LocalSandboxSession implements SandboxSession {
  final LocalSandboxEnvironment _environment;
  bool _disposed = false;

  LocalSandboxSession({required LocalSandboxEnvironment environment})
      : _environment = environment;

  @override
  SandboxEnvironment get sandbox => _environment;

  @override
  Map<String, SandboxEnvironment> get environments =>
      {'default': _environment};

  @override
  bool get isDisposed => _disposed;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _environment.cleanup();
  }

  @override
  Future<SandboxHealth> health() async {
    if (_disposed) {
      return const SandboxHealth({'default': false});
    }
    final exists = _environment.directory.existsSync();
    return SandboxHealth({'default': exists});
  }
}
