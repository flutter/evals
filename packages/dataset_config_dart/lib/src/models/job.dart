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
/// sandbox: podman
/// max_connections: 10
/// models:
///   - google/gemini-2.5-flash
/// variants:
///   baseline: {}
///   context_only:
///     context_files: [./context_files/flutter.md]
/// tasks:
///   dart_qa:
///     include-samples: [sample_1]
///
/// # Pass-through to eval_set()
/// eval_set_overrides:
///   retry_attempts: 20
///   log_level: debug
///
/// # Default Task-level overrides applied to every task
/// task_defaults:
///   time_limit: 600
///   message_limit: 50
/// ```
@freezed
sealed class Job with _$Job {
  const factory Job({
    // ------------------------------------------------------------------
    // Core job settings
    // ------------------------------------------------------------------

    /// Human-readable description of this job.
    String? description,

    /// Registry URL prefix prepended to image names during sandbox resolution.
    ///
    /// Example: `us-central1-docker.pkg.dev/project/repo/`
    @JsonKey(name: 'image_prefix') String? imagePrefix,

    /// Directory to write evaluation logs to.
    @JsonKey(name: 'log_dir') required String logDir,

    /// Sandbox type: `'local'`, `'docker'`, or `'podman'`.
    @JsonKey(name: 'sandbox_type') @Default('local') String sandboxType,

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
    // Promoted eval_set() parameters (convenience top-level keys)
    // ------------------------------------------------------------------

    /// Maximum retry attempts before giving up (defaults to 10).
    @JsonKey(name: 'retry_attempts') int? retryAttempts,

    /// Maximum number of retry attempts for failed samples.
    @JsonKey(name: 'max_retries') int? maxRetries,

    /// Time in seconds to wait between retry attempts (exponential backoff).
    @JsonKey(name: 'retry_wait') double? retryWait,

    /// Reduce `max_connections` at this rate with each retry (default 1.0).
    @JsonKey(name: 'retry_connections') double? retryConnections,

    /// Cleanup failed log files after retries (defaults to true).
    @JsonKey(name: 'retry_cleanup') bool? retryCleanup,

    /// Fail on sample errors.
    ///
    /// `0.0–1.0` = fail if proportion exceeds threshold,
    /// `>1` = fail if count exceeds threshold.
    @JsonKey(name: 'fail_on_error') double? failOnError,

    /// Continue running even if `fail_on_error` condition is met.
    @JsonKey(name: 'continue_on_fail') bool? continueOnFail,

    /// Number of times to retry samples on error (default: no retries).
    @JsonKey(name: 'retry_on_error') int? retryOnError,

    /// Raise task errors for debugging (defaults to false).
    @JsonKey(name: 'debug_errors') bool? debugErrors,

    /// Maximum samples to run in parallel (default is `max_connections`).
    @JsonKey(name: 'max_samples') int? maxSamples,

    /// Maximum tasks to run in parallel.
    @JsonKey(name: 'max_tasks') int? maxTasks,

    /// Maximum subprocesses to run in parallel.
    @JsonKey(name: 'max_subprocesses') int? maxSubprocesses,

    /// Maximum sandboxes (per-provider) to run in parallel.
    @JsonKey(name: 'max_sandboxes') int? maxSandboxes,

    /// Level for logging to the console (e.g. `"warning"`, `"info"`, `"debug"`).
    @JsonKey(name: 'log_level') String? logLevel,

    /// Level for logging to the log file (defaults to `"info"`).
    @JsonKey(name: 'log_level_transcript') String? logLevelTranscript,

    /// Format for writing log files (`"eval"` or `"json"`).
    @JsonKey(name: 'log_format') String? logFormat,

    /// Tags to associate with this evaluation run.
    List<String>? tags,

    /// Metadata to associate with this evaluation run.
    Map<String, dynamic>? metadata,

    /// Trace message interactions with evaluated model to terminal.
    bool? trace,

    /// Task display type (defaults to `"full"`).
    String? display,

    /// Score output (defaults to true).
    bool? score,

    /// Limit evaluated samples (int count or `[start, end]` range).
    Object? limit,

    /// Evaluate specific sample(s) from the dataset.
    @JsonKey(name: 'sample_id') Object? sampleId,

    /// Shuffle order of samples (pass a seed to make order deterministic).
    @JsonKey(name: 'sample_shuffle') Object? sampleShuffle,

    /// Epochs to repeat samples for and optional score reducer function(s).
    Object? epochs,

    /// Tool use approval policies (string or config dict).
    Object? approval,

    /// Alternative solver(s) for evaluating task(s) (string or config dict).
    Object? solver,

    /// Sandbox cleanup after task completes (defaults to true).
    @JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,

    /// Base URL for communicating with the model API.
    @JsonKey(name: 'model_base_url') String? modelBaseUrl,

    /// Model creation arguments.
    @JsonKey(name: 'model_args') Map<String, Object?>? modelArgs,

    /// Named roles for use in `get_model()`.
    @JsonKey(name: 'model_roles') Map<String, String>? modelRoles,

    /// Task creation arguments.
    @JsonKey(name: 'task_args') Map<String, Object?>? taskArgs,

    /// Limit on total messages per sample.
    @JsonKey(name: 'message_limit') int? messageLimit,

    /// Limit on total tokens per sample.
    @JsonKey(name: 'token_limit') int? tokenLimit,

    /// Limit on clock time (in seconds) per sample.
    @JsonKey(name: 'time_limit') int? timeLimit,

    /// Limit on working time (in seconds) per sample.
    @JsonKey(name: 'working_limit') int? workingLimit,

    /// Limit on total cost (in dollars) per sample.
    @JsonKey(name: 'cost_limit') double? costLimit,

    /// JSON file with model prices for cost tracking.
    @JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,

    /// Log detailed samples and scores (defaults to true).
    @JsonKey(name: 'log_samples') bool? logSamples,

    /// Log events in realtime (defaults to true).
    @JsonKey(name: 'log_realtime') bool? logRealtime,

    /// Log base64-encoded images (defaults to false).
    @JsonKey(name: 'log_images') bool? logImages,

    /// Number of samples to buffer before writing log file.
    @JsonKey(name: 'log_buffer') int? logBuffer,

    /// Sync sample events for realtime viewing.
    @JsonKey(name: 'log_shared') int? logShared,

    /// Directory to bundle logs and viewer into.
    @JsonKey(name: 'bundle_dir') String? bundleDir,

    /// Overwrite files in `bundle_dir` (defaults to false).
    @JsonKey(name: 'bundle_overwrite') bool? bundleOverwrite,

    /// Allow log directory to contain unrelated logs (defaults to false).
    @JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,

    /// ID for the eval set. Generated if not specified.
    @JsonKey(name: 'eval_set_id') String? evalSetId,

    // ------------------------------------------------------------------
    // Pass-through overrides
    // ------------------------------------------------------------------

    /// Additional `eval_set()` kwargs not covered by top-level fields.
    ///
    /// Any valid `eval_set()` parameter can be specified here and will be
    /// merged into the output JSON. Top-level fields take precedence.
    @JsonKey(name: 'eval_set_overrides') Map<String, dynamic>? evalSetOverrides,

    /// Default `Task` kwargs applied to every task in this job.
    ///
    /// Per-task overrides (from `task.yaml`) take precedence.
    @JsonKey(name: 'task_defaults') Map<String, dynamic>? taskDefaults,

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
/// Allows overriding which samples run for specific tasks and providing
/// a custom system message.
@freezed
sealed class JobTask with _$JobTask {
  const factory JobTask({
    /// Task identifier matching a task directory name in `tasks/`.
    required String id,

    /// Only run these sample IDs. Mutually exclusive with [excludeSamples].
    @JsonKey(name: 'include_samples') List<String>? includeSamples,

    /// Exclude these sample IDs. Mutually exclusive with [includeSamples].
    @JsonKey(name: 'exclude_samples') List<String>? excludeSamples,

    /// Override system message for this task.
    @JsonKey(name: 'system_message') String? systemMessage,

    /// Per-task argument overrides passed to the task function.
    @JsonKey(name: 'args') Map<String, dynamic>? args,
  }) = _JobTask;

  factory JobTask.fromJson(Map<String, dynamic> json) =>
      _$JobTaskFromJson(json);

  /// Create a [JobTask] from parsed YAML data.
  ///
  /// The [taskId] is the map key from the job YAML `tasks:` section.
  /// The [data] may be `null` for a simple task reference with no overrides.
  factory JobTask.fromYaml(String taskId, Map<String, dynamic>? data) {
    if (data == null) {
      return JobTask(id: taskId);
    }
    return JobTask(
      id: taskId,
      includeSamples: (data['include-samples'] as List?)?.cast<String>(),
      excludeSamples: (data['exclude-samples'] as List?)?.cast<String>(),
      systemMessage: data['system_message'] as String?,
      args: (data['args'] as Map?)?.cast<String, dynamic>(),
    );
  }
}
