import 'package:freezed_annotation/freezed_annotation.dart';

part 'eval_log.freezed.dart';
part 'eval_log.g.dart';

/// Evaluation log.
@freezed
abstract class EvalLog with _$EvalLog {
  /// Creates an evaluation log.
  const factory EvalLog({
    /// Eval log file format version.
    @Default(2) int version,

    /// Status of evaluation (did it succeed or fail).
    @Default('started') String status,

    /// Eval identity and configuration.
    required EvalSpec eval,

    /// Eval plan (solvers and config).
    EvalPlan? plan,

    /// Eval results (scores and metrics).
    EvalResults? results,

    /// Eval stats (runtime, model usage).
    EvalStats? stats,

    /// Error that halted eval (if status==“error”).
    EvalError? error,

    /// Whether any samples were invalidated.
    @Default(false) bool invalidated,

    /// Samples processed by eval.
    List<EvalSample>? samples,

    /// Reduced sample values.
    List<EvalSampleReductions>? reductions,

    /// Location that the log file was read from.
    String? location,

    /// ETag from S3 for conditional writes.
    String? etag,

    /// Eval set information.
    @JsonKey(name: 'eval_set_info') EvalSetInfo? evalSetInfo,
  }) = _EvalLog;

  const EvalLog._();

  factory EvalLog.fromJson(Map<String, dynamic> json) =>
      _$EvalLogFromJson(json);
}

/// Eval target and configuration.
@freezed
abstract class EvalSpec with _$EvalSpec {
  /// Creates an evaluation specification.
  const factory EvalSpec({
    /// Globally unique id for eval set (if any).
    @JsonKey(name: 'eval_set_id') String? evalSetId,

    /// Globally unique id for eval.
    @JsonKey(name: 'eval_id') required String evalId,

    /// Unique run id.
    @JsonKey(name: 'run_id') required String runId,

    /// Time created.
    required String created,

    /// Task name.
    required String task,

    /// Unique task id.
    @JsonKey(name: 'task_id') required String taskId,

    /// Task version.
    @JsonKey(name: 'task_version', defaultValue: 0)
    @Default(0)
    Object taskVersion,

    /// Task source file.
    @JsonKey(name: 'task_file') String? taskFile,

    /// Task display name.
    @JsonKey(name: 'task_display_name') String? taskDisplayName,

    /// Task registry name.
    @JsonKey(name: 'task_registry_name') String? taskRegistryName,

    /// Attributes of the @task decorator.
    @JsonKey(name: 'task_attribs', defaultValue: {})
    @Default({})
    Map<String, dynamic> taskAttribs,

    /// Arguments used for invoking the task (including defaults).
    @JsonKey(name: 'task_args', defaultValue: {})
    @Default({})
    Map<String, dynamic> taskArgs,

    /// Arguments explicitly passed by caller for invoking the task.
    @JsonKey(name: 'task_args_passed', defaultValue: {})
    @Default({})
    Map<String, dynamic> taskArgsPassed,

    /// Solver name.
    String? solver,

    /// Arguments used for invoking the solver.
    @JsonKey(name: 'solver_args', defaultValue: {})
    @Default({})
    Map<String, dynamic> solverArgs,

    /// Arguments explicitly passed by caller for invoking the solver.
    @JsonKey(name: 'solver_args_passed', defaultValue: {})
    @Default({})
    Map<String, dynamic> solverArgsPassed,

    /// Tags associated with evaluation run.
    @Default([]) List<String> tags,

    /// Dataset used for eval.
    EvalDataset? dataset,

    /// Sandbox environment type and optional config file.
    Object? sandbox,

    /// Model used for eval.
    @JsonKey(name: 'model') required String model,

    /// Generate config specified for model instance.
    @JsonKey(name: 'model_generate_config') GenerateConfig? modelGenerateConfig,

    /// Optional override of model base url.
    @JsonKey(name: 'model_base_url') String? modelBaseUrl,

    /// Model specific arguments.
    @JsonKey(name: 'model_args', defaultValue: {})
    @Default({})
    Map<String, dynamic> modelArgs,

    /// Model roles.
    @JsonKey(name: 'model_roles') Map<String, String>? modelRoles,

    /// Configuration values for eval.
    @Default(EvalConfig()) EvalConfig config,

    /// Source revision of eval.
    EvalRevision? revision,

    /// Package versions for eval.
    @JsonKey(name: 'packages', defaultValue: {})
    @Default({})
    Map<String, String> packages,

    /// Additional eval metadata.
    @JsonKey(name: 'metadata') Map<String, dynamic>? metadata,

    /// Scorers and args for this eval.
    @Default([]) List<Object> scorers,

    /// Metrics and args for this eval.
    @Default([]) List<Object> metrics,
  }) = _EvalSpec;

