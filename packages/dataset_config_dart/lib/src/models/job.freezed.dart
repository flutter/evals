// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Job {

// ------------------------------------------------------------------
// Core job settings
// ------------------------------------------------------------------
/// Human-readable description of this job.
 String? get description;/// Registry URL prefix prepended to image names during sandbox resolution.
///
/// Example: `us-central1-docker.pkg.dev/project/repo/`
@JsonKey(name: 'image_prefix') String? get imagePrefix;/// Directory to write evaluation logs to.
@JsonKey(name: 'log_dir') String get logDir;/// Sandbox type: `'local'`, `'docker'`, or `'podman'`.
@JsonKey(name: 'sandbox_type') String get sandboxType;/// Maximum concurrent API connections.
@JsonKey(name: 'max_connections') int get maxConnections;/// Models to run. `null` means use defaults from registries.
 List<String>? get models;/// Named variant map. Keys are variant names, values are config dicts.
/// `null` means baseline only.
 Map<String, Map<String, dynamic>>? get variants;/// Glob patterns for discovering task directories (relative to dataset root).
@JsonKey(name: 'task_paths') List<String>? get taskPaths;/// Per-task configurations with inline overrides.
/// `null` means run all tasks.
 Map<String, JobTask>? get tasks;/// If `true`, copy final workspace to `<logDir>/examples/` after each sample.
@JsonKey(name: 'save_examples') bool get saveExamples;// ------------------------------------------------------------------
// Promoted eval_set() parameters (convenience top-level keys)
// ------------------------------------------------------------------
/// Maximum retry attempts before giving up (defaults to 10).
@JsonKey(name: 'retry_attempts') int? get retryAttempts;/// Maximum number of retry attempts for failed samples.
@JsonKey(name: 'max_retries') int? get maxRetries;/// Time in seconds to wait between retry attempts (exponential backoff).
@JsonKey(name: 'retry_wait') double? get retryWait;/// Reduce `max_connections` at this rate with each retry (default 1.0).
@JsonKey(name: 'retry_connections') double? get retryConnections;/// Cleanup failed log files after retries (defaults to true).
@JsonKey(name: 'retry_cleanup') bool? get retryCleanup;/// Fail on sample errors.
///
/// `0.0–1.0` = fail if proportion exceeds threshold,
/// `>1` = fail if count exceeds threshold.
@JsonKey(name: 'fail_on_error') double? get failOnError;/// Continue running even if `fail_on_error` condition is met.
@JsonKey(name: 'continue_on_fail') bool? get continueOnFail;/// Number of times to retry samples on error (default: no retries).
@JsonKey(name: 'retry_on_error') int? get retryOnError;/// Raise task errors for debugging (defaults to false).
@JsonKey(name: 'debug_errors') bool? get debugErrors;/// Maximum samples to run in parallel (default is `max_connections`).
@JsonKey(name: 'max_samples') int? get maxSamples;/// Maximum tasks to run in parallel.
@JsonKey(name: 'max_tasks') int? get maxTasks;/// Maximum subprocesses to run in parallel.
@JsonKey(name: 'max_subprocesses') int? get maxSubprocesses;/// Maximum sandboxes (per-provider) to run in parallel.
@JsonKey(name: 'max_sandboxes') int? get maxSandboxes;/// Level for logging to the console (e.g. `"warning"`, `"info"`, `"debug"`).
@JsonKey(name: 'log_level') String? get logLevel;/// Level for logging to the log file (defaults to `"info"`).
@JsonKey(name: 'log_level_transcript') String? get logLevelTranscript;/// Format for writing log files (`"eval"` or `"json"`).
@JsonKey(name: 'log_format') String? get logFormat;/// Tags to associate with this evaluation run.
 List<String>? get tags;/// Metadata to associate with this evaluation run.
 Map<String, dynamic>? get metadata;/// Trace message interactions with evaluated model to terminal.
 bool? get trace;/// Task display type (defaults to `"full"`).
 String? get display;/// Score output (defaults to true).
 bool? get score;/// Limit evaluated samples (int count or `[start, end]` range).
 Object? get limit;/// Evaluate specific sample(s) from the dataset.
@JsonKey(name: 'sample_id') Object? get sampleId;/// Shuffle order of samples (pass a seed to make order deterministic).
@JsonKey(name: 'sample_shuffle') Object? get sampleShuffle;/// Epochs to repeat samples for and optional score reducer function(s).
 Object? get epochs;/// Tool use approval policies (string or config dict).
 Object? get approval;/// Alternative solver(s) for evaluating task(s) (string or config dict).
 Object? get solver;/// Sandbox cleanup after task completes (defaults to true).
