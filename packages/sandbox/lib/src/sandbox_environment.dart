import 'exec_result.dart';
import 'sandbox_exception.dart';

/// Abstract interface for executing commands and managing files in a
/// sandboxed environment.
///
/// Each implementation provides a uniform API for running processes and
/// reading/writing files, regardless of the underlying isolation mechanism
/// (Docker container, local host process, etc.).
abstract class SandboxEnvironment {
  /// Execute a command inside the sandbox.
  ///
  /// Returns an [ExecResult] with the exit code, stdout, and stderr.
  ///
  /// [cmd] is the command and its arguments (e.g. `['ls', '-la']`).
  /// [input] is optional stdin to feed to the process.
  /// [cwd] is an optional working directory (relative paths resolve to the
  /// sandbox's per-sample working directory).
  /// [env] is optional environment variables for the command.
  /// [user] is an optional username or UID to run the command as.
  /// [timeout] is an optional maximum duration for the command.
  ///
  /// Throws [SandboxTimeoutException] if [timeout] is exceeded.
  /// Throws [OutputLimitExceededException] if output exceeds 10 MiB.
  Future<ExecResult> exec(
    List<String> cmd, {
    String? input,
    String? cwd,
    Map<String, String>? env,
    String? user,
    Duration? timeout,
  });

  /// Write text content to a file in the sandbox.
  ///
  /// [path] is the file path inside the sandbox (relative paths resolve to the
  /// per-sample working directory). Parent directories are created
  /// automatically.
  ///
  /// [contents] is written as UTF-8 text.
  ///
  /// Throws [SandboxException] on failure.
  Future<void> writeFile(String path, String contents);

  /// Write binary content to a file in the sandbox.
  ///
  /// [path] is the file path inside the sandbox (relative paths resolve to the
  /// per-sample working directory). Parent directories are created
  /// automatically.
  ///
  /// [bytes] is written as raw bytes.
  ///
  /// Throws [SandboxException] on failure.
  Future<void> writeFileBytes(String path, List<int> bytes);

  /// Read a file from the sandbox as a UTF-8 string.
  ///
  /// Throws [FileNotFoundException] if the file does not exist.
  /// Throws [OutputLimitExceededException] if the file exceeds 100 MiB.
  Future<String> readFile(String path);

  /// Read a file from the sandbox as raw bytes.
  ///
  /// Throws [FileNotFoundException] if the file does not exist.
  /// Throws [OutputLimitExceededException] if the file exceeds 100 MiB.
  Future<List<int>> readFileBytes(String path);

  /// Check whether a file or directory exists at [path].
  Future<bool> fileExists(String path);

  /// List the contents of a directory at [path].
  ///
  /// Returns a list of entry names (not full paths).
  /// Throws [SandboxException] if [path] is not a directory or does not exist.
  Future<List<String>> listDirectory(String path);

  /// Delete a file or directory at [path].
  ///
  /// If [recursive] is true and [path] is a directory, deletes all contents.
  /// Throws [FileNotFoundException] if [path] does not exist.
  Future<void> deleteFile(String path, {bool recursive = false});

  /// Release resources held by this environment.
  ///
  /// Idempotent — calling multiple times is safe.
  Future<void> dispose();
}
