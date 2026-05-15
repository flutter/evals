import 'dart:io';

import 'package:logging/logging.dart';

final _log = Logger('ContainerRuntime');

/// The container runtime to use for compose operations.
///
/// Both Docker and Podman expose a compatible `compose` CLI, so the sandbox
/// implementation is identical — only the binary name changes.
enum ContainerRuntime {
  /// Use `docker compose`.
  docker,

  /// Use `podman compose`.
  podman;

  /// The CLI binary name.
  String get executable => switch (this) {
    docker => 'docker',
    podman => 'podman',
  };

  /// Parses a runtime from a string name.
  ///
  /// Throws [ArgumentError] if [name] is not a recognised runtime.
  static ContainerRuntime fromName(String name) => switch (name.toLowerCase()) {
    'docker' => ContainerRuntime.docker,
    'podman' => ContainerRuntime.podman,
    _ => throw ArgumentError(
      'Unknown container runtime: "$name". '
      'Supported values: docker, podman.',
    ),
  };
}

/// Detects the available container runtime.
///
/// Resolution order:
/// 1. The `DEVALS_CONTAINER_RUNTIME` environment variable (`docker` or
///    `podman`).
/// 2. If `docker` is on `PATH` and responds, use it.
/// 3. If `podman` is on `PATH` and responds, use it.
/// 4. Throw if neither is available.
Future<ContainerRuntime> detectContainerRuntime({
  Map<String, String>? environment,
}) async {
  final env = environment ?? Platform.environment;

  // 1. Explicit env-var override.
  final override = env['DEVALS_CONTAINER_RUNTIME'];
  if (override != null && override.isNotEmpty) {
    final runtime = ContainerRuntime.fromName(override);
    _log.info('Using container runtime from env: ${runtime.executable}');
    return runtime;
  }

  // 2. Try Docker first (backwards-compatible default).
  if (await _isAvailable('docker')) {
    _log.info('Auto-detected container runtime: docker');
    return ContainerRuntime.docker;
  }

  // 3. Fall back to Podman.
  if (await _isAvailable('podman')) {
    _log.info('Auto-detected container runtime: podman');
    return ContainerRuntime.podman;
  }

  throw StateError(
    'No container runtime found. Install Docker or Podman, or set '
    'the DEVALS_CONTAINER_RUNTIME environment variable.',
  );
}

/// Returns `true` if [binary] is installed and responds to `version`.
Future<bool> _isAvailable(String binary) async {
  try {
    final result = await Process.run(binary, ['version']);
    return result.exitCode == 0;
  } on ProcessException {
    return false;
  }
}
