/// Exception thrown when a CLI command fails with a specific exit code.
///
/// Throw this from anywhere in the CLI codebase when an error occurs.
/// The top-level main function catches these and exits with the specified code.
class CliException implements Exception {
  final String message;
  final int exitCode;

  CliException(this.message, {this.exitCode = 1});

  @override
  String toString() => message;
}
