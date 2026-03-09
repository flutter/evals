// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eval_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EvalSet {

/// Task(s) to evaluate.
///
/// Accepts task file paths, task function names, or other task specifiers.
 List<Task> get tasks;/// Output path for logging results.
///
/// Required to ensure a unique storage scope is assigned for the set.
@JsonKey(name: 'log_dir') String get logDir;/// Maximum number of retry attempts before giving up (defaults to 10).
@JsonKey(name: 'retry_attempts') int? get retryAttempts;/// Time in seconds to wait between retry attempts, increased
/// exponentially (defaults to 30).
@JsonKey(name: 'retry_wait') double? get retryWait;/// Reduce `max_connections` at this rate with each retry
/// (defaults to 1.0 — no reduction).
@JsonKey(name: 'retry_connections') double? get retryConnections;/// Cleanup failed log files after retries (defaults to true).
@JsonKey(name: 'retry_cleanup') bool? get retryCleanup;/// Model(s) for evaluation.
///
/// A list of Provider/model strings (e.g. `"openai/gpt-4o"`)
/// If not specified, uses the `INSPECT_EVAL_MODEL` environment variable.
 List<String>? get model;/// Base URL for communicating with the model API.
@JsonKey(name: 'model_base_url') String? get modelBaseUrl;/// Model creation arguments (dictionary or path to JSON/YAML config).
@JsonKey(name: 'model_args') Map<String, Object?> get modelArgs;/// Named roles for use in `get_model()`.
@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles;/// Task creation arguments (dictionary or path to JSON/YAML config).
@JsonKey(name: 'task_args') Map<String, Object?> get taskArgs;/// Sandbox environment type (or a shorthand spec).
 Object? get sandbox;/// Cleanup sandbox environments after task completes (defaults to true).
@JsonKey(name: 'sandbox_cleanup') bool? get sandboxCleanup;/// Alternative solver(s) for evaluating task(s).
 Object? get solver;/// Tags to associate with this evaluation run.
 List<String>? get tags;/// Metadata to associate with this evaluation run.
 Map<String, dynamic>? get metadata;/// Trace message interactions with evaluated model to terminal.
 bool? get trace;/// Task display type (defaults to `"full"`).
 String? get display;/// Tool use approval policies.
 Object? get approval;/// Score output (defaults to true).
 bool get score;/// Level for logging to the console (defaults to `"warning"`).
@JsonKey(name: 'log_level') String? get logLevel;/// Level for logging to the log file (defaults to `"info"`).
@JsonKey(name: 'log_level_transcript') String? get logLevelTranscript;/// Format for writing log files (`"eval"` or `"json"`).
@JsonKey(name: 'log_format') String? get logFormat;/// Limit evaluated samples (defaults to all samples).
///
/// Can be an `int` count or a `[start, end]` range.
 Object? get limit;/// Evaluate specific sample(s) from the dataset.
@JsonKey(name: 'sample_id') Object? get sampleId;/// Shuffle order of samples (pass a seed to make the order deterministic).
@JsonKey(name: 'sample_shuffle') Object? get sampleShuffle;/// Epochs to repeat samples for and optional score reducer function(s).
 Object? get epochs;/// Fail on sample errors.