@JsonKey(name: 'sandbox_cleanup') bool? get sandboxCleanup;/// Base URL for communicating with the model API.
@JsonKey(name: 'model_base_url') String? get modelBaseUrl;/// Model creation arguments.
@JsonKey(name: 'model_args') Map<String, Object?>? get modelArgs;/// Named roles for use in `get_model()`.
@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles;/// Task creation arguments.
@JsonKey(name: 'task_args') Map<String, Object?>? get taskArgs;/// Limit on total messages per sample.
@JsonKey(name: 'message_limit') int? get messageLimit;/// Limit on total tokens per sample.
@JsonKey(name: 'token_limit') int? get tokenLimit;/// Limit on clock time (in seconds) per sample.
@JsonKey(name: 'time_limit') int? get timeLimit;/// Limit on working time (in seconds) per sample.
@JsonKey(name: 'working_limit') int? get workingLimit;/// Limit on total cost (in dollars) per sample.
@JsonKey(name: 'cost_limit') double? get costLimit;/// JSON file with model prices for cost tracking.
@JsonKey(name: 'model_cost_config') Map<String, Object?>? get modelCostConfig;/// Log detailed samples and scores (defaults to true).
@JsonKey(name: 'log_samples') bool? get logSamples;/// Log events in realtime (defaults to true).
@JsonKey(name: 'log_realtime') bool? get logRealtime;/// Log base64-encoded images (defaults to false).
@JsonKey(name: 'log_images') bool? get logImages;/// Number of samples to buffer before writing log file.
@JsonKey(name: 'log_buffer') int? get logBuffer;/// Sync sample events for realtime viewing.
@JsonKey(name: 'log_shared') int? get logShared;/// Directory to bundle logs and viewer into.
@JsonKey(name: 'bundle_dir') String? get bundleDir;/// Overwrite files in `bundle_dir` (defaults to false).
@JsonKey(name: 'bundle_overwrite') bool? get bundleOverwrite;/// Allow log directory to contain unrelated logs (defaults to false).
@JsonKey(name: 'log_dir_allow_dirty') bool? get logDirAllowDirty;/// ID for the eval set. Generated if not specified.
@JsonKey(name: 'eval_set_id') String? get evalSetId;// ------------------------------------------------------------------
// Pass-through overrides
// ------------------------------------------------------------------
/// Additional `eval_set()` kwargs not covered by top-level fields.
///
/// Any valid `eval_set()` parameter can be specified here and will be
/// merged into the output JSON. Top-level fields take precedence.
@JsonKey(name: 'eval_set_overrides') Map<String, dynamic>? get evalSetOverrides;/// Default `Task` kwargs applied to every task in this job.
///
/// Per-task overrides (from `task.yaml`) take precedence.
@JsonKey(name: 'task_defaults') Map<String, dynamic>? get taskDefaults;// ------------------------------------------------------------------
// Tag-based filtering
// ------------------------------------------------------------------
/// Tag filters applied to tasks.
@JsonKey(name: 'task_filters') TagFilter? get taskFilters;/// Tag filters applied to samples.
@JsonKey(name: 'sample_filters') TagFilter? get sampleFilters;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePrefix, imagePrefix) || other.imagePrefix == imagePrefix)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.sandboxType, sandboxType) || other.sandboxType == sandboxType)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&const DeepCollectionEquality().equals(other.models, models)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.taskPaths, taskPaths)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.saveExamples, saveExamples) || other.saveExamples == saveExamples)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.retryWait, retryWait) || other.retryWait == retryWait)&&(identical(other.retryConnections, retryConnections) || other.retryConnections == retryConnections)&&(identical(other.retryCleanup, retryCleanup) || other.retryCleanup == retryCleanup)&&(identical(other.failOnError, failOnError) || other.failOnError == failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.debugErrors, debugErrors) || other.debugErrors == debugErrors)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.logLevelTranscript, logLevelTranscript) || other.logLevelTranscript == logLevelTranscript)&&(identical(other.logFormat, logFormat) || other.logFormat == logFormat)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.trace, trace) || other.trace == trace)&&(identical(other.display, display) || other.display == display)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&const DeepCollectionEquality().equals(other.sampleShuffle, sampleShuffle)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&const DeepCollectionEquality().equals(other.approval, approval)&&const DeepCollectionEquality().equals(other.solver, solver)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other.modelArgs, modelArgs)&&const DeepCollectionEquality().equals(other.modelRoles, modelRoles)&&const DeepCollectionEquality().equals(other.taskArgs, taskArgs)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other.modelCostConfig, modelCostConfig)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.bundleDir, bundleDir) || other.bundleDir == bundleDir)&&(identical(other.bundleOverwrite, bundleOverwrite) || other.bundleOverwrite == bundleOverwrite)&&(identical(other.logDirAllowDirty, logDirAllowDirty) || other.logDirAllowDirty == logDirAllowDirty)&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&const DeepCollectionEquality().equals(other.evalSetOverrides, evalSetOverrides)&&const DeepCollectionEquality().equals(other.taskDefaults, taskDefaults)&&(identical(other.taskFilters, taskFilters) || other.taskFilters == taskFilters)&&(identical(other.sampleFilters, sampleFilters) || other.sampleFilters == sampleFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,description,imagePrefix,logDir,sandboxType,maxConnections,const DeepCollectionEquality().hash(models),const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(taskPaths),const DeepCollectionEquality().hash(tasks),saveExamples,retryAttempts,maxRetries,retryWait,retryConnections,retryCleanup,failOnError,continueOnFail,retryOnError,debugErrors,maxSamples,maxTasks,maxSubprocesses,maxSandboxes,logLevel,logLevelTranscript,logFormat,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(metadata),trace,display,score,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),const DeepCollectionEquality().hash(sampleShuffle),const DeepCollectionEquality().hash(epochs),const DeepCollectionEquality().hash(approval),const DeepCollectionEquality().hash(solver),sandboxCleanup,modelBaseUrl,const DeepCollectionEquality().hash(modelArgs),const DeepCollectionEquality().hash(modelRoles),const DeepCollectionEquality().hash(taskArgs),messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(modelCostConfig),logSamples,logRealtime,logImages,logBuffer,logShared,bundleDir,bundleOverwrite,logDirAllowDirty,evalSetId,const DeepCollectionEquality().hash(evalSetOverrides),const DeepCollectionEquality().hash(taskDefaults),taskFilters,sampleFilters]);

@override
String toString() {
  return 'Job(description: $description, imagePrefix: $imagePrefix, logDir: $logDir, sandboxType: $sandboxType, maxConnections: $maxConnections, models: $models, variants: $variants, taskPaths: $taskPaths, tasks: $tasks, saveExamples: $saveExamples, retryAttempts: $retryAttempts, maxRetries: $maxRetries, retryWait: $retryWait, retryConnections: $retryConnections, retryCleanup: $retryCleanup, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, debugErrors: $debugErrors, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, logLevel: $logLevel, logLevelTranscript: $logLevelTranscript, logFormat: $logFormat, tags: $tags, metadata: $metadata, trace: $trace, display: $display, score: $score, limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, approval: $approval, solver: $solver, sandboxCleanup: $sandboxCleanup, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, taskArgs: $taskArgs, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, modelCostConfig: $modelCostConfig, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, bundleDir: $bundleDir, bundleOverwrite: $bundleOverwrite, logDirAllowDirty: $logDirAllowDirty, evalSetId: $evalSetId, evalSetOverrides: $evalSetOverrides, taskDefaults: $taskDefaults, taskFilters: $taskFilters, sampleFilters: $sampleFilters)';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String? description,@JsonKey(name: 'image_prefix') String? imagePrefix,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'sandbox_type') String sandboxType,@JsonKey(name: 'max_connections') int maxConnections, List<String>? models, Map<String, Map<String, dynamic>>? variants,@JsonKey(name: 'task_paths') List<String>? taskPaths, Map<String, JobTask>? tasks,@JsonKey(name: 'save_examples') bool saveExamples,@JsonKey(name: 'retry_attempts') int? retryAttempts,@JsonKey(name: 'max_retries') int? maxRetries,@JsonKey(name: 'retry_wait') double? retryWait,@JsonKey(name: 'retry_connections') double? retryConnections,@JsonKey(name: 'retry_cleanup') bool? retryCleanup,@JsonKey(name: 'fail_on_error') double? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'debug_errors') bool? debugErrors,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'log_level') String? logLevel,@JsonKey(name: 'log_level_transcript') String? logLevelTranscript,@JsonKey(name: 'log_format') String? logFormat, List<String>? tags, Map<String, dynamic>? metadata, bool? trace, String? display, bool? score, Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') Object? sampleShuffle, Object? epochs, Object? approval, Object? solver,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args') Map<String, Object?>? modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles,@JsonKey(name: 'task_args') Map<String, Object?>? taskArgs,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'bundle_dir') String? bundleDir,@JsonKey(name: 'bundle_overwrite') bool? bundleOverwrite,@JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,@JsonKey(name: 'eval_set_id') String? evalSetId,@JsonKey(name: 'eval_set_overrides') Map<String, dynamic>? evalSetOverrides,@JsonKey(name: 'task_defaults') Map<String, dynamic>? taskDefaults,@JsonKey(name: 'task_filters') TagFilter? taskFilters,@JsonKey(name: 'sample_filters') TagFilter? sampleFilters
});


