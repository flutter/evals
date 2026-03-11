import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dataset_config_dart/src/models/models.dart';

part 'eval_set.freezed.dart';
part 'eval_set.g.dart';

/// Dart representation of Inspect AI's `eval_set()` function parameters.
///
/// Models the configuration passed to
/// [`inspect_ai.eval_set()`](https://inspect.aisi.org.uk/reference/inspect_ai.html#eval_set).
///
/// This is the **Inspect AI** side of the eval set contract — it mirrors the
/// Python function signature. For the Dart-side resolved config that is
/// serialised *to* the Python runner, see `config/eval_set.dart`.
@freezed
sealed class EvalSet with _$EvalSet {
  const factory EvalSet({
    /// Task(s) to evaluate.
    ///
    /// Accepts task file paths, task function names, or other task specifiers.
    required List<Task> tasks,

    /// Output path for logging results.
    ///
    /// Required to ensure a unique storage scope is assigned for the set.
    @JsonKey(name: 'log_dir') required String logDir,

    /// Maximum number of retry attempts before giving up (defaults to 10).
    @JsonKey(name: 'retry_attempts') int? retryAttempts,

    /// Time in seconds to wait between retry attempts, increased
    /// exponentially (defaults to 30).
    @JsonKey(name: 'retry_wait') double? retryWait,

    /// Reduce `max_connections` at this rate with each retry
    /// (defaults to 1.0 — no reduction).
    @JsonKey(name: 'retry_connections') double? retryConnections,

    /// Cleanup failed log files after retries (defaults to true).
    @JsonKey(name: 'retry_cleanup') bool? retryCleanup,

    /// Model(s) for evaluation.
    ///
    /// A list of Provider/model strings (e.g. `"openai/gpt-4o"`)
    /// If not specified, uses the `INSPECT_EVAL_MODEL` environment variable.
    List<String>? model,

    /// Base URL for communicating with the model API.
    @JsonKey(name: 'model_base_url') String? modelBaseUrl,

    /// Model creation arguments (dictionary or path to JSON/YAML config).
    @JsonKey(name: 'model_args') @Default({}) Map<String, Object?> modelArgs,

    /// Named roles for use in `get_model()`.
    @JsonKey(name: 'model_roles') Map<String, String>? modelRoles,

    /// Task creation arguments (dictionary or path to JSON/YAML config).
    @JsonKey(name: 'task_args') @Default({}) Map<String, Object?> taskArgs,

    /// Sandbox environment type (or a shorthand spec).
    Object? sandbox,

    /// Cleanup sandbox environments after task completes (defaults to true).
    @JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,

    /// Alternative solver(s) for evaluating task(s).
    Object? solver,

    /// Tags to associate with this evaluation run.
    List<String>? tags,

    /// Metadata to associate with this evaluation run.
    Map<String, dynamic>? metadata,

    /// Trace message interactions with evaluated model to terminal.
    bool? trace,

    /// Task display type (defaults to `"full"`).
    String? display,

    /// Tool use approval policies.
    Object? approval,

    /// Score output (defaults to true).
    @Default(true) bool score,

    /// Level for logging to the console (defaults to `"warning"`).
    @JsonKey(name: 'log_level') String? logLevel,

    /// Level for logging to the log file (defaults to `"info"`).
    @JsonKey(name: 'log_level_transcript') String? logLevelTranscript,

    /// Format for writing log files (`"eval"` or `"json"`).
    @JsonKey(name: 'log_format') String? logFormat,

    /// Limit evaluated samples (defaults to all samples).
    ///
    /// Can be an `int` count or a `[start, end]` range.
    Object? limit,

    /// Evaluate specific sample(s) from the dataset.
    @JsonKey(name: 'sample_id') Object? sampleId,

    /// Shuffle order of samples (pass a seed to make the order deterministic).
    @JsonKey(name: 'sample_shuffle') Object? sampleShuffle,

    /// Epochs to repeat samples for and optional score reducer function(s).
    Object? epochs,

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

    /// Limit on total messages per sample.
    @JsonKey(name: 'message_limit') int? messageLimit,

    /// Limit on total tokens per sample.
    @JsonKey(name: 'token_limit') int? tokenLimit,

    /// Limit on clock time (in seconds) per sample.
    @JsonKey(name: 'time_limit') int? timeLimit,

    /// Limit on working time (in seconds) per sample.
    ///
    /// Working time includes model generation, tool calls, etc. but does not
    /// include waiting on retries or shared resources.
    @JsonKey(name: 'working_limit') int? workingLimit,

    /// Limit on total cost (in dollars) per sample.
    @JsonKey(name: 'cost_limit') double? costLimit,

    /// JSON file with model prices for cost tracking.
    @JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,

    /// Maximum samples to run in parallel (default is `max_connections`).
    @JsonKey(name: 'max_samples') int? maxSamples,

    /// Maximum tasks to run in parallel.
    @JsonKey(name: 'max_tasks') int? maxTasks,

    /// Maximum subprocesses to run in parallel (default is `os.cpu_count()`).
    @JsonKey(name: 'max_subprocesses') int? maxSubprocesses,

    /// Maximum sandboxes (per-provider) to run in parallel.
    @JsonKey(name: 'max_sandboxes') int? maxSandboxes,

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
    @JsonKey(name: 'bundle_overwrite') @Default(false) bool bundleOverwrite,

    /// Allow log directory to contain unrelated logs (defaults to false).
    @JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,

    /// ID for the eval set. Generated if not specified.
    @JsonKey(name: 'eval_set_id') String? evalSetId,
  }) = _EvalSet;

  factory EvalSet.fromJson(Map<String, dynamic> json) =>
      _$EvalSetFromJson(json);
}