///
/// `0.0–1.0` = fail if proportion exceeds threshold,
/// `>1` = fail if count exceeds threshold.
@JsonKey(name: 'fail_on_error') double? get failOnError;/// Continue running even if `fail_on_error` condition is met.
@JsonKey(name: 'continue_on_fail') bool? get continueOnFail;/// Number of times to retry samples on error (default: no retries).
@JsonKey(name: 'retry_on_error') int? get retryOnError;/// Raise task errors for debugging (defaults to false).
@JsonKey(name: 'debug_errors') bool? get debugErrors;/// Limit on total messages per sample.
@JsonKey(name: 'message_limit') int? get messageLimit;/// Limit on total tokens per sample.
@JsonKey(name: 'token_limit') int? get tokenLimit;/// Limit on clock time (in seconds) per sample.
@JsonKey(name: 'time_limit') int? get timeLimit;/// Limit on working time (in seconds) per sample.
///
/// Working time includes model generation, tool calls, etc. but does not
/// include waiting on retries or shared resources.
@JsonKey(name: 'working_limit') int? get workingLimit;/// Limit on total cost (in dollars) per sample.
@JsonKey(name: 'cost_limit') double? get costLimit;/// JSON file with model prices for cost tracking.
@JsonKey(name: 'model_cost_config') Map<String, Object?>? get modelCostConfig;/// Maximum samples to run in parallel (default is `max_connections`).
@JsonKey(name: 'max_samples') int? get maxSamples;/// Maximum tasks to run in parallel.
@JsonKey(name: 'max_tasks') int? get maxTasks;/// Maximum subprocesses to run in parallel (default is `os.cpu_count()`).
@JsonKey(name: 'max_subprocesses') int? get maxSubprocesses;/// Maximum sandboxes (per-provider) to run in parallel.
@JsonKey(name: 'max_sandboxes') int? get maxSandboxes;/// Log detailed samples and scores (defaults to true).
@JsonKey(name: 'log_samples') bool? get logSamples;/// Log events in realtime (defaults to true).
@JsonKey(name: 'log_realtime') bool? get logRealtime;/// Log base64-encoded images (defaults to false).
@JsonKey(name: 'log_images') bool? get logImages;/// Number of samples to buffer before writing log file.
@JsonKey(name: 'log_buffer') int? get logBuffer;/// Sync sample events for realtime viewing.
@JsonKey(name: 'log_shared') int? get logShared;/// Directory to bundle logs and viewer into.
@JsonKey(name: 'bundle_dir') String? get bundleDir;/// Overwrite files in `bundle_dir` (defaults to false).
@JsonKey(name: 'bundle_overwrite') bool get bundleOverwrite;/// Allow log directory to contain unrelated logs (defaults to false).
@JsonKey(name: 'log_dir_allow_dirty') bool? get logDirAllowDirty;/// ID for the eval set. Generated if not specified.
@JsonKey(name: 'eval_set_id') String? get evalSetId;
/// Create a copy of EvalSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSetCopyWith<EvalSet> get copyWith => _$EvalSetCopyWithImpl<EvalSet>(this as EvalSet, _$identity);

  /// Serializes this EvalSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSet&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts)&&(identical(other.retryWait, retryWait) || other.retryWait == retryWait)&&(identical(other.retryConnections, retryConnections) || other.retryConnections == retryConnections)&&(identical(other.retryCleanup, retryCleanup) || other.retryCleanup == retryCleanup)&&const DeepCollectionEquality().equals(other.model, model)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other.modelArgs, modelArgs)&&const DeepCollectionEquality().equals(other.modelRoles, modelRoles)&&const DeepCollectionEquality().equals(other.taskArgs, taskArgs)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&const DeepCollectionEquality().equals(other.solver, solver)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.trace, trace) || other.trace == trace)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other.approval, approval)&&(identical(other.score, score) || other.score == score)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.logLevelTranscript, logLevelTranscript) || other.logLevelTranscript == logLevelTranscript)&&(identical(other.logFormat, logFormat) || other.logFormat == logFormat)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&const DeepCollectionEquality().equals(other.sampleShuffle, sampleShuffle)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&(identical(other.failOnError, failOnError) || other.failOnError == failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.debugErrors, debugErrors) || other.debugErrors == debugErrors)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other.modelCostConfig, modelCostConfig)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.bundleDir, bundleDir) || other.bundleDir == bundleDir)&&(identical(other.bundleOverwrite, bundleOverwrite) || other.bundleOverwrite == bundleOverwrite)&&(identical(other.logDirAllowDirty, logDirAllowDirty) || other.logDirAllowDirty == logDirAllowDirty)&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(tasks),logDir,retryAttempts,retryWait,retryConnections,retryCleanup,const DeepCollectionEquality().hash(model),modelBaseUrl,const DeepCollectionEquality().hash(modelArgs),const DeepCollectionEquality().hash(modelRoles),const DeepCollectionEquality().hash(taskArgs),const DeepCollectionEquality().hash(sandbox),sandboxCleanup,const DeepCollectionEquality().hash(solver),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(metadata),trace,display,const DeepCollectionEquality().hash(approval),score,logLevel,logLevelTranscript,logFormat,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),const DeepCollectionEquality().hash(sampleShuffle),const DeepCollectionEquality().hash(epochs),failOnError,continueOnFail,retryOnError,debugErrors,messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(modelCostConfig),maxSamples,maxTasks,maxSubprocesses,maxSandboxes,logSamples,logRealtime,logImages,logBuffer,logShared,bundleDir,bundleOverwrite,logDirAllowDirty,evalSetId]);