$TagFilterCopyWith<$Res>? get taskFilters;$TagFilterCopyWith<$Res>? get sampleFilters;

}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = freezed,Object? imagePrefix = freezed,Object? logDir = null,Object? sandboxType = null,Object? maxConnections = null,Object? models = freezed,Object? variants = freezed,Object? taskPaths = freezed,Object? tasks = freezed,Object? saveExamples = null,Object? retryAttempts = freezed,Object? maxRetries = freezed,Object? retryWait = freezed,Object? retryConnections = freezed,Object? retryCleanup = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? debugErrors = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? logLevel = freezed,Object? logLevelTranscript = freezed,Object? logFormat = freezed,Object? tags = freezed,Object? metadata = freezed,Object? trace = freezed,Object? display = freezed,Object? score = freezed,Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? approval = freezed,Object? solver = freezed,Object? sandboxCleanup = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = freezed,Object? modelRoles = freezed,Object? taskArgs = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? modelCostConfig = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? bundleDir = freezed,Object? bundleOverwrite = freezed,Object? logDirAllowDirty = freezed,Object? evalSetId = freezed,Object? evalSetOverrides = freezed,Object? taskDefaults = freezed,Object? taskFilters = freezed,Object? sampleFilters = freezed,}) {
  return _then(_self.copyWith(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePrefix: freezed == imagePrefix ? _self.imagePrefix : imagePrefix // ignore: cast_nullable_to_non_nullable
as String?,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,sandboxType: null == sandboxType ? _self.sandboxType : sandboxType // ignore: cast_nullable_to_non_nullable
as String,maxConnections: null == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int,models: freezed == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<String>?,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,taskPaths: freezed == taskPaths ? _self.taskPaths : taskPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,tasks: freezed == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, JobTask>?,saveExamples: null == saveExamples ? _self.saveExamples : saveExamples // ignore: cast_nullable_to_non_nullable
as bool,retryAttempts: freezed == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int?,maxRetries: freezed == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int?,retryWait: freezed == retryWait ? _self.retryWait : retryWait // ignore: cast_nullable_to_non_nullable
as double?,retryConnections: freezed == retryConnections ? _self.retryConnections : retryConnections // ignore: cast_nullable_to_non_nullable
as double?,retryCleanup: freezed == retryCleanup ? _self.retryCleanup : retryCleanup // ignore: cast_nullable_to_non_nullable
as bool?,failOnError: freezed == failOnError ? _self.failOnError : failOnError // ignore: cast_nullable_to_non_nullable
as double?,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,debugErrors: freezed == debugErrors ? _self.debugErrors : debugErrors // ignore: cast_nullable_to_non_nullable
as bool?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,logLevel: freezed == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String?,logLevelTranscript: freezed == logLevelTranscript ? _self.logLevelTranscript : logLevelTranscript // ignore: cast_nullable_to_non_nullable
as String?,logFormat: freezed == logFormat ? _self.logFormat : logFormat // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as bool?,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as bool?,limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle ,epochs: freezed == epochs ? _self.epochs : epochs ,approval: freezed == approval ? _self.approval : approval ,solver: freezed == solver ? _self.solver : solver ,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: freezed == modelArgs ? _self.modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,modelRoles: freezed == modelRoles ? _self.modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,taskArgs: freezed == taskArgs ? _self.taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,modelCostConfig: freezed == modelCostConfig ? _self.modelCostConfig : modelCostConfig // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,bundleDir: freezed == bundleDir ? _self.bundleDir : bundleDir // ignore: cast_nullable_to_non_nullable
as String?,bundleOverwrite: freezed == bundleOverwrite ? _self.bundleOverwrite : bundleOverwrite // ignore: cast_nullable_to_non_nullable
as bool?,logDirAllowDirty: freezed == logDirAllowDirty ? _self.logDirAllowDirty : logDirAllowDirty // ignore: cast_nullable_to_non_nullable
as bool?,evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,evalSetOverrides: freezed == evalSetOverrides ? _self.evalSetOverrides : evalSetOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,taskDefaults: freezed == taskDefaults ? _self.taskDefaults : taskDefaults // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,taskFilters: freezed == taskFilters ? _self.taskFilters : taskFilters // ignore: cast_nullable_to_non_nullable
as TagFilter?,sampleFilters: freezed == sampleFilters ? _self.sampleFilters : sampleFilters // ignore: cast_nullable_to_non_nullable
as TagFilter?,
  ));
}
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagFilterCopyWith<$Res>? get taskFilters {
    if (_self.taskFilters == null) {
    return null;
  }

  return $TagFilterCopyWith<$Res>(_self.taskFilters!, (value) {
    return _then(_self.copyWith(taskFilters: value));
  });
}/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagFilterCopyWith<$Res>? get sampleFilters {
    if (_self.sampleFilters == null) {
    return null;
  }

  return $TagFilterCopyWith<$Res>(_self.sampleFilters!, (value) {
    return _then(_self.copyWith(sampleFilters: value));
  });
}
}