  const EvalSpec._();

  factory EvalSpec.fromJson(Map<String, dynamic> json) =>
      _$EvalSpecFromJson(json);
}

/// Dataset used for evaluation.
@freezed
abstract class EvalDataset with _$EvalDataset {
  /// Creates an evaluation dataset.
  const factory EvalDataset({
    /// Dataset name.
    String? name,

    /// Dataset location (file path or remote URL).
    String? location,

    /// Number of samples in the dataset.
    required int samples,

    /// IDs of samples in the dataset.
    @JsonKey(name: 'sample_ids') List<Object>? sampleIds,

    /// Was the dataset shuffled after reading.
    @Default(false) bool shuffled,
  }) = _EvalDataset;

  const EvalDataset._();

  factory EvalDataset.fromJson(Map<String, dynamic> json) =>
      _$EvalDatasetFromJson(json);
}

/// Configuration used for evaluation.
@freezed
abstract class EvalConfig with _$EvalConfig {
  /// Creates an evaluation configuration.
  const factory EvalConfig({
    /// Sample limit (number of samples or range of samples).
    Object? limit,

    /// Evaluate specific sample(s).
    @JsonKey(name: 'sample_id') Object? sampleId,

    /// Shuffle order of samples.
    @JsonKey(name: 'sample_shuffle') bool? sampleShuffle,

    /// Number of epochs to run samples over.
    int? epochs,

    /// Reducers for aggregating per-sample scores.
    @JsonKey(name: 'epochs_reducer') List<String>? epochsReducer,

    /// Approval policy for tool use.
    String? approval,

    /// Fail eval when sample errors occur.
    /// True to fail on first sample error (default); False to never fail on sample errors;
    /// Value between 0 and 1 to fail if a proportion of total samples fails.
    /// Value greater than 1 to fail eval if a count of samples fails.
    @JsonKey(name: 'fail_on_error') Object? failOnError,

    /// Continue eval even if the fail_on_error condition is met.
    @JsonKey(name: 'continue_on_fail') bool? continueOnFail,

    /// Number of times to retry samples if they encounter errors.
    @JsonKey(name: 'retry_on_error') int? retryOnError,

    /// Maximum messages to allow per sample.
    @JsonKey(name: 'message_limit') int? messageLimit,

    /// Maximum tokens usage per sample.
    @JsonKey(name: 'token_limit') int? tokenLimit,

    /// Maximum clock time per sample.
    @JsonKey(name: 'time_limit') int? timeLimit,

    /// Maximum working time per sample.
    @JsonKey(name: 'working_limit') int? workingLimit,

    /// Maximum number of samples to run in parallel.
    @JsonKey(name: 'max_samples') int? maxSamples,

    /// Maximum number of tasks to run in parallel.
    @JsonKey(name: 'max_tasks') int? maxTasks,

    /// Maximum number of subprocesses to run concurrently.
    @JsonKey(name: 'max_subprocesses') int? maxSubprocesses,

    /// Maximum number of sandboxes to run concurrently.
    @JsonKey(name: 'max_sandboxes') int? maxSandboxes,

    /// Cleanup sandbox environments after task completes.
    @JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,

    /// Log detailed information on each sample.
    @JsonKey(name: 'log_samples') bool? logSamples,

    /// Log events in realtime (enables live viewing of samples in inspect view).
    @JsonKey(name: 'log_realtime') bool? logRealtime,

    /// Log base64 encoded versions of images.
    @JsonKey(name: 'log_images') bool? logImages,

    /// Number of samples to buffer before writing log file.
    @JsonKey(name: 'log_buffer') int? logBuffer,

    /// Interval (in seconds) for syncing sample events to log directory.
    @JsonKey(name: 'log_shared') int? logShared,

    /// Display scoring metrics realtime.
    @JsonKey(name: 'score_display') bool? scoreDisplay,
  }) = _EvalConfig;

