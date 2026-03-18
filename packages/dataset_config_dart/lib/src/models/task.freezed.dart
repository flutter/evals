// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

/// Dataset to evaluate.
///
/// A `Dataset`, a sequence of `Sample` objects, or `null`.
 Dataset? get dataset;/// Files to copy into sandbox (inherited by all samples).
///
/// Keys are destination paths, values are source paths, inline text,
/// or inline binary (base64-encoded data URLs).
 Map<String, String>? get files;/// Setup step (always run even when the main solver is replaced).
 Object? get setup;/// Solver or list of solvers. Defaults to `generate()`.
 Object? get solver;/// Optional cleanup function for task.
///
/// Called after all solvers and scorers have run for each sample
/// (including if an exception occurs during the run).
 Object? get cleanup;/// Scorer used to evaluate model output.
 Object? get scorer;/// Alternative metrics (overrides the metrics provided by the scorer).
 Object? get metrics;/// Default model for task (optional, defaults to the eval model).
 String? get model;/// Model generation config for default model.
 Object? get config;/// Named roles for use in `get_model()`.
@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles;/// Sandbox environment type (or a shorthand spec).
 Object? get sandbox;/// Tool use approval policies.
 Object? get approval;/// Epochs to repeat samples for and optional score reducer function(s).
 Object? get epochs;/// Fail on sample errors.
///
/// `true` = fail on first error (default), `false` = never fail,
/// `0.0–1.0` = fail if proportion exceeds threshold,
/// `>1` = fail if count exceeds threshold.
@JsonKey(name: 'fail_on_error') Object? get failOnError;/// Continue running if the `fail_on_error` condition is met.
@JsonKey(name: 'continue_on_fail') bool? get continueOnFail;/// Limit on total messages per sample.
@JsonKey(name: 'message_limit') int? get messageLimit;/// Limit on total tokens per sample.
@JsonKey(name: 'token_limit') int? get tokenLimit;/// Limit on clock time (in seconds) per sample.
@JsonKey(name: 'time_limit') int? get timeLimit;/// Limit on working time (in seconds) per sample.
///
/// Working time includes model generation, tool calls, etc. but does not
/// include waiting on retries or shared resources.
@JsonKey(name: 'working_limit') int? get workingLimit;/// Limit on total cost (in dollars) per sample.
@JsonKey(name: 'cost_limit') double? get costLimit;/// Early stopping callbacks.
@JsonKey(name: 'early_stopping') Object? get earlyStopping;/// Task display name (e.g. for plotting).
///
/// Defaults to the registered task name.
@JsonKey(name: 'display_name') String? get displayName;/// Task function identifier for Mode 1 hydration.
///
/// When present, the Python runner uses this to look up a pre-built
/// `@task` function (e.g. `"flutter_code_gen"` or
/// `"dash_evals.runner.tasks.flutter_code_gen"`).
/// When absent, the runner hydrates directly from JSON (Mode 2 — future).
@JsonKey(name: 'func') String? get func;/// System message override for this task.
@JsonKey(name: 'system_message') String? get systemMessage;/// Pass-through dict for sandbox plugin configuration.
@JsonKey(name: 'sandbox_parameters') Map<String, dynamic>? get sandboxParameters;/// Task name.
///
/// Automatically determined based on the registered name if not specified.
 String? get name;/// Version of task (to distinguish evolutions of the task spec).
 Object get version;/// Additional metadata to associate with the task.
 Map<String, dynamic>? get metadata;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.dataset, dataset) || other.dataset == dataset)&&const DeepCollectionEquality().equals(other.files, files)&&const DeepCollectionEquality().equals(other.setup, setup)&&const DeepCollectionEquality().equals(other.solver, solver)&&const DeepCollectionEquality().equals(other.cleanup, cleanup)&&const DeepCollectionEquality().equals(other.scorer, scorer)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.config, config)&&const DeepCollectionEquality().equals(other.modelRoles, modelRoles)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other.approval, approval)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&const DeepCollectionEquality().equals(other.failOnError, failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other.earlyStopping, earlyStopping)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.func, func) || other.func == func)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&const DeepCollectionEquality().equals(other.sandboxParameters, sandboxParameters)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.version, version)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,dataset,const DeepCollectionEquality().hash(files),const DeepCollectionEquality().hash(setup),const DeepCollectionEquality().hash(solver),const DeepCollectionEquality().hash(cleanup),const DeepCollectionEquality().hash(scorer),const DeepCollectionEquality().hash(metrics),model,const DeepCollectionEquality().hash(config),const DeepCollectionEquality().hash(modelRoles),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(approval),const DeepCollectionEquality().hash(epochs),const DeepCollectionEquality().hash(failOnError),continueOnFail,messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(earlyStopping),displayName,func,systemMessage,const DeepCollectionEquality().hash(sandboxParameters),name,const DeepCollectionEquality().hash(version),const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'Task(dataset: $dataset, files: $files, setup: $setup, solver: $solver, cleanup: $cleanup, scorer: $scorer, metrics: $metrics, model: $model, config: $config, modelRoles: $modelRoles, sandbox: $sandbox, approval: $approval, epochs: $epochs, failOnError: $failOnError, continueOnFail: $continueOnFail, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, earlyStopping: $earlyStopping, displayName: $displayName, func: $func, systemMessage: $systemMessage, sandboxParameters: $sandboxParameters, name: $name, version: $version, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 Dataset? dataset, Map<String, String>? files, Object? setup, Object? solver, Object? cleanup, Object? scorer, Object? metrics, String? model, Object? config,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, Object? sandbox, Object? approval, Object? epochs,@JsonKey(name: 'fail_on_error') Object? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'early_stopping') Object? earlyStopping,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'func') String? func,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'sandbox_parameters') Map<String, dynamic>? sandboxParameters, String? name, Object version, Map<String, dynamic>? metadata
});