/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Job value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Job value)  $default,){
final _that = this;
switch (_that) {
case _Job():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Job value)?  $default,){
final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? description, @JsonKey(name: 'image_prefix')  String? imagePrefix, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'sandbox_type')  String sandboxType, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'max_retries')  int? maxRetries, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  bool? score,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs,  Object? approval,  Object? solver, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?>? modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?>? taskArgs, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool? bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_set_overrides')  Map<String, dynamic>? evalSetOverrides, @JsonKey(name: 'task_defaults')  Map<String, dynamic>? taskDefaults, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.description,_that.imagePrefix,_that.logDir,_that.sandboxType,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.retryAttempts,_that.maxRetries,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.tags,_that.metadata,_that.trace,_that.display,_that.score,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.approval,_that.solver,_that.sandboxCleanup,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId,_that.evalSetOverrides,_that.taskDefaults,_that.taskFilters,_that.sampleFilters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? description, @JsonKey(name: 'image_prefix')  String? imagePrefix, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'sandbox_type')  String sandboxType, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'max_retries')  int? maxRetries, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  bool? score,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs,  Object? approval,  Object? solver, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?>? modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?>? taskArgs, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool? bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_set_overrides')  Map<String, dynamic>? evalSetOverrides, @JsonKey(name: 'task_defaults')  Map<String, dynamic>? taskDefaults, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.description,_that.imagePrefix,_that.logDir,_that.sandboxType,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.retryAttempts,_that.maxRetries,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.tags,_that.metadata,_that.trace,_that.display,_that.score,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.approval,_that.solver,_that.sandboxCleanup,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId,_that.evalSetOverrides,_that.taskDefaults,_that.taskFilters,_that.sampleFilters);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? description, @JsonKey(name: 'image_prefix')  String? imagePrefix, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'sandbox_type')  String sandboxType, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'max_retries')  int? maxRetries, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  bool? score,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs,  Object? approval,  Object? solver, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?>? modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?>? taskArgs, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool? bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_set_overrides')  Map<String, dynamic>? evalSetOverrides, @JsonKey(name: 'task_defaults')  Map<String, dynamic>? taskDefaults, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.description,_that.imagePrefix,_that.logDir,_that.sandboxType,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.retryAttempts,_that.maxRetries,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.tags,_that.metadata,_that.trace,_that.display,_that.score,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.approval,_that.solver,_that.sandboxCleanup,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId,_that.evalSetOverrides,_that.taskDefaults,_that.taskFilters,_that.sampleFilters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Job implements Job {
  const _Job({this.description, @JsonKey(name: 'image_prefix') this.imagePrefix, @JsonKey(name: 'log_dir') required this.logDir, @JsonKey(name: 'sandbox_type') this.sandboxType = 'local', @JsonKey(name: 'max_connections') this.maxConnections = 10, final  List<String>? models, final  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths') final  List<String>? taskPaths, final  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples') this.saveExamples = false, @JsonKey(name: 'retry_attempts') this.retryAttempts, @JsonKey(name: 'max_retries') this.maxRetries, @JsonKey(name: 'retry_wait') this.retryWait, @JsonKey(name: 'retry_connections') this.retryConnections, @JsonKey(name: 'retry_cleanup') this.retryCleanup, @JsonKey(name: 'fail_on_error') this.failOnError, @JsonKey(name: 'continue_on_fail') this.continueOnFail, @JsonKey(name: 'retry_on_error') this.retryOnError, @JsonKey(name: 'debug_errors') this.debugErrors, @JsonKey(name: 'max_samples') this.maxSamples, @JsonKey(name: 'max_tasks') this.maxTasks, @JsonKey(name: 'max_subprocesses') this.maxSubprocesses, @JsonKey(name: 'max_sandboxes') this.maxSandboxes, @JsonKey(name: 'log_level') this.logLevel, @JsonKey(name: 'log_level_transcript') this.logLevelTranscript, @JsonKey(name: 'log_format') this.logFormat, final  List<String>? tags, final  Map<String, dynamic>? metadata, this.trace, this.display, this.score, this.limit, @JsonKey(name: 'sample_id') this.sampleId, @JsonKey(name: 'sample_shuffle') this.sampleShuffle, this.epochs, this.approval, this.solver, @JsonKey(name: 'sandbox_cleanup') this.sandboxCleanup, @JsonKey(name: 'model_base_url') this.modelBaseUrl, @JsonKey(name: 'model_args') final  Map<String, Object?>? modelArgs, @JsonKey(name: 'model_roles') final  Map<String, String>? modelRoles, @JsonKey(name: 'task_args') final  Map<String, Object?>? taskArgs, @JsonKey(name: 'message_limit') this.messageLimit, @JsonKey(name: 'token_limit') this.tokenLimit, @JsonKey(name: 'time_limit') this.timeLimit, @JsonKey(name: 'working_limit') this.workingLimit, @JsonKey(name: 'cost_limit') this.costLimit, @JsonKey(name: 'model_cost_config') final  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'log_samples') this.logSamples, @JsonKey(name: 'log_realtime') this.logRealtime, @JsonKey(name: 'log_images') this.logImages, @JsonKey(name: 'log_buffer') this.logBuffer, @JsonKey(name: 'log_shared') this.logShared, @JsonKey(name: 'bundle_dir') this.bundleDir, @JsonKey(name: 'bundle_overwrite') this.bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty') this.logDirAllowDirty, @JsonKey(name: 'eval_set_id') this.evalSetId, @JsonKey(name: 'eval_set_overrides') final  Map<String, dynamic>? evalSetOverrides, @JsonKey(name: 'task_defaults') final  Map<String, dynamic>? taskDefaults, @JsonKey(name: 'task_filters') this.taskFilters, @JsonKey(name: 'sample_filters') this.sampleFilters}): _models = models,_variants = variants,_taskPaths = taskPaths,_tasks = tasks,_tags = tags,_metadata = metadata,_modelArgs = modelArgs,_modelRoles = modelRoles,_taskArgs = taskArgs,_modelCostConfig = modelCostConfig,_evalSetOverrides = evalSetOverrides,_taskDefaults = taskDefaults;
  factory _Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

// ------------------------------------------------------------------
// Core job settings
// ------------------------------------------------------------------
/// Human-readable description of this job.
@override final  String? description;
/// Registry URL prefix prepended to image names during sandbox resolution.
///
/// Example: `us-central1-docker.pkg.dev/project/repo/`
@override@JsonKey(name: 'image_prefix') final  String? imagePrefix;
/// Directory to write evaluation logs to.
@override@JsonKey(name: 'log_dir') final  String logDir;
/// Sandbox type: `'local'`, `'docker'`, or `'podman'`.
@override@JsonKey(name: 'sandbox_type') final  String sandboxType;
/// Maximum concurrent API connections.
@override@JsonKey(name: 'max_connections') final  int maxConnections;
/// Models to run. `null` means use defaults from registries.
 final  List<String>? _models;
