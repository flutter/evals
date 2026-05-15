/// Base exception for sandbox operations.
class SandboxException implements Exception {
  /// Human-readable description of the error.
  final String message;

  /// Optional underlying error.
  final Object? cause;

  const SandboxException(this.message, {this.cause});

  @override
  String toString() => cause != null
      ? 'SandboxException: $message (caused by: $cause)'
      : 'SandboxException: $message';
}

/// Thrown when a sandbox command exceeds its timeout.
class SandboxTimeoutException extends SandboxException {
  /// The timeout duration that was exceeded.
  final Duration timeout;

  const SandboxTimeoutException(super.message, {required this.timeout});

  @override
  String toString() =>
      'SandboxTimeoutException: $message (timeout: ${timeout.inSeconds}s)';
}

/// Thrown when command output exceeds the allowed limit.
class OutputLimitExceededException extends SandboxException {
  /// The maximum allowed size in bytes.
  final int limitBytes;

  const OutputLimitExceededException(super.message, {required this.limitBytes});

  @override
  String toString() =>
      'OutputLimitExceededException: $message '
      '(limit: ${limitBytes ~/ (1024 * 1024)} MiB)';
}

/// Thrown when container runtime prerequisites are not met
/// (e.g. Docker/Podman not installed or daemon not running).
class ContainerPrerequisiteException extends SandboxException {
  const ContainerPrerequisiteException(super.message);
}

/// Backwards-compatible alias for [ContainerPrerequisiteException].
typedef DockerPrerequisiteException = ContainerPrerequisiteException;

/// Thrown when a file is not found in the sandbox.
class FileNotFoundException extends SandboxException {
  final String path;
  FileNotFoundException(this.path) : super('File not found: $path');
}
