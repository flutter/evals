/// Result of executing a command in a sandbox environment.
class ExecResult {
  /// The exit code of the process.
  final int exitCode;

  /// The standard output from the process.
  final String stdout;

  /// The standard error output from the process.
  final String stderr;

  /// The wall-clock duration of the command execution.
  ///
  /// May be null if timing was not captured.
  final Duration? duration;

  /// Creates an [ExecResult].
  const ExecResult({
    required this.exitCode,
    this.stdout = '',
    this.stderr = '',
    this.duration,
  });

  /// Whether the command completed successfully (exit code == 0).
  bool get success => exitCode == 0;

  @override
  String toString() =>
      'ExecResult(exitCode: $exitCode, stdout: ${_truncate(stdout)}, '
      'stderr: ${_truncate(stderr)})';

  static String _truncate(String s, [int maxLen = 200]) =>
      s.length <= maxLen ? s : '${s.substring(0, maxLen)}...';
}