/// Models to run. `null` means use defaults from registries.
@override List<String>? get models {
  final value = _models;
  if (value == null) return null;
  if (_models is EqualUnmodifiableListView) return _models;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Named variant map. Keys are variant names, values are config dicts.
/// `null` means baseline only.
 final  Map<String, Map<String, dynamic>>? _variants;
/// Named variant map. Keys are variant names, values are config dicts.
/// `null` means baseline only.
@override Map<String, Map<String, dynamic>>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableMapView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Glob patterns for discovering task directories (relative to dataset root).
 final  List<String>? _taskPaths;
/// Glob patterns for discovering task directories (relative to dataset root).
@override@JsonKey(name: 'task_paths') List<String>? get taskPaths {
  final value = _taskPaths;
  if (value == null) return null;
  if (_taskPaths is EqualUnmodifiableListView) return _taskPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Per-task configurations with inline overrides.
/// `null` means run all tasks.
 final  Map<String, JobTask>? _tasks;
/// Per-task configurations with inline overrides.
/// `null` means run all tasks.
@override Map<String, JobTask>? get tasks {
  final value = _tasks;
  if (value == null) return null;
  if (_tasks is EqualUnmodifiableMapView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// If `true`, copy final workspace to `<logDir>/examples/` after each sample.
@override@JsonKey(name: 'save_examples') final  bool saveExamples;
// ------------------------------------------------------------------
// Promoted eval_set() parameters (convenience top-level keys)
// ------------------------------------------------------------------
/// Maximum retry attempts before giving up (defaults to 10).
@override@JsonKey(name: 'retry_attempts') final  int? retryAttempts;
/// Maximum number of retry attempts for failed samples.
@override@JsonKey(name: 'max_retries') final  int? maxRetries;
/// Time in seconds to wait between retry attempts (exponential backoff).
@override@JsonKey(name: 'retry_wait') final  double? retryWait;
/// Reduce `max_connections` at this rate with each retry (default 1.0).
@override@JsonKey(name: 'retry_connections') final  double? retryConnections;
/// Cleanup failed log files after retries (defaults to true).
@override@JsonKey(name: 'retry_cleanup') final  bool? retryCleanup;
/// Fail on sample errors.
///
/// `0.0–1.0` = fail if proportion exceeds threshold,
/// `>1` = fail if count exceeds threshold.
@override@JsonKey(name: 'fail_on_error') final  double? failOnError;
/// Continue running even if `fail_on_error` condition is met.
@override@JsonKey(name: 'continue_on_fail') final  bool? continueOnFail;
/// Number of times to retry samples on error (default: no retries).
@override@JsonKey(name: 'retry_on_error') final  int? retryOnError;
/// Raise task errors for debugging (defaults to false).
@override@JsonKey(name: 'debug_errors') final  bool? debugErrors;
/// Maximum samples to run in parallel (default is `max_connections`).
@override@JsonKey(name: 'max_samples') final  int? maxSamples;
/// Maximum tasks to run in parallel.
@override@JsonKey(name: 'max_tasks') final  int? maxTasks;
/// Maximum subprocesses to run in parallel.
@override@JsonKey(name: 'max_subprocesses') final  int? maxSubprocesses;
/// Maximum sandboxes (per-provider) to run in parallel.
@override@JsonKey(name: 'max_sandboxes') final  int? maxSandboxes;
/// Level for logging to the console (e.g. `"warning"`, `"info"`, `"debug"`).
@override@JsonKey(name: 'log_level') final  String? logLevel;
/// Level for logging to the log file (defaults to `"info"`).
@override@JsonKey(name: 'log_level_transcript') final  String? logLevelTranscript;
/// Format for writing log files (`"eval"` or `"json"`).
@override@JsonKey(name: 'log_format') final  String? logFormat;
/// Tags to associate with this evaluation run.
 final  List<String>? _tags;
/// Tags to associate with this evaluation run.
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Metadata to associate with this evaluation run.
 final  Map<String, dynamic>? _metadata;
/// Metadata to associate with this evaluation run.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Trace message interactions with evaluated model to terminal.
@override final  bool? trace;
/// Task display type (defaults to `"full"`).
@override final  String? display;
/// Score output (defaults to true).
@override final  bool? score;
/// Limit evaluated samples (int count or `[start, end]` range).
@override final  Object? limit;
/// Evaluate specific sample(s) from the dataset.
@override@JsonKey(name: 'sample_id') final  Object? sampleId;
/// Shuffle order of samples (pass a seed to make order deterministic).
@override@JsonKey(name: 'sample_shuffle') final  Object? sampleShuffle;
/// Epochs to repeat samples for and optional score reducer function(s).
@override final  Object? epochs;
/// Tool use approval policies (string or config dict).
@override final  Object? approval;
/// Alternative solver(s) for evaluating task(s) (string or config dict).
@override final  Object? solver;
/// Sandbox cleanup after task completes (defaults to true).
@override@JsonKey(name: 'sandbox_cleanup') final  bool? sandboxCleanup;
/// Base URL for communicating with the model API.
@override@JsonKey(name: 'model_base_url') final  String? modelBaseUrl;
/// Model creation arguments.
 final  Map<String, Object?>? _modelArgs;
/// Model creation arguments.
@override@JsonKey(name: 'model_args') Map<String, Object?>? get modelArgs {
  final value = _modelArgs;
  if (value == null) return null;
  if (_modelArgs is EqualUnmodifiableMapView) return _modelArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Named roles for use in `get_model()`.
 final  Map<String, String>? _modelRoles;
/// Named roles for use in `get_model()`.
@override@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles {
  final value = _modelRoles;
  if (value == null) return null;
  if (_modelRoles is EqualUnmodifiableMapView) return _modelRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Task creation arguments.
 final  Map<String, Object?>? _taskArgs;
/// Task creation arguments.
@override@JsonKey(name: 'task_args') Map<String, Object?>? get taskArgs {
  final value = _taskArgs;
  if (value == null) return null;
  if (_taskArgs is EqualUnmodifiableMapView) return _taskArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Limit on total messages per sample.
@override@JsonKey(name: 'message_limit') final  int? messageLimit;
/// Limit on total tokens per sample.
@override@JsonKey(name: 'token_limit') final  int? tokenLimit;
/// Limit on clock time (in seconds) per sample.
@override@JsonKey(name: 'time_limit') final  int? timeLimit;
/// Limit on working time (in seconds) per sample.
@override@JsonKey(name: 'working_limit') final  int? workingLimit;
/// Limit on total cost (in dollars) per sample.
@override@JsonKey(name: 'cost_limit') final  double? costLimit;
/// JSON file with model prices for cost tracking.
 final  Map<String, Object?>? _modelCostConfig;
/// JSON file with model prices for cost tracking.
@override@JsonKey(name: 'model_cost_config') Map<String, Object?>? get modelCostConfig {
  final value = _modelCostConfig;
  if (value == null) return null;
  if (_modelCostConfig is EqualUnmodifiableMapView) return _modelCostConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Log detailed samples and scores (defaults to true).
@override@JsonKey(name: 'log_samples') final  bool? logSamples;
/// Log events in realtime (defaults to true).
@override@JsonKey(name: 'log_realtime') final  bool? logRealtime;
/// Log base64-encoded images (defaults to false).
@override@JsonKey(name: 'log_images') final  bool? logImages;
/// Number of samples to buffer before writing log file.
@override@JsonKey(name: 'log_buffer') final  int? logBuffer;
/// Sync sample events for realtime viewing.
@override@JsonKey(name: 'log_shared') final  int? logShared;
/// Directory to bundle logs and viewer into.
@override@JsonKey(name: 'bundle_dir') final  String? bundleDir;
/// Overwrite files in `bundle_dir` (defaults to false).
@override@JsonKey(name: 'bundle_overwrite') final  bool? bundleOverwrite;
/// Allow log directory to contain unrelated logs (defaults to false).
@override@JsonKey(name: 'log_dir_allow_dirty') final  bool? logDirAllowDirty;
/// ID for the eval set. Generated if not specified.
@override@JsonKey(name: 'eval_set_id') final  String? evalSetId;
// ------------------------------------------------------------------
// Pass-through overrides
// ------------------------------------------------------------------
/// Additional `eval_set()` kwargs not covered by top-level fields.
///
/// Any valid `eval_set()` parameter can be specified here and will be
/// merged into the output JSON. Top-level fields take precedence.
 final  Map<String, dynamic>? _evalSetOverrides;
// ------------------------------------------------------------------
// Pass-through overrides
// ------------------------------------------------------------------
/// Additional `eval_set()` kwargs not covered by top-level fields.
///
/// Any valid `eval_set()` parameter can be specified here and will be
/// merged into the output JSON. Top-level fields take precedence.
@override@JsonKey(name: 'eval_set_overrides') Map<String, dynamic>? get evalSetOverrides {
  final value = _evalSetOverrides;
  if (value == null) return null;
  if (_evalSetOverrides is EqualUnmodifiableMapView) return _evalSetOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Default `Task` kwargs applied to every task in this job.
///
/// Per-task overrides (from `task.yaml`) take precedence.
 final  Map<String, dynamic>? _taskDefaults;
/// Default `Task` kwargs applied to every task in this job.
///
/// Per-task overrides (from `task.yaml`) take precedence.
@override@JsonKey(name: 'task_defaults') Map<String, dynamic>? get taskDefaults {
  final value = _taskDefaults;
  if (value == null) return null;
  if (_taskDefaults is EqualUnmodifiableMapView) return _taskDefaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// ------------------------------------------------------------------
// Tag-based filtering
// ------------------------------------------------------------------
/// Tag filters applied to tasks.
@override@JsonKey(name: 'task_filters') final  TagFilter? taskFilters;
/// Tag filters applied to samples.
@override@JsonKey(name: 'sample_filters') final  TagFilter? sampleFilters;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePrefix, imagePrefix) || other.imagePrefix == imagePrefix)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.sandboxType, sandboxType) || other.sandboxType == sandboxType)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&const DeepCollectionEquality().equals(other._models, _models)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._taskPaths, _taskPaths)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.saveExamples, saveExamples) || other.saveExamples == saveExamples)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.retryWait, retryWait) || other.retryWait == retryWait)&&(identical(other.retryConnections, retryConnections) || other.retryConnections == retryConnections)&&(identical(other.retryCleanup, retryCleanup) || other.retryCleanup == retryCleanup)&&(identical(other.failOnError, failOnError) || other.failOnError == failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.debugErrors, debugErrors) || other.debugErrors == debugErrors)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.logLevelTranscript, logLevelTranscript) || other.logLevelTranscript == logLevelTranscript)&&(identical(other.logFormat, logFormat) || other.logFormat == logFormat)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.trace, trace) || other.trace == trace)&&(identical(other.display, display) || other.display == display)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&const DeepCollectionEquality().equals(other.sampleShuffle, sampleShuffle)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&const DeepCollectionEquality().equals(other.approval, approval)&&const DeepCollectionEquality().equals(other.solver, solver)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other._modelArgs, _modelArgs)&&const DeepCollectionEquality().equals(other._modelRoles, _modelRoles)&&const DeepCollectionEquality().equals(other._taskArgs, _taskArgs)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other._modelCostConfig, _modelCostConfig)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.bundleDir, bundleDir) || other.bundleDir == bundleDir)&&(identical(other.bundleOverwrite, bundleOverwrite) || other.bundleOverwrite == bundleOverwrite)&&(identical(other.logDirAllowDirty, logDirAllowDirty) || other.logDirAllowDirty == logDirAllowDirty)&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&const DeepCollectionEquality().equals(other._evalSetOverrides, _evalSetOverrides)&&const DeepCollectionEquality().equals(other._taskDefaults, _taskDefaults)&&(identical(other.taskFilters, taskFilters) || other.taskFilters == taskFilters)&&(identical(other.sampleFilters, sampleFilters) || other.sampleFilters == sampleFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,description,imagePrefix,logDir,sandboxType,maxConnections,const DeepCollectionEquality().hash(_models),const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_taskPaths),const DeepCollectionEquality().hash(_tasks),saveExamples,retryAttempts,maxRetries,retryWait,retryConnections,retryCleanup,failOnError,continueOnFail,retryOnError,debugErrors,maxSamples,maxTasks,maxSubprocesses,maxSandboxes,logLevel,logLevelTranscript,logFormat,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_metadata),trace,display,score,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),const DeepCollectionEquality().hash(sampleShuffle),const DeepCollectionEquality().hash(epochs),const DeepCollectionEquality().hash(approval),const DeepCollectionEquality().hash(solver),sandboxCleanup,modelBaseUrl,const DeepCollectionEquality().hash(_modelArgs),const DeepCollectionEquality().hash(_modelRoles),const DeepCollectionEquality().hash(_taskArgs),messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(_modelCostConfig),logSamples,logRealtime,logImages,logBuffer,logShared,bundleDir,bundleOverwrite,logDirAllowDirty,evalSetId,const DeepCollectionEquality().hash(_evalSetOverrides),const DeepCollectionEquality().hash(_taskDefaults),taskFilters,sampleFilters]);