@override
String toString() {
  return 'EvalSet(tasks: $tasks, logDir: $logDir, retryAttempts: $retryAttempts, retryWait: $retryWait, retryConnections: $retryConnections, retryCleanup: $retryCleanup, model: $model, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, taskArgs: $taskArgs, sandbox: $sandbox, sandboxCleanup: $sandboxCleanup, solver: $solver, tags: $tags, metadata: $metadata, trace: $trace, display: $display, approval: $approval, score: $score, logLevel: $logLevel, logLevelTranscript: $logLevelTranscript, logFormat: $logFormat, limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, debugErrors: $debugErrors, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, modelCostConfig: $modelCostConfig, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, bundleDir: $bundleDir, bundleOverwrite: $bundleOverwrite, logDirAllowDirty: $logDirAllowDirty, evalSetId: $evalSetId)';
}


}

/// @nodoc
abstract mixin class $EvalSetCopyWith<$Res>  {
  factory $EvalSetCopyWith(EvalSet value, $Res Function(EvalSet) _then) = _$EvalSetCopyWithImpl;
@useResult
$Res call({
 List<Task> tasks,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'retry_attempts') int? retryAttempts,@JsonKey(name: 'retry_wait') double? retryWait,@JsonKey(name: 'retry_connections') double? retryConnections,@JsonKey(name: 'retry_cleanup') bool? retryCleanup, List<String>? model,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args') Map<String, Object?> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles,@JsonKey(name: 'task_args') Map<String, Object?> taskArgs, Object? sandbox,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup, Object? solver, List<String>? tags, Map<String, dynamic>? metadata, bool? trace, String? display, Object? approval, bool score,@JsonKey(name: 'log_level') String? logLevel,@JsonKey(name: 'log_level_transcript') String? logLevelTranscript,@JsonKey(name: 'log_format') String? logFormat, Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') Object? sampleShuffle, Object? epochs,@JsonKey(name: 'fail_on_error') double? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'debug_errors') bool? debugErrors,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'bundle_dir') String? bundleDir,@JsonKey(name: 'bundle_overwrite') bool bundleOverwrite,@JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,@JsonKey(name: 'eval_set_id') String? evalSetId
});




}
/// @nodoc
class _$EvalSetCopyWithImpl<$Res>
    implements $EvalSetCopyWith<$Res> {
  _$EvalSetCopyWithImpl(this._self, this._then);

  final EvalSet _self;
  final $Res Function(EvalSet) _then;

/// Create a copy of EvalSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tasks = null,Object? logDir = null,Object? retryAttempts = freezed,Object? retryWait = freezed,Object? retryConnections = freezed,Object? retryCleanup = freezed,Object? model = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = null,Object? modelRoles = freezed,Object? taskArgs = null,Object? sandbox = freezed,Object? sandboxCleanup = freezed,Object? solver = freezed,Object? tags = freezed,Object? metadata = freezed,Object? trace = freezed,Object? display = freezed,Object? approval = freezed,Object? score = null,Object? logLevel = freezed,Object? logLevelTranscript = freezed,Object? logFormat = freezed,Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? debugErrors = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? modelCostConfig = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? bundleDir = freezed,Object? bundleOverwrite = null,Object? logDirAllowDirty = freezed,Object? evalSetId = freezed,}) {
  return _then(_self.copyWith(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,retryAttempts: freezed == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int?,retryWait: freezed == retryWait ? _self.retryWait : retryWait // ignore: cast_nullable_to_non_nullable
as double?,retryConnections: freezed == retryConnections ? _self.retryConnections : retryConnections // ignore: cast_nullable_to_non_nullable
as double?,retryCleanup: freezed == retryCleanup ? _self.retryCleanup : retryCleanup // ignore: cast_nullable_to_non_nullable
as bool?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as List<String>?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: null == modelArgs ? _self.modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,modelRoles: freezed == modelRoles ? _self.modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,taskArgs: null == taskArgs ? _self.taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,solver: freezed == solver ? _self.solver : solver ,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as bool?,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,approval: freezed == approval ? _self.approval : approval ,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as bool,logLevel: freezed == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String?,logLevelTranscript: freezed == logLevelTranscript ? _self.logLevelTranscript : logLevelTranscript // ignore: cast_nullable_to_non_nullable
as String?,logFormat: freezed == logFormat ? _self.logFormat : logFormat // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle ,epochs: freezed == epochs ? _self.epochs : epochs ,failOnError: freezed == failOnError ? _self.failOnError : failOnError // ignore: cast_nullable_to_non_nullable
as double?,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,debugErrors: freezed == debugErrors ? _self.debugErrors : debugErrors // ignore: cast_nullable_to_non_nullable
as bool?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,modelCostConfig: freezed == modelCostConfig ? _self.modelCostConfig : modelCostConfig // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,bundleDir: freezed == bundleDir ? _self.bundleDir : bundleDir // ignore: cast_nullable_to_non_nullable
as String?,bundleOverwrite: null == bundleOverwrite ? _self.bundleOverwrite : bundleOverwrite // ignore: cast_nullable_to_non_nullable
as bool,logDirAllowDirty: freezed == logDirAllowDirty ? _self.logDirAllowDirty : logDirAllowDirty // ignore: cast_nullable_to_non_nullable
as bool?,evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSet].
extension EvalSetPatterns on EvalSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSet value)  $default,){
final _that = this;
switch (_that) {
case _EvalSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSet value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Task> tasks, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup,  List<String>? model, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?> taskArgs,  Object? sandbox, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup,  Object? solver,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  Object? approval,  bool score, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSet() when $default != null:
return $default(_that.tasks,_that.logDir,_that.retryAttempts,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.model,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.sandbox,_that.sandboxCleanup,_that.solver,_that.tags,_that.metadata,_that.trace,_that.display,_that.approval,_that.score,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Task> tasks, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup,  List<String>? model, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?> taskArgs,  Object? sandbox, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup,  Object? solver,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  Object? approval,  bool score, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId)  $default,) {final _that = this;
switch (_that) {
case _EvalSet():
return $default(_that.tasks,_that.logDir,_that.retryAttempts,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.model,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.sandbox,_that.sandboxCleanup,_that.solver,_that.tags,_that.metadata,_that.trace,_that.display,_that.approval,_that.score,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Task> tasks, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'retry_attempts')  int? retryAttempts, @JsonKey(name: 'retry_wait')  double? retryWait, @JsonKey(name: 'retry_connections')  double? retryConnections, @JsonKey(name: 'retry_cleanup')  bool? retryCleanup,  List<String>? model, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args')  Map<String, Object?> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles, @JsonKey(name: 'task_args')  Map<String, Object?> taskArgs,  Object? sandbox, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup,  Object? solver,  List<String>? tags,  Map<String, dynamic>? metadata,  bool? trace,  String? display,  Object? approval,  bool score, @JsonKey(name: 'log_level')  String? logLevel, @JsonKey(name: 'log_level_transcript')  String? logLevelTranscript, @JsonKey(name: 'log_format')  String? logFormat,  Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  Object? sampleShuffle,  Object? epochs, @JsonKey(name: 'fail_on_error')  double? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'debug_errors')  bool? debugErrors, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'model_cost_config')  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'bundle_dir')  String? bundleDir, @JsonKey(name: 'bundle_overwrite')  bool bundleOverwrite, @JsonKey(name: 'log_dir_allow_dirty')  bool? logDirAllowDirty, @JsonKey(name: 'eval_set_id')  String? evalSetId)?  $default,) {final _that = this;
switch (_that) {
case _EvalSet() when $default != null:
return $default(_that.tasks,_that.logDir,_that.retryAttempts,_that.retryWait,_that.retryConnections,_that.retryCleanup,_that.model,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.taskArgs,_that.sandbox,_that.sandboxCleanup,_that.solver,_that.tags,_that.metadata,_that.trace,_that.display,_that.approval,_that.score,_that.logLevel,_that.logLevelTranscript,_that.logFormat,_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.debugErrors,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.modelCostConfig,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.bundleDir,_that.bundleOverwrite,_that.logDirAllowDirty,_that.evalSetId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSet implements EvalSet {
  const _EvalSet({required final  List<Task> tasks, @JsonKey(name: 'log_dir') required this.logDir, @JsonKey(name: 'retry_attempts') this.retryAttempts, @JsonKey(name: 'retry_wait') this.retryWait, @JsonKey(name: 'retry_connections') this.retryConnections, @JsonKey(name: 'retry_cleanup') this.retryCleanup, final  List<String>? model, @JsonKey(name: 'model_base_url') this.modelBaseUrl, @JsonKey(name: 'model_args') final  Map<String, Object?> modelArgs = const {}, @JsonKey(name: 'model_roles') final  Map<String, String>? modelRoles, @JsonKey(name: 'task_args') final  Map<String, Object?> taskArgs = const {}, this.sandbox, @JsonKey(name: 'sandbox_cleanup') this.sandboxCleanup, this.solver, final  List<String>? tags, final  Map<String, dynamic>? metadata, this.trace, this.display, this.approval, this.score = true, @JsonKey(name: 'log_level') this.logLevel, @JsonKey(name: 'log_level_transcript') this.logLevelTranscript, @JsonKey(name: 'log_format') this.logFormat, this.limit, @JsonKey(name: 'sample_id') this.sampleId, @JsonKey(name: 'sample_shuffle') this.sampleShuffle, this.epochs, @JsonKey(name: 'fail_on_error') this.failOnError, @JsonKey(name: 'continue_on_fail') this.continueOnFail, @JsonKey(name: 'retry_on_error') this.retryOnError, @JsonKey(name: 'debug_errors') this.debugErrors, @JsonKey(name: 'message_limit') this.messageLimit, @JsonKey(name: 'token_limit') this.tokenLimit, @JsonKey(name: 'time_limit') this.timeLimit, @JsonKey(name: 'working_limit') this.workingLimit, @JsonKey(name: 'cost_limit') this.costLimit, @JsonKey(name: 'model_cost_config') final  Map<String, Object?>? modelCostConfig, @JsonKey(name: 'max_samples') this.maxSamples, @JsonKey(name: 'max_tasks') this.maxTasks, @JsonKey(name: 'max_subprocesses') this.maxSubprocesses, @JsonKey(name: 'max_sandboxes') this.maxSandboxes, @JsonKey(name: 'log_samples') this.logSamples, @JsonKey(name: 'log_realtime') this.logRealtime, @JsonKey(name: 'log_images') this.logImages, @JsonKey(name: 'log_buffer') this.logBuffer, @JsonKey(name: 'log_shared') this.logShared, @JsonKey(name: 'bundle_dir') this.bundleDir, @JsonKey(name: 'bundle_overwrite') this.bundleOverwrite = false, @JsonKey(name: 'log_dir_allow_dirty') this.logDirAllowDirty, @JsonKey(name: 'eval_set_id') this.evalSetId}): _tasks = tasks,_model = model,_modelArgs = modelArgs,_modelRoles = modelRoles,_taskArgs = taskArgs,_tags = tags,_metadata = metadata,_modelCostConfig = modelCostConfig;
  factory _EvalSet.fromJson(Map<String, dynamic> json) => _$EvalSetFromJson(json);

/// Task(s) to evaluate.
///
/// Accepts task file paths, task function names, or other task specifiers.
 final  List<Task> _tasks;
/// Task(s) to evaluate.
///
/// Accepts task file paths, task function names, or other task specifiers.
@override List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

/// Output path for logging results.
///
/// Required to ensure a unique storage scope is assigned for the set.
@override@JsonKey(name: 'log_dir') final  String logDir;
/// Maximum number of retry attempts before giving up (defaults to 10).
@override@JsonKey(name: 'retry_attempts') final  int? retryAttempts;
/// Time in seconds to wait between retry attempts, increased
/// exponentially (defaults to 30).
@override@JsonKey(name: 'retry_wait') final  double? retryWait;
/// Reduce `max_connections` at this rate with each retry
/// (defaults to 1.0 — no reduction).
@override@JsonKey(name: 'retry_connections') final  double? retryConnections;
/// Cleanup failed log files after retries (defaults to true).
@override@JsonKey(name: 'retry_cleanup') final  bool? retryCleanup;
/// Model(s) for evaluation.
///
/// A list of Provider/model strings (e.g. `"openai/gpt-4o"`)
/// If not specified, uses the `INSPECT_EVAL_MODEL` environment variable.
 final  List<String>? _model;
/// Model(s) for evaluation.
///
/// A list of Provider/model strings (e.g. `"openai/gpt-4o"`)
/// If not specified, uses the `INSPECT_EVAL_MODEL` environment variable.
@override List<String>? get model {
  final value = _model;
  if (value == null) return null;
  if (_model is EqualUnmodifiableListView) return _model;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Base URL for communicating with the model API.
@override@JsonKey(name: 'model_base_url') final  String? modelBaseUrl;
/// Model creation arguments (dictionary or path to JSON/YAML config).
 final  Map<String, Object?> _modelArgs;
/// Model creation arguments (dictionary or path to JSON/YAML config).
@override@JsonKey(name: 'model_args') Map<String, Object?> get modelArgs {
  if (_modelArgs is EqualUnmodifiableMapView) return _modelArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modelArgs);
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

/// Task creation arguments (dictionary or path to JSON/YAML config).
 final  Map<String, Object?> _taskArgs;
/// Task creation arguments (dictionary or path to JSON/YAML config).
@override@JsonKey(name: 'task_args') Map<String, Object?> get taskArgs {
  if (_taskArgs is EqualUnmodifiableMapView) return _taskArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskArgs);
}

/// Sandbox environment type (or a shorthand spec).
@override final  Object? sandbox;
/// Cleanup sandbox environments after task completes (defaults to true).
@override@JsonKey(name: 'sandbox_cleanup') final  bool? sandboxCleanup;
/// Alternative solver(s) for evaluating task(s).
@override final  Object? solver;
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
/// Tool use approval policies.
@override final  Object? approval;
/// Score output (defaults to true).
@override@JsonKey() final  bool score;
/// Level for logging to the console (defaults to `"warning"`).
@override@JsonKey(name: 'log_level') final  String? logLevel;
/// Level for logging to the log file (defaults to `"info"`).
@override@JsonKey(name: 'log_level_transcript') final  String? logLevelTranscript;
/// Format for writing log files (`"eval"` or `"json"`).
@override@JsonKey(name: 'log_format') final  String? logFormat;
/// Limit evaluated samples (defaults to all samples).
///
/// Can be an `int` count or a `[start, end]` range.
@override final  Object? limit;
/// Evaluate specific sample(s) from the dataset.
@override@JsonKey(name: 'sample_id') final  Object? sampleId;
/// Shuffle order of samples (pass a seed to make the order deterministic).
@override@JsonKey(name: 'sample_shuffle') final  Object? sampleShuffle;
/// Epochs to repeat samples for and optional score reducer function(s).
@override final  Object? epochs;
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
/// Limit on total messages per sample.
@override@JsonKey(name: 'message_limit') final  int? messageLimit;
/// Limit on total tokens per sample.
@override@JsonKey(name: 'token_limit') final  int? tokenLimit;
/// Limit on clock time (in seconds) per sample.
@override@JsonKey(name: 'time_limit') final  int? timeLimit;
/// Limit on working time (in seconds) per sample.
///
/// Working time includes model generation, tool calls, etc. but does not
/// include waiting on retries or shared resources.
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

/// Maximum samples to run in parallel (default is `max_connections`).
@override@JsonKey(name: 'max_samples') final  int? maxSamples;
/// Maximum tasks to run in parallel.
@override@JsonKey(name: 'max_tasks') final  int? maxTasks;
/// Maximum subprocesses to run in parallel (default is `os.cpu_count()`).
@override@JsonKey(name: 'max_subprocesses') final  int? maxSubprocesses;
/// Maximum sandboxes (per-provider) to run in parallel.
@override@JsonKey(name: 'max_sandboxes') final  int? maxSandboxes;
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
@override@JsonKey(name: 'bundle_overwrite') final  bool bundleOverwrite;
/// Allow log directory to contain unrelated logs (defaults to false).
@override@JsonKey(name: 'log_dir_allow_dirty') final  bool? logDirAllowDirty;
/// ID for the eval set. Generated if not specified.
@override@JsonKey(name: 'eval_set_id') final  String? evalSetId;

/// Create a copy of EvalSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSetCopyWith<_EvalSet> get copyWith => __$EvalSetCopyWithImpl<_EvalSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSet&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts)&&(identical(other.retryWait, retryWait) || other.retryWait == retryWait)&&(identical(other.retryConnections, retryConnections) || other.retryConnections == retryConnections)&&(identical(other.retryCleanup, retryCleanup) || other.retryCleanup == retryCleanup)&&const DeepCollectionEquality().equals(other._model, _model)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other._modelArgs, _modelArgs)&&const DeepCollectionEquality().equals(other._modelRoles, _modelRoles)&&const DeepCollectionEquality().equals(other._taskArgs, _taskArgs)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&const DeepCollectionEquality().equals(other.solver, solver)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.trace, trace) || other.trace == trace)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other.approval, approval)&&(identical(other.score, score) || other.score == score)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel)&&(identical(other.logLevelTranscript, logLevelTranscript) || other.logLevelTranscript == logLevelTranscript)&&(identical(other.logFormat, logFormat) || other.logFormat == logFormat)&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&const DeepCollectionEquality().equals(other.sampleShuffle, sampleShuffle)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&(identical(other.failOnError, failOnError) || other.failOnError == failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.debugErrors, debugErrors) || other.debugErrors == debugErrors)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other._modelCostConfig, _modelCostConfig)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.bundleDir, bundleDir) || other.bundleDir == bundleDir)&&(identical(other.bundleOverwrite, bundleOverwrite) || other.bundleOverwrite == bundleOverwrite)&&(identical(other.logDirAllowDirty, logDirAllowDirty) || other.logDirAllowDirty == logDirAllowDirty)&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_tasks),logDir,retryAttempts,retryWait,retryConnections,retryCleanup,const DeepCollectionEquality().hash(_model),modelBaseUrl,const DeepCollectionEquality().hash(_modelArgs),const DeepCollectionEquality().hash(_modelRoles),const DeepCollectionEquality().hash(_taskArgs),const DeepCollectionEquality().hash(sandbox),sandboxCleanup,const DeepCollectionEquality().hash(solver),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_metadata),trace,display,const DeepCollectionEquality().hash(approval),score,logLevel,logLevelTranscript,logFormat,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),const DeepCollectionEquality().hash(sampleShuffle),const DeepCollectionEquality().hash(epochs),failOnError,continueOnFail,retryOnError,debugErrors,messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(_modelCostConfig),maxSamples,maxTasks,maxSubprocesses,maxSandboxes,logSamples,logRealtime,logImages,logBuffer,logShared,bundleDir,bundleOverwrite,logDirAllowDirty,evalSetId]);

@override
String toString() {
  return 'EvalSet(tasks: $tasks, logDir: $logDir, retryAttempts: $retryAttempts, retryWait: $retryWait, retryConnections: $retryConnections, retryCleanup: $retryCleanup, model: $model, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, taskArgs: $taskArgs, sandbox: $sandbox, sandboxCleanup: $sandboxCleanup, solver: $solver, tags: $tags, metadata: $metadata, trace: $trace, display: $display, approval: $approval, score: $score, logLevel: $logLevel, logLevelTranscript: $logLevelTranscript, logFormat: $logFormat, limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, debugErrors: $debugErrors, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, modelCostConfig: $modelCostConfig, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, bundleDir: $bundleDir, bundleOverwrite: $bundleOverwrite, logDirAllowDirty: $logDirAllowDirty, evalSetId: $evalSetId)';
}


}

/// @nodoc
abstract mixin class _$EvalSetCopyWith<$Res> implements $EvalSetCopyWith<$Res> {
  factory _$EvalSetCopyWith(_EvalSet value, $Res Function(_EvalSet) _then) = __$EvalSetCopyWithImpl;
@override @useResult
$Res call({
 List<Task> tasks,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'retry_attempts') int? retryAttempts,@JsonKey(name: 'retry_wait') double? retryWait,@JsonKey(name: 'retry_connections') double? retryConnections,@JsonKey(name: 'retry_cleanup') bool? retryCleanup, List<String>? model,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args') Map<String, Object?> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles,@JsonKey(name: 'task_args') Map<String, Object?> taskArgs, Object? sandbox,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup, Object? solver, List<String>? tags, Map<String, dynamic>? metadata, bool? trace, String? display, Object? approval, bool score,@JsonKey(name: 'log_level') String? logLevel,@JsonKey(name: 'log_level_transcript') String? logLevelTranscript,@JsonKey(name: 'log_format') String? logFormat, Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') Object? sampleShuffle, Object? epochs,@JsonKey(name: 'fail_on_error') double? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'debug_errors') bool? debugErrors,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'model_cost_config') Map<String, Object?>? modelCostConfig,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'bundle_dir') String? bundleDir,@JsonKey(name: 'bundle_overwrite') bool bundleOverwrite,@JsonKey(name: 'log_dir_allow_dirty') bool? logDirAllowDirty,@JsonKey(name: 'eval_set_id') String? evalSetId
});




}
/// @nodoc
class __$EvalSetCopyWithImpl<$Res>
    implements _$EvalSetCopyWith<$Res> {
  __$EvalSetCopyWithImpl(this._self, this._then);

  final _EvalSet _self;
  final $Res Function(_EvalSet) _then;

/// Create a copy of EvalSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? logDir = null,Object? retryAttempts = freezed,Object? retryWait = freezed,Object? retryConnections = freezed,Object? retryCleanup = freezed,Object? model = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = null,Object? modelRoles = freezed,Object? taskArgs = null,Object? sandbox = freezed,Object? sandboxCleanup = freezed,Object? solver = freezed,Object? tags = freezed,Object? metadata = freezed,Object? trace = freezed,Object? display = freezed,Object? approval = freezed,Object? score = null,Object? logLevel = freezed,Object? logLevelTranscript = freezed,Object? logFormat = freezed,Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? debugErrors = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? modelCostConfig = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? bundleDir = freezed,Object? bundleOverwrite = null,Object? logDirAllowDirty = freezed,Object? evalSetId = freezed,}) {
  return _then(_EvalSet(
tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,retryAttempts: freezed == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int?,retryWait: freezed == retryWait ? _self.retryWait : retryWait // ignore: cast_nullable_to_non_nullable
as double?,retryConnections: freezed == retryConnections ? _self.retryConnections : retryConnections // ignore: cast_nullable_to_non_nullable
as double?,retryCleanup: freezed == retryCleanup ? _self.retryCleanup : retryCleanup // ignore: cast_nullable_to_non_nullable
as bool?,model: freezed == model ? _self._model : model // ignore: cast_nullable_to_non_nullable
as List<String>?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: null == modelArgs ? _self._modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,modelRoles: freezed == modelRoles ? _self._modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,taskArgs: null == taskArgs ? _self._taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,solver: freezed == solver ? _self.solver : solver ,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as bool?,display: freezed == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as String?,approval: freezed == approval ? _self.approval : approval ,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as bool,logLevel: freezed == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as String?,logLevelTranscript: freezed == logLevelTranscript ? _self.logLevelTranscript : logLevelTranscript // ignore: cast_nullable_to_non_nullable
as String?,logFormat: freezed == logFormat ? _self.logFormat : logFormat // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle ,epochs: freezed == epochs ? _self.epochs : epochs ,failOnError: freezed == failOnError ? _self.failOnError : failOnError // ignore: cast_nullable_to_non_nullable
as double?,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,debugErrors: freezed == debugErrors ? _self.debugErrors : debugErrors // ignore: cast_nullable_to_non_nullable
as bool?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,modelCostConfig: freezed == modelCostConfig ? _self._modelCostConfig : modelCostConfig // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,bundleDir: freezed == bundleDir ? _self.bundleDir : bundleDir // ignore: cast_nullable_to_non_nullable
as String?,bundleOverwrite: null == bundleOverwrite ? _self.bundleOverwrite : bundleOverwrite // ignore: cast_nullable_to_non_nullable
as bool,logDirAllowDirty: freezed == logDirAllowDirty ? _self.logDirAllowDirty : logDirAllowDirty // ignore: cast_nullable_to_non_nullable
as bool?,evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