$DatasetCopyWith<$Res>? get dataset;

}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dataset = freezed,Object? files = freezed,Object? setup = freezed,Object? solver = freezed,Object? cleanup = freezed,Object? scorer = freezed,Object? metrics = freezed,Object? model = freezed,Object? config = freezed,Object? modelRoles = freezed,Object? sandbox = freezed,Object? approval = freezed,Object? epochs = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? earlyStopping = freezed,Object? displayName = freezed,Object? func = freezed,Object? systemMessage = freezed,Object? sandboxParameters = freezed,Object? name = freezed,Object? version = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
dataset: freezed == dataset ? _self.dataset : dataset // ignore: cast_nullable_to_non_nullable
as Dataset?,files: freezed == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,setup: freezed == setup ? _self.setup : setup ,solver: freezed == solver ? _self.solver : solver ,cleanup: freezed == cleanup ? _self.cleanup : cleanup ,scorer: freezed == scorer ? _self.scorer : scorer ,metrics: freezed == metrics ? _self.metrics : metrics ,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config ,modelRoles: freezed == modelRoles ? _self.modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,approval: freezed == approval ? _self.approval : approval ,epochs: freezed == epochs ? _self.epochs : epochs ,failOnError: freezed == failOnError ? _self.failOnError : failOnError ,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,earlyStopping: freezed == earlyStopping ? _self.earlyStopping : earlyStopping ,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,func: freezed == func ? _self.func : func // ignore: cast_nullable_to_non_nullable
as String?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,sandboxParameters: freezed == sandboxParameters ? _self.sandboxParameters : sandboxParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version ,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatasetCopyWith<$Res>? get dataset {
    if (_self.dataset == null) {
    return null;
  }

  return $DatasetCopyWith<$Res>(_self.dataset!, (value) {
    return _then(_self.copyWith(dataset: value));
  });
}
}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Dataset? dataset,  Map<String, String>? files,  Object? setup,  Object? solver,  Object? cleanup,  Object? scorer,  Object? metrics,  String? model,  Object? config, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  Object? sandbox,  Object? approval,  Object? epochs, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'early_stopping')  Object? earlyStopping, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'func')  String? func, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'sandbox_parameters')  Map<String, dynamic>? sandboxParameters,  String? name,  Object version,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.dataset,_that.files,_that.setup,_that.solver,_that.cleanup,_that.scorer,_that.metrics,_that.model,_that.config,_that.modelRoles,_that.sandbox,_that.approval,_that.epochs,_that.failOnError,_that.continueOnFail,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.earlyStopping,_that.displayName,_that.func,_that.systemMessage,_that.sandboxParameters,_that.name,_that.version,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Dataset? dataset,  Map<String, String>? files,  Object? setup,  Object? solver,  Object? cleanup,  Object? scorer,  Object? metrics,  String? model,  Object? config, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  Object? sandbox,  Object? approval,  Object? epochs, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'early_stopping')  Object? earlyStopping, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'func')  String? func, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'sandbox_parameters')  Map<String, dynamic>? sandboxParameters,  String? name,  Object version,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.dataset,_that.files,_that.setup,_that.solver,_that.cleanup,_that.scorer,_that.metrics,_that.model,_that.config,_that.modelRoles,_that.sandbox,_that.approval,_that.epochs,_that.failOnError,_that.continueOnFail,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.earlyStopping,_that.displayName,_that.func,_that.systemMessage,_that.sandboxParameters,_that.name,_that.version,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Dataset? dataset,  Map<String, String>? files,  Object? setup,  Object? solver,  Object? cleanup,  Object? scorer,  Object? metrics,  String? model,  Object? config, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  Object? sandbox,  Object? approval,  Object? epochs, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'cost_limit')  double? costLimit, @JsonKey(name: 'early_stopping')  Object? earlyStopping, @JsonKey(name: 'display_name')  String? displayName, @JsonKey(name: 'func')  String? func, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'sandbox_parameters')  Map<String, dynamic>? sandboxParameters,  String? name,  Object version,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.dataset,_that.files,_that.setup,_that.solver,_that.cleanup,_that.scorer,_that.metrics,_that.model,_that.config,_that.modelRoles,_that.sandbox,_that.approval,_that.epochs,_that.failOnError,_that.continueOnFail,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.costLimit,_that.earlyStopping,_that.displayName,_that.func,_that.systemMessage,_that.sandboxParameters,_that.name,_that.version,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({this.dataset, final  Map<String, String>? files, this.setup, this.solver, this.cleanup, this.scorer, this.metrics, this.model, this.config, @JsonKey(name: 'model_roles') final  Map<String, String>? modelRoles, this.sandbox, this.approval, this.epochs, @JsonKey(name: 'fail_on_error') this.failOnError, @JsonKey(name: 'continue_on_fail') this.continueOnFail, @JsonKey(name: 'message_limit') this.messageLimit, @JsonKey(name: 'token_limit') this.tokenLimit, @JsonKey(name: 'time_limit') this.timeLimit, @JsonKey(name: 'working_limit') this.workingLimit, @JsonKey(name: 'cost_limit') this.costLimit, @JsonKey(name: 'early_stopping') this.earlyStopping, @JsonKey(name: 'display_name') this.displayName, @JsonKey(name: 'func') this.func, @JsonKey(name: 'system_message') this.systemMessage, @JsonKey(name: 'sandbox_parameters') final  Map<String, dynamic>? sandboxParameters, this.name, this.version = 0, final  Map<String, dynamic>? metadata}): _files = files,_modelRoles = modelRoles,_sandboxParameters = sandboxParameters,_metadata = metadata;
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