@override
String toString() {
  return 'Job(description: $description, imagePrefix: $imagePrefix, logDir: $logDir, sandboxType: $sandboxType, maxConnections: $maxConnections, models: $models, variants: $variants, taskPaths: $taskPaths, tasks: $tasks, saveExamples: $saveExamples, retryAttempts: $retryAttempts, maxRetries: $maxRetries, retryWait: $retryWait, retryConnections: $retryConnections, retryCleanup: $retryCleanup, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, debugErrors: $debugErrors, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, logLevel: $logLevel, logLevelTranscript: $logLevelTranscript, logFormat: $logFormat, tags: $tags, metadata: $metadata, trace: $trace, display: $display, score: $score, limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, approval: $approval, solver: $solver, sandboxCleanup: $sandboxCleanup, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, taskArgs: $taskArgs, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, modelCostConfig: $modelCostConfig, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, bundleDir: $bundleDir, bundleOverwrite: $bundleOverwrite, logDirAllowDirty: $logDirAllowDirty, evalSetId: $evalSetId, evalSetOverrides: $evalSetOverrides, taskDefaults: $taskDefaults, taskFilters: $taskFilters, sampleFilters: $sampleFilters)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String? description,@JsonKey(name: 'image_prefix') String? imagePrefix,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'sandbox_type') String sandboxType,@JsonKey(name: 'max_connections') int maxConnections, List<String>? models, Map<String, Map<String, dynamic>>? variants,@JsonKey(name: 'task_paths') List<String>? taskPaths, Map<String, JobTask>? tasks,@JsonKey(name: 'save_examples') bool saveExamples,@JsonKey(name: 'retry_attempts') int? retryAttempts,@JsonKey(name: 'max_retries') int? maxRetries,@JsonKey(name: 'retry_wait') double? retryWait,@JsonKey(name: 'retry_connections') double? retryConnections,@JsonKey(name: 'retry_cleanup') bool? retryCleanup,@JsonKey(name: 'fail_on_error') double? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'debug_errors') bool? debugErrors,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'log_level') String? logLevel,@JsonKey(name: 'log_level_transcript') String? logLevelTranscript,@JsonKey(name: 'log_format') String? logFormat, List<String>? tags, Map<String, dynamic>? metadata, bool? trace, String? display, bool? score, Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') Object? sampleShuffle, Object? epochs, Object? approval, Object? solver,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args') Map<String, Object?>? modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles,@JsonKey(name: 'task_args') Map<String, Object?>? taskArgs,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'bundle_dir') String? bundleDir,@JsonKey(name: 'bundle_overwrite') bool? bundleOverwrite,@JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,@JsonKey(name: 'eval_set_id') String? evalSetId,@JsonKey(name: 'eval_set_overrides') Map<String, dynamic>? evalSetOverrides,@JsonKey(name: 'task_defaults') Map<String, dynamic>? taskDefaults,@JsonKey(name: 'task_filters') TagFilter? taskFilters,@JsonKey(name: 'sample_filters') TagFilter? sampleFilters
});


