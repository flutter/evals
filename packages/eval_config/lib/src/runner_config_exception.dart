/// Exception thrown when runner config resolution fails.
///
/// This is the library-level exception for the runner_config package.
/// CLI or web frontends can catch this and present the error appropriately.
class ConfigException implements Exception {
  final String message;

  ConfigException(this.message);

  @override
  String toString() => message;
}