  const EvalConfig._();

  factory EvalConfig.fromJson(Map<String, dynamic> json) =>
      _$EvalConfigFromJson(json);
}

/// Git revision for evaluation.
@freezed
abstract class EvalRevision with _$EvalRevision {
  /// Creates an evaluation revision.
  const factory EvalRevision({
    /// Type of revision (currently only “git”).
    required String type,

    /// Revision origin server.
    required String origin,

    /// Revision commit.
    required String commit,

    /// Working tree has uncommitted changes or untracked files.
    @Default(false) bool dirty,
  }) = _EvalRevision;

  const EvalRevision._();

  factory EvalRevision.fromJson(Map<String, dynamic> json) =>
      _$EvalRevisionFromJson(json);
}

/// Plan (solvers) used in evaluation.
@freezed
abstract class EvalPlan with _$EvalPlan {
  /// Creates an evaluation plan.
  const factory EvalPlan({
    /// Plan name.
    @Default('plan') String name,

    /// Steps in plan.
    @Default([]) List<EvalPlanStep> steps,

    /// Step to always run at the end.
    EvalPlanStep? finish,

    /// Generation config.
    @Default(GenerateConfig()) GenerateConfig config,
  }) = _EvalPlan;

  const EvalPlan._();

  factory EvalPlan.fromJson(Map<String, dynamic> json) =>
      _$EvalPlanFromJson(json);
}

/// Solver step.
@freezed
abstract class EvalPlanStep with _$EvalPlanStep {
  /// Creates an evaluation plan step.
  const factory EvalPlanStep({
    /// Name of solver.
    required String solver,

    /// Parameters used to instantiate solver.
    @Default({}) Map<String, dynamic> params,

    /// Parameters explicitly passed to the eval plan.
    @JsonKey(name: 'params_passed') Map<String, dynamic>? paramsPassed,
  }) = _EvalPlanStep;

  const EvalPlanStep._();

  factory EvalPlanStep.fromJson(Map<String, dynamic> json) =>
      _$EvalPlanStepFromJson(json);
}

/// Scoring results from evaluation.
@freezed
abstract class EvalResults with _$EvalResults {
  /// Creates evaluation results.
  const factory EvalResults({
    /// Total samples in eval (dataset samples * epochs).
    @JsonKey(name: 'total_samples', defaultValue: 0)
    @Default(0)
    int totalSamples,

    /// Samples completed without error.
    @JsonKey(name: 'completed_samples', defaultValue: 0)
    @Default(0)
    int completedSamples,

    /// Early stopping summary (if an early stopping manager was present).
    @JsonKey(name: 'early_stopping') EarlyStoppingSummary? earlyStopping,

    /// Scorers used to compute results.
    @Default([]) List<EvalScore> scores,

    /// Additional results metadata.
    @Default({}) Map<String, dynamic> metadata,

    /// List of per sample scores reduced across epochs.
    @JsonKey(name: 'sample_reductions')
    List<EvalSampleReductions>? sampleReductions,
  }) = _EvalResults;

  const EvalResults._();

  factory EvalResults.fromJson(Map<String, dynamic> json) =>
      _$EvalResultsFromJson(json);
}

/// Early stopping summary.
@freezed
abstract class EarlyStoppingSummary with _$EarlyStoppingSummary {
  /// Creates an early stopping summary.
  const factory EarlyStoppingSummary({
    /// Type of early stopping.
    required String type,

    /// Limit that triggered early stopping.
    double? limit,

    /// Score that triggered early stopping.
    double? score,

    /// Additional metadata.
    @Default({}) Map<String, dynamic> metadata,
  }) = _EarlyStoppingSummary;

  const EarlyStoppingSummary._();

  factory EarlyStoppingSummary.fromJson(Map<String, dynamic> json) =>
      _$EarlyStoppingSummaryFromJson(json);
}