@override $TagFilterCopyWith<$Res>? get taskFilters;@override $TagFilterCopyWith<$Res>? get sampleFilters;

}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = freezed,Object? imagePrefix = freezed,Object? logDir = null,Object? sandboxType = null,Object? maxConnections = null,Object? models = freezed,Object? variants = freezed,Object? taskPaths = freezed,Object? tasks = freezed,Object? saveExamples = null,Object? retryAttempts = freezed,Object? maxRetries = freezed,Object? retryWait = freezed,Object? retryConnections = freezed,Object? retryCleanup = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? debugErrors = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? logLevel = freezed,Object? logLevelTranscript = freezed,Object? logFormat = freezed,Object? tags = freezed,Object? metadata = freezed,Object? trace = freezed,Object? display = freezed,Object? score = freezed,Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? approval = freezed,Object? solver = freezed,Object? sandboxCleanup = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = freezed,Object? modelRoles = freezed,Object? taskArgs = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? modelCostConfig = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? bundleDir = freezed,Object? bundleOverwrite = freezed,Object? logDirAllowDirty = freezed,Object? evalSetId = freezed,Object? evalSetOverrides = freezed,Object? taskDefaults = freezed,Object? taskFilters = freezed,Object? sampleFilters = freezed,}) {
  return _then(_Job(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePrefix: freezed == imagePrefix ? _self.imagePrefix : imagePrefix // ignore: cast_nullable_to_non_nullable
as String?,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,sandboxType: null == sandboxType ? _self.sandboxType : sandboxType // ignore: cast_nullable_to_non_nullable
as String,maxConnections: null == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int,models: freezed == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<String>?,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,taskPaths: freezed == taskPaths ? _self._taskPaths : taskPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,tasks: freezed == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, JobTask>?,saveExamples: null == saveExamples ? _self.saveExamples : saveExamples // ignore: cast_nullable_to_non_nullable
as bool,retryAttempts: freezed == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int?,maxRetries: freezed == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int?,retryWait: freezed == retryWait ? _self.retryWait : retryWait // ignore: cast_nullable_to_non_nullable
as double?,retryConnections: freezed == retryConnections ? _self.retryConnections : retryConnections // ignore: cast_nullable_to_non_nullable
as double?,retryCleanup: freezed == retryCleanup ? _self.retryCleanup : retryCleanup // ignore: cast_nullable_to_non_nullable
as bool?,failOnError: freezed == failOnError ? _self.failOnError : failOnError // ignore: cast_nullable_to_non_nullable
as double?,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,debugErrors: freezed == debugErrors ? _self.debugErrors : debugErrors // ignore: cast_nullable_to_non_nullable
as bool?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,logLevel: freezed == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String?,logLevelTranscript: freezed == logLevelTranscript ? _self.logLevelTranscript : logLevelTranscript // ignore: cast_nullable_to_non_nullable
as String?,logFormat: freezed == logFormat ? _self.logFormat : logFormat // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as bool?,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as bool?,limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle ,epochs: freezed == epochs ? _self.epochs : epochs ,approval: freezed == approval ? _self.approval : approval ,solver: freezed == solver ? _self.solver : solver ,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: freezed == modelArgs ? _self._modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,modelRoles: freezed == modelRoles ? _self._modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,taskArgs: freezed == taskArgs ? _self._taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,modelCostConfig: freezed == modelCostConfig ? _self._modelCostConfig : modelCostConfig // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,bundleDir: freezed == bundleDir ? _self.bundleDir : bundleDir // ignore: cast_nullable_to_non_nullable
as String?,bundleOverwrite: freezed == bundleOverwrite ? _self.bundleOverwrite : bundleOverwrite // ignore: cast_nullable_to_non_nullable
as bool?,logDirAllowDirty: freezed == logDirAllowDirty ? _self.logDirAllowDirty : logDirAllowDirty // ignore: cast_nullable_to_non_nullable
as bool?,evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,evalSetOverrides: freezed == evalSetOverrides ? _self._evalSetOverrides : evalSetOverrides // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,taskDefaults: freezed == taskDefaults ? _self._taskDefaults : taskDefaults // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,taskFilters: freezed == taskFilters ? _self.taskFilters : taskFilters // ignore: cast_nullable_to_non_nullable
as TagFilter?,sampleFilters: freezed == sampleFilters ? _self.sampleFilters : sampleFilters // ignore: cast_nullable_to_non_nullable
as TagFilter?,
  ));
}

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagFilterCopyWith<$Res>? get taskFilters {
    if (_self.taskFilters == null) {
    return null;
  }

  return $TagFilterCopyWith<$Res>(_self.taskFilters!, (value) {
    return _then(_self.copyWith(taskFilters: value));
  });
}/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TagFilterCopyWith<$Res>? get sampleFilters {
    if (_self.sampleFilters == null) {
    return null;
  }

  return $TagFilterCopyWith<$Res>(_self.sampleFilters!, (value) {
    return _then(_self.copyWith(sampleFilters: value));
  });
}
}


