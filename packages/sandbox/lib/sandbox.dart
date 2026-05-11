/// Sandboxing for eval workloads — Docker, Podman, and local backends.
///
/// Provides [SandboxManager] for creating sandbox sessions.
/// Use [DockerSandboxManager] for Docker containers,
/// [PodmanSandboxManager] for Podman containers, or
/// [LocalSandboxManager] for direct host execution during development.
///
/// ## Quick start (Docker)
///
/// ```dart
/// import 'package:devals_sandbox/sandbox.dart';
///
/// final manager = DockerSandboxManager();
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// final result = await session.sandbox.exec(['echo', 'hello']);
/// await session.dispose();
/// ```
///
/// ## Quick start (Podman)
///
/// ```dart
/// import 'package:devals_sandbox/sandbox.dart';
///
/// final manager = PodmanSandboxManager(
///   dockerfilePath: 'example/docker/Dockerfile',
///   buildContext: 'example',
/// );
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// final result = await session.sandbox.exec(['echo', 'hello']);
/// await session.dispose();
/// ```
///
/// ## Quick start (Local)
///
/// ```dart
/// import 'package:devals_sandbox/sandbox.dart';
///
/// final manager = LocalSandboxManager();
/// final session = await manager.createSession('my_eval', evalId: 'run-1');
/// final result = await session.sandbox.exec(['echo', 'hello']);
/// await session.dispose();
/// ```
library;

// Core abstractions
export 'src/exec_result.dart';
export 'src/sandbox_environment.dart';
export 'src/sandbox_exception.dart';
export 'src/sandbox_manager.dart';
export 'src/sandbox_registry.dart';
export 'src/sandbox_session.dart';

// Compose config models (Docker-specific)
export 'src/compose/compose_config.dart';
export 'src/compose/compose_project.dart';
export 'src/compose/compose_runner.dart';

// Docker implementation
export 'src/docker/docker_sandbox_environment.dart';
export 'src/docker/docker_sandbox_manager.dart';
export 'src/docker/docker_sandbox_session.dart';

// Podman implementation
export 'src/podman/podman_sandbox_environment.dart';
export 'src/podman/podman_sandbox_manager.dart';
export 'src/podman/podman_sandbox_session.dart';

// Local implementation
export 'src/local/local_sandbox_environment.dart';
export 'src/local/local_sandbox_manager.dart';
export 'src/local/local_sandbox_session.dart';
