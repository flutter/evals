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

      // Parse samples from inline data (no file I/O)
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

          // Normalize tags
          final rawTags = def['tags'];
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
                ...Map<String, dynamic>.from(
                  def['metadata'] as Map? ?? {},
                ),
                'difficulty': def['difficulty'] as String? ?? 'medium',
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

      // Parse Task-level settings
      final model = data['model'] as String?;
      final config = data['config'] is Map
          ? Map<String, dynamic>.from(data['config'] as Map)
          : null;
      final modelRoles = data['model_roles'] is Map
          ? Map<String, String>.from(data['model_roles'] as Map)
          : null;
      final sandbox = data['sandbox'];
      final approval = data['approval'];
      final epochs = data['epochs'];
      final failOnError = data['fail_on_error'];
      final continueOnFail = data['continue_on_fail'] as bool?;
      final messageLimit = data['message_limit'] as int?;
      final tokenLimit = data['token_limit'] as int?;
      final timeLimit = data['time_limit'] as int?;
      final workingLimit = data['working_limit'] as int?;
      final costLimit = (data['cost_limit'] as num?)?.toDouble();
      final earlyStopping = data['early_stopping'];
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
    return Job(
      logDir: (data['log_dir'] as String?) ?? '',
      sandboxType: (data['sandbox_type'] as String?) ?? 'local',
      maxConnections: (data['max_connections'] as int?) ?? 10,
      models: (data['models'] as List?)?.cast<String>(),
      saveExamples: data['save_examples'] == true,
      // Promoted eval_set() fields
      retryAttempts: data['retry_attempts'] as int?,
      maxRetries: data['max_retries'] as int?,
      retryWait: (data['retry_wait'] as num?)?.toDouble(),
      retryConnections: (data['retry_connections'] as num?)?.toDouble(),
      retryCleanup: data['retry_cleanup'] as bool?,
      failOnError: (data['fail_on_error'] as num?)?.toDouble(),
      continueOnFail: data['continue_on_fail'] as bool?,
      retryOnError: data['retry_on_error'] as int?,
      debugErrors: data['debug_errors'] as bool?,
      maxSamples: data['max_samples'] as int?,
      maxTasks: data['max_tasks'] as int?,
      maxSubprocesses: data['max_subprocesses'] as int?,
      maxSandboxes: data['max_sandboxes'] as int?,
      logLevel: data['log_level'] as String?,
      logLevelTranscript: data['log_level_transcript'] as String?,
      logFormat: data['log_format'] as String?,
      tags: (data['tags'] as List?)?.cast<String>(),
      metadata: data['metadata'] is Map
          ? Map<String, dynamic>.from(data['metadata'] as Map)
          : null,
      trace: data['trace'] as bool?,
      display: data['display'] as String?,
      score: data['score'] as bool?,
      limit: data['limit'],
      sampleId: data['sample_id'],
      sampleShuffle: data['sample_shuffle'],
      epochs: data['epochs'],
      approval: data['approval'],
      solver: data['solver'],
      sandboxCleanup: data['sandbox_cleanup'] as bool?,
      modelBaseUrl: data['model_base_url'] as String?,
      modelArgs: data['model_args'] is Map
          ? Map<String, Object?>.from(data['model_args'] as Map)
          : null,
      modelRoles: data['model_roles'] is Map
          ? Map<String, String>.from(data['model_roles'] as Map)
          : null,
      taskArgs: data['task_args'] is Map
          ? Map<String, Object?>.from(data['task_args'] as Map)
          : null,
      messageLimit: data['message_limit'] as int?,
      tokenLimit: data['token_limit'] as int?,
      timeLimit: data['time_limit'] as int?,
      workingLimit: data['working_limit'] as int?,
      costLimit: (data['cost_limit'] as num?)?.toDouble(),
      modelCostConfig: data['model_cost_config'] is Map
          ? Map<String, Object?>.from(data['model_cost_config'] as Map)
          : null,
      logSamples: data['log_samples'] as bool?,
      logRealtime: data['log_realtime'] as bool?,
      logImages: data['log_images'] as bool?,
      logBuffer: data['log_buffer'] as int?,
      logShared: data['log_shared'] as int?,
      bundleDir: data['bundle_dir'] as String?,
      bundleOverwrite: data['bundle_overwrite'] as bool?,
      logDirAllowDirty: data['log_dir_allow_dirty'] as bool?,
      evalSetId: data['eval_set_id'] as String?,
      // Pass-through sections
      evalSetOverrides: data['eval_set_overrides'] is Map
          ? Map<String, dynamic>.from(data['eval_set_overrides'] as Map)
          : null,
      taskDefaults: data['task_defaults'] is Map
          ? Map<String, dynamic>.from(data['task_defaults'] as Map)
          : null,
    );
  }
}
