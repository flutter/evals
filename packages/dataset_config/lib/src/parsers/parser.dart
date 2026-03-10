import '../models/models.dart';

import '../parsed_task.dart';

/// Abstract base for config parsers.
///
/// Parsers are responsible for turning raw configuration data (YAML files,
/// JSON maps, etc.) into domain model objects ([ParsedTask], [Job]).
///
/// Concrete implementations:
/// - [YamlParser] — reads `.yaml` files from the filesystem
/// - [JsonParser] — accepts pre-parsed `Map<String, dynamic>` data
abstract class Parser {
  /// Parse all task configs from a dataset root directory.
  ///
  /// The dataset root is expected to contain a `tasks/` subdirectory
  /// with per-task YAML/JSON files.
  List<ParsedTask> parseTasks(String datasetRoot);

  /// Parse a job config.
  ///
  /// [jobPath] identifies the job (file path for YAML, key for JSON).
  /// [datasetRoot] is the dataset root for resolving relative paths.
  Job parseJob(String jobPath, String datasetRoot);
}
