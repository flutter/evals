import '../models/models.dart';

import '../parsed_task.dart';
import 'parser.dart';

/// Parses config from pre-parsed `Map<String, dynamic>` data.
///
/// Useful for programmatic config construction (web UI, tests)
/// without touching the filesystem.
class JsonParser extends Parser {
  @override
  List<ParsedTask> parseTasks(String datasetRoot) {
    // JSON parser expects data to be provided directly, not from filesystem.
    // For now, return empty — callers should use parseTasksFromMaps() instead.
    return [];
  }

  /// Parse task configs from pre-parsed maps.
  ///
  /// Each map should have the same structure as a task.yaml file.
  List<ParsedTask> parseTasksFromMaps(List<Map<String, dynamic>> taskMaps) {
    return taskMaps.map((data) {
      final taskId = data['id'] as String;
      final func = (data['func'] as String?) ?? taskId;
      final systemMessage = data['system_message'] as String?;
      final allowedVariants = (data['allowed_variants'] as List?)
          ?.cast<String>();

      // Parse samples from inline data (no file I/O) - optional
      final samplesRaw = data['samples'];
      final samples = <Sample>[];
      if (samplesRaw is Map) {
        final inlineDefs =
            (samplesRaw['inline'] as List?)?.cast<Map<String, dynamic>>() ??
            const [];
        for (final def in inlineDefs) {
          if (def.isEmpty) continue;

          // Validate required fields
          for (final field in ['id', 'input', 'target']) {
            if (!def.containsKey(field)) {
              throw FormatException(
                "Sample '${def['id'] ?? 'unknown'}' missing required "
                "field: $field",
              );
            }
          }

          // Read metadata from the metadata dict
          final metaRaw = Map<String, dynamic>.from(
            def['metadata'] as Map? ?? {},
          );

          // Normalize tags from metadata
          final rawTags = metaRaw['tags'];
          final List<String> tags;
          if (rawTags is String) {
            tags = rawTags.split(',').map((t) => t.trim()).toList();
          } else if (rawTags is List) {
            tags = rawTags.cast<String>();
          } else {
            tags = [];
          }

          // Parse sample-level fields
          final choices = (def['choices'] as List?)?.cast<String>();
          final sampleSandbox = def['sandbox'];
          final setup = def['setup'] as String?;
          final files = def['files'] is Map
              ? Map<String, String>.from(def['files'] as Map)
              : null;

          samples.add(
            Sample(
              id: def['id'] as String,
              input: def['input'] as String,
              target: def['target'] as String,
              metadata: <String, dynamic>{
                ...metaRaw,
                'difficulty': metaRaw['difficulty'] as String? ?? 'medium',
                'tags': tags,
              },
              choices: choices,
              sandbox: sampleSandbox,
              setup: setup,
              files: files,
            ),
          );
        }
      }

      // Task-level Inspect AI args from inspect_task_args
      final taskArgs = data['inspect_task_args'] is Map
          ? Map<String, dynamic>.from(data['inspect_task_args'] as Map)
          : <String, dynamic>{};
      final model = taskArgs['model'] as String?;
      final config = taskArgs['config'] is Map
          ? Map<String, dynamic>.from(taskArgs['config'] as Map)
          : null;
      final modelRoles = taskArgs['model_roles'] is Map
          ? Map<String, String>.from(taskArgs['model_roles'] as Map)
          : null;
      final sandbox = taskArgs['sandbox'];
      final approval = taskArgs['approval'];
      final epochs = taskArgs['epochs'];
      final failOnError = taskArgs['fail_on_error'];
      final continueOnFail = taskArgs['continue_on_fail'] as bool?;
      final messageLimit = taskArgs['message_limit'] as int?;
      final tokenLimit = taskArgs['token_limit'] as int?;
      final timeLimit = taskArgs['time_limit'] as int?;
      final workingLimit = taskArgs['working_limit'] as int?;
      final costLimit = (taskArgs['cost_limit'] as num?)?.toDouble();
      final earlyStopping = taskArgs['early_stopping'];
      final displayName = data['display_name'] as String?;
      final version = data['version'];
      final taskMetadata = data['metadata'] is Map
          ? Map<String, dynamic>.from(data['metadata'] as Map)
          : null;

      return ParsedTask(
        id: taskId,
        func: func,
        variant: const Variant(),
        samples: samples,
        systemMessage: systemMessage,
        allowedVariants: allowedVariants,
        // Task-level settings
        model: model,
        config: config,
        modelRoles: modelRoles,
        sandbox: sandbox,
        approval: approval,
        epochs: epochs,
        failOnError: failOnError,
        continueOnFail: continueOnFail,
        messageLimit: messageLimit,
        tokenLimit: tokenLimit,
        timeLimit: timeLimit,
        workingLimit: workingLimit,
        costLimit: costLimit,
        earlyStopping: earlyStopping,
        displayName: displayName,
        version: version,
        metadata: taskMetadata,
      );
    }).toList();
  }

  @override
  Job parseJob(String jobPath, String datasetRoot) {
    // JSON parser expects data to be provided directly.
    // Callers should use parseJobFromMap() instead.
    throw UnsupportedError(
      'JsonParser.parseJob() requires a file path. '
      'Use parseJobFromMap() for pre-parsed data.',
    );
  }

  /// Parse a job from a pre-parsed map.
  Job parseJobFromMap(Map<String, dynamic> data) {
    // Parse sandbox config
    Map<String, dynamic>? sandbox;
    final sandboxRaw = data['sandbox'];
    if (sandboxRaw is Map) {
      sandbox = Map<String, dynamic>.from(sandboxRaw);
    } else if (sandboxRaw is String) {
      sandbox = {'environment': sandboxRaw};
    }

    return Job(
      logDir: (data['log_dir'] as String?) ?? '',
      maxConnections: (data['max_connections'] as int?) ?? 10,
      models: (data['models'] as List?)?.cast<String>(),
      saveExamples: data['save_examples'] == true,
      sandbox: sandbox,
      inspectEvalArguments: data['inspect_eval_arguments'] is Map
          ? Map<String, dynamic>.from(data['inspect_eval_arguments'] as Map)
          : null,
    );
  }
}
