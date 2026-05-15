import 'sandbox_session.dart';

/// Abstract interface for creating sandbox sessions.
///
/// Implementations handle the specifics of a particular sandbox backend
/// (Docker, local, etc.) while providing a uniform API for callers.
///
/// Managers are designed to be instantiated per-isolate. Each isolate
/// creates its own [SandboxManager] and calls [createSession]. Sessions
/// are independent — no shared state between isolates.
///
/// Concrete implementations:
/// - [DockerSandboxManager] — Docker Compose-based containers
/// - [LocalSandboxManager] — Direct host execution in a temp directory
abstract class SandboxManager {
  /// Create a new sandbox session.
  ///
  /// Handles all initialization (prerequisites, images, container startup,
  /// file provisioning, setup scripts) in a single call. Returns a
  /// [SandboxSession] that must be disposed when done.
  ///
  /// [name] identifies the workload (used for container naming).
  /// [evalId] and [epoch] provide uniqueness for concurrent sessions.
  /// [configFile] is an optional explicit compose file path.
  /// [configDir] is the directory to search for compose files.
  /// [metadata] becomes `EVAL_METADATA_*` env vars in the container.
  /// [files] maps sandbox paths → inline contents (`String` text or
  /// `List<int>` bytes) to provision into the sandbox.
  /// [setupScript] is inline bash to run after provisioning.
  /// [setupScriptFile] is a host file path to a bash script to run.
  /// [timeout] is the max time for container startup.
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
  });

  /// Optional: pre-pull/build images for faster session creation.
  ///
  /// Not required — [createSession] works correctly without calling this
  /// first. Useful for warming up before a batch of evals.
  ///
  /// For Docker: validates prerequisites, builds/pulls images.
  /// For local: no-op.
  Future<void> warmUp(String name, {String? configFile, String? configDir});
}