/// Score for evaluation task.
@freezed
abstract class EvalScore with _$EvalScore {
  /// Creates an evaluation score.
  const factory EvalScore({
    /// Score name.
    required String name,

    /// Scorer name.
    required String scorer,

    /// Reducer name.
    String? reducer,

    /// Number of samples scored by this scorer.
    @JsonKey(name: 'scored_samples') int? scoredSamples,

    /// Number of samples not scored by this scorer.
    @JsonKey(name: 'unscored_samples') int? unscoredSamples,

    /// Parameters specified when creating scorer.
    @Default({}) Map<String, dynamic> params,

    /// Metrics computed for this scorer.
    @JsonKey(fromJson: _metricsFromJson) @Default([]) List<EvalMetric> metrics,

    /// Additional scorer metadata.
    @JsonKey(name: 'metadata') Map<String, dynamic>? metadata,
  }) = _EvalScore;

  const EvalScore._();

  factory EvalScore.fromJson(Map<String, dynamic> json) =>
      _$EvalScoreFromJson(json);
}

/// Converts metrics from Map or List format to [List<EvalMetric>].
List<EvalMetric> _metricsFromJson(Object? json) {
  if (json == null) return [];

  // If it's already a list, parse it normally
  if (json is List) {
    return json
        .map((e) => EvalMetric.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // If it's a map (old format), convert to list
  if (json is Map<String, dynamic>) {
    return json.values
        .map((e) => EvalMetric.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  return [];
}

/// Metric for evaluation score.
@freezed
abstract class EvalMetric with _$EvalMetric {
  /// Creates an evaluation metric.
  const factory EvalMetric({
    /// Metric name.
    required String name,

    /// Metric value.
    required Object value,

    /// Params specified when creating metric.
    @Default({}) Map<String, dynamic> params,

    /// Additional metadata associated with metric.
    Map<String, dynamic>? metadata,
  }) = _EvalMetric;

  const EvalMetric._();

  factory EvalMetric.fromJson(Map<String, dynamic> json) =>
      _$EvalMetricFromJson(json);
}

/// Score reductions.
@freezed
abstract class EvalSampleReductions with _$EvalSampleReductions {
  /// Creates evaluation sample reductions.
  const factory EvalSampleReductions({
    /// Name the of scorer.
    required String scorer,

    /// Name the of reducer.
    String? reducer,

    /// List of reduced scores.
    required List<EvalSampleScore> samples,
  }) = _EvalSampleReductions;

  const EvalSampleReductions._();

  factory EvalSampleReductions.fromJson(Map<String, dynamic> json) =>
      _$EvalSampleReductionsFromJson(json);
}

/// Timing and usage statistics.
@freezed
abstract class EvalStats with _$EvalStats {
  /// Creates evaluation statistics.
  const factory EvalStats({
    /// Evaluation start time. Empty string if eval interrupted before start time set.
    @JsonKey(name: 'started_at') required String startedAt,

    /// Evaluation completion time. Empty string if eval interrupted before completion.
    @JsonKey(name: 'completed_at') required String completedAt,

    /// Model token usage for evaluation.
    @JsonKey(name: 'model_usage', defaultValue: {})
    @Default({})
    Map<String, ModelUsage> modelUsage,
  }) = _EvalStats;

  const EvalStats._();

  factory EvalStats.fromJson(Map<String, dynamic> json) =>
      _$EvalStatsFromJson(json);
}

/// Eval error details.
@freezed
abstract class EvalError with _$EvalError {
  /// Creates evaluation error details.
  const factory EvalError({
    /// Error message.
    required String message,

    /// Error traceback.
    required String traceback,

    /// Error traceback with ANSI color codes.
    @JsonKey(name: 'traceback_ansi') required String tracebackAnsi,
  }) = _EvalError;

  const EvalError._();

  factory EvalError.fromJson(Map<String, dynamic> json) =>
      _$EvalErrorFromJson(json);
}

/// Sample from evaluation task.
@freezed
abstract class EvalSample with _$EvalSample {
  /// Creates an evaluation sample.
  const factory EvalSample({
    /// Unique id for sample.
    required Object id,

    /// Epoch number for sample.
    required int epoch,

    /// Sample input.
    required Object input,

    /// Sample choices.
    List<String>? choices,

    /// Sample target value(s).
    Object? target,

    /// Additional sample metadata.
    @Default({}) Map<String, dynamic> metadata,

    /// Sandbox environment type and optional config file.
    Object? sandbox,

    /// Files that go along with the sample (copied to SandboxEnvironment).
    List<String>? files,

    /// Setup script to run for sample (run within default SandboxEnvironment).
    String? setup,

    /// Chat conversation history for sample.
    @Default([]) List<ChatMessage> messages,

    /// Model output from sample.
    required ModelOutput output,

    /// Scores for sample.
    Map<String, Score>? scores,

    /// State at end of sample execution.
    @Default({}) Map<String, dynamic> store,

    /// Events that occurred during sample execution.
    @Default([]) List<Object> events,

    /// Model token usage for sample.
    @JsonKey(name: 'model_usage', defaultValue: {})
    @Default({})
    Map<String, ModelUsage> modelUsage,

    /// Time sample started.
    @JsonKey(name: 'started_at') String? startedAt,

    /// Time sample completed.
    @JsonKey(name: 'completed_at') String? completedAt,

    /// Total time that the sample was running.
    @JsonKey(name: 'total_time') double? totalTime,

    /// Time spent working (model generation, sandbox calls, etc.).
    @JsonKey(name: 'working_time') double? workingTime,

    /// Globally unique identifier for sample run.
    String? uuid,

    /// Provenance data for invalidation.
    ProvenanceData? invalidation,

    /// Error that halted sample.
    EvalError? error,

    /// Errors that were retried for this sample.
    @JsonKey(name: 'error_retries') List<EvalError>? errorRetries,

    /// Attachments referenced from messages and events.
    @Default({}) Map<String, String> attachments,

    /// The limit that halted the sample.
    EvalSampleLimit? limit,
  }) = _EvalSample;

  const EvalSample._();

  factory EvalSample.fromJson(Map<String, dynamic> json) =>
      _$EvalSampleFromJson(json);
}

/// Model output.
@freezed
abstract class ModelOutput with _$ModelOutput {
  /// Creates model output.
  const factory ModelOutput({
    /// Model used for generation.
    required String model,

    /// Completion choices.
    @Default([]) List<ChatCompletionChoice> choices,

    /// Model token usage.
    ModelUsage? usage,

    /// Model completion.
    required String completion,

    /// First message stop reason.
    @JsonKey(name: 'stop_reason', defaultValue: 'unknown')
    @Default('unknown')
    String stopReason,

    /// Time elapsed (in seconds) for call to generate.
    double? time,

    /// Additional metadata associated with model output.
    @Default({}) Map<String, dynamic> metadata,

    /// Error message in the case of content moderation refusals.
    String? error,

    /// First message choice.
    ChatMessageAssistant? message,
  }) = _ModelOutput;

  const ModelOutput._();

  factory ModelOutput.fromJson(Map<String, dynamic> json) =>
      _$ModelOutputFromJson(json);
}

/// Choice generated for completion.
@freezed
abstract class ChatCompletionChoice with _$ChatCompletionChoice {
  /// Creates a chat completion choice.
  const factory ChatCompletionChoice({
    /// Assistant message.
    required ChatMessageAssistant message,

    /// Reason that the model stopped generating.
    @JsonKey(name: 'stop_reason', defaultValue: 'unknown')
    @Default('unknown')
    String stopReason,

    /// Logprobs.
    Logprobs? logprobs,
  }) = _ChatCompletionChoice;

  const ChatCompletionChoice._();

  factory ChatCompletionChoice.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionChoiceFromJson(json);
}

/// Token usage for completion.
@freezed
abstract class ModelUsage with _$ModelUsage {
  /// Creates model usage details.
  const factory ModelUsage({
    /// Total input tokens used.
    @JsonKey(name: 'input_tokens', defaultValue: 0) @Default(0) int inputTokens,

    /// Total output tokens used.
    @JsonKey(name: 'output_tokens', defaultValue: 0)
    @Default(0)
    int outputTokens,

    /// Total tokens used.
    @JsonKey(name: 'total_tokens', defaultValue: 0) @Default(0) int totalTokens,

    /// Number of tokens written to the cache.
    @JsonKey(name: 'input_tokens_cache_write') int? inputTokensCacheWrite,

    /// Number of tokens retrieved from the cache.
    @JsonKey(name: 'input_tokens_cache_read') int? inputTokensCacheRead,

    /// Number of tokens used for reasoning.
    @JsonKey(name: 'reasoning_tokens', defaultValue: 0)
    @Default(0)
    int reasoningTokens,
  }) = _ModelUsage;

  const ModelUsage._();

  factory ModelUsage.fromJson(Map<String, dynamic> json) =>
      _$ModelUsageFromJson(json);
}

/// Chat message.
@Freezed(unionKey: 'role', unionValueCase: FreezedUnionCase.snake)
sealed class ChatMessage with _$ChatMessage {
  /// System chat message.
  const factory ChatMessage.system({
    /// Unique identifer for message.
    String? id,

    /// Content (simple string or list of content objects).
    required Object content,

    /// Source of message.
    String? source,

    /// Additional message metadata.
    Map<String, dynamic>? metadata,

    /// Conversation role.
    @Default('system') String role,
  }) = ChatMessageSystem;

  /// User chat message.
  const factory ChatMessage.user({
    /// Unique identifer for message.
    String? id,

    /// Content (simple string or list of content objects).
    required Object content,

    /// Source of message.
    String? source,

    /// Additional message metadata.
    Map<String, dynamic>? metadata,

    /// Conversation role.
    @Default('user') String role,

    /// ID(s) of tool call(s) this message has the content payload for.
    @JsonKey(name: 'tool_call_id') Object? toolCallId,
  }) = ChatMessageUser;

  /// Assistant chat message.
  const factory ChatMessage.assistant({
    /// Unique identifer for message.
    String? id,

    /// Content (simple string or list of content objects).
    required Object content,

    /// Source of message.
    String? source,

    /// Additional message metadata.
    Map<String, dynamic>? metadata,

    /// Conversation role.
    @Default('assistant') String role,

    /// Tool calls made by the model.
    @JsonKey(name: 'tool_calls') List<ToolCall>? toolCalls,

    /// Model used to generate assistant message.
    String? model,
  }) = ChatMessageAssistant;

  /// Tool chat message.
  const factory ChatMessage.tool({
    /// Unique identifer for message.
    String? id,

    /// Content (simple string or list of content objects).
    required Object content,

    /// Source of message.
    String? source,

    /// Additional message metadata.
    Map<String, dynamic>? metadata,

    /// Conversation role.
    @Default('tool') String role,

    /// ID of tool call.
    @JsonKey(name: 'tool_call_id') String? toolCallId,

    /// Name of function called.
    String? function,

    /// Error which occurred during tool call.
    ToolCallError? error,
  }) = ChatMessageTool;

  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

/// Content sent to or received from a model.
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class Content with _$Content {
  /// Text content.
  const factory Content.text({
    /// Text content.
    required String text,

    /// Was this a refusal message?
    @Default(false) bool refusal,

    /// Citations supporting the text block.
    List<Object>? citations,

    /// Content type.
    @Default('text') String type,
  }) = ContentText;

  /// Reasoning content.
  const factory Content.reasoning({
    /// Reasoning content.
    required String reasoning,

    /// Reasoning summary.
    String? summary,

    /// Signature for reasoning content.
    String? signature,

    /// Indicates that the explicit content of this reasoning block has been redacted.
    @Default(false) bool redacted,

    /// Pure text rendering of reasoning.
    String? text,

    /// Content type.
    @Default('reasoning') String type,
  }) = ContentReasoning;

  /// Image content.
  const factory Content.image({
    /// Either a URL of the image or the base64 encoded image data.
    required String image,

    /// Specifies the detail level of the image.
    @Default('auto') String detail,

    /// Content type.
    @Default('image') String type,
  }) = ContentImage;

  /// Audio content.
  const factory Content.audio({
    /// Audio file path or base64 encoded data URL.
    required String audio,

    /// Format of audio data (‘mp3’ or ‘wav’).
    required String format,

    /// Content type.
    @Default('audio') String type,
  }) = ContentAudio;

  /// Video content.
  const factory Content.video({
    /// Video file path or base64 encoded data URL.
    required String video,

    /// Format of video data (‘mp4’, ‘mpeg’, or ‘mov’).
    required String format,

    /// Content type.
    @Default('video') String type,
  }) = ContentVideo;

  /// Document content.
  const factory Content.document({
    /// Document file path or base64 encoded data URL.
    required String document,

    /// Document filename.
    String? filename,

    /// Document mime type.
    @JsonKey(name: 'mime_type') String? mimeType,

    /// Content type.
    @Default('document') String type,
  }) = ContentDocument;

  /// Model internal data.
  const factory Content.data({
    /// Model provider specific payload.
    required Map<String, dynamic> data,

    /// Content type.
    @Default('data') String type,
  }) = ContentData;

  /// Server side tool use.
  const factory Content.toolUse({
    /// The type of the tool call.
    @JsonKey(name: 'tool_type') required String toolType,

    /// The unique ID of the tool call.
    required String id,

    /// Name of the tool.
    required String name,

    /// Tool context (e.g. MCP Server).
    Map<String, dynamic>? context,

    /// Arguments passed to the tool.
    required Map<String, dynamic> arguments,

    /// Result from the tool call.
    Object? result,

    /// The error from the tool call (if any).
    Object? error,

    /// Content type.
    @Default('tool_use') String type,
  }) = ContentToolUse;

  const Content._();

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

/// Score and sample_id scored.
@freezed
abstract class EvalSampleScore with _$EvalSampleScore {
  /// Creates an evaluation sample score.
  const factory EvalSampleScore({
    /// Score value.
    required Object value,

    /// Model's answer (for logging).
    String? answer,

    /// Why this score was given.
    String? explanation,

    /// Additional metadata.
    @Default({}) Map<String, dynamic> metadata,

    /// History of scores (if applicable).
    @Default([]) List<Object> history,

    /// Sample ID.
    @JsonKey(name: 'sample_id') Object? sampleId,
  }) = _EvalSampleScore;

  const EvalSampleScore._();

  factory EvalSampleScore.fromJson(Map<String, dynamic> json) =>
      _$EvalSampleScoreFromJson(json);
}

/// Score for evaluation.
@freezed
abstract class Score with _$Score {
  /// Creates a score.
  const factory Score({
    /// Score value.
    required Object value,

    /// Model's answer (for logging).
    String? answer,

    /// Why this score was given.
    String? explanation,

    /// Additional metadata.
    Map<String, dynamic>? metadata,
  }) = _Score;

  const Score._();

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

/// Tool call details.
@freezed
abstract class ToolCall with _$ToolCall {
  /// Creates tool call details.
  const factory ToolCall({
    /// Unique ID of tool call.
    required String id,

    /// Name of function called.
    required String function,

    /// Arguments passed to function.
    required Map<String, dynamic> arguments,

    /// Type of tool call.
    @Default('call') String type,
  }) = _ToolCall;

  const ToolCall._();

  factory ToolCall.fromJson(Map<String, dynamic> json) =>
      _$ToolCallFromJson(json);
}

/// Tool call error.
@freezed
abstract class ToolCallError with _$ToolCallError {
  /// Creates a tool call error.
  const factory ToolCallError({
    /// Error message.
    required String message,

    /// Error code.
    int? code,

    /// Additional error data.
    @JsonKey(name: 'data') Map<String, dynamic>? data,
  }) = _ToolCallError;

  const ToolCallError._();

  factory ToolCallError.fromJson(Map<String, dynamic> json) =>
      _$ToolCallErrorFromJson(json);
}

/// Model generation options.
@freezed
abstract class GenerateConfig with _$GenerateConfig {
  /// Creates model generation options.
  const factory GenerateConfig({
    /// Maximum number of times to retry a request.
    @JsonKey(name: 'max_retries') int? maxRetries,

    /// Request timeout (in seconds).
    int? timeout,

    /// Timeout for each individual request attempt (in seconds).
    @JsonKey(name: 'attempt_timeout') int? attemptTimeout,

    /// Maximum number of concurrent connections to the model API.
    @JsonKey(name: 'max_connections') int? maxConnections,

    /// System message to provide to the model.
    @JsonKey(name: 'system_message') String? systemMessage,

    /// Maximum number of tokens to generate.
    @JsonKey(name: 'max_tokens') int? maxTokens,

    /// Top-p sampling parameter.
    @JsonKey(name: 'top_p') double? topP,

    /// Temperature sampling parameter.
    double? temperature,

    /// Sequences that should stop generation.
    @JsonKey(name: 'stop_seqs') List<String>? stopSeqs,

    /// Number of completions to generate and choose the best from.
    @JsonKey(name: 'best_of') int? bestOf,

    /// Frequency penalty parameter.
    @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,

    /// Presence penalty parameter.
    @JsonKey(name: 'presence_penalty') double? presencePenalty,

    /// Logit bias parameter.
    @JsonKey(name: 'logit_bias') Map<String, double>? logitBias,

    /// Random seed for generation.
    int? seed,

    /// Top-k sampling parameter.
    @JsonKey(name: 'top_k') int? topK,

    /// Number of completion choices to return.
    @JsonKey(name: 'num_choices') int? numChoices,

    /// Whether to return logprobs.
    bool? logprobs,

    /// Number of top logprobs to return.
    @JsonKey(name: 'top_logprobs') int? topLogprobs,

    /// Whether to allow parallel tool calls.
    @JsonKey(name: 'parallel_tool_calls') bool? parallelToolCalls,

    /// Whether to allow internal model tools.
    @JsonKey(name: 'internal_tools') bool? internalTools,

    /// Maximum number of characters to retain for tool output.
    @JsonKey(name: 'max_tool_output') int? maxToolOutput,

    /// Cache the prompt (if supported by the provider).
    @JsonKey(name: 'cache_prompt') Object? cachePrompt,
  }) = _GenerateConfig;

  const GenerateConfig._();

  factory GenerateConfig.fromJson(Map<String, dynamic> json) =>
      _$GenerateConfigFromJson(json);
}

/// Logprobs for chat completion.
@freezed
abstract class Logprobs with _$Logprobs {
  /// Creates logprobs.
  const factory Logprobs({
    /// Logprob content.
    required List<Object> content,
  }) = _Logprobs;

  const Logprobs._();

  factory Logprobs.fromJson(Map<String, dynamic> json) =>
      _$LogprobsFromJson(json);
}

/// Provenance data for invalidation.
@freezed
abstract class ProvenanceData with _$ProvenanceData {
  /// Creates provenance data.
  const factory ProvenanceData({
    /// Source location.
    required String location,

    /// Static hash.
    required String shash,
  }) = _ProvenanceData;

  const ProvenanceData._();

  factory ProvenanceData.fromJson(Map<String, dynamic> json) =>
      _$ProvenanceDataFromJson(json);
}

/// Limit encountered by sample.
@freezed
abstract class EvalSampleLimit with _$EvalSampleLimit {
  /// Creates an evaluation sample limit.
  const factory EvalSampleLimit({
    /// The type of limit.
    required String type,

    /// The limit value.
    required double limit,
  }) = _EvalSampleLimit;

  const EvalSampleLimit._();

  factory EvalSampleLimit.fromJson(Map<String, dynamic> json) =>
      _$EvalSampleLimitFromJson(json);
}

/// Eval set information.
@freezed
abstract class EvalSetInfo with _$EvalSetInfo {
  /// Creates evaluation set information.
  const factory EvalSetInfo({
    /// Globally unique id for eval set.
    @JsonKey(name: 'eval_set_id') required String evalSetId,

    /// Tasks in the eval set.
    required List<EvalSetTask> tasks,
  }) = _EvalSetInfo;

  const EvalSetInfo._();

  factory EvalSetInfo.fromJson(Map<String, dynamic> json) =>
      _$EvalSetInfoFromJson(json);
}

/// Task in an eval set.
@freezed
abstract class EvalSetTask with _$EvalSetTask {
  /// Creates an evaluation set task.
  const factory EvalSetTask({
    /// Task name.
    String? name,

    /// Unique task id.
    @JsonKey(name: 'task_id') required String taskId,

    /// Task source file.
    @JsonKey(name: 'task_file') String? taskFile,

    /// Task arguments.
    @JsonKey(name: 'task_args', defaultValue: {})
    @Default({})
    Map<String, dynamic> taskArgs,

    /// Model used for evaluation.
    required String model,

    /// Model specific arguments.
    @JsonKey(name: 'model_args', defaultValue: {})
    @Default({})
    Map<String, dynamic> modelArgs,

    /// Model roles.
    @JsonKey(name: 'model_roles') Map<String, String>? modelRoles,

    /// Sequence number of task in eval set.
    required int sequence,
  }) = _EvalSetTask;

  const EvalSetTask._();

  factory EvalSetTask.fromJson(Map<String, dynamic> json) =>
      _$EvalSetTaskFromJson(json);
}
