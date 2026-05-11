import 'sandbox_environment.dart';

/// A live sandbox session with one or more environments.
///
/// Created by [SandboxManager.createSession]. Owns its resources and
/// cleans them up on [dispose].
///
/// For most evals, use [sandbox] to get the default (primary) environment
/// directly. Multi-service setups can access all environments via
/// [environments].
///
/// ```dart
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// try {
///   final result = await session.sandbox.exec(['echo', 'hello']);
///   print(result.stdout);
/// } finally {
///   await session.dispose();
/// }
/// ```
abstract class SandboxSession {
  /// The default (primary) sandbox environment.
  ///
  /// For single-service setups (including all local sandboxes), this is the
  /// only environment. For multi-service Docker Compose projects, this is
  /// the service named `default`, the service with `x-default: true`, or
  /// the first service listed.
  SandboxEnvironment get sandbox;

  /// All environments in this session, keyed by service name.
  ///
  /// For single-service setups, this contains exactly
  /// `{'default': sandbox}`.
  Map<String, SandboxEnvironment> get environments;

  /// Clean up all resources (containers, temp dirs) for this session.
  ///
  /// Idempotent — safe to call multiple times.
  Future<void> dispose();

  /// Whether this session has been disposed.
  bool get isDisposed;

  /// Check whether the session is still healthy and responsive.
  ///
  /// Returns a [SandboxHealth] with per-service status. If the session
  /// has been disposed, all services report as unhealthy.
  Future<SandboxHealth> health();
}

/// Health status of a sandbox session.
class SandboxHealth {
  /// Per-service health status. Key is the service name.
  final Map<String, bool> services;

  /// Whether all services are healthy.
  bool get healthy => services.values.every((v) => v);

  const SandboxHealth(this.services);

  @override
  String toString() => 'SandboxHealth($services, healthy=$healthy)';
}