/// @nodoc
mixin _$JobTask {

/// Task identifier matching a task directory name in `tasks/`.
 String get id;/// Only run these sample IDs. Mutually exclusive with [excludeSamples].
@JsonKey(name: 'include_samples') List<String>? get includeSamples;/// Exclude these sample IDs. Mutually exclusive with [includeSamples].
@JsonKey(name: 'exclude_samples') List<String>? get excludeSamples;/// Override system message for this task.
@JsonKey(name: 'system_message') String? get systemMessage;/// Per-task argument overrides passed to the task function.
@JsonKey(name: 'args') Map<String, dynamic>? get args;
/// Create a copy of JobTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobTaskCopyWith<JobTask> get copyWith => _$JobTaskCopyWithImpl<JobTask>(this as JobTask, _$identity);

  /// Serializes this JobTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobTask&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.includeSamples, includeSamples)&&const DeepCollectionEquality().equals(other.excludeSamples, excludeSamples)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&const DeepCollectionEquality().equals(other.args, args));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(includeSamples),const DeepCollectionEquality().hash(excludeSamples),systemMessage,const DeepCollectionEquality().hash(args));

@override
String toString() {
  return 'JobTask(id: $id, includeSamples: $includeSamples, excludeSamples: $excludeSamples, systemMessage: $systemMessage, args: $args)';
}


}

/// @nodoc
abstract mixin class $JobTaskCopyWith<$Res>  {
  factory $JobTaskCopyWith(JobTask value, $Res Function(JobTask) _then) = _$JobTaskCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'include_samples') List<String>? includeSamples,@JsonKey(name: 'exclude_samples') List<String>? excludeSamples,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'args') Map<String, dynamic>? args
});




}
/// @nodoc
class _$JobTaskCopyWithImpl<$Res>
    implements $JobTaskCopyWith<$Res> {
  _$JobTaskCopyWithImpl(this._self, this._then);

  final JobTask _self;
  final $Res Function(JobTask) _then;

/// Create a copy of JobTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? includeSamples = freezed,Object? excludeSamples = freezed,Object? systemMessage = freezed,Object? args = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,includeSamples: freezed == includeSamples ? _self.includeSamples : includeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeSamples: freezed == excludeSamples ? _self.excludeSamples : excludeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,args: freezed == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobTask].
extension JobTaskPatterns on JobTask {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobTask value)  $default,){
final _that = this;
switch (_that) {
case _JobTask():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobTask value)?  $default,){
final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'args')  Map<String, dynamic>? args)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.systemMessage,_that.args);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'args')  Map<String, dynamic>? args)  $default,) {final _that = this;
switch (_that) {
case _JobTask():
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.systemMessage,_that.args);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'args')  Map<String, dynamic>? args)?  $default,) {final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.systemMessage,_that.args);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobTask implements JobTask {
  const _JobTask({required this.id, @JsonKey(name: 'include_samples') final  List<String>? includeSamples, @JsonKey(name: 'exclude_samples') final  List<String>? excludeSamples, @JsonKey(name: 'system_message') this.systemMessage, @JsonKey(name: 'args') final  Map<String, dynamic>? args}): _includeSamples = includeSamples,_excludeSamples = excludeSamples,_args = args;
  factory _JobTask.fromJson(Map<String, dynamic> json) => _$JobTaskFromJson(json);

/// Task identifier matching a task directory name in `tasks/`.
@override final  String id;
/// Only run these sample IDs. Mutually exclusive with [excludeSamples].
 final  List<String>? _includeSamples;
/// Only run these sample IDs. Mutually exclusive with [excludeSamples].
@override@JsonKey(name: 'include_samples') List<String>? get includeSamples {
  final value = _includeSamples;
  if (value == null) return null;
  if (_includeSamples is EqualUnmodifiableListView) return _includeSamples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Exclude these sample IDs. Mutually exclusive with [includeSamples].
 final  List<String>? _excludeSamples;
/// Exclude these sample IDs. Mutually exclusive with [includeSamples].
@override@JsonKey(name: 'exclude_samples') List<String>? get excludeSamples {
  final value = _excludeSamples;
  if (value == null) return null;
  if (_excludeSamples is EqualUnmodifiableListView) return _excludeSamples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Override system message for this task.
@override@JsonKey(name: 'system_message') final  String? systemMessage;
/// Per-task argument overrides passed to the task function.
 final  Map<String, dynamic>? _args;
/// Per-task argument overrides passed to the task function.
@override@JsonKey(name: 'args') Map<String, dynamic>? get args {
  final value = _args;
  if (value == null) return null;
  if (_args is EqualUnmodifiableMapView) return _args;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of JobTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobTaskCopyWith<_JobTask> get copyWith => __$JobTaskCopyWithImpl<_JobTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobTask&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._includeSamples, _includeSamples)&&const DeepCollectionEquality().equals(other._excludeSamples, _excludeSamples)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&const DeepCollectionEquality().equals(other._args, _args));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_includeSamples),const DeepCollectionEquality().hash(_excludeSamples),systemMessage,const DeepCollectionEquality().hash(_args));

@override
String toString() {
  return 'JobTask(id: $id, includeSamples: $includeSamples, excludeSamples: $excludeSamples, systemMessage: $systemMessage, args: $args)';
}


}

/// @nodoc
abstract mixin class _$JobTaskCopyWith<$Res> implements $JobTaskCopyWith<$Res> {
  factory _$JobTaskCopyWith(_JobTask value, $Res Function(_JobTask) _then) = __$JobTaskCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'include_samples') List<String>? includeSamples,@JsonKey(name: 'exclude_samples') List<String>? excludeSamples,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'args') Map<String, dynamic>? args
});




}
/// @nodoc
class __$JobTaskCopyWithImpl<$Res>
    implements _$JobTaskCopyWith<$Res> {
  __$JobTaskCopyWithImpl(this._self, this._then);

  final _JobTask _self;
  final $Res Function(_JobTask) _then;

/// Create a copy of JobTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? includeSamples = freezed,Object? excludeSamples = freezed,Object? systemMessage = freezed,Object? args = freezed,}) {
  return _then(_JobTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,includeSamples: freezed == includeSamples ? _self._includeSamples : includeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeSamples: freezed == excludeSamples ? _self._excludeSamples : excludeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,args: freezed == args ? _self._args : args // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