/// Dataset to evaluate.
///
/// A `Dataset`, a sequence of `Sample` objects, or `null`.
@override final  Dataset? dataset;
/// Files to copy into sandbox (inherited by all samples).
///
/// Keys are destination paths, values are source paths, inline text,
/// or inline binary (base64-encoded data URLs).
 final  Map<String, String>? _files;
/// Files to copy into sandbox (inherited by all samples).
///
/// Keys are destination paths, values are source paths, inline text,
/// or inline binary (base64-encoded data URLs).
@override Map<String, String>? get files {
  final value = _files;
  if (value == null) return null;
  if (_files is EqualUnmodifiableMapView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Setup step (always run even when the main solver is replaced).
@override final  Object? setup;
/// Solver or list of solvers. Defaults to `generate()`.
@override final  Object? solver;
/// Optional cleanup function for task.
///
/// Called after all solvers and scorers have run for each sample
/// (including if an exception occurs during the run).
@override final  Object? cleanup;
/// Scorer used to evaluate model output.
@override final  Object? scorer;
/// Alternative metrics (overrides the metrics provided by the scorer).
@override final  Object? metrics;
/// Default model for task (optional, defaults to the eval model).
@override final  String? model;
/// Model generation config for default model.
@override final  Object? config;
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

/// Sandbox environment type (or a shorthand spec).
@override final  Object? sandbox;
/// Tool use approval policies.
@override final  Object? approval;
/// Epochs to repeat samples for and optional score reducer function(s).
@override final  Object? epochs;
/// Fail on sample errors.
///
/// `true` = fail on first error (default), `false` = never fail,
/// `0.0–1.0` = fail if proportion exceeds threshold,
/// `>1` = fail if count exceeds threshold.
@override@JsonKey(name: 'fail_on_error') final  Object? failOnError;
/// Continue running if the `fail_on_error` condition is met.
@override@JsonKey(name: 'continue_on_fail') final  bool? continueOnFail;
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
/// Early stopping callbacks.
@override@JsonKey(name: 'early_stopping') final  Object? earlyStopping;
/// Task display name (e.g. for plotting).
///
/// Defaults to the registered task name.
@override@JsonKey(name: 'display_name') final  String? displayName;
/// Task function identifier for Mode 1 hydration.
///
/// When present, the Python runner uses this to look up a pre-built
/// `@task` function (e.g. `"flutter_code_gen"` or
/// `"dash_evals.runner.tasks.flutter_code_gen"`).
/// When absent, the runner hydrates directly from JSON (Mode 2 — future).
@override@JsonKey(name: 'func') final  String? func;
/// System message override for this task.
@override@JsonKey(name: 'system_message') final  String? systemMessage;
/// Pass-through dict for sandbox plugin configuration.
 final  Map<String, dynamic>? _sandboxParameters;
/// Pass-through dict for sandbox plugin configuration.
@override@JsonKey(name: 'sandbox_parameters') Map<String, dynamic>? get sandboxParameters {
  final value = _sandboxParameters;
  if (value == null) return null;
  if (_sandboxParameters is EqualUnmodifiableMapView) return _sandboxParameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Task name.
///
/// Automatically determined based on the registered name if not specified.
@override final  String? name;
/// Version of task (to distinguish evolutions of the task spec).
@override@JsonKey() final  Object version;
/// Additional metadata to associate with the task.
 final  Map<String, dynamic>? _metadata;
/// Additional metadata to associate with the task.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.dataset, dataset) || other.dataset == dataset)&&const DeepCollectionEquality().equals(other._files, _files)&&const DeepCollectionEquality().equals(other.setup, setup)&&const DeepCollectionEquality().equals(other.solver, solver)&&const DeepCollectionEquality().equals(other.cleanup, cleanup)&&const DeepCollectionEquality().equals(other.scorer, scorer)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.config, config)&&const DeepCollectionEquality().equals(other._modelRoles, _modelRoles)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other.approval, approval)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&const DeepCollectionEquality().equals(other.failOnError, failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.costLimit, costLimit) || other.costLimit == costLimit)&&const DeepCollectionEquality().equals(other.earlyStopping, earlyStopping)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.func, func) || other.func == func)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&const DeepCollectionEquality().equals(other._sandboxParameters, _sandboxParameters)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.version, version)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,dataset,const DeepCollectionEquality().hash(_files),const DeepCollectionEquality().hash(setup),const DeepCollectionEquality().hash(solver),const DeepCollectionEquality().hash(cleanup),const DeepCollectionEquality().hash(scorer),const DeepCollectionEquality().hash(metrics),model,const DeepCollectionEquality().hash(config),const DeepCollectionEquality().hash(_modelRoles),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(approval),const DeepCollectionEquality().hash(epochs),const DeepCollectionEquality().hash(failOnError),continueOnFail,messageLimit,tokenLimit,timeLimit,workingLimit,costLimit,const DeepCollectionEquality().hash(earlyStopping),displayName,func,systemMessage,const DeepCollectionEquality().hash(_sandboxParameters),name,const DeepCollectionEquality().hash(version),const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'Task(dataset: $dataset, files: $files, setup: $setup, solver: $solver, cleanup: $cleanup, scorer: $scorer, metrics: $metrics, model: $model, config: $config, modelRoles: $modelRoles, sandbox: $sandbox, approval: $approval, epochs: $epochs, failOnError: $failOnError, continueOnFail: $continueOnFail, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, costLimit: $costLimit, earlyStopping: $earlyStopping, displayName: $displayName, func: $func, systemMessage: $systemMessage, sandboxParameters: $sandboxParameters, name: $name, version: $version, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 Dataset? dataset, Map<String, String>? files, Object? setup, Object? solver, Object? cleanup, Object? scorer, Object? metrics, String? model, Object? config,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, Object? sandbox, Object? approval, Object? epochs,@JsonKey(name: 'fail_on_error') Object? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'cost_limit') double? costLimit,@JsonKey(name: 'early_stopping') Object? earlyStopping,@JsonKey(name: 'display_name') String? displayName,@JsonKey(name: 'func') String? func,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'sandbox_parameters') Map<String, dynamic>? sandboxParameters, String? name, Object version, Map<String, dynamic>? metadata
});


@override $DatasetCopyWith<$Res>? get dataset;

}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dataset = freezed,Object? files = freezed,Object? setup = freezed,Object? solver = freezed,Object? cleanup = freezed,Object? scorer = freezed,Object? metrics = freezed,Object? model = freezed,Object? config = freezed,Object? modelRoles = freezed,Object? sandbox = freezed,Object? approval = freezed,Object? epochs = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? costLimit = freezed,Object? earlyStopping = freezed,Object? displayName = freezed,Object? func = freezed,Object? systemMessage = freezed,Object? sandboxParameters = freezed,Object? name = freezed,Object? version = null,Object? metadata = freezed,}) {
  return _then(_Task(
dataset: freezed == dataset ? _self.dataset : dataset // ignore: cast_nullable_to_non_nullable
as Dataset?,files: freezed == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,setup: freezed == setup ? _self.setup : setup ,solver: freezed == solver ? _self.solver : solver ,cleanup: freezed == cleanup ? _self.cleanup : cleanup ,scorer: freezed == scorer ? _self.scorer : scorer ,metrics: freezed == metrics ? _self.metrics : metrics ,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config ,modelRoles: freezed == modelRoles ? _self._modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,approval: freezed == approval ? _self.approval : approval ,epochs: freezed == epochs ? _self.epochs : epochs ,failOnError: freezed == failOnError ? _self.failOnError : failOnError ,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,costLimit: freezed == costLimit ? _self.costLimit : costLimit // ignore: cast_nullable_to_non_nullable
as double?,earlyStopping: freezed == earlyStopping ? _self.earlyStopping : earlyStopping ,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,func: freezed == func ? _self.func : func // ignore: cast_nullable_to_non_nullable
as String?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,sandboxParameters: freezed == sandboxParameters ? _self._sandboxParameters : sandboxParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version ,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatasetCopyWith<$Res>? get dataset {
    if (_self.dataset == null) {
    return null;
  }

  return $DatasetCopyWith<$Res>(_self.dataset!, (value) {
    return _then(_self.copyWith(dataset: value));
  });
}
}

// dart format on
