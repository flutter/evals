import 'package:freezed_annotation/freezed_annotation.dart';
import 'tag_filter.dart';

part 'job.freezed.dart';
part 'job.g.dart';

/// A job configuration defining what to run and how to run it.
///
/// Jobs combine runtime settings (log directory, sandbox type, rate limits)
/// with filtering (which models, variants, and tasks to include).
///
/// Top-level fields cover the most common settings. For full control over
/// `eval_set()` and `Task` parameters, use [evalSetOverrides] and
/// [taskDefaults] respectively — any valid `eval_set()` / `Task` kwarg can
/// be specified there and will be passed through to the Python runner.
///
/// Example YAML:
/// ```yaml
/// log_dir: ./logs/my_run
/// sandbox:
///   environment: podman
/// max_connections: 10
/// models:
///   - google/gemini-2.5-flash
/// variants:
///   baseline: {}
///   context_only:
///     files: [./context_files/flutter.md]
/// tasks:
///   dart_qa:
///     include-samples: [sample_1]
///
/// # All Inspect AI eval_set() parameters
/// inspect_eval_arguments:
///   retry_attempts: 20
///   log_level: debug
///   task_defaults:
///     time_limit: 600
/// ```
@freezed
sealed class Job with _$Job {
  const factory Job({
    // ------------------------------------------------------------------
    // Core job settings
    // ------------------------------------------------------------------

    /// Human-readable description of this job.
    String? description,

    /// Directory to write evaluation logs to.
    @JsonKey(name: 'log_dir') required String logDir,

    /// Maximum concurrent API connections.
    @JsonKey(name: 'max_connections') @Default(10) int maxConnections,

    /// Models to run. `null` means use defaults from registries.
    List<String>? models,

    /// Named variant map. Keys are variant names, values are config dicts.
    /// `null` means baseline only.
    Map<String, Map<String, dynamic>>? variants,

    /// Glob patterns for discovering task directories (relative to dataset root).
    @JsonKey(name: 'task_paths') List<String>? taskPaths,

    /// Per-task configurations with inline overrides.
    /// `null` means run all tasks.
    Map<String, JobTask>? tasks,

    /// If `true`, copy final workspace to `<logDir>/examples/` after each sample.
    @JsonKey(name: 'save_examples') @Default(false) bool saveExamples,

    // ------------------------------------------------------------------
    // Sandbox configuration
    // ------------------------------------------------------------------

    /// Sandbox config with keys: environment, parameters, image_prefix.
    Map<String, dynamic>? sandbox,

    // ------------------------------------------------------------------
    // Inspect eval arguments (passed through to eval_set())
    // ------------------------------------------------------------------

    /// All Inspect AI eval_set() parameters, nested under one key.
    @JsonKey(name: 'inspect_eval_arguments')
    Map<String, dynamic>? inspectEvalArguments,

    // ------------------------------------------------------------------
    // Tag-based filtering
    // ------------------------------------------------------------------

    /// Tag filters applied to tasks.
    @JsonKey(name: 'task_filters') TagFilter? taskFilters,

    /// Tag filters applied to samples.
    @JsonKey(name: 'sample_filters') TagFilter? sampleFilters,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}

/// Per-task configuration within a job.
///
/// Allows overriding which samples and variants run for specific tasks.
@freezed
sealed class JobTask with _$JobTask {
  const factory JobTask({
    /// Task identifier matching a task directory name in `tasks/`.
    required String id,

    /// Only run these sample IDs. Mutually exclusive with [excludeSamples].
    @JsonKey(name: 'include_samples') List<String>? includeSamples,

    /// Exclude these sample IDs. Mutually exclusive with [includeSamples].
    @JsonKey(name: 'exclude_samples') List<String>? excludeSamples,

    /// Only run these variant names for this task.
    @JsonKey(name: 'include_variants') List<String>? includeVariants,

    /// Exclude these variant names for this task.
    @JsonKey(name: 'exclude_variants') List<String>? excludeVariants,

    /// Per-task argument overrides passed to the task function.
    @JsonKey(name: 'args') Map<String, dynamic>? args,
  }) = _JobTask;

  factory JobTask.fromJson(Map<String, dynamic> json) =>
      _$JobTaskFromJson(json);

  /// Create a [JobTask] from parsed YAML data.
  factory JobTask.fromYaml(String taskId, Map<String, dynamic>? data) {
    if (data == null) {
      return JobTask(id: taskId);
    }
    return JobTask(
      id: taskId,
      includeSamples: (data['include-samples'] as List?)?.cast<String>(),
      excludeSamples: (data['exclude-samples'] as List?)?.cast<String>(),
      includeVariants: (data['include-variants'] as List?)?.cast<String>(),
      excludeVariants: (data['exclude-variants'] as List?)?.cast<String>(),
      args: (data['args'] as Map?)?.cast<String, dynamic>(),
    );
  }
}
