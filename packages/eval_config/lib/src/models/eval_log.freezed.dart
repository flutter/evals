// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eval_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EvalLog {

/// Eval log file format version.
 int get version;/// Status of evaluation (did it succeed or fail).
 String get status;/// Eval identity and configuration.
 EvalSpec get eval;/// Eval plan (solvers and config).
 EvalPlan? get plan;/// Eval results (scores and metrics).
 EvalResults? get results;/// Eval stats (runtime, model usage).
 EvalStats? get stats;/// Error that halted eval (if status==“error”).
 EvalError? get error;/// Whether any samples were invalidated.
 bool get invalidated;/// Samples processed by eval.
 List<EvalSample>? get samples;/// Reduced sample values.
 List<EvalSampleReductions>? get reductions;/// Location that the log file was read from.
 String? get location;/// ETag from S3 for conditional writes.
 String? get etag;/// Eval set information.
@JsonKey(name: 'eval_set_info') EvalSetInfo? get evalSetInfo;
/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalLogCopyWith<EvalLog> get copyWith => _$EvalLogCopyWithImpl<EvalLog>(this as EvalLog, _$identity);

  /// Serializes this EvalLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalLog&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status)&&(identical(other.eval, eval) || other.eval == eval)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.results, results) || other.results == results)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.error, error) || other.error == error)&&(identical(other.invalidated, invalidated) || other.invalidated == invalidated)&&const DeepCollectionEquality().equals(other.samples, samples)&&const DeepCollectionEquality().equals(other.reductions, reductions)&&(identical(other.location, location) || other.location == location)&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.evalSetInfo, evalSetInfo) || other.evalSetInfo == evalSetInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,status,eval,plan,results,stats,error,invalidated,const DeepCollectionEquality().hash(samples),const DeepCollectionEquality().hash(reductions),location,etag,evalSetInfo);

@override
String toString() {
  return 'EvalLog(version: $version, status: $status, eval: $eval, plan: $plan, results: $results, stats: $stats, error: $error, invalidated: $invalidated, samples: $samples, reductions: $reductions, location: $location, etag: $etag, evalSetInfo: $evalSetInfo)';
}


}

/// @nodoc
abstract mixin class $EvalLogCopyWith<$Res>  {
  factory $EvalLogCopyWith(EvalLog value, $Res Function(EvalLog) _then) = _$EvalLogCopyWithImpl;
@useResult
$Res call({
 int version, String status, EvalSpec eval, EvalPlan? plan, EvalResults? results, EvalStats? stats, EvalError? error, bool invalidated, List<EvalSample>? samples, List<EvalSampleReductions>? reductions, String? location, String? etag,@JsonKey(name: 'eval_set_info') EvalSetInfo? evalSetInfo
});


$EvalSpecCopyWith<$Res> get eval;$EvalPlanCopyWith<$Res>? get plan;$EvalResultsCopyWith<$Res>? get results;$EvalStatsCopyWith<$Res>? get stats;$EvalErrorCopyWith<$Res>? get error;$EvalSetInfoCopyWith<$Res>? get evalSetInfo;

}
/// @nodoc
class _$EvalLogCopyWithImpl<$Res>
    implements $EvalLogCopyWith<$Res> {
  _$EvalLogCopyWithImpl(this._self, this._then);

  final EvalLog _self;
  final $Res Function(EvalLog) _then;

/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? status = null,Object? eval = null,Object? plan = freezed,Object? results = freezed,Object? stats = freezed,Object? error = freezed,Object? invalidated = null,Object? samples = freezed,Object? reductions = freezed,Object? location = freezed,Object? etag = freezed,Object? evalSetInfo = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eval: null == eval ? _self.eval : eval // ignore: cast_nullable_to_non_nullable
as EvalSpec,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as EvalPlan?,results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as EvalResults?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as EvalStats?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as EvalError?,invalidated: null == invalidated ? _self.invalidated : invalidated // ignore: cast_nullable_to_non_nullable
as bool,samples: freezed == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as List<EvalSample>?,reductions: freezed == reductions ? _self.reductions : reductions // ignore: cast_nullable_to_non_nullable
as List<EvalSampleReductions>?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,etag: freezed == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String?,evalSetInfo: freezed == evalSetInfo ? _self.evalSetInfo : evalSetInfo // ignore: cast_nullable_to_non_nullable
as EvalSetInfo?,
  ));
}
/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSpecCopyWith<$Res> get eval {
  
  return $EvalSpecCopyWith<$Res>(_self.eval, (value) {
    return _then(_self.copyWith(eval: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $EvalPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalResultsCopyWith<$Res>? get results {
    if (_self.results == null) {
    return null;
  }

  return $EvalResultsCopyWith<$Res>(_self.results!, (value) {
    return _then(_self.copyWith(results: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $EvalStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $EvalErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSetInfoCopyWith<$Res>? get evalSetInfo {
    if (_self.evalSetInfo == null) {
    return null;
  }

  return $EvalSetInfoCopyWith<$Res>(_self.evalSetInfo!, (value) {
    return _then(_self.copyWith(evalSetInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [EvalLog].
extension EvalLogPatterns on EvalLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalLog value)  $default,){
final _that = this;
switch (_that) {
case _EvalLog():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalLog value)?  $default,){
final _that = this;
switch (_that) {
case _EvalLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  String status,  EvalSpec eval,  EvalPlan? plan,  EvalResults? results,  EvalStats? stats,  EvalError? error,  bool invalidated,  List<EvalSample>? samples,  List<EvalSampleReductions>? reductions,  String? location,  String? etag, @JsonKey(name: 'eval_set_info')  EvalSetInfo? evalSetInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalLog() when $default != null:
return $default(_that.version,_that.status,_that.eval,_that.plan,_that.results,_that.stats,_that.error,_that.invalidated,_that.samples,_that.reductions,_that.location,_that.etag,_that.evalSetInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  String status,  EvalSpec eval,  EvalPlan? plan,  EvalResults? results,  EvalStats? stats,  EvalError? error,  bool invalidated,  List<EvalSample>? samples,  List<EvalSampleReductions>? reductions,  String? location,  String? etag, @JsonKey(name: 'eval_set_info')  EvalSetInfo? evalSetInfo)  $default,) {final _that = this;
switch (_that) {
case _EvalLog():
return $default(_that.version,_that.status,_that.eval,_that.plan,_that.results,_that.stats,_that.error,_that.invalidated,_that.samples,_that.reductions,_that.location,_that.etag,_that.evalSetInfo);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  String status,  EvalSpec eval,  EvalPlan? plan,  EvalResults? results,  EvalStats? stats,  EvalError? error,  bool invalidated,  List<EvalSample>? samples,  List<EvalSampleReductions>? reductions,  String? location,  String? etag, @JsonKey(name: 'eval_set_info')  EvalSetInfo? evalSetInfo)?  $default,) {final _that = this;
switch (_that) {
case _EvalLog() when $default != null:
return $default(_that.version,_that.status,_that.eval,_that.plan,_that.results,_that.stats,_that.error,_that.invalidated,_that.samples,_that.reductions,_that.location,_that.etag,_that.evalSetInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalLog extends EvalLog {
  const _EvalLog({this.version = 2, this.status = 'started', required this.eval, this.plan, this.results, this.stats, this.error, this.invalidated = false, final  List<EvalSample>? samples, final  List<EvalSampleReductions>? reductions, this.location, this.etag, @JsonKey(name: 'eval_set_info') this.evalSetInfo}): _samples = samples,_reductions = reductions,super._();
  factory _EvalLog.fromJson(Map<String, dynamic> json) => _$EvalLogFromJson(json);

/// Eval log file format version.
@override@JsonKey() final  int version;
/// Status of evaluation (did it succeed or fail).
@override@JsonKey() final  String status;
/// Eval identity and configuration.
@override final  EvalSpec eval;
/// Eval plan (solvers and config).
@override final  EvalPlan? plan;
/// Eval results (scores and metrics).
@override final  EvalResults? results;
/// Eval stats (runtime, model usage).
@override final  EvalStats? stats;
/// Error that halted eval (if status==“error”).
@override final  EvalError? error;
/// Whether any samples were invalidated.
@override@JsonKey() final  bool invalidated;
/// Samples processed by eval.
 final  List<EvalSample>? _samples;
/// Samples processed by eval.
@override List<EvalSample>? get samples {
  final value = _samples;
  if (value == null) return null;
  if (_samples is EqualUnmodifiableListView) return _samples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Reduced sample values.
 final  List<EvalSampleReductions>? _reductions;
/// Reduced sample values.
@override List<EvalSampleReductions>? get reductions {
  final value = _reductions;
  if (value == null) return null;
  if (_reductions is EqualUnmodifiableListView) return _reductions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Location that the log file was read from.
@override final  String? location;
/// ETag from S3 for conditional writes.
@override final  String? etag;
/// Eval set information.
@override@JsonKey(name: 'eval_set_info') final  EvalSetInfo? evalSetInfo;

/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalLogCopyWith<_EvalLog> get copyWith => __$EvalLogCopyWithImpl<_EvalLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalLog&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status)&&(identical(other.eval, eval) || other.eval == eval)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.results, results) || other.results == results)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.error, error) || other.error == error)&&(identical(other.invalidated, invalidated) || other.invalidated == invalidated)&&const DeepCollectionEquality().equals(other._samples, _samples)&&const DeepCollectionEquality().equals(other._reductions, _reductions)&&(identical(other.location, location) || other.location == location)&&(identical(other.etag, etag) || other.etag == etag)&&(identical(other.evalSetInfo, evalSetInfo) || other.evalSetInfo == evalSetInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,status,eval,plan,results,stats,error,invalidated,const DeepCollectionEquality().hash(_samples),const DeepCollectionEquality().hash(_reductions),location,etag,evalSetInfo);

@override
String toString() {
  return 'EvalLog(version: $version, status: $status, eval: $eval, plan: $plan, results: $results, stats: $stats, error: $error, invalidated: $invalidated, samples: $samples, reductions: $reductions, location: $location, etag: $etag, evalSetInfo: $evalSetInfo)';
}


}

/// @nodoc
abstract mixin class _$EvalLogCopyWith<$Res> implements $EvalLogCopyWith<$Res> {
  factory _$EvalLogCopyWith(_EvalLog value, $Res Function(_EvalLog) _then) = __$EvalLogCopyWithImpl;
@override @useResult
$Res call({
 int version, String status, EvalSpec eval, EvalPlan? plan, EvalResults? results, EvalStats? stats, EvalError? error, bool invalidated, List<EvalSample>? samples, List<EvalSampleReductions>? reductions, String? location, String? etag,@JsonKey(name: 'eval_set_info') EvalSetInfo? evalSetInfo
});


@override $EvalSpecCopyWith<$Res> get eval;@override $EvalPlanCopyWith<$Res>? get plan;@override $EvalResultsCopyWith<$Res>? get results;@override $EvalStatsCopyWith<$Res>? get stats;@override $EvalErrorCopyWith<$Res>? get error;@override $EvalSetInfoCopyWith<$Res>? get evalSetInfo;

}
/// @nodoc
class __$EvalLogCopyWithImpl<$Res>
    implements _$EvalLogCopyWith<$Res> {
  __$EvalLogCopyWithImpl(this._self, this._then);

  final _EvalLog _self;
  final $Res Function(_EvalLog) _then;

/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? status = null,Object? eval = null,Object? plan = freezed,Object? results = freezed,Object? stats = freezed,Object? error = freezed,Object? invalidated = null,Object? samples = freezed,Object? reductions = freezed,Object? location = freezed,Object? etag = freezed,Object? evalSetInfo = freezed,}) {
  return _then(_EvalLog(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eval: null == eval ? _self.eval : eval // ignore: cast_nullable_to_non_nullable
as EvalSpec,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as EvalPlan?,results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as EvalResults?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as EvalStats?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as EvalError?,invalidated: null == invalidated ? _self.invalidated : invalidated // ignore: cast_nullable_to_non_nullable
as bool,samples: freezed == samples ? _self._samples : samples // ignore: cast_nullable_to_non_nullable
as List<EvalSample>?,reductions: freezed == reductions ? _self._reductions : reductions // ignore: cast_nullable_to_non_nullable
as List<EvalSampleReductions>?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,etag: freezed == etag ? _self.etag : etag // ignore: cast_nullable_to_non_nullable
as String?,evalSetInfo: freezed == evalSetInfo ? _self.evalSetInfo : evalSetInfo // ignore: cast_nullable_to_non_nullable
as EvalSetInfo?,
  ));
}

/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSpecCopyWith<$Res> get eval {
  
  return $EvalSpecCopyWith<$Res>(_self.eval, (value) {
    return _then(_self.copyWith(eval: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $EvalPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalResultsCopyWith<$Res>? get results {
    if (_self.results == null) {
    return null;
  }

  return $EvalResultsCopyWith<$Res>(_self.results!, (value) {
    return _then(_self.copyWith(results: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $EvalStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $EvalErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of EvalLog
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSetInfoCopyWith<$Res>? get evalSetInfo {
    if (_self.evalSetInfo == null) {
    return null;
  }

  return $EvalSetInfoCopyWith<$Res>(_self.evalSetInfo!, (value) {
    return _then(_self.copyWith(evalSetInfo: value));
  });
}
}


/// @nodoc
mixin _$EvalSpec {

/// Globally unique id for eval set (if any).
@JsonKey(name: 'eval_set_id') String? get evalSetId;/// Globally unique id for eval.
@JsonKey(name: 'eval_id') String get evalId;/// Unique run id.
@JsonKey(name: 'run_id') String get runId;/// Time created.
 String get created;/// Task name.
 String get task;/// Unique task id.
@JsonKey(name: 'task_id') String get taskId;/// Task version.
@JsonKey(name: 'task_version', defaultValue: 0) Object get taskVersion;/// Task source file.
@JsonKey(name: 'task_file') String? get taskFile;/// Task display name.
@JsonKey(name: 'task_display_name') String? get taskDisplayName;/// Task registry name.
@JsonKey(name: 'task_registry_name') String? get taskRegistryName;/// Attributes of the @task decorator.
@JsonKey(name: 'task_attribs', defaultValue: {}) Map<String, dynamic> get taskAttribs;/// Arguments used for invoking the task (including defaults).
@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> get taskArgs;/// Arguments explicitly passed by caller for invoking the task.
@JsonKey(name: 'task_args_passed', defaultValue: {}) Map<String, dynamic> get taskArgsPassed;/// Solver name.
 String? get solver;/// Arguments used for invoking the solver.
@JsonKey(name: 'solver_args', defaultValue: {}) Map<String, dynamic> get solverArgs;/// Arguments explicitly passed by caller for invoking the solver.
@JsonKey(name: 'solver_args_passed', defaultValue: {}) Map<String, dynamic> get solverArgsPassed;/// Tags associated with evaluation run.
 List<String> get tags;/// Dataset used for eval.
 EvalDataset? get dataset;/// Sandbox environment type and optional config file.
 Object? get sandbox;/// Model used for eval.
@JsonKey(name: 'model') String get model;/// Generate config specified for model instance.
@JsonKey(name: 'model_generate_config') GenerateConfig? get modelGenerateConfig;/// Optional override of model base url.
@JsonKey(name: 'model_base_url') String? get modelBaseUrl;/// Model specific arguments.
@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> get modelArgs;/// Model roles.
@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles;/// Configuration values for eval.
 EvalConfig get config;/// Source revision of eval.
 EvalRevision? get revision;/// Package versions for eval.
@JsonKey(name: 'packages', defaultValue: {}) Map<String, String> get packages;/// Additional eval metadata.
@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata;/// Scorers and args for this eval.
 List<Object> get scorers;/// Metrics and args for this eval.
 List<Object> get metrics;
/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSpecCopyWith<EvalSpec> get copyWith => _$EvalSpecCopyWithImpl<EvalSpec>(this as EvalSpec, _$identity);

  /// Serializes this EvalSpec to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSpec&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&(identical(other.evalId, evalId) || other.evalId == evalId)&&(identical(other.runId, runId) || other.runId == runId)&&(identical(other.created, created) || other.created == created)&&(identical(other.task, task) || other.task == task)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&const DeepCollectionEquality().equals(other.taskVersion, taskVersion)&&(identical(other.taskFile, taskFile) || other.taskFile == taskFile)&&(identical(other.taskDisplayName, taskDisplayName) || other.taskDisplayName == taskDisplayName)&&(identical(other.taskRegistryName, taskRegistryName) || other.taskRegistryName == taskRegistryName)&&const DeepCollectionEquality().equals(other.taskAttribs, taskAttribs)&&const DeepCollectionEquality().equals(other.taskArgs, taskArgs)&&const DeepCollectionEquality().equals(other.taskArgsPassed, taskArgsPassed)&&(identical(other.solver, solver) || other.solver == solver)&&const DeepCollectionEquality().equals(other.solverArgs, solverArgs)&&const DeepCollectionEquality().equals(other.solverArgsPassed, solverArgsPassed)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.dataset, dataset) || other.dataset == dataset)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&(identical(other.model, model) || other.model == model)&&(identical(other.modelGenerateConfig, modelGenerateConfig) || other.modelGenerateConfig == modelGenerateConfig)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other.modelArgs, modelArgs)&&const DeepCollectionEquality().equals(other.modelRoles, modelRoles)&&(identical(other.config, config) || other.config == config)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other.packages, packages)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.scorers, scorers)&&const DeepCollectionEquality().equals(other.metrics, metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,evalSetId,evalId,runId,created,task,taskId,const DeepCollectionEquality().hash(taskVersion),taskFile,taskDisplayName,taskRegistryName,const DeepCollectionEquality().hash(taskAttribs),const DeepCollectionEquality().hash(taskArgs),const DeepCollectionEquality().hash(taskArgsPassed),solver,const DeepCollectionEquality().hash(solverArgs),const DeepCollectionEquality().hash(solverArgsPassed),const DeepCollectionEquality().hash(tags),dataset,const DeepCollectionEquality().hash(sandbox),model,modelGenerateConfig,modelBaseUrl,const DeepCollectionEquality().hash(modelArgs),const DeepCollectionEquality().hash(modelRoles),config,revision,const DeepCollectionEquality().hash(packages),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(scorers),const DeepCollectionEquality().hash(metrics)]);

@override
String toString() {
  return 'EvalSpec(evalSetId: $evalSetId, evalId: $evalId, runId: $runId, created: $created, task: $task, taskId: $taskId, taskVersion: $taskVersion, taskFile: $taskFile, taskDisplayName: $taskDisplayName, taskRegistryName: $taskRegistryName, taskAttribs: $taskAttribs, taskArgs: $taskArgs, taskArgsPassed: $taskArgsPassed, solver: $solver, solverArgs: $solverArgs, solverArgsPassed: $solverArgsPassed, tags: $tags, dataset: $dataset, sandbox: $sandbox, model: $model, modelGenerateConfig: $modelGenerateConfig, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, config: $config, revision: $revision, packages: $packages, metadata: $metadata, scorers: $scorers, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $EvalSpecCopyWith<$Res>  {
  factory $EvalSpecCopyWith(EvalSpec value, $Res Function(EvalSpec) _then) = _$EvalSpecCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'eval_set_id') String? evalSetId,@JsonKey(name: 'eval_id') String evalId,@JsonKey(name: 'run_id') String runId, String created, String task,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'task_version', defaultValue: 0) Object taskVersion,@JsonKey(name: 'task_file') String? taskFile,@JsonKey(name: 'task_display_name') String? taskDisplayName,@JsonKey(name: 'task_registry_name') String? taskRegistryName,@JsonKey(name: 'task_attribs', defaultValue: {}) Map<String, dynamic> taskAttribs,@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> taskArgs,@JsonKey(name: 'task_args_passed', defaultValue: {}) Map<String, dynamic> taskArgsPassed, String? solver,@JsonKey(name: 'solver_args', defaultValue: {}) Map<String, dynamic> solverArgs,@JsonKey(name: 'solver_args_passed', defaultValue: {}) Map<String, dynamic> solverArgsPassed, List<String> tags, EvalDataset? dataset, Object? sandbox,@JsonKey(name: 'model') String model,@JsonKey(name: 'model_generate_config') GenerateConfig? modelGenerateConfig,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, EvalConfig config, EvalRevision? revision,@JsonKey(name: 'packages', defaultValue: {}) Map<String, String> packages,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata, List<Object> scorers, List<Object> metrics
});


$EvalDatasetCopyWith<$Res>? get dataset;$GenerateConfigCopyWith<$Res>? get modelGenerateConfig;$EvalConfigCopyWith<$Res> get config;$EvalRevisionCopyWith<$Res>? get revision;

}
/// @nodoc
class _$EvalSpecCopyWithImpl<$Res>
    implements $EvalSpecCopyWith<$Res> {
  _$EvalSpecCopyWithImpl(this._self, this._then);

  final EvalSpec _self;
  final $Res Function(EvalSpec) _then;

/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? evalSetId = freezed,Object? evalId = null,Object? runId = null,Object? created = null,Object? task = null,Object? taskId = null,Object? taskVersion = null,Object? taskFile = freezed,Object? taskDisplayName = freezed,Object? taskRegistryName = freezed,Object? taskAttribs = null,Object? taskArgs = null,Object? taskArgsPassed = null,Object? solver = freezed,Object? solverArgs = null,Object? solverArgsPassed = null,Object? tags = null,Object? dataset = freezed,Object? sandbox = freezed,Object? model = null,Object? modelGenerateConfig = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = null,Object? modelRoles = freezed,Object? config = null,Object? revision = freezed,Object? packages = null,Object? metadata = freezed,Object? scorers = null,Object? metrics = null,}) {
  return _then(_self.copyWith(
evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,evalId: null == evalId ? _self.evalId : evalId // ignore: cast_nullable_to_non_nullable
as String,runId: null == runId ? _self.runId : runId // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskVersion: null == taskVersion ? _self.taskVersion : taskVersion ,taskFile: freezed == taskFile ? _self.taskFile : taskFile // ignore: cast_nullable_to_non_nullable
as String?,taskDisplayName: freezed == taskDisplayName ? _self.taskDisplayName : taskDisplayName // ignore: cast_nullable_to_non_nullable
as String?,taskRegistryName: freezed == taskRegistryName ? _self.taskRegistryName : taskRegistryName // ignore: cast_nullable_to_non_nullable
as String?,taskAttribs: null == taskAttribs ? _self.taskAttribs : taskAttribs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,taskArgs: null == taskArgs ? _self.taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,taskArgsPassed: null == taskArgsPassed ? _self.taskArgsPassed : taskArgsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,solver: freezed == solver ? _self.solver : solver // ignore: cast_nullable_to_non_nullable
as String?,solverArgs: null == solverArgs ? _self.solverArgs : solverArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,solverArgsPassed: null == solverArgsPassed ? _self.solverArgsPassed : solverArgsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,dataset: freezed == dataset ? _self.dataset : dataset // ignore: cast_nullable_to_non_nullable
as EvalDataset?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,modelGenerateConfig: freezed == modelGenerateConfig ? _self.modelGenerateConfig : modelGenerateConfig // ignore: cast_nullable_to_non_nullable
as GenerateConfig?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: null == modelArgs ? _self.modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,modelRoles: freezed == modelRoles ? _self.modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as EvalConfig,revision: freezed == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as EvalRevision?,packages: null == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as Map<String, String>,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scorers: null == scorers ? _self.scorers : scorers // ignore: cast_nullable_to_non_nullable
as List<Object>,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}
/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalDatasetCopyWith<$Res>? get dataset {
    if (_self.dataset == null) {
    return null;
  }

  return $EvalDatasetCopyWith<$Res>(_self.dataset!, (value) {
    return _then(_self.copyWith(dataset: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenerateConfigCopyWith<$Res>? get modelGenerateConfig {
    if (_self.modelGenerateConfig == null) {
    return null;
  }

  return $GenerateConfigCopyWith<$Res>(_self.modelGenerateConfig!, (value) {
    return _then(_self.copyWith(modelGenerateConfig: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalConfigCopyWith<$Res> get config {
  
  return $EvalConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalRevisionCopyWith<$Res>? get revision {
    if (_self.revision == null) {
    return null;
  }

  return $EvalRevisionCopyWith<$Res>(_self.revision!, (value) {
    return _then(_self.copyWith(revision: value));
  });
}
}


/// Adds pattern-matching-related methods to [EvalSpec].
extension EvalSpecPatterns on EvalSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSpec value)  $default,){
final _that = this;
switch (_that) {
case _EvalSpec():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSpec value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_id')  String evalId, @JsonKey(name: 'run_id')  String runId,  String created,  String task, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_version', defaultValue: 0)  Object taskVersion, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_display_name')  String? taskDisplayName, @JsonKey(name: 'task_registry_name')  String? taskRegistryName, @JsonKey(name: 'task_attribs', defaultValue: {})  Map<String, dynamic> taskAttribs, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs, @JsonKey(name: 'task_args_passed', defaultValue: {})  Map<String, dynamic> taskArgsPassed,  String? solver, @JsonKey(name: 'solver_args', defaultValue: {})  Map<String, dynamic> solverArgs, @JsonKey(name: 'solver_args_passed', defaultValue: {})  Map<String, dynamic> solverArgsPassed,  List<String> tags,  EvalDataset? dataset,  Object? sandbox, @JsonKey(name: 'model')  String model, @JsonKey(name: 'model_generate_config')  GenerateConfig? modelGenerateConfig, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  EvalConfig config,  EvalRevision? revision, @JsonKey(name: 'packages', defaultValue: {})  Map<String, String> packages, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata,  List<Object> scorers,  List<Object> metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSpec() when $default != null:
return $default(_that.evalSetId,_that.evalId,_that.runId,_that.created,_that.task,_that.taskId,_that.taskVersion,_that.taskFile,_that.taskDisplayName,_that.taskRegistryName,_that.taskAttribs,_that.taskArgs,_that.taskArgsPassed,_that.solver,_that.solverArgs,_that.solverArgsPassed,_that.tags,_that.dataset,_that.sandbox,_that.model,_that.modelGenerateConfig,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.config,_that.revision,_that.packages,_that.metadata,_that.scorers,_that.metrics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_id')  String evalId, @JsonKey(name: 'run_id')  String runId,  String created,  String task, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_version', defaultValue: 0)  Object taskVersion, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_display_name')  String? taskDisplayName, @JsonKey(name: 'task_registry_name')  String? taskRegistryName, @JsonKey(name: 'task_attribs', defaultValue: {})  Map<String, dynamic> taskAttribs, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs, @JsonKey(name: 'task_args_passed', defaultValue: {})  Map<String, dynamic> taskArgsPassed,  String? solver, @JsonKey(name: 'solver_args', defaultValue: {})  Map<String, dynamic> solverArgs, @JsonKey(name: 'solver_args_passed', defaultValue: {})  Map<String, dynamic> solverArgsPassed,  List<String> tags,  EvalDataset? dataset,  Object? sandbox, @JsonKey(name: 'model')  String model, @JsonKey(name: 'model_generate_config')  GenerateConfig? modelGenerateConfig, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  EvalConfig config,  EvalRevision? revision, @JsonKey(name: 'packages', defaultValue: {})  Map<String, String> packages, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata,  List<Object> scorers,  List<Object> metrics)  $default,) {final _that = this;
switch (_that) {
case _EvalSpec():
return $default(_that.evalSetId,_that.evalId,_that.runId,_that.created,_that.task,_that.taskId,_that.taskVersion,_that.taskFile,_that.taskDisplayName,_that.taskRegistryName,_that.taskAttribs,_that.taskArgs,_that.taskArgsPassed,_that.solver,_that.solverArgs,_that.solverArgsPassed,_that.tags,_that.dataset,_that.sandbox,_that.model,_that.modelGenerateConfig,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.config,_that.revision,_that.packages,_that.metadata,_that.scorers,_that.metrics);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'eval_set_id')  String? evalSetId, @JsonKey(name: 'eval_id')  String evalId, @JsonKey(name: 'run_id')  String runId,  String created,  String task, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_version', defaultValue: 0)  Object taskVersion, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_display_name')  String? taskDisplayName, @JsonKey(name: 'task_registry_name')  String? taskRegistryName, @JsonKey(name: 'task_attribs', defaultValue: {})  Map<String, dynamic> taskAttribs, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs, @JsonKey(name: 'task_args_passed', defaultValue: {})  Map<String, dynamic> taskArgsPassed,  String? solver, @JsonKey(name: 'solver_args', defaultValue: {})  Map<String, dynamic> solverArgs, @JsonKey(name: 'solver_args_passed', defaultValue: {})  Map<String, dynamic> solverArgsPassed,  List<String> tags,  EvalDataset? dataset,  Object? sandbox, @JsonKey(name: 'model')  String model, @JsonKey(name: 'model_generate_config')  GenerateConfig? modelGenerateConfig, @JsonKey(name: 'model_base_url')  String? modelBaseUrl, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  EvalConfig config,  EvalRevision? revision, @JsonKey(name: 'packages', defaultValue: {})  Map<String, String> packages, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata,  List<Object> scorers,  List<Object> metrics)?  $default,) {final _that = this;
switch (_that) {
case _EvalSpec() when $default != null:
return $default(_that.evalSetId,_that.evalId,_that.runId,_that.created,_that.task,_that.taskId,_that.taskVersion,_that.taskFile,_that.taskDisplayName,_that.taskRegistryName,_that.taskAttribs,_that.taskArgs,_that.taskArgsPassed,_that.solver,_that.solverArgs,_that.solverArgsPassed,_that.tags,_that.dataset,_that.sandbox,_that.model,_that.modelGenerateConfig,_that.modelBaseUrl,_that.modelArgs,_that.modelRoles,_that.config,_that.revision,_that.packages,_that.metadata,_that.scorers,_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSpec extends EvalSpec {
  const _EvalSpec({@JsonKey(name: 'eval_set_id') this.evalSetId, @JsonKey(name: 'eval_id') required this.evalId, @JsonKey(name: 'run_id') required this.runId, required this.created, required this.task, @JsonKey(name: 'task_id') required this.taskId, @JsonKey(name: 'task_version', defaultValue: 0) this.taskVersion = 0, @JsonKey(name: 'task_file') this.taskFile, @JsonKey(name: 'task_display_name') this.taskDisplayName, @JsonKey(name: 'task_registry_name') this.taskRegistryName, @JsonKey(name: 'task_attribs', defaultValue: {}) final  Map<String, dynamic> taskAttribs = const {}, @JsonKey(name: 'task_args', defaultValue: {}) final  Map<String, dynamic> taskArgs = const {}, @JsonKey(name: 'task_args_passed', defaultValue: {}) final  Map<String, dynamic> taskArgsPassed = const {}, this.solver, @JsonKey(name: 'solver_args', defaultValue: {}) final  Map<String, dynamic> solverArgs = const {}, @JsonKey(name: 'solver_args_passed', defaultValue: {}) final  Map<String, dynamic> solverArgsPassed = const {}, final  List<String> tags = const [], this.dataset, this.sandbox, @JsonKey(name: 'model') required this.model, @JsonKey(name: 'model_generate_config') this.modelGenerateConfig, @JsonKey(name: 'model_base_url') this.modelBaseUrl, @JsonKey(name: 'model_args', defaultValue: {}) final  Map<String, dynamic> modelArgs = const {}, @JsonKey(name: 'model_roles') final  Map<String, String>? modelRoles, this.config = const EvalConfig(), this.revision, @JsonKey(name: 'packages', defaultValue: {}) final  Map<String, String> packages = const {}, @JsonKey(name: 'metadata') final  Map<String, dynamic>? metadata, final  List<Object> scorers = const [], final  List<Object> metrics = const []}): _taskAttribs = taskAttribs,_taskArgs = taskArgs,_taskArgsPassed = taskArgsPassed,_solverArgs = solverArgs,_solverArgsPassed = solverArgsPassed,_tags = tags,_modelArgs = modelArgs,_modelRoles = modelRoles,_packages = packages,_metadata = metadata,_scorers = scorers,_metrics = metrics,super._();
  factory _EvalSpec.fromJson(Map<String, dynamic> json) => _$EvalSpecFromJson(json);

/// Globally unique id for eval set (if any).
@override@JsonKey(name: 'eval_set_id') final  String? evalSetId;
/// Globally unique id for eval.
@override@JsonKey(name: 'eval_id') final  String evalId;
/// Unique run id.
@override@JsonKey(name: 'run_id') final  String runId;
/// Time created.
@override final  String created;
/// Task name.
@override final  String task;
/// Unique task id.
@override@JsonKey(name: 'task_id') final  String taskId;
/// Task version.
@override@JsonKey(name: 'task_version', defaultValue: 0) final  Object taskVersion;
/// Task source file.
@override@JsonKey(name: 'task_file') final  String? taskFile;
/// Task display name.
@override@JsonKey(name: 'task_display_name') final  String? taskDisplayName;
/// Task registry name.
@override@JsonKey(name: 'task_registry_name') final  String? taskRegistryName;
/// Attributes of the @task decorator.
 final  Map<String, dynamic> _taskAttribs;
/// Attributes of the @task decorator.
@override@JsonKey(name: 'task_attribs', defaultValue: {}) Map<String, dynamic> get taskAttribs {
  if (_taskAttribs is EqualUnmodifiableMapView) return _taskAttribs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskAttribs);
}

/// Arguments used for invoking the task (including defaults).
 final  Map<String, dynamic> _taskArgs;
/// Arguments used for invoking the task (including defaults).
@override@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> get taskArgs {
  if (_taskArgs is EqualUnmodifiableMapView) return _taskArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskArgs);
}

/// Arguments explicitly passed by caller for invoking the task.
 final  Map<String, dynamic> _taskArgsPassed;
/// Arguments explicitly passed by caller for invoking the task.
@override@JsonKey(name: 'task_args_passed', defaultValue: {}) Map<String, dynamic> get taskArgsPassed {
  if (_taskArgsPassed is EqualUnmodifiableMapView) return _taskArgsPassed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskArgsPassed);
}

/// Solver name.
@override final  String? solver;
/// Arguments used for invoking the solver.
 final  Map<String, dynamic> _solverArgs;
/// Arguments used for invoking the solver.
@override@JsonKey(name: 'solver_args', defaultValue: {}) Map<String, dynamic> get solverArgs {
  if (_solverArgs is EqualUnmodifiableMapView) return _solverArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_solverArgs);
}

/// Arguments explicitly passed by caller for invoking the solver.
 final  Map<String, dynamic> _solverArgsPassed;
/// Arguments explicitly passed by caller for invoking the solver.
@override@JsonKey(name: 'solver_args_passed', defaultValue: {}) Map<String, dynamic> get solverArgsPassed {
  if (_solverArgsPassed is EqualUnmodifiableMapView) return _solverArgsPassed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_solverArgsPassed);
}

/// Tags associated with evaluation run.
 final  List<String> _tags;
/// Tags associated with evaluation run.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Dataset used for eval.
@override final  EvalDataset? dataset;
/// Sandbox environment type and optional config file.
@override final  Object? sandbox;
/// Model used for eval.
@override@JsonKey(name: 'model') final  String model;
/// Generate config specified for model instance.
@override@JsonKey(name: 'model_generate_config') final  GenerateConfig? modelGenerateConfig;
/// Optional override of model base url.
@override@JsonKey(name: 'model_base_url') final  String? modelBaseUrl;
/// Model specific arguments.
 final  Map<String, dynamic> _modelArgs;
/// Model specific arguments.
@override@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> get modelArgs {
  if (_modelArgs is EqualUnmodifiableMapView) return _modelArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modelArgs);
}

/// Model roles.
 final  Map<String, String>? _modelRoles;
/// Model roles.
@override@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles {
  final value = _modelRoles;
  if (value == null) return null;
  if (_modelRoles is EqualUnmodifiableMapView) return _modelRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Configuration values for eval.
@override@JsonKey() final  EvalConfig config;
/// Source revision of eval.
@override final  EvalRevision? revision;
/// Package versions for eval.
 final  Map<String, String> _packages;
/// Package versions for eval.
@override@JsonKey(name: 'packages', defaultValue: {}) Map<String, String> get packages {
  if (_packages is EqualUnmodifiableMapView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_packages);
}

/// Additional eval metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional eval metadata.
@override@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Scorers and args for this eval.
 final  List<Object> _scorers;
/// Scorers and args for this eval.
@override@JsonKey() List<Object> get scorers {
  if (_scorers is EqualUnmodifiableListView) return _scorers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scorers);
}

/// Metrics and args for this eval.
 final  List<Object> _metrics;
/// Metrics and args for this eval.
@override@JsonKey() List<Object> get metrics {
  if (_metrics is EqualUnmodifiableListView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metrics);
}


/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSpecCopyWith<_EvalSpec> get copyWith => __$EvalSpecCopyWithImpl<_EvalSpec>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSpecToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSpec&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&(identical(other.evalId, evalId) || other.evalId == evalId)&&(identical(other.runId, runId) || other.runId == runId)&&(identical(other.created, created) || other.created == created)&&(identical(other.task, task) || other.task == task)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&const DeepCollectionEquality().equals(other.taskVersion, taskVersion)&&(identical(other.taskFile, taskFile) || other.taskFile == taskFile)&&(identical(other.taskDisplayName, taskDisplayName) || other.taskDisplayName == taskDisplayName)&&(identical(other.taskRegistryName, taskRegistryName) || other.taskRegistryName == taskRegistryName)&&const DeepCollectionEquality().equals(other._taskAttribs, _taskAttribs)&&const DeepCollectionEquality().equals(other._taskArgs, _taskArgs)&&const DeepCollectionEquality().equals(other._taskArgsPassed, _taskArgsPassed)&&(identical(other.solver, solver) || other.solver == solver)&&const DeepCollectionEquality().equals(other._solverArgs, _solverArgs)&&const DeepCollectionEquality().equals(other._solverArgsPassed, _solverArgsPassed)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.dataset, dataset) || other.dataset == dataset)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&(identical(other.model, model) || other.model == model)&&(identical(other.modelGenerateConfig, modelGenerateConfig) || other.modelGenerateConfig == modelGenerateConfig)&&(identical(other.modelBaseUrl, modelBaseUrl) || other.modelBaseUrl == modelBaseUrl)&&const DeepCollectionEquality().equals(other._modelArgs, _modelArgs)&&const DeepCollectionEquality().equals(other._modelRoles, _modelRoles)&&(identical(other.config, config) || other.config == config)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other._packages, _packages)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._scorers, _scorers)&&const DeepCollectionEquality().equals(other._metrics, _metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,evalSetId,evalId,runId,created,task,taskId,const DeepCollectionEquality().hash(taskVersion),taskFile,taskDisplayName,taskRegistryName,const DeepCollectionEquality().hash(_taskAttribs),const DeepCollectionEquality().hash(_taskArgs),const DeepCollectionEquality().hash(_taskArgsPassed),solver,const DeepCollectionEquality().hash(_solverArgs),const DeepCollectionEquality().hash(_solverArgsPassed),const DeepCollectionEquality().hash(_tags),dataset,const DeepCollectionEquality().hash(sandbox),model,modelGenerateConfig,modelBaseUrl,const DeepCollectionEquality().hash(_modelArgs),const DeepCollectionEquality().hash(_modelRoles),config,revision,const DeepCollectionEquality().hash(_packages),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_scorers),const DeepCollectionEquality().hash(_metrics)]);

@override
String toString() {
  return 'EvalSpec(evalSetId: $evalSetId, evalId: $evalId, runId: $runId, created: $created, task: $task, taskId: $taskId, taskVersion: $taskVersion, taskFile: $taskFile, taskDisplayName: $taskDisplayName, taskRegistryName: $taskRegistryName, taskAttribs: $taskAttribs, taskArgs: $taskArgs, taskArgsPassed: $taskArgsPassed, solver: $solver, solverArgs: $solverArgs, solverArgsPassed: $solverArgsPassed, tags: $tags, dataset: $dataset, sandbox: $sandbox, model: $model, modelGenerateConfig: $modelGenerateConfig, modelBaseUrl: $modelBaseUrl, modelArgs: $modelArgs, modelRoles: $modelRoles, config: $config, revision: $revision, packages: $packages, metadata: $metadata, scorers: $scorers, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$EvalSpecCopyWith<$Res> implements $EvalSpecCopyWith<$Res> {
  factory _$EvalSpecCopyWith(_EvalSpec value, $Res Function(_EvalSpec) _then) = __$EvalSpecCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'eval_set_id') String? evalSetId,@JsonKey(name: 'eval_id') String evalId,@JsonKey(name: 'run_id') String runId, String created, String task,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'task_version', defaultValue: 0) Object taskVersion,@JsonKey(name: 'task_file') String? taskFile,@JsonKey(name: 'task_display_name') String? taskDisplayName,@JsonKey(name: 'task_registry_name') String? taskRegistryName,@JsonKey(name: 'task_attribs', defaultValue: {}) Map<String, dynamic> taskAttribs,@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> taskArgs,@JsonKey(name: 'task_args_passed', defaultValue: {}) Map<String, dynamic> taskArgsPassed, String? solver,@JsonKey(name: 'solver_args', defaultValue: {}) Map<String, dynamic> solverArgs,@JsonKey(name: 'solver_args_passed', defaultValue: {}) Map<String, dynamic> solverArgsPassed, List<String> tags, EvalDataset? dataset, Object? sandbox,@JsonKey(name: 'model') String model,@JsonKey(name: 'model_generate_config') GenerateConfig? modelGenerateConfig,@JsonKey(name: 'model_base_url') String? modelBaseUrl,@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, EvalConfig config, EvalRevision? revision,@JsonKey(name: 'packages', defaultValue: {}) Map<String, String> packages,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata, List<Object> scorers, List<Object> metrics
});


@override $EvalDatasetCopyWith<$Res>? get dataset;@override $GenerateConfigCopyWith<$Res>? get modelGenerateConfig;@override $EvalConfigCopyWith<$Res> get config;@override $EvalRevisionCopyWith<$Res>? get revision;

}
/// @nodoc
class __$EvalSpecCopyWithImpl<$Res>
    implements _$EvalSpecCopyWith<$Res> {
  __$EvalSpecCopyWithImpl(this._self, this._then);

  final _EvalSpec _self;
  final $Res Function(_EvalSpec) _then;

/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? evalSetId = freezed,Object? evalId = null,Object? runId = null,Object? created = null,Object? task = null,Object? taskId = null,Object? taskVersion = null,Object? taskFile = freezed,Object? taskDisplayName = freezed,Object? taskRegistryName = freezed,Object? taskAttribs = null,Object? taskArgs = null,Object? taskArgsPassed = null,Object? solver = freezed,Object? solverArgs = null,Object? solverArgsPassed = null,Object? tags = null,Object? dataset = freezed,Object? sandbox = freezed,Object? model = null,Object? modelGenerateConfig = freezed,Object? modelBaseUrl = freezed,Object? modelArgs = null,Object? modelRoles = freezed,Object? config = null,Object? revision = freezed,Object? packages = null,Object? metadata = freezed,Object? scorers = null,Object? metrics = null,}) {
  return _then(_EvalSpec(
evalSetId: freezed == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String?,evalId: null == evalId ? _self.evalId : evalId // ignore: cast_nullable_to_non_nullable
as String,runId: null == runId ? _self.runId : runId // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as String,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskVersion: null == taskVersion ? _self.taskVersion : taskVersion ,taskFile: freezed == taskFile ? _self.taskFile : taskFile // ignore: cast_nullable_to_non_nullable
as String?,taskDisplayName: freezed == taskDisplayName ? _self.taskDisplayName : taskDisplayName // ignore: cast_nullable_to_non_nullable
as String?,taskRegistryName: freezed == taskRegistryName ? _self.taskRegistryName : taskRegistryName // ignore: cast_nullable_to_non_nullable
as String?,taskAttribs: null == taskAttribs ? _self._taskAttribs : taskAttribs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,taskArgs: null == taskArgs ? _self._taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,taskArgsPassed: null == taskArgsPassed ? _self._taskArgsPassed : taskArgsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,solver: freezed == solver ? _self.solver : solver // ignore: cast_nullable_to_non_nullable
as String?,solverArgs: null == solverArgs ? _self._solverArgs : solverArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,solverArgsPassed: null == solverArgsPassed ? _self._solverArgsPassed : solverArgsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,dataset: freezed == dataset ? _self.dataset : dataset // ignore: cast_nullable_to_non_nullable
as EvalDataset?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,modelGenerateConfig: freezed == modelGenerateConfig ? _self.modelGenerateConfig : modelGenerateConfig // ignore: cast_nullable_to_non_nullable
as GenerateConfig?,modelBaseUrl: freezed == modelBaseUrl ? _self.modelBaseUrl : modelBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,modelArgs: null == modelArgs ? _self._modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,modelRoles: freezed == modelRoles ? _self._modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as EvalConfig,revision: freezed == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as EvalRevision?,packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as Map<String, String>,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scorers: null == scorers ? _self._scorers : scorers // ignore: cast_nullable_to_non_nullable
as List<Object>,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}

/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalDatasetCopyWith<$Res>? get dataset {
    if (_self.dataset == null) {
    return null;
  }

  return $EvalDatasetCopyWith<$Res>(_self.dataset!, (value) {
    return _then(_self.copyWith(dataset: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenerateConfigCopyWith<$Res>? get modelGenerateConfig {
    if (_self.modelGenerateConfig == null) {
    return null;
  }

  return $GenerateConfigCopyWith<$Res>(_self.modelGenerateConfig!, (value) {
    return _then(_self.copyWith(modelGenerateConfig: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalConfigCopyWith<$Res> get config {
  
  return $EvalConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of EvalSpec
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalRevisionCopyWith<$Res>? get revision {
    if (_self.revision == null) {
    return null;
  }

  return $EvalRevisionCopyWith<$Res>(_self.revision!, (value) {
    return _then(_self.copyWith(revision: value));
  });
}
}


/// @nodoc
mixin _$EvalDataset {

/// Dataset name.
 String? get name;/// Dataset location (file path or remote URL).
 String? get location;/// Number of samples in the dataset.
 int get samples;/// IDs of samples in the dataset.
@JsonKey(name: 'sample_ids') List<Object>? get sampleIds;/// Was the dataset shuffled after reading.
 bool get shuffled;
/// Create a copy of EvalDataset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalDatasetCopyWith<EvalDataset> get copyWith => _$EvalDatasetCopyWithImpl<EvalDataset>(this as EvalDataset, _$identity);

  /// Serializes this EvalDataset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalDataset&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.samples, samples) || other.samples == samples)&&const DeepCollectionEquality().equals(other.sampleIds, sampleIds)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,location,samples,const DeepCollectionEquality().hash(sampleIds),shuffled);

@override
String toString() {
  return 'EvalDataset(name: $name, location: $location, samples: $samples, sampleIds: $sampleIds, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class $EvalDatasetCopyWith<$Res>  {
  factory $EvalDatasetCopyWith(EvalDataset value, $Res Function(EvalDataset) _then) = _$EvalDatasetCopyWithImpl;
@useResult
$Res call({
 String? name, String? location, int samples,@JsonKey(name: 'sample_ids') List<Object>? sampleIds, bool shuffled
});




}
/// @nodoc
class _$EvalDatasetCopyWithImpl<$Res>
    implements $EvalDatasetCopyWith<$Res> {
  _$EvalDatasetCopyWithImpl(this._self, this._then);

  final EvalDataset _self;
  final $Res Function(EvalDataset) _then;

/// Create a copy of EvalDataset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? location = freezed,Object? samples = null,Object? sampleIds = freezed,Object? shuffled = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as int,sampleIds: freezed == sampleIds ? _self.sampleIds : sampleIds // ignore: cast_nullable_to_non_nullable
as List<Object>?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalDataset].
extension EvalDatasetPatterns on EvalDataset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalDataset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalDataset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalDataset value)  $default,){
final _that = this;
switch (_that) {
case _EvalDataset():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalDataset value)?  $default,){
final _that = this;
switch (_that) {
case _EvalDataset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? location,  int samples, @JsonKey(name: 'sample_ids')  List<Object>? sampleIds,  bool shuffled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalDataset() when $default != null:
return $default(_that.name,_that.location,_that.samples,_that.sampleIds,_that.shuffled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? location,  int samples, @JsonKey(name: 'sample_ids')  List<Object>? sampleIds,  bool shuffled)  $default,) {final _that = this;
switch (_that) {
case _EvalDataset():
return $default(_that.name,_that.location,_that.samples,_that.sampleIds,_that.shuffled);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? location,  int samples, @JsonKey(name: 'sample_ids')  List<Object>? sampleIds,  bool shuffled)?  $default,) {final _that = this;
switch (_that) {
case _EvalDataset() when $default != null:
return $default(_that.name,_that.location,_that.samples,_that.sampleIds,_that.shuffled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalDataset extends EvalDataset {
  const _EvalDataset({this.name, this.location, required this.samples, @JsonKey(name: 'sample_ids') final  List<Object>? sampleIds, this.shuffled = false}): _sampleIds = sampleIds,super._();
  factory _EvalDataset.fromJson(Map<String, dynamic> json) => _$EvalDatasetFromJson(json);

/// Dataset name.
@override final  String? name;
/// Dataset location (file path or remote URL).
@override final  String? location;
/// Number of samples in the dataset.
@override final  int samples;
/// IDs of samples in the dataset.
 final  List<Object>? _sampleIds;
/// IDs of samples in the dataset.
@override@JsonKey(name: 'sample_ids') List<Object>? get sampleIds {
  final value = _sampleIds;
  if (value == null) return null;
  if (_sampleIds is EqualUnmodifiableListView) return _sampleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Was the dataset shuffled after reading.
@override@JsonKey() final  bool shuffled;

/// Create a copy of EvalDataset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalDatasetCopyWith<_EvalDataset> get copyWith => __$EvalDatasetCopyWithImpl<_EvalDataset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalDatasetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalDataset&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.samples, samples) || other.samples == samples)&&const DeepCollectionEquality().equals(other._sampleIds, _sampleIds)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,location,samples,const DeepCollectionEquality().hash(_sampleIds),shuffled);

@override
String toString() {
  return 'EvalDataset(name: $name, location: $location, samples: $samples, sampleIds: $sampleIds, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class _$EvalDatasetCopyWith<$Res> implements $EvalDatasetCopyWith<$Res> {
  factory _$EvalDatasetCopyWith(_EvalDataset value, $Res Function(_EvalDataset) _then) = __$EvalDatasetCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? location, int samples,@JsonKey(name: 'sample_ids') List<Object>? sampleIds, bool shuffled
});




}
/// @nodoc
class __$EvalDatasetCopyWithImpl<$Res>
    implements _$EvalDatasetCopyWith<$Res> {
  __$EvalDatasetCopyWithImpl(this._self, this._then);

  final _EvalDataset _self;
  final $Res Function(_EvalDataset) _then;

/// Create a copy of EvalDataset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? location = freezed,Object? samples = null,Object? sampleIds = freezed,Object? shuffled = null,}) {
  return _then(_EvalDataset(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as int,sampleIds: freezed == sampleIds ? _self._sampleIds : sampleIds // ignore: cast_nullable_to_non_nullable
as List<Object>?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EvalConfig {

/// Sample limit (number of samples or range of samples).
 Object? get limit;/// Evaluate specific sample(s).
@JsonKey(name: 'sample_id') Object? get sampleId;/// Shuffle order of samples.
@JsonKey(name: 'sample_shuffle') bool? get sampleShuffle;/// Number of epochs to run samples over.
 int? get epochs;/// Reducers for aggregating per-sample scores.
@JsonKey(name: 'epochs_reducer') List<String>? get epochsReducer;/// Approval policy for tool use.
 String? get approval;/// Fail eval when sample errors occur.
/// True to fail on first sample error (default); False to never fail on sample errors;
/// Value between 0 and 1 to fail if a proportion of total samples fails.
/// Value greater than 1 to fail eval if a count of samples fails.
@JsonKey(name: 'fail_on_error') Object? get failOnError;/// Continue eval even if the fail_on_error condition is met.
@JsonKey(name: 'continue_on_fail') bool? get continueOnFail;/// Number of times to retry samples if they encounter errors.
@JsonKey(name: 'retry_on_error') int? get retryOnError;/// Maximum messages to allow per sample.
@JsonKey(name: 'message_limit') int? get messageLimit;/// Maximum tokens usage per sample.
@JsonKey(name: 'token_limit') int? get tokenLimit;/// Maximum clock time per sample.
@JsonKey(name: 'time_limit') int? get timeLimit;/// Maximum working time per sample.
@JsonKey(name: 'working_limit') int? get workingLimit;/// Maximum number of samples to run in parallel.
@JsonKey(name: 'max_samples') int? get maxSamples;/// Maximum number of tasks to run in parallel.
@JsonKey(name: 'max_tasks') int? get maxTasks;/// Maximum number of subprocesses to run concurrently.
@JsonKey(name: 'max_subprocesses') int? get maxSubprocesses;/// Maximum number of sandboxes to run concurrently.
@JsonKey(name: 'max_sandboxes') int? get maxSandboxes;/// Cleanup sandbox environments after task completes.
@JsonKey(name: 'sandbox_cleanup') bool? get sandboxCleanup;/// Log detailed information on each sample.
@JsonKey(name: 'log_samples') bool? get logSamples;/// Log events in realtime (enables live viewing of samples in inspect view).
@JsonKey(name: 'log_realtime') bool? get logRealtime;/// Log base64 encoded versions of images.
@JsonKey(name: 'log_images') bool? get logImages;/// Number of samples to buffer before writing log file.
@JsonKey(name: 'log_buffer') int? get logBuffer;/// Interval (in seconds) for syncing sample events to log directory.
@JsonKey(name: 'log_shared') int? get logShared;/// Display scoring metrics realtime.
@JsonKey(name: 'score_display') bool? get scoreDisplay;
/// Create a copy of EvalConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalConfigCopyWith<EvalConfig> get copyWith => _$EvalConfigCopyWithImpl<EvalConfig>(this as EvalConfig, _$identity);

  /// Serializes this EvalConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalConfig&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&(identical(other.sampleShuffle, sampleShuffle) || other.sampleShuffle == sampleShuffle)&&(identical(other.epochs, epochs) || other.epochs == epochs)&&const DeepCollectionEquality().equals(other.epochsReducer, epochsReducer)&&(identical(other.approval, approval) || other.approval == approval)&&const DeepCollectionEquality().equals(other.failOnError, failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.scoreDisplay, scoreDisplay) || other.scoreDisplay == scoreDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),sampleShuffle,epochs,const DeepCollectionEquality().hash(epochsReducer),approval,const DeepCollectionEquality().hash(failOnError),continueOnFail,retryOnError,messageLimit,tokenLimit,timeLimit,workingLimit,maxSamples,maxTasks,maxSubprocesses,maxSandboxes,sandboxCleanup,logSamples,logRealtime,logImages,logBuffer,logShared,scoreDisplay]);

@override
String toString() {
  return 'EvalConfig(limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, epochsReducer: $epochsReducer, approval: $approval, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, sandboxCleanup: $sandboxCleanup, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, scoreDisplay: $scoreDisplay)';
}


}

/// @nodoc
abstract mixin class $EvalConfigCopyWith<$Res>  {
  factory $EvalConfigCopyWith(EvalConfig value, $Res Function(EvalConfig) _then) = _$EvalConfigCopyWithImpl;
@useResult
$Res call({
 Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') bool? sampleShuffle, int? epochs,@JsonKey(name: 'epochs_reducer') List<String>? epochsReducer, String? approval,@JsonKey(name: 'fail_on_error') Object? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'score_display') bool? scoreDisplay
});




}
/// @nodoc
class _$EvalConfigCopyWithImpl<$Res>
    implements $EvalConfigCopyWith<$Res> {
  _$EvalConfigCopyWithImpl(this._self, this._then);

  final EvalConfig _self;
  final $Res Function(EvalConfig) _then;

/// Create a copy of EvalConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? epochsReducer = freezed,Object? approval = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? sandboxCleanup = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? scoreDisplay = freezed,}) {
  return _then(_self.copyWith(
limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle // ignore: cast_nullable_to_non_nullable
as bool?,epochs: freezed == epochs ? _self.epochs : epochs // ignore: cast_nullable_to_non_nullable
as int?,epochsReducer: freezed == epochsReducer ? _self.epochsReducer : epochsReducer // ignore: cast_nullable_to_non_nullable
as List<String>?,approval: freezed == approval ? _self.approval : approval // ignore: cast_nullable_to_non_nullable
as String?,failOnError: freezed == failOnError ? _self.failOnError : failOnError ,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,scoreDisplay: freezed == scoreDisplay ? _self.scoreDisplay : scoreDisplay // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalConfig].
extension EvalConfigPatterns on EvalConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalConfig value)  $default,){
final _that = this;
switch (_that) {
case _EvalConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalConfig value)?  $default,){
final _that = this;
switch (_that) {
case _EvalConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  bool? sampleShuffle,  int? epochs, @JsonKey(name: 'epochs_reducer')  List<String>? epochsReducer,  String? approval, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'score_display')  bool? scoreDisplay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalConfig() when $default != null:
return $default(_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.epochsReducer,_that.approval,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.sandboxCleanup,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.scoreDisplay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  bool? sampleShuffle,  int? epochs, @JsonKey(name: 'epochs_reducer')  List<String>? epochsReducer,  String? approval, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'score_display')  bool? scoreDisplay)  $default,) {final _that = this;
switch (_that) {
case _EvalConfig():
return $default(_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.epochsReducer,_that.approval,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.sandboxCleanup,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.scoreDisplay);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object? limit, @JsonKey(name: 'sample_id')  Object? sampleId, @JsonKey(name: 'sample_shuffle')  bool? sampleShuffle,  int? epochs, @JsonKey(name: 'epochs_reducer')  List<String>? epochsReducer,  String? approval, @JsonKey(name: 'fail_on_error')  Object? failOnError, @JsonKey(name: 'continue_on_fail')  bool? continueOnFail, @JsonKey(name: 'retry_on_error')  int? retryOnError, @JsonKey(name: 'message_limit')  int? messageLimit, @JsonKey(name: 'token_limit')  int? tokenLimit, @JsonKey(name: 'time_limit')  int? timeLimit, @JsonKey(name: 'working_limit')  int? workingLimit, @JsonKey(name: 'max_samples')  int? maxSamples, @JsonKey(name: 'max_tasks')  int? maxTasks, @JsonKey(name: 'max_subprocesses')  int? maxSubprocesses, @JsonKey(name: 'max_sandboxes')  int? maxSandboxes, @JsonKey(name: 'sandbox_cleanup')  bool? sandboxCleanup, @JsonKey(name: 'log_samples')  bool? logSamples, @JsonKey(name: 'log_realtime')  bool? logRealtime, @JsonKey(name: 'log_images')  bool? logImages, @JsonKey(name: 'log_buffer')  int? logBuffer, @JsonKey(name: 'log_shared')  int? logShared, @JsonKey(name: 'score_display')  bool? scoreDisplay)?  $default,) {final _that = this;
switch (_that) {
case _EvalConfig() when $default != null:
return $default(_that.limit,_that.sampleId,_that.sampleShuffle,_that.epochs,_that.epochsReducer,_that.approval,_that.failOnError,_that.continueOnFail,_that.retryOnError,_that.messageLimit,_that.tokenLimit,_that.timeLimit,_that.workingLimit,_that.maxSamples,_that.maxTasks,_that.maxSubprocesses,_that.maxSandboxes,_that.sandboxCleanup,_that.logSamples,_that.logRealtime,_that.logImages,_that.logBuffer,_that.logShared,_that.scoreDisplay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalConfig extends EvalConfig {
  const _EvalConfig({this.limit, @JsonKey(name: 'sample_id') this.sampleId, @JsonKey(name: 'sample_shuffle') this.sampleShuffle, this.epochs, @JsonKey(name: 'epochs_reducer') final  List<String>? epochsReducer, this.approval, @JsonKey(name: 'fail_on_error') this.failOnError, @JsonKey(name: 'continue_on_fail') this.continueOnFail, @JsonKey(name: 'retry_on_error') this.retryOnError, @JsonKey(name: 'message_limit') this.messageLimit, @JsonKey(name: 'token_limit') this.tokenLimit, @JsonKey(name: 'time_limit') this.timeLimit, @JsonKey(name: 'working_limit') this.workingLimit, @JsonKey(name: 'max_samples') this.maxSamples, @JsonKey(name: 'max_tasks') this.maxTasks, @JsonKey(name: 'max_subprocesses') this.maxSubprocesses, @JsonKey(name: 'max_sandboxes') this.maxSandboxes, @JsonKey(name: 'sandbox_cleanup') this.sandboxCleanup, @JsonKey(name: 'log_samples') this.logSamples, @JsonKey(name: 'log_realtime') this.logRealtime, @JsonKey(name: 'log_images') this.logImages, @JsonKey(name: 'log_buffer') this.logBuffer, @JsonKey(name: 'log_shared') this.logShared, @JsonKey(name: 'score_display') this.scoreDisplay}): _epochsReducer = epochsReducer,super._();
  factory _EvalConfig.fromJson(Map<String, dynamic> json) => _$EvalConfigFromJson(json);

/// Sample limit (number of samples or range of samples).
@override final  Object? limit;
/// Evaluate specific sample(s).
@override@JsonKey(name: 'sample_id') final  Object? sampleId;
/// Shuffle order of samples.
@override@JsonKey(name: 'sample_shuffle') final  bool? sampleShuffle;
/// Number of epochs to run samples over.
@override final  int? epochs;
/// Reducers for aggregating per-sample scores.
 final  List<String>? _epochsReducer;
/// Reducers for aggregating per-sample scores.
@override@JsonKey(name: 'epochs_reducer') List<String>? get epochsReducer {
  final value = _epochsReducer;
  if (value == null) return null;
  if (_epochsReducer is EqualUnmodifiableListView) return _epochsReducer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Approval policy for tool use.
@override final  String? approval;
/// Fail eval when sample errors occur.
/// True to fail on first sample error (default); False to never fail on sample errors;
/// Value between 0 and 1 to fail if a proportion of total samples fails.
/// Value greater than 1 to fail eval if a count of samples fails.
@override@JsonKey(name: 'fail_on_error') final  Object? failOnError;
/// Continue eval even if the fail_on_error condition is met.
@override@JsonKey(name: 'continue_on_fail') final  bool? continueOnFail;
/// Number of times to retry samples if they encounter errors.
@override@JsonKey(name: 'retry_on_error') final  int? retryOnError;
/// Maximum messages to allow per sample.
@override@JsonKey(name: 'message_limit') final  int? messageLimit;
/// Maximum tokens usage per sample.
@override@JsonKey(name: 'token_limit') final  int? tokenLimit;
/// Maximum clock time per sample.
@override@JsonKey(name: 'time_limit') final  int? timeLimit;
/// Maximum working time per sample.
@override@JsonKey(name: 'working_limit') final  int? workingLimit;
/// Maximum number of samples to run in parallel.
@override@JsonKey(name: 'max_samples') final  int? maxSamples;
/// Maximum number of tasks to run in parallel.
@override@JsonKey(name: 'max_tasks') final  int? maxTasks;
/// Maximum number of subprocesses to run concurrently.
@override@JsonKey(name: 'max_subprocesses') final  int? maxSubprocesses;
/// Maximum number of sandboxes to run concurrently.
@override@JsonKey(name: 'max_sandboxes') final  int? maxSandboxes;
/// Cleanup sandbox environments after task completes.
@override@JsonKey(name: 'sandbox_cleanup') final  bool? sandboxCleanup;
/// Log detailed information on each sample.
@override@JsonKey(name: 'log_samples') final  bool? logSamples;
/// Log events in realtime (enables live viewing of samples in inspect view).
@override@JsonKey(name: 'log_realtime') final  bool? logRealtime;
/// Log base64 encoded versions of images.
@override@JsonKey(name: 'log_images') final  bool? logImages;
/// Number of samples to buffer before writing log file.
@override@JsonKey(name: 'log_buffer') final  int? logBuffer;
/// Interval (in seconds) for syncing sample events to log directory.
@override@JsonKey(name: 'log_shared') final  int? logShared;
/// Display scoring metrics realtime.
@override@JsonKey(name: 'score_display') final  bool? scoreDisplay;

/// Create a copy of EvalConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalConfigCopyWith<_EvalConfig> get copyWith => __$EvalConfigCopyWithImpl<_EvalConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalConfig&&const DeepCollectionEquality().equals(other.limit, limit)&&const DeepCollectionEquality().equals(other.sampleId, sampleId)&&(identical(other.sampleShuffle, sampleShuffle) || other.sampleShuffle == sampleShuffle)&&(identical(other.epochs, epochs) || other.epochs == epochs)&&const DeepCollectionEquality().equals(other._epochsReducer, _epochsReducer)&&(identical(other.approval, approval) || other.approval == approval)&&const DeepCollectionEquality().equals(other.failOnError, failOnError)&&(identical(other.continueOnFail, continueOnFail) || other.continueOnFail == continueOnFail)&&(identical(other.retryOnError, retryOnError) || other.retryOnError == retryOnError)&&(identical(other.messageLimit, messageLimit) || other.messageLimit == messageLimit)&&(identical(other.tokenLimit, tokenLimit) || other.tokenLimit == tokenLimit)&&(identical(other.timeLimit, timeLimit) || other.timeLimit == timeLimit)&&(identical(other.workingLimit, workingLimit) || other.workingLimit == workingLimit)&&(identical(other.maxSamples, maxSamples) || other.maxSamples == maxSamples)&&(identical(other.maxTasks, maxTasks) || other.maxTasks == maxTasks)&&(identical(other.maxSubprocesses, maxSubprocesses) || other.maxSubprocesses == maxSubprocesses)&&(identical(other.maxSandboxes, maxSandboxes) || other.maxSandboxes == maxSandboxes)&&(identical(other.sandboxCleanup, sandboxCleanup) || other.sandboxCleanup == sandboxCleanup)&&(identical(other.logSamples, logSamples) || other.logSamples == logSamples)&&(identical(other.logRealtime, logRealtime) || other.logRealtime == logRealtime)&&(identical(other.logImages, logImages) || other.logImages == logImages)&&(identical(other.logBuffer, logBuffer) || other.logBuffer == logBuffer)&&(identical(other.logShared, logShared) || other.logShared == logShared)&&(identical(other.scoreDisplay, scoreDisplay) || other.scoreDisplay == scoreDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(limit),const DeepCollectionEquality().hash(sampleId),sampleShuffle,epochs,const DeepCollectionEquality().hash(_epochsReducer),approval,const DeepCollectionEquality().hash(failOnError),continueOnFail,retryOnError,messageLimit,tokenLimit,timeLimit,workingLimit,maxSamples,maxTasks,maxSubprocesses,maxSandboxes,sandboxCleanup,logSamples,logRealtime,logImages,logBuffer,logShared,scoreDisplay]);

@override
String toString() {
  return 'EvalConfig(limit: $limit, sampleId: $sampleId, sampleShuffle: $sampleShuffle, epochs: $epochs, epochsReducer: $epochsReducer, approval: $approval, failOnError: $failOnError, continueOnFail: $continueOnFail, retryOnError: $retryOnError, messageLimit: $messageLimit, tokenLimit: $tokenLimit, timeLimit: $timeLimit, workingLimit: $workingLimit, maxSamples: $maxSamples, maxTasks: $maxTasks, maxSubprocesses: $maxSubprocesses, maxSandboxes: $maxSandboxes, sandboxCleanup: $sandboxCleanup, logSamples: $logSamples, logRealtime: $logRealtime, logImages: $logImages, logBuffer: $logBuffer, logShared: $logShared, scoreDisplay: $scoreDisplay)';
}


}

/// @nodoc
abstract mixin class _$EvalConfigCopyWith<$Res> implements $EvalConfigCopyWith<$Res> {
  factory _$EvalConfigCopyWith(_EvalConfig value, $Res Function(_EvalConfig) _then) = __$EvalConfigCopyWithImpl;
@override @useResult
$Res call({
 Object? limit,@JsonKey(name: 'sample_id') Object? sampleId,@JsonKey(name: 'sample_shuffle') bool? sampleShuffle, int? epochs,@JsonKey(name: 'epochs_reducer') List<String>? epochsReducer, String? approval,@JsonKey(name: 'fail_on_error') Object? failOnError,@JsonKey(name: 'continue_on_fail') bool? continueOnFail,@JsonKey(name: 'retry_on_error') int? retryOnError,@JsonKey(name: 'message_limit') int? messageLimit,@JsonKey(name: 'token_limit') int? tokenLimit,@JsonKey(name: 'time_limit') int? timeLimit,@JsonKey(name: 'working_limit') int? workingLimit,@JsonKey(name: 'max_samples') int? maxSamples,@JsonKey(name: 'max_tasks') int? maxTasks,@JsonKey(name: 'max_subprocesses') int? maxSubprocesses,@JsonKey(name: 'max_sandboxes') int? maxSandboxes,@JsonKey(name: 'sandbox_cleanup') bool? sandboxCleanup,@JsonKey(name: 'log_samples') bool? logSamples,@JsonKey(name: 'log_realtime') bool? logRealtime,@JsonKey(name: 'log_images') bool? logImages,@JsonKey(name: 'log_buffer') int? logBuffer,@JsonKey(name: 'log_shared') int? logShared,@JsonKey(name: 'score_display') bool? scoreDisplay
});




}
/// @nodoc
class __$EvalConfigCopyWithImpl<$Res>
    implements _$EvalConfigCopyWith<$Res> {
  __$EvalConfigCopyWithImpl(this._self, this._then);

  final _EvalConfig _self;
  final $Res Function(_EvalConfig) _then;

/// Create a copy of EvalConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = freezed,Object? sampleId = freezed,Object? sampleShuffle = freezed,Object? epochs = freezed,Object? epochsReducer = freezed,Object? approval = freezed,Object? failOnError = freezed,Object? continueOnFail = freezed,Object? retryOnError = freezed,Object? messageLimit = freezed,Object? tokenLimit = freezed,Object? timeLimit = freezed,Object? workingLimit = freezed,Object? maxSamples = freezed,Object? maxTasks = freezed,Object? maxSubprocesses = freezed,Object? maxSandboxes = freezed,Object? sandboxCleanup = freezed,Object? logSamples = freezed,Object? logRealtime = freezed,Object? logImages = freezed,Object? logBuffer = freezed,Object? logShared = freezed,Object? scoreDisplay = freezed,}) {
  return _then(_EvalConfig(
limit: freezed == limit ? _self.limit : limit ,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,sampleShuffle: freezed == sampleShuffle ? _self.sampleShuffle : sampleShuffle // ignore: cast_nullable_to_non_nullable
as bool?,epochs: freezed == epochs ? _self.epochs : epochs // ignore: cast_nullable_to_non_nullable
as int?,epochsReducer: freezed == epochsReducer ? _self._epochsReducer : epochsReducer // ignore: cast_nullable_to_non_nullable
as List<String>?,approval: freezed == approval ? _self.approval : approval // ignore: cast_nullable_to_non_nullable
as String?,failOnError: freezed == failOnError ? _self.failOnError : failOnError ,continueOnFail: freezed == continueOnFail ? _self.continueOnFail : continueOnFail // ignore: cast_nullable_to_non_nullable
as bool?,retryOnError: freezed == retryOnError ? _self.retryOnError : retryOnError // ignore: cast_nullable_to_non_nullable
as int?,messageLimit: freezed == messageLimit ? _self.messageLimit : messageLimit // ignore: cast_nullable_to_non_nullable
as int?,tokenLimit: freezed == tokenLimit ? _self.tokenLimit : tokenLimit // ignore: cast_nullable_to_non_nullable
as int?,timeLimit: freezed == timeLimit ? _self.timeLimit : timeLimit // ignore: cast_nullable_to_non_nullable
as int?,workingLimit: freezed == workingLimit ? _self.workingLimit : workingLimit // ignore: cast_nullable_to_non_nullable
as int?,maxSamples: freezed == maxSamples ? _self.maxSamples : maxSamples // ignore: cast_nullable_to_non_nullable
as int?,maxTasks: freezed == maxTasks ? _self.maxTasks : maxTasks // ignore: cast_nullable_to_non_nullable
as int?,maxSubprocesses: freezed == maxSubprocesses ? _self.maxSubprocesses : maxSubprocesses // ignore: cast_nullable_to_non_nullable
as int?,maxSandboxes: freezed == maxSandboxes ? _self.maxSandboxes : maxSandboxes // ignore: cast_nullable_to_non_nullable
as int?,sandboxCleanup: freezed == sandboxCleanup ? _self.sandboxCleanup : sandboxCleanup // ignore: cast_nullable_to_non_nullable
as bool?,logSamples: freezed == logSamples ? _self.logSamples : logSamples // ignore: cast_nullable_to_non_nullable
as bool?,logRealtime: freezed == logRealtime ? _self.logRealtime : logRealtime // ignore: cast_nullable_to_non_nullable
as bool?,logImages: freezed == logImages ? _self.logImages : logImages // ignore: cast_nullable_to_non_nullable
as bool?,logBuffer: freezed == logBuffer ? _self.logBuffer : logBuffer // ignore: cast_nullable_to_non_nullable
as int?,logShared: freezed == logShared ? _self.logShared : logShared // ignore: cast_nullable_to_non_nullable
as int?,scoreDisplay: freezed == scoreDisplay ? _self.scoreDisplay : scoreDisplay // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$EvalRevision {

/// Type of revision (currently only “git”).
 String get type;/// Revision origin server.
 String get origin;/// Revision commit.
 String get commit;/// Working tree has uncommitted changes or untracked files.
 bool get dirty;
/// Create a copy of EvalRevision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalRevisionCopyWith<EvalRevision> get copyWith => _$EvalRevisionCopyWithImpl<EvalRevision>(this as EvalRevision, _$identity);

  /// Serializes this EvalRevision to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalRevision&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.commit, commit) || other.commit == commit)&&(identical(other.dirty, dirty) || other.dirty == dirty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,commit,dirty);

@override
String toString() {
  return 'EvalRevision(type: $type, origin: $origin, commit: $commit, dirty: $dirty)';
}


}

/// @nodoc
abstract mixin class $EvalRevisionCopyWith<$Res>  {
  factory $EvalRevisionCopyWith(EvalRevision value, $Res Function(EvalRevision) _then) = _$EvalRevisionCopyWithImpl;
@useResult
$Res call({
 String type, String origin, String commit, bool dirty
});




}
/// @nodoc
class _$EvalRevisionCopyWithImpl<$Res>
    implements $EvalRevisionCopyWith<$Res> {
  _$EvalRevisionCopyWithImpl(this._self, this._then);

  final EvalRevision _self;
  final $Res Function(EvalRevision) _then;

/// Create a copy of EvalRevision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? origin = null,Object? commit = null,Object? dirty = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,commit: null == commit ? _self.commit : commit // ignore: cast_nullable_to_non_nullable
as String,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalRevision].
extension EvalRevisionPatterns on EvalRevision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalRevision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalRevision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalRevision value)  $default,){
final _that = this;
switch (_that) {
case _EvalRevision():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalRevision value)?  $default,){
final _that = this;
switch (_that) {
case _EvalRevision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String origin,  String commit,  bool dirty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalRevision() when $default != null:
return $default(_that.type,_that.origin,_that.commit,_that.dirty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String origin,  String commit,  bool dirty)  $default,) {final _that = this;
switch (_that) {
case _EvalRevision():
return $default(_that.type,_that.origin,_that.commit,_that.dirty);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String origin,  String commit,  bool dirty)?  $default,) {final _that = this;
switch (_that) {
case _EvalRevision() when $default != null:
return $default(_that.type,_that.origin,_that.commit,_that.dirty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalRevision extends EvalRevision {
  const _EvalRevision({required this.type, required this.origin, required this.commit, this.dirty = false}): super._();
  factory _EvalRevision.fromJson(Map<String, dynamic> json) => _$EvalRevisionFromJson(json);

/// Type of revision (currently only “git”).
@override final  String type;
/// Revision origin server.
@override final  String origin;
/// Revision commit.
@override final  String commit;
/// Working tree has uncommitted changes or untracked files.
@override@JsonKey() final  bool dirty;

/// Create a copy of EvalRevision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalRevisionCopyWith<_EvalRevision> get copyWith => __$EvalRevisionCopyWithImpl<_EvalRevision>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalRevisionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalRevision&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.commit, commit) || other.commit == commit)&&(identical(other.dirty, dirty) || other.dirty == dirty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,commit,dirty);

@override
String toString() {
  return 'EvalRevision(type: $type, origin: $origin, commit: $commit, dirty: $dirty)';
}


}

/// @nodoc
abstract mixin class _$EvalRevisionCopyWith<$Res> implements $EvalRevisionCopyWith<$Res> {
  factory _$EvalRevisionCopyWith(_EvalRevision value, $Res Function(_EvalRevision) _then) = __$EvalRevisionCopyWithImpl;
@override @useResult
$Res call({
 String type, String origin, String commit, bool dirty
});




}
/// @nodoc
class __$EvalRevisionCopyWithImpl<$Res>
    implements _$EvalRevisionCopyWith<$Res> {
  __$EvalRevisionCopyWithImpl(this._self, this._then);

  final _EvalRevision _self;
  final $Res Function(_EvalRevision) _then;

/// Create a copy of EvalRevision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? origin = null,Object? commit = null,Object? dirty = null,}) {
  return _then(_EvalRevision(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,commit: null == commit ? _self.commit : commit // ignore: cast_nullable_to_non_nullable
as String,dirty: null == dirty ? _self.dirty : dirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EvalPlan {

/// Plan name.
 String get name;/// Steps in plan.
 List<EvalPlanStep> get steps;/// Step to always run at the end.
 EvalPlanStep? get finish;/// Generation config.
 GenerateConfig get config;
/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalPlanCopyWith<EvalPlan> get copyWith => _$EvalPlanCopyWithImpl<EvalPlan>(this as EvalPlan, _$identity);

  /// Serializes this EvalPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalPlan&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.finish, finish) || other.finish == finish)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(steps),finish,config);

@override
String toString() {
  return 'EvalPlan(name: $name, steps: $steps, finish: $finish, config: $config)';
}


}

/// @nodoc
abstract mixin class $EvalPlanCopyWith<$Res>  {
  factory $EvalPlanCopyWith(EvalPlan value, $Res Function(EvalPlan) _then) = _$EvalPlanCopyWithImpl;
@useResult
$Res call({
 String name, List<EvalPlanStep> steps, EvalPlanStep? finish, GenerateConfig config
});


$EvalPlanStepCopyWith<$Res>? get finish;$GenerateConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$EvalPlanCopyWithImpl<$Res>
    implements $EvalPlanCopyWith<$Res> {
  _$EvalPlanCopyWithImpl(this._self, this._then);

  final EvalPlan _self;
  final $Res Function(EvalPlan) _then;

/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? steps = null,Object? finish = freezed,Object? config = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<EvalPlanStep>,finish: freezed == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as EvalPlanStep?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as GenerateConfig,
  ));
}
/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalPlanStepCopyWith<$Res>? get finish {
    if (_self.finish == null) {
    return null;
  }

  return $EvalPlanStepCopyWith<$Res>(_self.finish!, (value) {
    return _then(_self.copyWith(finish: value));
  });
}/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenerateConfigCopyWith<$Res> get config {
  
  return $GenerateConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [EvalPlan].
extension EvalPlanPatterns on EvalPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalPlan value)  $default,){
final _that = this;
switch (_that) {
case _EvalPlan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalPlan value)?  $default,){
final _that = this;
switch (_that) {
case _EvalPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<EvalPlanStep> steps,  EvalPlanStep? finish,  GenerateConfig config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalPlan() when $default != null:
return $default(_that.name,_that.steps,_that.finish,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<EvalPlanStep> steps,  EvalPlanStep? finish,  GenerateConfig config)  $default,) {final _that = this;
switch (_that) {
case _EvalPlan():
return $default(_that.name,_that.steps,_that.finish,_that.config);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<EvalPlanStep> steps,  EvalPlanStep? finish,  GenerateConfig config)?  $default,) {final _that = this;
switch (_that) {
case _EvalPlan() when $default != null:
return $default(_that.name,_that.steps,_that.finish,_that.config);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalPlan extends EvalPlan {
  const _EvalPlan({this.name = 'plan', final  List<EvalPlanStep> steps = const [], this.finish, this.config = const GenerateConfig()}): _steps = steps,super._();
  factory _EvalPlan.fromJson(Map<String, dynamic> json) => _$EvalPlanFromJson(json);

/// Plan name.
@override@JsonKey() final  String name;
/// Steps in plan.
 final  List<EvalPlanStep> _steps;
/// Steps in plan.
@override@JsonKey() List<EvalPlanStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

/// Step to always run at the end.
@override final  EvalPlanStep? finish;
/// Generation config.
@override@JsonKey() final  GenerateConfig config;

/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalPlanCopyWith<_EvalPlan> get copyWith => __$EvalPlanCopyWithImpl<_EvalPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalPlan&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.finish, finish) || other.finish == finish)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_steps),finish,config);

@override
String toString() {
  return 'EvalPlan(name: $name, steps: $steps, finish: $finish, config: $config)';
}


}

/// @nodoc
abstract mixin class _$EvalPlanCopyWith<$Res> implements $EvalPlanCopyWith<$Res> {
  factory _$EvalPlanCopyWith(_EvalPlan value, $Res Function(_EvalPlan) _then) = __$EvalPlanCopyWithImpl;
@override @useResult
$Res call({
 String name, List<EvalPlanStep> steps, EvalPlanStep? finish, GenerateConfig config
});


@override $EvalPlanStepCopyWith<$Res>? get finish;@override $GenerateConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$EvalPlanCopyWithImpl<$Res>
    implements _$EvalPlanCopyWith<$Res> {
  __$EvalPlanCopyWithImpl(this._self, this._then);

  final _EvalPlan _self;
  final $Res Function(_EvalPlan) _then;

/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? steps = null,Object? finish = freezed,Object? config = null,}) {
  return _then(_EvalPlan(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<EvalPlanStep>,finish: freezed == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as EvalPlanStep?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as GenerateConfig,
  ));
}

/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalPlanStepCopyWith<$Res>? get finish {
    if (_self.finish == null) {
    return null;
  }

  return $EvalPlanStepCopyWith<$Res>(_self.finish!, (value) {
    return _then(_self.copyWith(finish: value));
  });
}/// Create a copy of EvalPlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenerateConfigCopyWith<$Res> get config {
  
  return $GenerateConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// @nodoc
mixin _$EvalPlanStep {

/// Name of solver.
 String get solver;/// Parameters used to instantiate solver.
 Map<String, dynamic> get params;/// Parameters explicitly passed to the eval plan.
@JsonKey(name: 'params_passed') Map<String, dynamic>? get paramsPassed;
/// Create a copy of EvalPlanStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalPlanStepCopyWith<EvalPlanStep> get copyWith => _$EvalPlanStepCopyWithImpl<EvalPlanStep>(this as EvalPlanStep, _$identity);

  /// Serializes this EvalPlanStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalPlanStep&&(identical(other.solver, solver) || other.solver == solver)&&const DeepCollectionEquality().equals(other.params, params)&&const DeepCollectionEquality().equals(other.paramsPassed, paramsPassed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,solver,const DeepCollectionEquality().hash(params),const DeepCollectionEquality().hash(paramsPassed));

@override
String toString() {
  return 'EvalPlanStep(solver: $solver, params: $params, paramsPassed: $paramsPassed)';
}


}

/// @nodoc
abstract mixin class $EvalPlanStepCopyWith<$Res>  {
  factory $EvalPlanStepCopyWith(EvalPlanStep value, $Res Function(EvalPlanStep) _then) = _$EvalPlanStepCopyWithImpl;
@useResult
$Res call({
 String solver, Map<String, dynamic> params,@JsonKey(name: 'params_passed') Map<String, dynamic>? paramsPassed
});




}
/// @nodoc
class _$EvalPlanStepCopyWithImpl<$Res>
    implements $EvalPlanStepCopyWith<$Res> {
  _$EvalPlanStepCopyWithImpl(this._self, this._then);

  final EvalPlanStep _self;
  final $Res Function(EvalPlanStep) _then;

/// Create a copy of EvalPlanStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? solver = null,Object? params = null,Object? paramsPassed = freezed,}) {
  return _then(_self.copyWith(
solver: null == solver ? _self.solver : solver // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,paramsPassed: freezed == paramsPassed ? _self.paramsPassed : paramsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalPlanStep].
extension EvalPlanStepPatterns on EvalPlanStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalPlanStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalPlanStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalPlanStep value)  $default,){
final _that = this;
switch (_that) {
case _EvalPlanStep():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalPlanStep value)?  $default,){
final _that = this;
switch (_that) {
case _EvalPlanStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String solver,  Map<String, dynamic> params, @JsonKey(name: 'params_passed')  Map<String, dynamic>? paramsPassed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalPlanStep() when $default != null:
return $default(_that.solver,_that.params,_that.paramsPassed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String solver,  Map<String, dynamic> params, @JsonKey(name: 'params_passed')  Map<String, dynamic>? paramsPassed)  $default,) {final _that = this;
switch (_that) {
case _EvalPlanStep():
return $default(_that.solver,_that.params,_that.paramsPassed);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String solver,  Map<String, dynamic> params, @JsonKey(name: 'params_passed')  Map<String, dynamic>? paramsPassed)?  $default,) {final _that = this;
switch (_that) {
case _EvalPlanStep() when $default != null:
return $default(_that.solver,_that.params,_that.paramsPassed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalPlanStep extends EvalPlanStep {
  const _EvalPlanStep({required this.solver, final  Map<String, dynamic> params = const {}, @JsonKey(name: 'params_passed') final  Map<String, dynamic>? paramsPassed}): _params = params,_paramsPassed = paramsPassed,super._();
  factory _EvalPlanStep.fromJson(Map<String, dynamic> json) => _$EvalPlanStepFromJson(json);

/// Name of solver.
@override final  String solver;
/// Parameters used to instantiate solver.
 final  Map<String, dynamic> _params;
/// Parameters used to instantiate solver.
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}

/// Parameters explicitly passed to the eval plan.
 final  Map<String, dynamic>? _paramsPassed;
/// Parameters explicitly passed to the eval plan.
@override@JsonKey(name: 'params_passed') Map<String, dynamic>? get paramsPassed {
  final value = _paramsPassed;
  if (value == null) return null;
  if (_paramsPassed is EqualUnmodifiableMapView) return _paramsPassed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EvalPlanStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalPlanStepCopyWith<_EvalPlanStep> get copyWith => __$EvalPlanStepCopyWithImpl<_EvalPlanStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalPlanStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalPlanStep&&(identical(other.solver, solver) || other.solver == solver)&&const DeepCollectionEquality().equals(other._params, _params)&&const DeepCollectionEquality().equals(other._paramsPassed, _paramsPassed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,solver,const DeepCollectionEquality().hash(_params),const DeepCollectionEquality().hash(_paramsPassed));

@override
String toString() {
  return 'EvalPlanStep(solver: $solver, params: $params, paramsPassed: $paramsPassed)';
}


}

/// @nodoc
abstract mixin class _$EvalPlanStepCopyWith<$Res> implements $EvalPlanStepCopyWith<$Res> {
  factory _$EvalPlanStepCopyWith(_EvalPlanStep value, $Res Function(_EvalPlanStep) _then) = __$EvalPlanStepCopyWithImpl;
@override @useResult
$Res call({
 String solver, Map<String, dynamic> params,@JsonKey(name: 'params_passed') Map<String, dynamic>? paramsPassed
});




}
/// @nodoc
class __$EvalPlanStepCopyWithImpl<$Res>
    implements _$EvalPlanStepCopyWith<$Res> {
  __$EvalPlanStepCopyWithImpl(this._self, this._then);

  final _EvalPlanStep _self;
  final $Res Function(_EvalPlanStep) _then;

/// Create a copy of EvalPlanStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? solver = null,Object? params = null,Object? paramsPassed = freezed,}) {
  return _then(_EvalPlanStep(
solver: null == solver ? _self.solver : solver // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,paramsPassed: freezed == paramsPassed ? _self._paramsPassed : paramsPassed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$EvalResults {

/// Total samples in eval (dataset samples * epochs).
@JsonKey(name: 'total_samples', defaultValue: 0) int get totalSamples;/// Samples completed without error.
@JsonKey(name: 'completed_samples', defaultValue: 0) int get completedSamples;/// Early stopping summary (if an early stopping manager was present).
@JsonKey(name: 'early_stopping') EarlyStoppingSummary? get earlyStopping;/// Scorers used to compute results.
 List<EvalScore> get scores;/// Additional results metadata.
 Map<String, dynamic> get metadata;/// List of per sample scores reduced across epochs.
@JsonKey(name: 'sample_reductions') List<EvalSampleReductions>? get sampleReductions;
/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalResultsCopyWith<EvalResults> get copyWith => _$EvalResultsCopyWithImpl<EvalResults>(this as EvalResults, _$identity);

  /// Serializes this EvalResults to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalResults&&(identical(other.totalSamples, totalSamples) || other.totalSamples == totalSamples)&&(identical(other.completedSamples, completedSamples) || other.completedSamples == completedSamples)&&(identical(other.earlyStopping, earlyStopping) || other.earlyStopping == earlyStopping)&&const DeepCollectionEquality().equals(other.scores, scores)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.sampleReductions, sampleReductions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSamples,completedSamples,earlyStopping,const DeepCollectionEquality().hash(scores),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(sampleReductions));

@override
String toString() {
  return 'EvalResults(totalSamples: $totalSamples, completedSamples: $completedSamples, earlyStopping: $earlyStopping, scores: $scores, metadata: $metadata, sampleReductions: $sampleReductions)';
}


}

/// @nodoc
abstract mixin class $EvalResultsCopyWith<$Res>  {
  factory $EvalResultsCopyWith(EvalResults value, $Res Function(EvalResults) _then) = _$EvalResultsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_samples', defaultValue: 0) int totalSamples,@JsonKey(name: 'completed_samples', defaultValue: 0) int completedSamples,@JsonKey(name: 'early_stopping') EarlyStoppingSummary? earlyStopping, List<EvalScore> scores, Map<String, dynamic> metadata,@JsonKey(name: 'sample_reductions') List<EvalSampleReductions>? sampleReductions
});


$EarlyStoppingSummaryCopyWith<$Res>? get earlyStopping;

}
/// @nodoc
class _$EvalResultsCopyWithImpl<$Res>
    implements $EvalResultsCopyWith<$Res> {
  _$EvalResultsCopyWithImpl(this._self, this._then);

  final EvalResults _self;
  final $Res Function(EvalResults) _then;

/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSamples = null,Object? completedSamples = null,Object? earlyStopping = freezed,Object? scores = null,Object? metadata = null,Object? sampleReductions = freezed,}) {
  return _then(_self.copyWith(
totalSamples: null == totalSamples ? _self.totalSamples : totalSamples // ignore: cast_nullable_to_non_nullable
as int,completedSamples: null == completedSamples ? _self.completedSamples : completedSamples // ignore: cast_nullable_to_non_nullable
as int,earlyStopping: freezed == earlyStopping ? _self.earlyStopping : earlyStopping // ignore: cast_nullable_to_non_nullable
as EarlyStoppingSummary?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<EvalScore>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sampleReductions: freezed == sampleReductions ? _self.sampleReductions : sampleReductions // ignore: cast_nullable_to_non_nullable
as List<EvalSampleReductions>?,
  ));
}
/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarlyStoppingSummaryCopyWith<$Res>? get earlyStopping {
    if (_self.earlyStopping == null) {
    return null;
  }

  return $EarlyStoppingSummaryCopyWith<$Res>(_self.earlyStopping!, (value) {
    return _then(_self.copyWith(earlyStopping: value));
  });
}
}


/// Adds pattern-matching-related methods to [EvalResults].
extension EvalResultsPatterns on EvalResults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalResults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalResults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalResults value)  $default,){
final _that = this;
switch (_that) {
case _EvalResults():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalResults value)?  $default,){
final _that = this;
switch (_that) {
case _EvalResults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_samples', defaultValue: 0)  int totalSamples, @JsonKey(name: 'completed_samples', defaultValue: 0)  int completedSamples, @JsonKey(name: 'early_stopping')  EarlyStoppingSummary? earlyStopping,  List<EvalScore> scores,  Map<String, dynamic> metadata, @JsonKey(name: 'sample_reductions')  List<EvalSampleReductions>? sampleReductions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalResults() when $default != null:
return $default(_that.totalSamples,_that.completedSamples,_that.earlyStopping,_that.scores,_that.metadata,_that.sampleReductions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_samples', defaultValue: 0)  int totalSamples, @JsonKey(name: 'completed_samples', defaultValue: 0)  int completedSamples, @JsonKey(name: 'early_stopping')  EarlyStoppingSummary? earlyStopping,  List<EvalScore> scores,  Map<String, dynamic> metadata, @JsonKey(name: 'sample_reductions')  List<EvalSampleReductions>? sampleReductions)  $default,) {final _that = this;
switch (_that) {
case _EvalResults():
return $default(_that.totalSamples,_that.completedSamples,_that.earlyStopping,_that.scores,_that.metadata,_that.sampleReductions);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_samples', defaultValue: 0)  int totalSamples, @JsonKey(name: 'completed_samples', defaultValue: 0)  int completedSamples, @JsonKey(name: 'early_stopping')  EarlyStoppingSummary? earlyStopping,  List<EvalScore> scores,  Map<String, dynamic> metadata, @JsonKey(name: 'sample_reductions')  List<EvalSampleReductions>? sampleReductions)?  $default,) {final _that = this;
switch (_that) {
case _EvalResults() when $default != null:
return $default(_that.totalSamples,_that.completedSamples,_that.earlyStopping,_that.scores,_that.metadata,_that.sampleReductions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalResults extends EvalResults {
  const _EvalResults({@JsonKey(name: 'total_samples', defaultValue: 0) this.totalSamples = 0, @JsonKey(name: 'completed_samples', defaultValue: 0) this.completedSamples = 0, @JsonKey(name: 'early_stopping') this.earlyStopping, final  List<EvalScore> scores = const [], final  Map<String, dynamic> metadata = const {}, @JsonKey(name: 'sample_reductions') final  List<EvalSampleReductions>? sampleReductions}): _scores = scores,_metadata = metadata,_sampleReductions = sampleReductions,super._();
  factory _EvalResults.fromJson(Map<String, dynamic> json) => _$EvalResultsFromJson(json);

/// Total samples in eval (dataset samples * epochs).
@override@JsonKey(name: 'total_samples', defaultValue: 0) final  int totalSamples;
/// Samples completed without error.
@override@JsonKey(name: 'completed_samples', defaultValue: 0) final  int completedSamples;
/// Early stopping summary (if an early stopping manager was present).
@override@JsonKey(name: 'early_stopping') final  EarlyStoppingSummary? earlyStopping;
/// Scorers used to compute results.
 final  List<EvalScore> _scores;
/// Scorers used to compute results.
@override@JsonKey() List<EvalScore> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

/// Additional results metadata.
 final  Map<String, dynamic> _metadata;
/// Additional results metadata.
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// List of per sample scores reduced across epochs.
 final  List<EvalSampleReductions>? _sampleReductions;
/// List of per sample scores reduced across epochs.
@override@JsonKey(name: 'sample_reductions') List<EvalSampleReductions>? get sampleReductions {
  final value = _sampleReductions;
  if (value == null) return null;
  if (_sampleReductions is EqualUnmodifiableListView) return _sampleReductions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalResultsCopyWith<_EvalResults> get copyWith => __$EvalResultsCopyWithImpl<_EvalResults>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalResultsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalResults&&(identical(other.totalSamples, totalSamples) || other.totalSamples == totalSamples)&&(identical(other.completedSamples, completedSamples) || other.completedSamples == completedSamples)&&(identical(other.earlyStopping, earlyStopping) || other.earlyStopping == earlyStopping)&&const DeepCollectionEquality().equals(other._scores, _scores)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._sampleReductions, _sampleReductions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSamples,completedSamples,earlyStopping,const DeepCollectionEquality().hash(_scores),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_sampleReductions));

@override
String toString() {
  return 'EvalResults(totalSamples: $totalSamples, completedSamples: $completedSamples, earlyStopping: $earlyStopping, scores: $scores, metadata: $metadata, sampleReductions: $sampleReductions)';
}


}

/// @nodoc
abstract mixin class _$EvalResultsCopyWith<$Res> implements $EvalResultsCopyWith<$Res> {
  factory _$EvalResultsCopyWith(_EvalResults value, $Res Function(_EvalResults) _then) = __$EvalResultsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_samples', defaultValue: 0) int totalSamples,@JsonKey(name: 'completed_samples', defaultValue: 0) int completedSamples,@JsonKey(name: 'early_stopping') EarlyStoppingSummary? earlyStopping, List<EvalScore> scores, Map<String, dynamic> metadata,@JsonKey(name: 'sample_reductions') List<EvalSampleReductions>? sampleReductions
});


@override $EarlyStoppingSummaryCopyWith<$Res>? get earlyStopping;

}
/// @nodoc
class __$EvalResultsCopyWithImpl<$Res>
    implements _$EvalResultsCopyWith<$Res> {
  __$EvalResultsCopyWithImpl(this._self, this._then);

  final _EvalResults _self;
  final $Res Function(_EvalResults) _then;

/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSamples = null,Object? completedSamples = null,Object? earlyStopping = freezed,Object? scores = null,Object? metadata = null,Object? sampleReductions = freezed,}) {
  return _then(_EvalResults(
totalSamples: null == totalSamples ? _self.totalSamples : totalSamples // ignore: cast_nullable_to_non_nullable
as int,completedSamples: null == completedSamples ? _self.completedSamples : completedSamples // ignore: cast_nullable_to_non_nullable
as int,earlyStopping: freezed == earlyStopping ? _self.earlyStopping : earlyStopping // ignore: cast_nullable_to_non_nullable
as EarlyStoppingSummary?,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<EvalScore>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sampleReductions: freezed == sampleReductions ? _self._sampleReductions : sampleReductions // ignore: cast_nullable_to_non_nullable
as List<EvalSampleReductions>?,
  ));
}

/// Create a copy of EvalResults
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarlyStoppingSummaryCopyWith<$Res>? get earlyStopping {
    if (_self.earlyStopping == null) {
    return null;
  }

  return $EarlyStoppingSummaryCopyWith<$Res>(_self.earlyStopping!, (value) {
    return _then(_self.copyWith(earlyStopping: value));
  });
}
}


/// @nodoc
mixin _$EarlyStoppingSummary {

/// Type of early stopping.
 String get type;/// Limit that triggered early stopping.
 double? get limit;/// Score that triggered early stopping.
 double? get score;/// Additional metadata.
 Map<String, dynamic> get metadata;
/// Create a copy of EarlyStoppingSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarlyStoppingSummaryCopyWith<EarlyStoppingSummary> get copyWith => _$EarlyStoppingSummaryCopyWithImpl<EarlyStoppingSummary>(this as EarlyStoppingSummary, _$identity);

  /// Serializes this EarlyStoppingSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarlyStoppingSummary&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit,score,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'EarlyStoppingSummary(type: $type, limit: $limit, score: $score, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $EarlyStoppingSummaryCopyWith<$Res>  {
  factory $EarlyStoppingSummaryCopyWith(EarlyStoppingSummary value, $Res Function(EarlyStoppingSummary) _then) = _$EarlyStoppingSummaryCopyWithImpl;
@useResult
$Res call({
 String type, double? limit, double? score, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$EarlyStoppingSummaryCopyWithImpl<$Res>
    implements $EarlyStoppingSummaryCopyWith<$Res> {
  _$EarlyStoppingSummaryCopyWithImpl(this._self, this._then);

  final EarlyStoppingSummary _self;
  final $Res Function(EarlyStoppingSummary) _then;

/// Create a copy of EarlyStoppingSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? limit = freezed,Object? score = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarlyStoppingSummary].
extension EarlyStoppingSummaryPatterns on EarlyStoppingSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarlyStoppingSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarlyStoppingSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarlyStoppingSummary value)  $default,){
final _that = this;
switch (_that) {
case _EarlyStoppingSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarlyStoppingSummary value)?  $default,){
final _that = this;
switch (_that) {
case _EarlyStoppingSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  double? limit,  double? score,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarlyStoppingSummary() when $default != null:
return $default(_that.type,_that.limit,_that.score,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  double? limit,  double? score,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _EarlyStoppingSummary():
return $default(_that.type,_that.limit,_that.score,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  double? limit,  double? score,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _EarlyStoppingSummary() when $default != null:
return $default(_that.type,_that.limit,_that.score,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarlyStoppingSummary extends EarlyStoppingSummary {
  const _EarlyStoppingSummary({required this.type, this.limit, this.score, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata,super._();
  factory _EarlyStoppingSummary.fromJson(Map<String, dynamic> json) => _$EarlyStoppingSummaryFromJson(json);

/// Type of early stopping.
@override final  String type;
/// Limit that triggered early stopping.
@override final  double? limit;
/// Score that triggered early stopping.
@override final  double? score;
/// Additional metadata.
 final  Map<String, dynamic> _metadata;
/// Additional metadata.
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of EarlyStoppingSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarlyStoppingSummaryCopyWith<_EarlyStoppingSummary> get copyWith => __$EarlyStoppingSummaryCopyWithImpl<_EarlyStoppingSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarlyStoppingSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarlyStoppingSummary&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit,score,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'EarlyStoppingSummary(type: $type, limit: $limit, score: $score, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$EarlyStoppingSummaryCopyWith<$Res> implements $EarlyStoppingSummaryCopyWith<$Res> {
  factory _$EarlyStoppingSummaryCopyWith(_EarlyStoppingSummary value, $Res Function(_EarlyStoppingSummary) _then) = __$EarlyStoppingSummaryCopyWithImpl;
@override @useResult
$Res call({
 String type, double? limit, double? score, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$EarlyStoppingSummaryCopyWithImpl<$Res>
    implements _$EarlyStoppingSummaryCopyWith<$Res> {
  __$EarlyStoppingSummaryCopyWithImpl(this._self, this._then);

  final _EarlyStoppingSummary _self;
  final $Res Function(_EarlyStoppingSummary) _then;

/// Create a copy of EarlyStoppingSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? limit = freezed,Object? score = freezed,Object? metadata = null,}) {
  return _then(_EarlyStoppingSummary(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$EvalScore {

/// Score name.
 String get name;/// Scorer name.
 String get scorer;/// Reducer name.
 String? get reducer;/// Number of samples scored by this scorer.
@JsonKey(name: 'scored_samples') int? get scoredSamples;/// Number of samples not scored by this scorer.
@JsonKey(name: 'unscored_samples') int? get unscoredSamples;/// Parameters specified when creating scorer.
 Map<String, dynamic> get params;/// Metrics computed for this scorer.
@JsonKey(fromJson: _metricsFromJson) List<EvalMetric> get metrics;/// Additional scorer metadata.
@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata;
/// Create a copy of EvalScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalScoreCopyWith<EvalScore> get copyWith => _$EvalScoreCopyWithImpl<EvalScore>(this as EvalScore, _$identity);

  /// Serializes this EvalScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalScore&&(identical(other.name, name) || other.name == name)&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.reducer, reducer) || other.reducer == reducer)&&(identical(other.scoredSamples, scoredSamples) || other.scoredSamples == scoredSamples)&&(identical(other.unscoredSamples, unscoredSamples) || other.unscoredSamples == unscoredSamples)&&const DeepCollectionEquality().equals(other.params, params)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,scorer,reducer,scoredSamples,unscoredSamples,const DeepCollectionEquality().hash(params),const DeepCollectionEquality().hash(metrics),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'EvalScore(name: $name, scorer: $scorer, reducer: $reducer, scoredSamples: $scoredSamples, unscoredSamples: $unscoredSamples, params: $params, metrics: $metrics, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $EvalScoreCopyWith<$Res>  {
  factory $EvalScoreCopyWith(EvalScore value, $Res Function(EvalScore) _then) = _$EvalScoreCopyWithImpl;
@useResult
$Res call({
 String name, String scorer, String? reducer,@JsonKey(name: 'scored_samples') int? scoredSamples,@JsonKey(name: 'unscored_samples') int? unscoredSamples, Map<String, dynamic> params,@JsonKey(fromJson: _metricsFromJson) List<EvalMetric> metrics,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$EvalScoreCopyWithImpl<$Res>
    implements $EvalScoreCopyWith<$Res> {
  _$EvalScoreCopyWithImpl(this._self, this._then);

  final EvalScore _self;
  final $Res Function(EvalScore) _then;

/// Create a copy of EvalScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? scorer = null,Object? reducer = freezed,Object? scoredSamples = freezed,Object? unscoredSamples = freezed,Object? params = null,Object? metrics = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scorer: null == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String,reducer: freezed == reducer ? _self.reducer : reducer // ignore: cast_nullable_to_non_nullable
as String?,scoredSamples: freezed == scoredSamples ? _self.scoredSamples : scoredSamples // ignore: cast_nullable_to_non_nullable
as int?,unscoredSamples: freezed == unscoredSamples ? _self.unscoredSamples : unscoredSamples // ignore: cast_nullable_to_non_nullable
as int?,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<EvalMetric>,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalScore].
extension EvalScorePatterns on EvalScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalScore value)  $default,){
final _that = this;
switch (_that) {
case _EvalScore():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalScore value)?  $default,){
final _that = this;
switch (_that) {
case _EvalScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String scorer,  String? reducer, @JsonKey(name: 'scored_samples')  int? scoredSamples, @JsonKey(name: 'unscored_samples')  int? unscoredSamples,  Map<String, dynamic> params, @JsonKey(fromJson: _metricsFromJson)  List<EvalMetric> metrics, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalScore() when $default != null:
return $default(_that.name,_that.scorer,_that.reducer,_that.scoredSamples,_that.unscoredSamples,_that.params,_that.metrics,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String scorer,  String? reducer, @JsonKey(name: 'scored_samples')  int? scoredSamples, @JsonKey(name: 'unscored_samples')  int? unscoredSamples,  Map<String, dynamic> params, @JsonKey(fromJson: _metricsFromJson)  List<EvalMetric> metrics, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _EvalScore():
return $default(_that.name,_that.scorer,_that.reducer,_that.scoredSamples,_that.unscoredSamples,_that.params,_that.metrics,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String scorer,  String? reducer, @JsonKey(name: 'scored_samples')  int? scoredSamples, @JsonKey(name: 'unscored_samples')  int? unscoredSamples,  Map<String, dynamic> params, @JsonKey(fromJson: _metricsFromJson)  List<EvalMetric> metrics, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _EvalScore() when $default != null:
return $default(_that.name,_that.scorer,_that.reducer,_that.scoredSamples,_that.unscoredSamples,_that.params,_that.metrics,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalScore extends EvalScore {
  const _EvalScore({required this.name, required this.scorer, this.reducer, @JsonKey(name: 'scored_samples') this.scoredSamples, @JsonKey(name: 'unscored_samples') this.unscoredSamples, final  Map<String, dynamic> params = const {}, @JsonKey(fromJson: _metricsFromJson) final  List<EvalMetric> metrics = const [], @JsonKey(name: 'metadata') final  Map<String, dynamic>? metadata}): _params = params,_metrics = metrics,_metadata = metadata,super._();
  factory _EvalScore.fromJson(Map<String, dynamic> json) => _$EvalScoreFromJson(json);

/// Score name.
@override final  String name;
/// Scorer name.
@override final  String scorer;
/// Reducer name.
@override final  String? reducer;
/// Number of samples scored by this scorer.
@override@JsonKey(name: 'scored_samples') final  int? scoredSamples;
/// Number of samples not scored by this scorer.
@override@JsonKey(name: 'unscored_samples') final  int? unscoredSamples;
/// Parameters specified when creating scorer.
 final  Map<String, dynamic> _params;
/// Parameters specified when creating scorer.
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}

/// Metrics computed for this scorer.
 final  List<EvalMetric> _metrics;
/// Metrics computed for this scorer.
@override@JsonKey(fromJson: _metricsFromJson) List<EvalMetric> get metrics {
  if (_metrics is EqualUnmodifiableListView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metrics);
}

/// Additional scorer metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional scorer metadata.
@override@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EvalScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalScoreCopyWith<_EvalScore> get copyWith => __$EvalScoreCopyWithImpl<_EvalScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalScore&&(identical(other.name, name) || other.name == name)&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.reducer, reducer) || other.reducer == reducer)&&(identical(other.scoredSamples, scoredSamples) || other.scoredSamples == scoredSamples)&&(identical(other.unscoredSamples, unscoredSamples) || other.unscoredSamples == unscoredSamples)&&const DeepCollectionEquality().equals(other._params, _params)&&const DeepCollectionEquality().equals(other._metrics, _metrics)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,scorer,reducer,scoredSamples,unscoredSamples,const DeepCollectionEquality().hash(_params),const DeepCollectionEquality().hash(_metrics),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'EvalScore(name: $name, scorer: $scorer, reducer: $reducer, scoredSamples: $scoredSamples, unscoredSamples: $unscoredSamples, params: $params, metrics: $metrics, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$EvalScoreCopyWith<$Res> implements $EvalScoreCopyWith<$Res> {
  factory _$EvalScoreCopyWith(_EvalScore value, $Res Function(_EvalScore) _then) = __$EvalScoreCopyWithImpl;
@override @useResult
$Res call({
 String name, String scorer, String? reducer,@JsonKey(name: 'scored_samples') int? scoredSamples,@JsonKey(name: 'unscored_samples') int? unscoredSamples, Map<String, dynamic> params,@JsonKey(fromJson: _metricsFromJson) List<EvalMetric> metrics,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$EvalScoreCopyWithImpl<$Res>
    implements _$EvalScoreCopyWith<$Res> {
  __$EvalScoreCopyWithImpl(this._self, this._then);

  final _EvalScore _self;
  final $Res Function(_EvalScore) _then;

/// Create a copy of EvalScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? scorer = null,Object? reducer = freezed,Object? scoredSamples = freezed,Object? unscoredSamples = freezed,Object? params = null,Object? metrics = null,Object? metadata = freezed,}) {
  return _then(_EvalScore(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scorer: null == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String,reducer: freezed == reducer ? _self.reducer : reducer // ignore: cast_nullable_to_non_nullable
as String?,scoredSamples: freezed == scoredSamples ? _self.scoredSamples : scoredSamples // ignore: cast_nullable_to_non_nullable
as int?,unscoredSamples: freezed == unscoredSamples ? _self.unscoredSamples : unscoredSamples // ignore: cast_nullable_to_non_nullable
as int?,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as List<EvalMetric>,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$EvalMetric {

/// Metric name.
 String get name;/// Metric value.
 Object get value;/// Params specified when creating metric.
 Map<String, dynamic> get params;/// Additional metadata associated with metric.
 Map<String, dynamic>? get metadata;
/// Create a copy of EvalMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalMetricCopyWith<EvalMetric> get copyWith => _$EvalMetricCopyWithImpl<EvalMetric>(this as EvalMetric, _$identity);

  /// Serializes this EvalMetric to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalMetric&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.value, value)&&const DeepCollectionEquality().equals(other.params, params)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(value),const DeepCollectionEquality().hash(params),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'EvalMetric(name: $name, value: $value, params: $params, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $EvalMetricCopyWith<$Res>  {
  factory $EvalMetricCopyWith(EvalMetric value, $Res Function(EvalMetric) _then) = _$EvalMetricCopyWithImpl;
@useResult
$Res call({
 String name, Object value, Map<String, dynamic> params, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$EvalMetricCopyWithImpl<$Res>
    implements $EvalMetricCopyWith<$Res> {
  _$EvalMetricCopyWithImpl(this._self, this._then);

  final EvalMetric _self;
  final $Res Function(EvalMetric) _then;

/// Create a copy of EvalMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,Object? params = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value ,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalMetric].
extension EvalMetricPatterns on EvalMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalMetric value)  $default,){
final _that = this;
switch (_that) {
case _EvalMetric():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalMetric value)?  $default,){
final _that = this;
switch (_that) {
case _EvalMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Object value,  Map<String, dynamic> params,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalMetric() when $default != null:
return $default(_that.name,_that.value,_that.params,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Object value,  Map<String, dynamic> params,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _EvalMetric():
return $default(_that.name,_that.value,_that.params,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Object value,  Map<String, dynamic> params,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _EvalMetric() when $default != null:
return $default(_that.name,_that.value,_that.params,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalMetric extends EvalMetric {
  const _EvalMetric({required this.name, required this.value, final  Map<String, dynamic> params = const {}, final  Map<String, dynamic>? metadata}): _params = params,_metadata = metadata,super._();
  factory _EvalMetric.fromJson(Map<String, dynamic> json) => _$EvalMetricFromJson(json);

/// Metric name.
@override final  String name;
/// Metric value.
@override final  Object value;
/// Params specified when creating metric.
 final  Map<String, dynamic> _params;
/// Params specified when creating metric.
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}

/// Additional metadata associated with metric.
 final  Map<String, dynamic>? _metadata;
/// Additional metadata associated with metric.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EvalMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalMetricCopyWith<_EvalMetric> get copyWith => __$EvalMetricCopyWithImpl<_EvalMetric>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalMetricToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalMetric&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.value, value)&&const DeepCollectionEquality().equals(other._params, _params)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(value),const DeepCollectionEquality().hash(_params),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'EvalMetric(name: $name, value: $value, params: $params, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$EvalMetricCopyWith<$Res> implements $EvalMetricCopyWith<$Res> {
  factory _$EvalMetricCopyWith(_EvalMetric value, $Res Function(_EvalMetric) _then) = __$EvalMetricCopyWithImpl;
@override @useResult
$Res call({
 String name, Object value, Map<String, dynamic> params, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$EvalMetricCopyWithImpl<$Res>
    implements _$EvalMetricCopyWith<$Res> {
  __$EvalMetricCopyWithImpl(this._self, this._then);

  final _EvalMetric _self;
  final $Res Function(_EvalMetric) _then;

/// Create a copy of EvalMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,Object? params = null,Object? metadata = freezed,}) {
  return _then(_EvalMetric(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value ,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$EvalSampleReductions {

/// Name the of scorer.
 String get scorer;/// Name the of reducer.
 String? get reducer;/// List of reduced scores.
 List<EvalSampleScore> get samples;
/// Create a copy of EvalSampleReductions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSampleReductionsCopyWith<EvalSampleReductions> get copyWith => _$EvalSampleReductionsCopyWithImpl<EvalSampleReductions>(this as EvalSampleReductions, _$identity);

  /// Serializes this EvalSampleReductions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSampleReductions&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.reducer, reducer) || other.reducer == reducer)&&const DeepCollectionEquality().equals(other.samples, samples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scorer,reducer,const DeepCollectionEquality().hash(samples));

@override
String toString() {
  return 'EvalSampleReductions(scorer: $scorer, reducer: $reducer, samples: $samples)';
}


}

/// @nodoc
abstract mixin class $EvalSampleReductionsCopyWith<$Res>  {
  factory $EvalSampleReductionsCopyWith(EvalSampleReductions value, $Res Function(EvalSampleReductions) _then) = _$EvalSampleReductionsCopyWithImpl;
@useResult
$Res call({
 String scorer, String? reducer, List<EvalSampleScore> samples
});




}
/// @nodoc
class _$EvalSampleReductionsCopyWithImpl<$Res>
    implements $EvalSampleReductionsCopyWith<$Res> {
  _$EvalSampleReductionsCopyWithImpl(this._self, this._then);

  final EvalSampleReductions _self;
  final $Res Function(EvalSampleReductions) _then;

/// Create a copy of EvalSampleReductions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scorer = null,Object? reducer = freezed,Object? samples = null,}) {
  return _then(_self.copyWith(
scorer: null == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String,reducer: freezed == reducer ? _self.reducer : reducer // ignore: cast_nullable_to_non_nullable
as String?,samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as List<EvalSampleScore>,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSampleReductions].
extension EvalSampleReductionsPatterns on EvalSampleReductions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSampleReductions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSampleReductions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSampleReductions value)  $default,){
final _that = this;
switch (_that) {
case _EvalSampleReductions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSampleReductions value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSampleReductions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String scorer,  String? reducer,  List<EvalSampleScore> samples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSampleReductions() when $default != null:
return $default(_that.scorer,_that.reducer,_that.samples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String scorer,  String? reducer,  List<EvalSampleScore> samples)  $default,) {final _that = this;
switch (_that) {
case _EvalSampleReductions():
return $default(_that.scorer,_that.reducer,_that.samples);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String scorer,  String? reducer,  List<EvalSampleScore> samples)?  $default,) {final _that = this;
switch (_that) {
case _EvalSampleReductions() when $default != null:
return $default(_that.scorer,_that.reducer,_that.samples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSampleReductions extends EvalSampleReductions {
  const _EvalSampleReductions({required this.scorer, this.reducer, required final  List<EvalSampleScore> samples}): _samples = samples,super._();
  factory _EvalSampleReductions.fromJson(Map<String, dynamic> json) => _$EvalSampleReductionsFromJson(json);

/// Name the of scorer.
@override final  String scorer;
/// Name the of reducer.
@override final  String? reducer;
/// List of reduced scores.
 final  List<EvalSampleScore> _samples;
/// List of reduced scores.
@override List<EvalSampleScore> get samples {
  if (_samples is EqualUnmodifiableListView) return _samples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_samples);
}


/// Create a copy of EvalSampleReductions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSampleReductionsCopyWith<_EvalSampleReductions> get copyWith => __$EvalSampleReductionsCopyWithImpl<_EvalSampleReductions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSampleReductionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSampleReductions&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.reducer, reducer) || other.reducer == reducer)&&const DeepCollectionEquality().equals(other._samples, _samples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scorer,reducer,const DeepCollectionEquality().hash(_samples));

@override
String toString() {
  return 'EvalSampleReductions(scorer: $scorer, reducer: $reducer, samples: $samples)';
}


}

/// @nodoc
abstract mixin class _$EvalSampleReductionsCopyWith<$Res> implements $EvalSampleReductionsCopyWith<$Res> {
  factory _$EvalSampleReductionsCopyWith(_EvalSampleReductions value, $Res Function(_EvalSampleReductions) _then) = __$EvalSampleReductionsCopyWithImpl;
@override @useResult
$Res call({
 String scorer, String? reducer, List<EvalSampleScore> samples
});




}
/// @nodoc
class __$EvalSampleReductionsCopyWithImpl<$Res>
    implements _$EvalSampleReductionsCopyWith<$Res> {
  __$EvalSampleReductionsCopyWithImpl(this._self, this._then);

  final _EvalSampleReductions _self;
  final $Res Function(_EvalSampleReductions) _then;

/// Create a copy of EvalSampleReductions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scorer = null,Object? reducer = freezed,Object? samples = null,}) {
  return _then(_EvalSampleReductions(
scorer: null == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String,reducer: freezed == reducer ? _self.reducer : reducer // ignore: cast_nullable_to_non_nullable
as String?,samples: null == samples ? _self._samples : samples // ignore: cast_nullable_to_non_nullable
as List<EvalSampleScore>,
  ));
}


}


/// @nodoc
mixin _$EvalStats {

/// Evaluation start time. Empty string if eval interrupted before start time set.
@JsonKey(name: 'started_at') String get startedAt;/// Evaluation completion time. Empty string if eval interrupted before completion.
@JsonKey(name: 'completed_at') String get completedAt;/// Model token usage for evaluation.
@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> get modelUsage;
/// Create a copy of EvalStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalStatsCopyWith<EvalStats> get copyWith => _$EvalStatsCopyWithImpl<EvalStats>(this as EvalStats, _$identity);

  /// Serializes this EvalStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalStats&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.modelUsage, modelUsage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startedAt,completedAt,const DeepCollectionEquality().hash(modelUsage));

@override
String toString() {
  return 'EvalStats(startedAt: $startedAt, completedAt: $completedAt, modelUsage: $modelUsage)';
}


}

/// @nodoc
abstract mixin class $EvalStatsCopyWith<$Res>  {
  factory $EvalStatsCopyWith(EvalStats value, $Res Function(EvalStats) _then) = _$EvalStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'completed_at') String completedAt,@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> modelUsage
});




}
/// @nodoc
class _$EvalStatsCopyWithImpl<$Res>
    implements $EvalStatsCopyWith<$Res> {
  _$EvalStatsCopyWithImpl(this._self, this._then);

  final EvalStats _self;
  final $Res Function(EvalStats) _then;

/// Create a copy of EvalStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startedAt = null,Object? completedAt = null,Object? modelUsage = null,}) {
  return _then(_self.copyWith(
startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String,modelUsage: null == modelUsage ? _self.modelUsage : modelUsage // ignore: cast_nullable_to_non_nullable
as Map<String, ModelUsage>,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalStats].
extension EvalStatsPatterns on EvalStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalStats value)  $default,){
final _that = this;
switch (_that) {
case _EvalStats():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalStats value)?  $default,){
final _that = this;
switch (_that) {
case _EvalStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'completed_at')  String completedAt, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalStats() when $default != null:
return $default(_that.startedAt,_that.completedAt,_that.modelUsage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'completed_at')  String completedAt, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage)  $default,) {final _that = this;
switch (_that) {
case _EvalStats():
return $default(_that.startedAt,_that.completedAt,_that.modelUsage);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'completed_at')  String completedAt, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage)?  $default,) {final _that = this;
switch (_that) {
case _EvalStats() when $default != null:
return $default(_that.startedAt,_that.completedAt,_that.modelUsage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalStats extends EvalStats {
  const _EvalStats({@JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'completed_at') required this.completedAt, @JsonKey(name: 'model_usage', defaultValue: {}) final  Map<String, ModelUsage> modelUsage = const {}}): _modelUsage = modelUsage,super._();
  factory _EvalStats.fromJson(Map<String, dynamic> json) => _$EvalStatsFromJson(json);

/// Evaluation start time. Empty string if eval interrupted before start time set.
@override@JsonKey(name: 'started_at') final  String startedAt;
/// Evaluation completion time. Empty string if eval interrupted before completion.
@override@JsonKey(name: 'completed_at') final  String completedAt;
/// Model token usage for evaluation.
 final  Map<String, ModelUsage> _modelUsage;
/// Model token usage for evaluation.
@override@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> get modelUsage {
  if (_modelUsage is EqualUnmodifiableMapView) return _modelUsage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modelUsage);
}


/// Create a copy of EvalStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalStatsCopyWith<_EvalStats> get copyWith => __$EvalStatsCopyWithImpl<_EvalStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalStats&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._modelUsage, _modelUsage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startedAt,completedAt,const DeepCollectionEquality().hash(_modelUsage));

@override
String toString() {
  return 'EvalStats(startedAt: $startedAt, completedAt: $completedAt, modelUsage: $modelUsage)';
}


}

/// @nodoc
abstract mixin class _$EvalStatsCopyWith<$Res> implements $EvalStatsCopyWith<$Res> {
  factory _$EvalStatsCopyWith(_EvalStats value, $Res Function(_EvalStats) _then) = __$EvalStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'completed_at') String completedAt,@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> modelUsage
});




}
/// @nodoc
class __$EvalStatsCopyWithImpl<$Res>
    implements _$EvalStatsCopyWith<$Res> {
  __$EvalStatsCopyWithImpl(this._self, this._then);

  final _EvalStats _self;
  final $Res Function(_EvalStats) _then;

/// Create a copy of EvalStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startedAt = null,Object? completedAt = null,Object? modelUsage = null,}) {
  return _then(_EvalStats(
startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String,modelUsage: null == modelUsage ? _self._modelUsage : modelUsage // ignore: cast_nullable_to_non_nullable
as Map<String, ModelUsage>,
  ));
}


}


/// @nodoc
mixin _$EvalError {

/// Error message.
 String get message;/// Error traceback.
 String get traceback;/// Error traceback with ANSI color codes.
@JsonKey(name: 'traceback_ansi') String get tracebackAnsi;
/// Create a copy of EvalError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalErrorCopyWith<EvalError> get copyWith => _$EvalErrorCopyWithImpl<EvalError>(this as EvalError, _$identity);

  /// Serializes this EvalError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalError&&(identical(other.message, message) || other.message == message)&&(identical(other.traceback, traceback) || other.traceback == traceback)&&(identical(other.tracebackAnsi, tracebackAnsi) || other.tracebackAnsi == tracebackAnsi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,traceback,tracebackAnsi);

@override
String toString() {
  return 'EvalError(message: $message, traceback: $traceback, tracebackAnsi: $tracebackAnsi)';
}


}

/// @nodoc
abstract mixin class $EvalErrorCopyWith<$Res>  {
  factory $EvalErrorCopyWith(EvalError value, $Res Function(EvalError) _then) = _$EvalErrorCopyWithImpl;
@useResult
$Res call({
 String message, String traceback,@JsonKey(name: 'traceback_ansi') String tracebackAnsi
});




}
/// @nodoc
class _$EvalErrorCopyWithImpl<$Res>
    implements $EvalErrorCopyWith<$Res> {
  _$EvalErrorCopyWithImpl(this._self, this._then);

  final EvalError _self;
  final $Res Function(EvalError) _then;

/// Create a copy of EvalError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? traceback = null,Object? tracebackAnsi = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,traceback: null == traceback ? _self.traceback : traceback // ignore: cast_nullable_to_non_nullable
as String,tracebackAnsi: null == tracebackAnsi ? _self.tracebackAnsi : tracebackAnsi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalError].
extension EvalErrorPatterns on EvalError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalError value)  $default,){
final _that = this;
switch (_that) {
case _EvalError():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalError value)?  $default,){
final _that = this;
switch (_that) {
case _EvalError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String traceback, @JsonKey(name: 'traceback_ansi')  String tracebackAnsi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalError() when $default != null:
return $default(_that.message,_that.traceback,_that.tracebackAnsi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String traceback, @JsonKey(name: 'traceback_ansi')  String tracebackAnsi)  $default,) {final _that = this;
switch (_that) {
case _EvalError():
return $default(_that.message,_that.traceback,_that.tracebackAnsi);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String traceback, @JsonKey(name: 'traceback_ansi')  String tracebackAnsi)?  $default,) {final _that = this;
switch (_that) {
case _EvalError() when $default != null:
return $default(_that.message,_that.traceback,_that.tracebackAnsi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalError extends EvalError {
  const _EvalError({required this.message, required this.traceback, @JsonKey(name: 'traceback_ansi') required this.tracebackAnsi}): super._();
  factory _EvalError.fromJson(Map<String, dynamic> json) => _$EvalErrorFromJson(json);

/// Error message.
@override final  String message;
/// Error traceback.
@override final  String traceback;
/// Error traceback with ANSI color codes.
@override@JsonKey(name: 'traceback_ansi') final  String tracebackAnsi;

/// Create a copy of EvalError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalErrorCopyWith<_EvalError> get copyWith => __$EvalErrorCopyWithImpl<_EvalError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalError&&(identical(other.message, message) || other.message == message)&&(identical(other.traceback, traceback) || other.traceback == traceback)&&(identical(other.tracebackAnsi, tracebackAnsi) || other.tracebackAnsi == tracebackAnsi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,traceback,tracebackAnsi);

@override
String toString() {
  return 'EvalError(message: $message, traceback: $traceback, tracebackAnsi: $tracebackAnsi)';
}


}

/// @nodoc
abstract mixin class _$EvalErrorCopyWith<$Res> implements $EvalErrorCopyWith<$Res> {
  factory _$EvalErrorCopyWith(_EvalError value, $Res Function(_EvalError) _then) = __$EvalErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, String traceback,@JsonKey(name: 'traceback_ansi') String tracebackAnsi
});




}
/// @nodoc
class __$EvalErrorCopyWithImpl<$Res>
    implements _$EvalErrorCopyWith<$Res> {
  __$EvalErrorCopyWithImpl(this._self, this._then);

  final _EvalError _self;
  final $Res Function(_EvalError) _then;

/// Create a copy of EvalError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? traceback = null,Object? tracebackAnsi = null,}) {
  return _then(_EvalError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,traceback: null == traceback ? _self.traceback : traceback // ignore: cast_nullable_to_non_nullable
as String,tracebackAnsi: null == tracebackAnsi ? _self.tracebackAnsi : tracebackAnsi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EvalSample {

/// Unique id for sample.
 Object get id;/// Epoch number for sample.
 int get epoch;/// Sample input.
 Object get input;/// Sample choices.
 List<String>? get choices;/// Sample target value(s).
 Object? get target;/// Additional sample metadata.
 Map<String, dynamic> get metadata;/// Sandbox environment type and optional config file.
 Object? get sandbox;/// Files that go along with the sample (copied to SandboxEnvironment).
 List<String>? get files;/// Setup script to run for sample (run within default SandboxEnvironment).
 String? get setup;/// Chat conversation history for sample.
 List<ChatMessage> get messages;/// Model output from sample.
 ModelOutput get output;/// Scores for sample.
 Map<String, Score>? get scores;/// State at end of sample execution.
 Map<String, dynamic> get store;/// Events that occurred during sample execution.
 List<Object> get events;/// Model token usage for sample.
@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> get modelUsage;/// Time sample started.
@JsonKey(name: 'started_at') String? get startedAt;/// Time sample completed.
@JsonKey(name: 'completed_at') String? get completedAt;/// Total time that the sample was running.
@JsonKey(name: 'total_time') double? get totalTime;/// Time spent working (model generation, sandbox calls, etc.).
@JsonKey(name: 'working_time') double? get workingTime;/// Globally unique identifier for sample run.
 String? get uuid;/// Provenance data for invalidation.
 ProvenanceData? get invalidation;/// Error that halted sample.
 EvalError? get error;/// Errors that were retried for this sample.
@JsonKey(name: 'error_retries') List<EvalError>? get errorRetries;/// Attachments referenced from messages and events.
 Map<String, String> get attachments;/// The limit that halted the sample.
 EvalSampleLimit? get limit;
/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSampleCopyWith<EvalSample> get copyWith => _$EvalSampleCopyWithImpl<EvalSample>(this as EvalSample, _$identity);

  /// Serializes this EvalSample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSample&&const DeepCollectionEquality().equals(other.id, id)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&const DeepCollectionEquality().equals(other.input, input)&&const DeepCollectionEquality().equals(other.choices, choices)&&const DeepCollectionEquality().equals(other.target, target)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other.files, files)&&(identical(other.setup, setup) || other.setup == setup)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.output, output) || other.output == output)&&const DeepCollectionEquality().equals(other.scores, scores)&&const DeepCollectionEquality().equals(other.store, store)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.modelUsage, modelUsage)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&(identical(other.workingTime, workingTime) || other.workingTime == workingTime)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.invalidation, invalidation) || other.invalidation == invalidation)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.errorRetries, errorRetries)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),epoch,const DeepCollectionEquality().hash(input),const DeepCollectionEquality().hash(choices),const DeepCollectionEquality().hash(target),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(files),setup,const DeepCollectionEquality().hash(messages),output,const DeepCollectionEquality().hash(scores),const DeepCollectionEquality().hash(store),const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(modelUsage),startedAt,completedAt,totalTime,workingTime,uuid,invalidation,error,const DeepCollectionEquality().hash(errorRetries),const DeepCollectionEquality().hash(attachments),limit]);

@override
String toString() {
  return 'EvalSample(id: $id, epoch: $epoch, input: $input, choices: $choices, target: $target, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup, messages: $messages, output: $output, scores: $scores, store: $store, events: $events, modelUsage: $modelUsage, startedAt: $startedAt, completedAt: $completedAt, totalTime: $totalTime, workingTime: $workingTime, uuid: $uuid, invalidation: $invalidation, error: $error, errorRetries: $errorRetries, attachments: $attachments, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $EvalSampleCopyWith<$Res>  {
  factory $EvalSampleCopyWith(EvalSample value, $Res Function(EvalSample) _then) = _$EvalSampleCopyWithImpl;
@useResult
$Res call({
 Object id, int epoch, Object input, List<String>? choices, Object? target, Map<String, dynamic> metadata, Object? sandbox, List<String>? files, String? setup, List<ChatMessage> messages, ModelOutput output, Map<String, Score>? scores, Map<String, dynamic> store, List<Object> events,@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> modelUsage,@JsonKey(name: 'started_at') String? startedAt,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'total_time') double? totalTime,@JsonKey(name: 'working_time') double? workingTime, String? uuid, ProvenanceData? invalidation, EvalError? error,@JsonKey(name: 'error_retries') List<EvalError>? errorRetries, Map<String, String> attachments, EvalSampleLimit? limit
});


$ModelOutputCopyWith<$Res> get output;$ProvenanceDataCopyWith<$Res>? get invalidation;$EvalErrorCopyWith<$Res>? get error;$EvalSampleLimitCopyWith<$Res>? get limit;

}
/// @nodoc
class _$EvalSampleCopyWithImpl<$Res>
    implements $EvalSampleCopyWith<$Res> {
  _$EvalSampleCopyWithImpl(this._self, this._then);

  final EvalSample _self;
  final $Res Function(EvalSample) _then;

/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? epoch = null,Object? input = null,Object? choices = freezed,Object? target = freezed,Object? metadata = null,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,Object? messages = null,Object? output = null,Object? scores = freezed,Object? store = null,Object? events = null,Object? modelUsage = null,Object? startedAt = freezed,Object? completedAt = freezed,Object? totalTime = freezed,Object? workingTime = freezed,Object? uuid = freezed,Object? invalidation = freezed,Object? error = freezed,Object? errorRetries = freezed,Object? attachments = null,Object? limit = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id ,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,input: null == input ? _self.input : input ,choices: freezed == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,target: freezed == target ? _self.target : target ,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,files: freezed == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<String>?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as ModelOutput,scores: freezed == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, Score>?,store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<Object>,modelUsage: null == modelUsage ? _self.modelUsage : modelUsage // ignore: cast_nullable_to_non_nullable
as Map<String, ModelUsage>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalTime: freezed == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as double?,workingTime: freezed == workingTime ? _self.workingTime : workingTime // ignore: cast_nullable_to_non_nullable
as double?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,invalidation: freezed == invalidation ? _self.invalidation : invalidation // ignore: cast_nullable_to_non_nullable
as ProvenanceData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as EvalError?,errorRetries: freezed == errorRetries ? _self.errorRetries : errorRetries // ignore: cast_nullable_to_non_nullable
as List<EvalError>?,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as Map<String, String>,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as EvalSampleLimit?,
  ));
}
/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelOutputCopyWith<$Res> get output {
  
  return $ModelOutputCopyWith<$Res>(_self.output, (value) {
    return _then(_self.copyWith(output: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProvenanceDataCopyWith<$Res>? get invalidation {
    if (_self.invalidation == null) {
    return null;
  }

  return $ProvenanceDataCopyWith<$Res>(_self.invalidation!, (value) {
    return _then(_self.copyWith(invalidation: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $EvalErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSampleLimitCopyWith<$Res>? get limit {
    if (_self.limit == null) {
    return null;
  }

  return $EvalSampleLimitCopyWith<$Res>(_self.limit!, (value) {
    return _then(_self.copyWith(limit: value));
  });
}
}


/// Adds pattern-matching-related methods to [EvalSample].
extension EvalSamplePatterns on EvalSample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSample value)  $default,){
final _that = this;
switch (_that) {
case _EvalSample():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSample value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object id,  int epoch,  Object input,  List<String>? choices,  Object? target,  Map<String, dynamic> metadata,  Object? sandbox,  List<String>? files,  String? setup,  List<ChatMessage> messages,  ModelOutput output,  Map<String, Score>? scores,  Map<String, dynamic> store,  List<Object> events, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage, @JsonKey(name: 'started_at')  String? startedAt, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'total_time')  double? totalTime, @JsonKey(name: 'working_time')  double? workingTime,  String? uuid,  ProvenanceData? invalidation,  EvalError? error, @JsonKey(name: 'error_retries')  List<EvalError>? errorRetries,  Map<String, String> attachments,  EvalSampleLimit? limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSample() when $default != null:
return $default(_that.id,_that.epoch,_that.input,_that.choices,_that.target,_that.metadata,_that.sandbox,_that.files,_that.setup,_that.messages,_that.output,_that.scores,_that.store,_that.events,_that.modelUsage,_that.startedAt,_that.completedAt,_that.totalTime,_that.workingTime,_that.uuid,_that.invalidation,_that.error,_that.errorRetries,_that.attachments,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object id,  int epoch,  Object input,  List<String>? choices,  Object? target,  Map<String, dynamic> metadata,  Object? sandbox,  List<String>? files,  String? setup,  List<ChatMessage> messages,  ModelOutput output,  Map<String, Score>? scores,  Map<String, dynamic> store,  List<Object> events, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage, @JsonKey(name: 'started_at')  String? startedAt, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'total_time')  double? totalTime, @JsonKey(name: 'working_time')  double? workingTime,  String? uuid,  ProvenanceData? invalidation,  EvalError? error, @JsonKey(name: 'error_retries')  List<EvalError>? errorRetries,  Map<String, String> attachments,  EvalSampleLimit? limit)  $default,) {final _that = this;
switch (_that) {
case _EvalSample():
return $default(_that.id,_that.epoch,_that.input,_that.choices,_that.target,_that.metadata,_that.sandbox,_that.files,_that.setup,_that.messages,_that.output,_that.scores,_that.store,_that.events,_that.modelUsage,_that.startedAt,_that.completedAt,_that.totalTime,_that.workingTime,_that.uuid,_that.invalidation,_that.error,_that.errorRetries,_that.attachments,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object id,  int epoch,  Object input,  List<String>? choices,  Object? target,  Map<String, dynamic> metadata,  Object? sandbox,  List<String>? files,  String? setup,  List<ChatMessage> messages,  ModelOutput output,  Map<String, Score>? scores,  Map<String, dynamic> store,  List<Object> events, @JsonKey(name: 'model_usage', defaultValue: {})  Map<String, ModelUsage> modelUsage, @JsonKey(name: 'started_at')  String? startedAt, @JsonKey(name: 'completed_at')  String? completedAt, @JsonKey(name: 'total_time')  double? totalTime, @JsonKey(name: 'working_time')  double? workingTime,  String? uuid,  ProvenanceData? invalidation,  EvalError? error, @JsonKey(name: 'error_retries')  List<EvalError>? errorRetries,  Map<String, String> attachments,  EvalSampleLimit? limit)?  $default,) {final _that = this;
switch (_that) {
case _EvalSample() when $default != null:
return $default(_that.id,_that.epoch,_that.input,_that.choices,_that.target,_that.metadata,_that.sandbox,_that.files,_that.setup,_that.messages,_that.output,_that.scores,_that.store,_that.events,_that.modelUsage,_that.startedAt,_that.completedAt,_that.totalTime,_that.workingTime,_that.uuid,_that.invalidation,_that.error,_that.errorRetries,_that.attachments,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSample extends EvalSample {
  const _EvalSample({required this.id, required this.epoch, required this.input, final  List<String>? choices, this.target, final  Map<String, dynamic> metadata = const {}, this.sandbox, final  List<String>? files, this.setup, final  List<ChatMessage> messages = const [], required this.output, final  Map<String, Score>? scores, final  Map<String, dynamic> store = const {}, final  List<Object> events = const [], @JsonKey(name: 'model_usage', defaultValue: {}) final  Map<String, ModelUsage> modelUsage = const {}, @JsonKey(name: 'started_at') this.startedAt, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'total_time') this.totalTime, @JsonKey(name: 'working_time') this.workingTime, this.uuid, this.invalidation, this.error, @JsonKey(name: 'error_retries') final  List<EvalError>? errorRetries, final  Map<String, String> attachments = const {}, this.limit}): _choices = choices,_metadata = metadata,_files = files,_messages = messages,_scores = scores,_store = store,_events = events,_modelUsage = modelUsage,_errorRetries = errorRetries,_attachments = attachments,super._();
  factory _EvalSample.fromJson(Map<String, dynamic> json) => _$EvalSampleFromJson(json);

/// Unique id for sample.
@override final  Object id;
/// Epoch number for sample.
@override final  int epoch;
/// Sample input.
@override final  Object input;
/// Sample choices.
 final  List<String>? _choices;
/// Sample choices.
@override List<String>? get choices {
  final value = _choices;
  if (value == null) return null;
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Sample target value(s).
@override final  Object? target;
/// Additional sample metadata.
 final  Map<String, dynamic> _metadata;
/// Additional sample metadata.
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Sandbox environment type and optional config file.
@override final  Object? sandbox;
/// Files that go along with the sample (copied to SandboxEnvironment).
 final  List<String>? _files;
/// Files that go along with the sample (copied to SandboxEnvironment).
@override List<String>? get files {
  final value = _files;
  if (value == null) return null;
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Setup script to run for sample (run within default SandboxEnvironment).
@override final  String? setup;
/// Chat conversation history for sample.
 final  List<ChatMessage> _messages;
/// Chat conversation history for sample.
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

/// Model output from sample.
@override final  ModelOutput output;
/// Scores for sample.
 final  Map<String, Score>? _scores;
/// Scores for sample.
@override Map<String, Score>? get scores {
  final value = _scores;
  if (value == null) return null;
  if (_scores is EqualUnmodifiableMapView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// State at end of sample execution.
 final  Map<String, dynamic> _store;
/// State at end of sample execution.
@override@JsonKey() Map<String, dynamic> get store {
  if (_store is EqualUnmodifiableMapView) return _store;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_store);
}

/// Events that occurred during sample execution.
 final  List<Object> _events;
/// Events that occurred during sample execution.
@override@JsonKey() List<Object> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

/// Model token usage for sample.
 final  Map<String, ModelUsage> _modelUsage;
/// Model token usage for sample.
@override@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> get modelUsage {
  if (_modelUsage is EqualUnmodifiableMapView) return _modelUsage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modelUsage);
}

/// Time sample started.
@override@JsonKey(name: 'started_at') final  String? startedAt;
/// Time sample completed.
@override@JsonKey(name: 'completed_at') final  String? completedAt;
/// Total time that the sample was running.
@override@JsonKey(name: 'total_time') final  double? totalTime;
/// Time spent working (model generation, sandbox calls, etc.).
@override@JsonKey(name: 'working_time') final  double? workingTime;
/// Globally unique identifier for sample run.
@override final  String? uuid;
/// Provenance data for invalidation.
@override final  ProvenanceData? invalidation;
/// Error that halted sample.
@override final  EvalError? error;
/// Errors that were retried for this sample.
 final  List<EvalError>? _errorRetries;
/// Errors that were retried for this sample.
@override@JsonKey(name: 'error_retries') List<EvalError>? get errorRetries {
  final value = _errorRetries;
  if (value == null) return null;
  if (_errorRetries is EqualUnmodifiableListView) return _errorRetries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Attachments referenced from messages and events.
 final  Map<String, String> _attachments;
/// Attachments referenced from messages and events.
@override@JsonKey() Map<String, String> get attachments {
  if (_attachments is EqualUnmodifiableMapView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attachments);
}

/// The limit that halted the sample.
@override final  EvalSampleLimit? limit;

/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSampleCopyWith<_EvalSample> get copyWith => __$EvalSampleCopyWithImpl<_EvalSample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSample&&const DeepCollectionEquality().equals(other.id, id)&&(identical(other.epoch, epoch) || other.epoch == epoch)&&const DeepCollectionEquality().equals(other.input, input)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other.target, target)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other._files, _files)&&(identical(other.setup, setup) || other.setup == setup)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.output, output) || other.output == output)&&const DeepCollectionEquality().equals(other._scores, _scores)&&const DeepCollectionEquality().equals(other._store, _store)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._modelUsage, _modelUsage)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalTime, totalTime) || other.totalTime == totalTime)&&(identical(other.workingTime, workingTime) || other.workingTime == workingTime)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.invalidation, invalidation) || other.invalidation == invalidation)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._errorRetries, _errorRetries)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(id),epoch,const DeepCollectionEquality().hash(input),const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(target),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(_files),setup,const DeepCollectionEquality().hash(_messages),output,const DeepCollectionEquality().hash(_scores),const DeepCollectionEquality().hash(_store),const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_modelUsage),startedAt,completedAt,totalTime,workingTime,uuid,invalidation,error,const DeepCollectionEquality().hash(_errorRetries),const DeepCollectionEquality().hash(_attachments),limit]);

@override
String toString() {
  return 'EvalSample(id: $id, epoch: $epoch, input: $input, choices: $choices, target: $target, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup, messages: $messages, output: $output, scores: $scores, store: $store, events: $events, modelUsage: $modelUsage, startedAt: $startedAt, completedAt: $completedAt, totalTime: $totalTime, workingTime: $workingTime, uuid: $uuid, invalidation: $invalidation, error: $error, errorRetries: $errorRetries, attachments: $attachments, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$EvalSampleCopyWith<$Res> implements $EvalSampleCopyWith<$Res> {
  factory _$EvalSampleCopyWith(_EvalSample value, $Res Function(_EvalSample) _then) = __$EvalSampleCopyWithImpl;
@override @useResult
$Res call({
 Object id, int epoch, Object input, List<String>? choices, Object? target, Map<String, dynamic> metadata, Object? sandbox, List<String>? files, String? setup, List<ChatMessage> messages, ModelOutput output, Map<String, Score>? scores, Map<String, dynamic> store, List<Object> events,@JsonKey(name: 'model_usage', defaultValue: {}) Map<String, ModelUsage> modelUsage,@JsonKey(name: 'started_at') String? startedAt,@JsonKey(name: 'completed_at') String? completedAt,@JsonKey(name: 'total_time') double? totalTime,@JsonKey(name: 'working_time') double? workingTime, String? uuid, ProvenanceData? invalidation, EvalError? error,@JsonKey(name: 'error_retries') List<EvalError>? errorRetries, Map<String, String> attachments, EvalSampleLimit? limit
});


@override $ModelOutputCopyWith<$Res> get output;@override $ProvenanceDataCopyWith<$Res>? get invalidation;@override $EvalErrorCopyWith<$Res>? get error;@override $EvalSampleLimitCopyWith<$Res>? get limit;

}
/// @nodoc
class __$EvalSampleCopyWithImpl<$Res>
    implements _$EvalSampleCopyWith<$Res> {
  __$EvalSampleCopyWithImpl(this._self, this._then);

  final _EvalSample _self;
  final $Res Function(_EvalSample) _then;

/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? epoch = null,Object? input = null,Object? choices = freezed,Object? target = freezed,Object? metadata = null,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,Object? messages = null,Object? output = null,Object? scores = freezed,Object? store = null,Object? events = null,Object? modelUsage = null,Object? startedAt = freezed,Object? completedAt = freezed,Object? totalTime = freezed,Object? workingTime = freezed,Object? uuid = freezed,Object? invalidation = freezed,Object? error = freezed,Object? errorRetries = freezed,Object? attachments = null,Object? limit = freezed,}) {
  return _then(_EvalSample(
id: null == id ? _self.id : id ,epoch: null == epoch ? _self.epoch : epoch // ignore: cast_nullable_to_non_nullable
as int,input: null == input ? _self.input : input ,choices: freezed == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,target: freezed == target ? _self.target : target ,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,files: freezed == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<String>?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as ModelOutput,scores: freezed == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, Score>?,store: null == store ? _self._store : store // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Object>,modelUsage: null == modelUsage ? _self._modelUsage : modelUsage // ignore: cast_nullable_to_non_nullable
as Map<String, ModelUsage>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalTime: freezed == totalTime ? _self.totalTime : totalTime // ignore: cast_nullable_to_non_nullable
as double?,workingTime: freezed == workingTime ? _self.workingTime : workingTime // ignore: cast_nullable_to_non_nullable
as double?,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,invalidation: freezed == invalidation ? _self.invalidation : invalidation // ignore: cast_nullable_to_non_nullable
as ProvenanceData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as EvalError?,errorRetries: freezed == errorRetries ? _self._errorRetries : errorRetries // ignore: cast_nullable_to_non_nullable
as List<EvalError>?,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as Map<String, String>,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as EvalSampleLimit?,
  ));
}

/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelOutputCopyWith<$Res> get output {
  
  return $ModelOutputCopyWith<$Res>(_self.output, (value) {
    return _then(_self.copyWith(output: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProvenanceDataCopyWith<$Res>? get invalidation {
    if (_self.invalidation == null) {
    return null;
  }

  return $ProvenanceDataCopyWith<$Res>(_self.invalidation!, (value) {
    return _then(_self.copyWith(invalidation: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $EvalErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of EvalSample
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvalSampleLimitCopyWith<$Res>? get limit {
    if (_self.limit == null) {
    return null;
  }

  return $EvalSampleLimitCopyWith<$Res>(_self.limit!, (value) {
    return _then(_self.copyWith(limit: value));
  });
}
}


/// @nodoc
mixin _$ModelOutput {

/// Model used for generation.
 String get model;/// Completion choices.
 List<ChatCompletionChoice> get choices;/// Model token usage.
 ModelUsage? get usage;/// Model completion.
 String get completion;/// First message stop reason.
@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String get stopReason;/// Time elapsed (in seconds) for call to generate.
 double? get time;/// Additional metadata associated with model output.
 Map<String, dynamic> get metadata;/// Error message in the case of content moderation refusals.
 String? get error;/// First message choice.
 ChatMessageAssistant? get message;
/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelOutputCopyWith<ModelOutput> get copyWith => _$ModelOutputCopyWithImpl<ModelOutput>(this as ModelOutput, _$identity);

  /// Serializes this ModelOutput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelOutput&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.choices, choices)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.completion, completion) || other.completion == completion)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.message, message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(choices),usage,completion,stopReason,time,const DeepCollectionEquality().hash(metadata),error,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'ModelOutput(model: $model, choices: $choices, usage: $usage, completion: $completion, stopReason: $stopReason, time: $time, metadata: $metadata, error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class $ModelOutputCopyWith<$Res>  {
  factory $ModelOutputCopyWith(ModelOutput value, $Res Function(ModelOutput) _then) = _$ModelOutputCopyWithImpl;
@useResult
$Res call({
 String model, List<ChatCompletionChoice> choices, ModelUsage? usage, String completion,@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String stopReason, double? time, Map<String, dynamic> metadata, String? error, ChatMessageAssistant? message
});


$ModelUsageCopyWith<$Res>? get usage;

}
/// @nodoc
class _$ModelOutputCopyWithImpl<$Res>
    implements $ModelOutputCopyWith<$Res> {
  _$ModelOutputCopyWithImpl(this._self, this._then);

  final ModelOutput _self;
  final $Res Function(ModelOutput) _then;

/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? choices = null,Object? usage = freezed,Object? completion = null,Object? stopReason = null,Object? time = freezed,Object? metadata = null,Object? error = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<ChatCompletionChoice>,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as ModelUsage?,completion: null == completion ? _self.completion : completion // ignore: cast_nullable_to_non_nullable
as String,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as double?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessageAssistant?,
  ));
}
/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelUsageCopyWith<$Res>? get usage {
    if (_self.usage == null) {
    return null;
  }

  return $ModelUsageCopyWith<$Res>(_self.usage!, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ModelOutput].
extension ModelOutputPatterns on ModelOutput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelOutput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelOutput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelOutput value)  $default,){
final _that = this;
switch (_that) {
case _ModelOutput():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelOutput value)?  $default,){
final _that = this;
switch (_that) {
case _ModelOutput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  List<ChatCompletionChoice> choices,  ModelUsage? usage,  String completion, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  double? time,  Map<String, dynamic> metadata,  String? error,  ChatMessageAssistant? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelOutput() when $default != null:
return $default(_that.model,_that.choices,_that.usage,_that.completion,_that.stopReason,_that.time,_that.metadata,_that.error,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  List<ChatCompletionChoice> choices,  ModelUsage? usage,  String completion, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  double? time,  Map<String, dynamic> metadata,  String? error,  ChatMessageAssistant? message)  $default,) {final _that = this;
switch (_that) {
case _ModelOutput():
return $default(_that.model,_that.choices,_that.usage,_that.completion,_that.stopReason,_that.time,_that.metadata,_that.error,_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  List<ChatCompletionChoice> choices,  ModelUsage? usage,  String completion, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  double? time,  Map<String, dynamic> metadata,  String? error,  ChatMessageAssistant? message)?  $default,) {final _that = this;
switch (_that) {
case _ModelOutput() when $default != null:
return $default(_that.model,_that.choices,_that.usage,_that.completion,_that.stopReason,_that.time,_that.metadata,_that.error,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelOutput extends ModelOutput {
  const _ModelOutput({required this.model, final  List<ChatCompletionChoice> choices = const [], this.usage, required this.completion, @JsonKey(name: 'stop_reason', defaultValue: 'unknown') this.stopReason = 'unknown', this.time, final  Map<String, dynamic> metadata = const {}, this.error, this.message}): _choices = choices,_metadata = metadata,super._();
  factory _ModelOutput.fromJson(Map<String, dynamic> json) => _$ModelOutputFromJson(json);

/// Model used for generation.
@override final  String model;
/// Completion choices.
 final  List<ChatCompletionChoice> _choices;
/// Completion choices.
@override@JsonKey() List<ChatCompletionChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

/// Model token usage.
@override final  ModelUsage? usage;
/// Model completion.
@override final  String completion;
/// First message stop reason.
@override@JsonKey(name: 'stop_reason', defaultValue: 'unknown') final  String stopReason;
/// Time elapsed (in seconds) for call to generate.
@override final  double? time;
/// Additional metadata associated with model output.
 final  Map<String, dynamic> _metadata;
/// Additional metadata associated with model output.
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Error message in the case of content moderation refusals.
@override final  String? error;
/// First message choice.
@override final  ChatMessageAssistant? message;

/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelOutputCopyWith<_ModelOutput> get copyWith => __$ModelOutputCopyWithImpl<_ModelOutput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelOutputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelOutput&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.completion, completion) || other.completion == completion)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.message, message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(_choices),usage,completion,stopReason,time,const DeepCollectionEquality().hash(_metadata),error,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'ModelOutput(model: $model, choices: $choices, usage: $usage, completion: $completion, stopReason: $stopReason, time: $time, metadata: $metadata, error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ModelOutputCopyWith<$Res> implements $ModelOutputCopyWith<$Res> {
  factory _$ModelOutputCopyWith(_ModelOutput value, $Res Function(_ModelOutput) _then) = __$ModelOutputCopyWithImpl;
@override @useResult
$Res call({
 String model, List<ChatCompletionChoice> choices, ModelUsage? usage, String completion,@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String stopReason, double? time, Map<String, dynamic> metadata, String? error, ChatMessageAssistant? message
});


@override $ModelUsageCopyWith<$Res>? get usage;

}
/// @nodoc
class __$ModelOutputCopyWithImpl<$Res>
    implements _$ModelOutputCopyWith<$Res> {
  __$ModelOutputCopyWithImpl(this._self, this._then);

  final _ModelOutput _self;
  final $Res Function(_ModelOutput) _then;

/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? choices = null,Object? usage = freezed,Object? completion = null,Object? stopReason = null,Object? time = freezed,Object? metadata = null,Object? error = freezed,Object? message = freezed,}) {
  return _then(_ModelOutput(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<ChatCompletionChoice>,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as ModelUsage?,completion: null == completion ? _self.completion : completion // ignore: cast_nullable_to_non_nullable
as String,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as double?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessageAssistant?,
  ));
}

/// Create a copy of ModelOutput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelUsageCopyWith<$Res>? get usage {
    if (_self.usage == null) {
    return null;
  }

  return $ModelUsageCopyWith<$Res>(_self.usage!, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}


/// @nodoc
mixin _$ChatCompletionChoice {

/// Assistant message.
 ChatMessageAssistant get message;/// Reason that the model stopped generating.
@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String get stopReason;/// Logprobs.
 Logprobs? get logprobs;
/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionChoiceCopyWith<ChatCompletionChoice> get copyWith => _$ChatCompletionChoiceCopyWithImpl<ChatCompletionChoice>(this as ChatCompletionChoice, _$identity);

  /// Serializes this ChatCompletionChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletionChoice&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.logprobs, logprobs) || other.logprobs == logprobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message),stopReason,logprobs);

@override
String toString() {
  return 'ChatCompletionChoice(message: $message, stopReason: $stopReason, logprobs: $logprobs)';
}


}

/// @nodoc
abstract mixin class $ChatCompletionChoiceCopyWith<$Res>  {
  factory $ChatCompletionChoiceCopyWith(ChatCompletionChoice value, $Res Function(ChatCompletionChoice) _then) = _$ChatCompletionChoiceCopyWithImpl;
@useResult
$Res call({
 ChatMessageAssistant message,@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String stopReason, Logprobs? logprobs
});


$LogprobsCopyWith<$Res>? get logprobs;

}
/// @nodoc
class _$ChatCompletionChoiceCopyWithImpl<$Res>
    implements $ChatCompletionChoiceCopyWith<$Res> {
  _$ChatCompletionChoiceCopyWithImpl(this._self, this._then);

  final ChatCompletionChoice _self;
  final $Res Function(ChatCompletionChoice) _then;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? stopReason = null,Object? logprobs = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessageAssistant,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as String,logprobs: freezed == logprobs ? _self.logprobs : logprobs // ignore: cast_nullable_to_non_nullable
as Logprobs?,
  ));
}
/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LogprobsCopyWith<$Res>? get logprobs {
    if (_self.logprobs == null) {
    return null;
  }

  return $LogprobsCopyWith<$Res>(_self.logprobs!, (value) {
    return _then(_self.copyWith(logprobs: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatCompletionChoice].
extension ChatCompletionChoicePatterns on ChatCompletionChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCompletionChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCompletionChoice value)  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionChoice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCompletionChoice value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatMessageAssistant message, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  Logprobs? logprobs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
return $default(_that.message,_that.stopReason,_that.logprobs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatMessageAssistant message, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  Logprobs? logprobs)  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionChoice():
return $default(_that.message,_that.stopReason,_that.logprobs);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatMessageAssistant message, @JsonKey(name: 'stop_reason', defaultValue: 'unknown')  String stopReason,  Logprobs? logprobs)?  $default,) {final _that = this;
switch (_that) {
case _ChatCompletionChoice() when $default != null:
return $default(_that.message,_that.stopReason,_that.logprobs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatCompletionChoice extends ChatCompletionChoice {
  const _ChatCompletionChoice({required this.message, @JsonKey(name: 'stop_reason', defaultValue: 'unknown') this.stopReason = 'unknown', this.logprobs}): super._();
  factory _ChatCompletionChoice.fromJson(Map<String, dynamic> json) => _$ChatCompletionChoiceFromJson(json);

/// Assistant message.
@override final  ChatMessageAssistant message;
/// Reason that the model stopped generating.
@override@JsonKey(name: 'stop_reason', defaultValue: 'unknown') final  String stopReason;
/// Logprobs.
@override final  Logprobs? logprobs;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionChoiceCopyWith<_ChatCompletionChoice> get copyWith => __$ChatCompletionChoiceCopyWithImpl<_ChatCompletionChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatCompletionChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletionChoice&&const DeepCollectionEquality().equals(other.message, message)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.logprobs, logprobs) || other.logprobs == logprobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message),stopReason,logprobs);

@override
String toString() {
  return 'ChatCompletionChoice(message: $message, stopReason: $stopReason, logprobs: $logprobs)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionChoiceCopyWith<$Res> implements $ChatCompletionChoiceCopyWith<$Res> {
  factory _$ChatCompletionChoiceCopyWith(_ChatCompletionChoice value, $Res Function(_ChatCompletionChoice) _then) = __$ChatCompletionChoiceCopyWithImpl;
@override @useResult
$Res call({
 ChatMessageAssistant message,@JsonKey(name: 'stop_reason', defaultValue: 'unknown') String stopReason, Logprobs? logprobs
});


@override $LogprobsCopyWith<$Res>? get logprobs;

}
/// @nodoc
class __$ChatCompletionChoiceCopyWithImpl<$Res>
    implements _$ChatCompletionChoiceCopyWith<$Res> {
  __$ChatCompletionChoiceCopyWithImpl(this._self, this._then);

  final _ChatCompletionChoice _self;
  final $Res Function(_ChatCompletionChoice) _then;

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? stopReason = null,Object? logprobs = freezed,}) {
  return _then(_ChatCompletionChoice(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessageAssistant,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as String,logprobs: freezed == logprobs ? _self.logprobs : logprobs // ignore: cast_nullable_to_non_nullable
as Logprobs?,
  ));
}

/// Create a copy of ChatCompletionChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LogprobsCopyWith<$Res>? get logprobs {
    if (_self.logprobs == null) {
    return null;
  }

  return $LogprobsCopyWith<$Res>(_self.logprobs!, (value) {
    return _then(_self.copyWith(logprobs: value));
  });
}
}


/// @nodoc
mixin _$ModelUsage {

/// Total input tokens used.
@JsonKey(name: 'input_tokens', defaultValue: 0) int get inputTokens;/// Total output tokens used.
@JsonKey(name: 'output_tokens', defaultValue: 0) int get outputTokens;/// Total tokens used.
@JsonKey(name: 'total_tokens', defaultValue: 0) int get totalTokens;/// Number of tokens written to the cache.
@JsonKey(name: 'input_tokens_cache_write') int? get inputTokensCacheWrite;/// Number of tokens retrieved from the cache.
@JsonKey(name: 'input_tokens_cache_read') int? get inputTokensCacheRead;/// Number of tokens used for reasoning.
@JsonKey(name: 'reasoning_tokens', defaultValue: 0) int get reasoningTokens;
/// Create a copy of ModelUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelUsageCopyWith<ModelUsage> get copyWith => _$ModelUsageCopyWithImpl<ModelUsage>(this as ModelUsage, _$identity);

  /// Serializes this ModelUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelUsage&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.inputTokensCacheWrite, inputTokensCacheWrite) || other.inputTokensCacheWrite == inputTokensCacheWrite)&&(identical(other.inputTokensCacheRead, inputTokensCacheRead) || other.inputTokensCacheRead == inputTokensCacheRead)&&(identical(other.reasoningTokens, reasoningTokens) || other.reasoningTokens == reasoningTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inputTokens,outputTokens,totalTokens,inputTokensCacheWrite,inputTokensCacheRead,reasoningTokens);

@override
String toString() {
  return 'ModelUsage(inputTokens: $inputTokens, outputTokens: $outputTokens, totalTokens: $totalTokens, inputTokensCacheWrite: $inputTokensCacheWrite, inputTokensCacheRead: $inputTokensCacheRead, reasoningTokens: $reasoningTokens)';
}


}

/// @nodoc
abstract mixin class $ModelUsageCopyWith<$Res>  {
  factory $ModelUsageCopyWith(ModelUsage value, $Res Function(ModelUsage) _then) = _$ModelUsageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'input_tokens', defaultValue: 0) int inputTokens,@JsonKey(name: 'output_tokens', defaultValue: 0) int outputTokens,@JsonKey(name: 'total_tokens', defaultValue: 0) int totalTokens,@JsonKey(name: 'input_tokens_cache_write') int? inputTokensCacheWrite,@JsonKey(name: 'input_tokens_cache_read') int? inputTokensCacheRead,@JsonKey(name: 'reasoning_tokens', defaultValue: 0) int reasoningTokens
});




}
/// @nodoc
class _$ModelUsageCopyWithImpl<$Res>
    implements $ModelUsageCopyWith<$Res> {
  _$ModelUsageCopyWithImpl(this._self, this._then);

  final ModelUsage _self;
  final $Res Function(ModelUsage) _then;

/// Create a copy of ModelUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inputTokens = null,Object? outputTokens = null,Object? totalTokens = null,Object? inputTokensCacheWrite = freezed,Object? inputTokensCacheRead = freezed,Object? reasoningTokens = null,}) {
  return _then(_self.copyWith(
inputTokens: null == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int,outputTokens: null == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,inputTokensCacheWrite: freezed == inputTokensCacheWrite ? _self.inputTokensCacheWrite : inputTokensCacheWrite // ignore: cast_nullable_to_non_nullable
as int?,inputTokensCacheRead: freezed == inputTokensCacheRead ? _self.inputTokensCacheRead : inputTokensCacheRead // ignore: cast_nullable_to_non_nullable
as int?,reasoningTokens: null == reasoningTokens ? _self.reasoningTokens : reasoningTokens // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelUsage].
extension ModelUsagePatterns on ModelUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelUsage value)  $default,){
final _that = this;
switch (_that) {
case _ModelUsage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelUsage value)?  $default,){
final _that = this;
switch (_that) {
case _ModelUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'input_tokens', defaultValue: 0)  int inputTokens, @JsonKey(name: 'output_tokens', defaultValue: 0)  int outputTokens, @JsonKey(name: 'total_tokens', defaultValue: 0)  int totalTokens, @JsonKey(name: 'input_tokens_cache_write')  int? inputTokensCacheWrite, @JsonKey(name: 'input_tokens_cache_read')  int? inputTokensCacheRead, @JsonKey(name: 'reasoning_tokens', defaultValue: 0)  int reasoningTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelUsage() when $default != null:
return $default(_that.inputTokens,_that.outputTokens,_that.totalTokens,_that.inputTokensCacheWrite,_that.inputTokensCacheRead,_that.reasoningTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'input_tokens', defaultValue: 0)  int inputTokens, @JsonKey(name: 'output_tokens', defaultValue: 0)  int outputTokens, @JsonKey(name: 'total_tokens', defaultValue: 0)  int totalTokens, @JsonKey(name: 'input_tokens_cache_write')  int? inputTokensCacheWrite, @JsonKey(name: 'input_tokens_cache_read')  int? inputTokensCacheRead, @JsonKey(name: 'reasoning_tokens', defaultValue: 0)  int reasoningTokens)  $default,) {final _that = this;
switch (_that) {
case _ModelUsage():
return $default(_that.inputTokens,_that.outputTokens,_that.totalTokens,_that.inputTokensCacheWrite,_that.inputTokensCacheRead,_that.reasoningTokens);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'input_tokens', defaultValue: 0)  int inputTokens, @JsonKey(name: 'output_tokens', defaultValue: 0)  int outputTokens, @JsonKey(name: 'total_tokens', defaultValue: 0)  int totalTokens, @JsonKey(name: 'input_tokens_cache_write')  int? inputTokensCacheWrite, @JsonKey(name: 'input_tokens_cache_read')  int? inputTokensCacheRead, @JsonKey(name: 'reasoning_tokens', defaultValue: 0)  int reasoningTokens)?  $default,) {final _that = this;
switch (_that) {
case _ModelUsage() when $default != null:
return $default(_that.inputTokens,_that.outputTokens,_that.totalTokens,_that.inputTokensCacheWrite,_that.inputTokensCacheRead,_that.reasoningTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelUsage extends ModelUsage {
  const _ModelUsage({@JsonKey(name: 'input_tokens', defaultValue: 0) this.inputTokens = 0, @JsonKey(name: 'output_tokens', defaultValue: 0) this.outputTokens = 0, @JsonKey(name: 'total_tokens', defaultValue: 0) this.totalTokens = 0, @JsonKey(name: 'input_tokens_cache_write') this.inputTokensCacheWrite, @JsonKey(name: 'input_tokens_cache_read') this.inputTokensCacheRead, @JsonKey(name: 'reasoning_tokens', defaultValue: 0) this.reasoningTokens = 0}): super._();
  factory _ModelUsage.fromJson(Map<String, dynamic> json) => _$ModelUsageFromJson(json);

/// Total input tokens used.
@override@JsonKey(name: 'input_tokens', defaultValue: 0) final  int inputTokens;
/// Total output tokens used.
@override@JsonKey(name: 'output_tokens', defaultValue: 0) final  int outputTokens;
/// Total tokens used.
@override@JsonKey(name: 'total_tokens', defaultValue: 0) final  int totalTokens;
/// Number of tokens written to the cache.
@override@JsonKey(name: 'input_tokens_cache_write') final  int? inputTokensCacheWrite;
/// Number of tokens retrieved from the cache.
@override@JsonKey(name: 'input_tokens_cache_read') final  int? inputTokensCacheRead;
/// Number of tokens used for reasoning.
@override@JsonKey(name: 'reasoning_tokens', defaultValue: 0) final  int reasoningTokens;

/// Create a copy of ModelUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelUsageCopyWith<_ModelUsage> get copyWith => __$ModelUsageCopyWithImpl<_ModelUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelUsage&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.inputTokensCacheWrite, inputTokensCacheWrite) || other.inputTokensCacheWrite == inputTokensCacheWrite)&&(identical(other.inputTokensCacheRead, inputTokensCacheRead) || other.inputTokensCacheRead == inputTokensCacheRead)&&(identical(other.reasoningTokens, reasoningTokens) || other.reasoningTokens == reasoningTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inputTokens,outputTokens,totalTokens,inputTokensCacheWrite,inputTokensCacheRead,reasoningTokens);

@override
String toString() {
  return 'ModelUsage(inputTokens: $inputTokens, outputTokens: $outputTokens, totalTokens: $totalTokens, inputTokensCacheWrite: $inputTokensCacheWrite, inputTokensCacheRead: $inputTokensCacheRead, reasoningTokens: $reasoningTokens)';
}


}

/// @nodoc
abstract mixin class _$ModelUsageCopyWith<$Res> implements $ModelUsageCopyWith<$Res> {
  factory _$ModelUsageCopyWith(_ModelUsage value, $Res Function(_ModelUsage) _then) = __$ModelUsageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'input_tokens', defaultValue: 0) int inputTokens,@JsonKey(name: 'output_tokens', defaultValue: 0) int outputTokens,@JsonKey(name: 'total_tokens', defaultValue: 0) int totalTokens,@JsonKey(name: 'input_tokens_cache_write') int? inputTokensCacheWrite,@JsonKey(name: 'input_tokens_cache_read') int? inputTokensCacheRead,@JsonKey(name: 'reasoning_tokens', defaultValue: 0) int reasoningTokens
});




}
/// @nodoc
class __$ModelUsageCopyWithImpl<$Res>
    implements _$ModelUsageCopyWith<$Res> {
  __$ModelUsageCopyWithImpl(this._self, this._then);

  final _ModelUsage _self;
  final $Res Function(_ModelUsage) _then;

/// Create a copy of ModelUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inputTokens = null,Object? outputTokens = null,Object? totalTokens = null,Object? inputTokensCacheWrite = freezed,Object? inputTokensCacheRead = freezed,Object? reasoningTokens = null,}) {
  return _then(_ModelUsage(
inputTokens: null == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int,outputTokens: null == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,inputTokensCacheWrite: freezed == inputTokensCacheWrite ? _self.inputTokensCacheWrite : inputTokensCacheWrite // ignore: cast_nullable_to_non_nullable
as int?,inputTokensCacheRead: freezed == inputTokensCacheRead ? _self.inputTokensCacheRead : inputTokensCacheRead // ignore: cast_nullable_to_non_nullable
as int?,reasoningTokens: null == reasoningTokens ? _self.reasoningTokens : reasoningTokens // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

ChatMessage _$ChatMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['role']) {
                  case 'system':
          return ChatMessageSystem.fromJson(
            json
          );
                case 'user':
          return ChatMessageUser.fromJson(
            json
          );
                case 'assistant':
          return ChatMessageAssistant.fromJson(
            json
          );
                case 'tool':
          return ChatMessageTool.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'role',
  'ChatMessage',
  'Invalid union type "${json['role']}"!'
);
        }
      
}

/// @nodoc
mixin _$ChatMessage {

/// Unique identifer for message.
 String? get id;/// Content (simple string or list of content objects).
 Object get content;/// Source of message.
 String? get source;/// Additional message metadata.
 Map<String, dynamic>? get metadata;/// Conversation role.
 String get role;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(content),source,const DeepCollectionEquality().hash(metadata),role);

@override
String toString() {
  return 'ChatMessage(id: $id, content: $content, source: $source, metadata: $metadata, role: $role)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String? id, Object content, String? source, Map<String, dynamic>? metadata, String role
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? content = null,Object? source = freezed,Object? metadata = freezed,Object? role = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content ,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatMessageSystem value)?  system,TResult Function( ChatMessageUser value)?  user,TResult Function( ChatMessageAssistant value)?  assistant,TResult Function( ChatMessageTool value)?  tool,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatMessageSystem() when system != null:
return system(_that);case ChatMessageUser() when user != null:
return user(_that);case ChatMessageAssistant() when assistant != null:
return assistant(_that);case ChatMessageTool() when tool != null:
return tool(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatMessageSystem value)  system,required TResult Function( ChatMessageUser value)  user,required TResult Function( ChatMessageAssistant value)  assistant,required TResult Function( ChatMessageTool value)  tool,}){
final _that = this;
switch (_that) {
case ChatMessageSystem():
return system(_that);case ChatMessageUser():
return user(_that);case ChatMessageAssistant():
return assistant(_that);case ChatMessageTool():
return tool(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatMessageSystem value)?  system,TResult? Function( ChatMessageUser value)?  user,TResult? Function( ChatMessageAssistant value)?  assistant,TResult? Function( ChatMessageTool value)?  tool,}){
final _that = this;
switch (_that) {
case ChatMessageSystem() when system != null:
return system(_that);case ChatMessageUser() when user != null:
return user(_that);case ChatMessageAssistant() when assistant != null:
return assistant(_that);case ChatMessageTool() when tool != null:
return tool(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role)?  system,TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  Object? toolCallId)?  user,TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_calls')  List<ToolCall>? toolCalls,  String? model)?  assistant,TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  String? toolCallId,  String? function,  ToolCallError? error)?  tool,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatMessageSystem() when system != null:
return system(_that.id,_that.content,_that.source,_that.metadata,_that.role);case ChatMessageUser() when user != null:
return user(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId);case ChatMessageAssistant() when assistant != null:
return assistant(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCalls,_that.model);case ChatMessageTool() when tool != null:
return tool(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId,_that.function,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role)  system,required TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  Object? toolCallId)  user,required TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_calls')  List<ToolCall>? toolCalls,  String? model)  assistant,required TResult Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  String? toolCallId,  String? function,  ToolCallError? error)  tool,}) {final _that = this;
switch (_that) {
case ChatMessageSystem():
return system(_that.id,_that.content,_that.source,_that.metadata,_that.role);case ChatMessageUser():
return user(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId);case ChatMessageAssistant():
return assistant(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCalls,_that.model);case ChatMessageTool():
return tool(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId,_that.function,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role)?  system,TResult? Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  Object? toolCallId)?  user,TResult? Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_calls')  List<ToolCall>? toolCalls,  String? model)?  assistant,TResult? Function( String? id,  Object content,  String? source,  Map<String, dynamic>? metadata,  String role, @JsonKey(name: 'tool_call_id')  String? toolCallId,  String? function,  ToolCallError? error)?  tool,}) {final _that = this;
switch (_that) {
case ChatMessageSystem() when system != null:
return system(_that.id,_that.content,_that.source,_that.metadata,_that.role);case ChatMessageUser() when user != null:
return user(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId);case ChatMessageAssistant() when assistant != null:
return assistant(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCalls,_that.model);case ChatMessageTool() when tool != null:
return tool(_that.id,_that.content,_that.source,_that.metadata,_that.role,_that.toolCallId,_that.function,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ChatMessageSystem extends ChatMessage {
  const ChatMessageSystem({this.id, required this.content, this.source, final  Map<String, dynamic>? metadata, this.role = 'system'}): _metadata = metadata,super._();
  factory ChatMessageSystem.fromJson(Map<String, dynamic> json) => _$ChatMessageSystemFromJson(json);

/// Unique identifer for message.
@override final  String? id;
/// Content (simple string or list of content objects).
@override final  Object content;
/// Source of message.
@override final  String? source;
/// Additional message metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional message metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Conversation role.
@override@JsonKey() final  String role;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageSystemCopyWith<ChatMessageSystem> get copyWith => _$ChatMessageSystemCopyWithImpl<ChatMessageSystem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageSystemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageSystem&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(content),source,const DeepCollectionEquality().hash(_metadata),role);

@override
String toString() {
  return 'ChatMessage.system(id: $id, content: $content, source: $source, metadata: $metadata, role: $role)';
}


}

/// @nodoc
abstract mixin class $ChatMessageSystemCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory $ChatMessageSystemCopyWith(ChatMessageSystem value, $Res Function(ChatMessageSystem) _then) = _$ChatMessageSystemCopyWithImpl;
@override @useResult
$Res call({
 String? id, Object content, String? source, Map<String, dynamic>? metadata, String role
});




}
/// @nodoc
class _$ChatMessageSystemCopyWithImpl<$Res>
    implements $ChatMessageSystemCopyWith<$Res> {
  _$ChatMessageSystemCopyWithImpl(this._self, this._then);

  final ChatMessageSystem _self;
  final $Res Function(ChatMessageSystem) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? source = freezed,Object? metadata = freezed,Object? role = null,}) {
  return _then(ChatMessageSystem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content ,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ChatMessageUser extends ChatMessage {
  const ChatMessageUser({this.id, required this.content, this.source, final  Map<String, dynamic>? metadata, this.role = 'user', @JsonKey(name: 'tool_call_id') this.toolCallId}): _metadata = metadata,super._();
  factory ChatMessageUser.fromJson(Map<String, dynamic> json) => _$ChatMessageUserFromJson(json);

/// Unique identifer for message.
@override final  String? id;
/// Content (simple string or list of content objects).
@override final  Object content;
/// Source of message.
@override final  String? source;
/// Additional message metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional message metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Conversation role.
@override@JsonKey() final  String role;
/// ID(s) of tool call(s) this message has the content payload for.
@JsonKey(name: 'tool_call_id') final  Object? toolCallId;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageUserCopyWith<ChatMessageUser> get copyWith => _$ChatMessageUserCopyWithImpl<ChatMessageUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageUser&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.toolCallId, toolCallId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(content),source,const DeepCollectionEquality().hash(_metadata),role,const DeepCollectionEquality().hash(toolCallId));

@override
String toString() {
  return 'ChatMessage.user(id: $id, content: $content, source: $source, metadata: $metadata, role: $role, toolCallId: $toolCallId)';
}


}

/// @nodoc
abstract mixin class $ChatMessageUserCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory $ChatMessageUserCopyWith(ChatMessageUser value, $Res Function(ChatMessageUser) _then) = _$ChatMessageUserCopyWithImpl;
@override @useResult
$Res call({
 String? id, Object content, String? source, Map<String, dynamic>? metadata, String role,@JsonKey(name: 'tool_call_id') Object? toolCallId
});




}
/// @nodoc
class _$ChatMessageUserCopyWithImpl<$Res>
    implements $ChatMessageUserCopyWith<$Res> {
  _$ChatMessageUserCopyWithImpl(this._self, this._then);

  final ChatMessageUser _self;
  final $Res Function(ChatMessageUser) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? source = freezed,Object? metadata = freezed,Object? role = null,Object? toolCallId = freezed,}) {
  return _then(ChatMessageUser(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content ,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,toolCallId: freezed == toolCallId ? _self.toolCallId : toolCallId ,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ChatMessageAssistant extends ChatMessage {
  const ChatMessageAssistant({this.id, required this.content, this.source, final  Map<String, dynamic>? metadata, this.role = 'assistant', @JsonKey(name: 'tool_calls') final  List<ToolCall>? toolCalls, this.model}): _metadata = metadata,_toolCalls = toolCalls,super._();
  factory ChatMessageAssistant.fromJson(Map<String, dynamic> json) => _$ChatMessageAssistantFromJson(json);

/// Unique identifer for message.
@override final  String? id;
/// Content (simple string or list of content objects).
@override final  Object content;
/// Source of message.
@override final  String? source;
/// Additional message metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional message metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Conversation role.
@override@JsonKey() final  String role;
/// Tool calls made by the model.
 final  List<ToolCall>? _toolCalls;
/// Tool calls made by the model.
@JsonKey(name: 'tool_calls') List<ToolCall>? get toolCalls {
  final value = _toolCalls;
  if (value == null) return null;
  if (_toolCalls is EqualUnmodifiableListView) return _toolCalls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Model used to generate assistant message.
 final  String? model;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageAssistantCopyWith<ChatMessageAssistant> get copyWith => _$ChatMessageAssistantCopyWithImpl<ChatMessageAssistant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageAssistantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageAssistant&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._toolCalls, _toolCalls)&&(identical(other.model, model) || other.model == model));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(content),source,const DeepCollectionEquality().hash(_metadata),role,const DeepCollectionEquality().hash(_toolCalls),model);

@override
String toString() {
  return 'ChatMessage.assistant(id: $id, content: $content, source: $source, metadata: $metadata, role: $role, toolCalls: $toolCalls, model: $model)';
}


}

/// @nodoc
abstract mixin class $ChatMessageAssistantCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory $ChatMessageAssistantCopyWith(ChatMessageAssistant value, $Res Function(ChatMessageAssistant) _then) = _$ChatMessageAssistantCopyWithImpl;
@override @useResult
$Res call({
 String? id, Object content, String? source, Map<String, dynamic>? metadata, String role,@JsonKey(name: 'tool_calls') List<ToolCall>? toolCalls, String? model
});




}
/// @nodoc
class _$ChatMessageAssistantCopyWithImpl<$Res>
    implements $ChatMessageAssistantCopyWith<$Res> {
  _$ChatMessageAssistantCopyWithImpl(this._self, this._then);

  final ChatMessageAssistant _self;
  final $Res Function(ChatMessageAssistant) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? source = freezed,Object? metadata = freezed,Object? role = null,Object? toolCalls = freezed,Object? model = freezed,}) {
  return _then(ChatMessageAssistant(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content ,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,toolCalls: freezed == toolCalls ? _self._toolCalls : toolCalls // ignore: cast_nullable_to_non_nullable
as List<ToolCall>?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ChatMessageTool extends ChatMessage {
  const ChatMessageTool({this.id, required this.content, this.source, final  Map<String, dynamic>? metadata, this.role = 'tool', @JsonKey(name: 'tool_call_id') this.toolCallId, this.function, this.error}): _metadata = metadata,super._();
  factory ChatMessageTool.fromJson(Map<String, dynamic> json) => _$ChatMessageToolFromJson(json);

/// Unique identifer for message.
@override final  String? id;
/// Content (simple string or list of content objects).
@override final  Object content;
/// Source of message.
@override final  String? source;
/// Additional message metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional message metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Conversation role.
@override@JsonKey() final  String role;
/// ID of tool call.
@JsonKey(name: 'tool_call_id') final  String? toolCallId;
/// Name of function called.
 final  String? function;
/// Error which occurred during tool call.
 final  ToolCallError? error;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageToolCopyWith<ChatMessageTool> get copyWith => _$ChatMessageToolCopyWithImpl<ChatMessageTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageTool&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.role, role) || other.role == role)&&(identical(other.toolCallId, toolCallId) || other.toolCallId == toolCallId)&&(identical(other.function, function) || other.function == function)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(content),source,const DeepCollectionEquality().hash(_metadata),role,toolCallId,function,error);

@override
String toString() {
  return 'ChatMessage.tool(id: $id, content: $content, source: $source, metadata: $metadata, role: $role, toolCallId: $toolCallId, function: $function, error: $error)';
}


}

/// @nodoc
abstract mixin class $ChatMessageToolCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory $ChatMessageToolCopyWith(ChatMessageTool value, $Res Function(ChatMessageTool) _then) = _$ChatMessageToolCopyWithImpl;
@override @useResult
$Res call({
 String? id, Object content, String? source, Map<String, dynamic>? metadata, String role,@JsonKey(name: 'tool_call_id') String? toolCallId, String? function, ToolCallError? error
});


$ToolCallErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$ChatMessageToolCopyWithImpl<$Res>
    implements $ChatMessageToolCopyWith<$Res> {
  _$ChatMessageToolCopyWithImpl(this._self, this._then);

  final ChatMessageTool _self;
  final $Res Function(ChatMessageTool) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = null,Object? source = freezed,Object? metadata = freezed,Object? role = null,Object? toolCallId = freezed,Object? function = freezed,Object? error = freezed,}) {
  return _then(ChatMessageTool(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content ,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,toolCallId: freezed == toolCallId ? _self.toolCallId : toolCallId // ignore: cast_nullable_to_non_nullable
as String?,function: freezed == function ? _self.function : function // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ToolCallError?,
  ));
}

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolCallErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ToolCallErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

Content _$ContentFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text':
          return ContentText.fromJson(
            json
          );
                case 'reasoning':
          return ContentReasoning.fromJson(
            json
          );
                case 'image':
          return ContentImage.fromJson(
            json
          );
                case 'audio':
          return ContentAudio.fromJson(
            json
          );
                case 'video':
          return ContentVideo.fromJson(
            json
          );
                case 'document':
          return ContentDocument.fromJson(
            json
          );
                case 'data':
          return ContentData.fromJson(
            json
          );
                case 'tool_use':
          return ContentToolUse.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Content',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Content {

/// Content type.
 String get type;
/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCopyWith<Content> get copyWith => _$ContentCopyWithImpl<Content>(this as Content, _$identity);

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Content&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'Content(type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res>  {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) = _$ContentCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$ContentCopyWithImpl<$Res>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Content].
extension ContentPatterns on Content {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContentText value)?  text,TResult Function( ContentReasoning value)?  reasoning,TResult Function( ContentImage value)?  image,TResult Function( ContentAudio value)?  audio,TResult Function( ContentVideo value)?  video,TResult Function( ContentDocument value)?  document,TResult Function( ContentData value)?  data,TResult Function( ContentToolUse value)?  toolUse,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContentText() when text != null:
return text(_that);case ContentReasoning() when reasoning != null:
return reasoning(_that);case ContentImage() when image != null:
return image(_that);case ContentAudio() when audio != null:
return audio(_that);case ContentVideo() when video != null:
return video(_that);case ContentDocument() when document != null:
return document(_that);case ContentData() when data != null:
return data(_that);case ContentToolUse() when toolUse != null:
return toolUse(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContentText value)  text,required TResult Function( ContentReasoning value)  reasoning,required TResult Function( ContentImage value)  image,required TResult Function( ContentAudio value)  audio,required TResult Function( ContentVideo value)  video,required TResult Function( ContentDocument value)  document,required TResult Function( ContentData value)  data,required TResult Function( ContentToolUse value)  toolUse,}){
final _that = this;
switch (_that) {
case ContentText():
return text(_that);case ContentReasoning():
return reasoning(_that);case ContentImage():
return image(_that);case ContentAudio():
return audio(_that);case ContentVideo():
return video(_that);case ContentDocument():
return document(_that);case ContentData():
return data(_that);case ContentToolUse():
return toolUse(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContentText value)?  text,TResult? Function( ContentReasoning value)?  reasoning,TResult? Function( ContentImage value)?  image,TResult? Function( ContentAudio value)?  audio,TResult? Function( ContentVideo value)?  video,TResult? Function( ContentDocument value)?  document,TResult? Function( ContentData value)?  data,TResult? Function( ContentToolUse value)?  toolUse,}){
final _that = this;
switch (_that) {
case ContentText() when text != null:
return text(_that);case ContentReasoning() when reasoning != null:
return reasoning(_that);case ContentImage() when image != null:
return image(_that);case ContentAudio() when audio != null:
return audio(_that);case ContentVideo() when video != null:
return video(_that);case ContentDocument() when document != null:
return document(_that);case ContentData() when data != null:
return data(_that);case ContentToolUse() when toolUse != null:
return toolUse(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text,  bool refusal,  List<Object>? citations,  String type)?  text,TResult Function( String reasoning,  String? summary,  String? signature,  bool redacted,  String? text,  String type)?  reasoning,TResult Function( String image,  String detail,  String type)?  image,TResult Function( String audio,  String format,  String type)?  audio,TResult Function( String video,  String format,  String type)?  video,TResult Function( String document,  String? filename, @JsonKey(name: 'mime_type')  String? mimeType,  String type)?  document,TResult Function( Map<String, dynamic> data,  String type)?  data,TResult Function(@JsonKey(name: 'tool_type')  String toolType,  String id,  String name,  Map<String, dynamic>? context,  Map<String, dynamic> arguments,  Object? result,  Object? error,  String type)?  toolUse,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContentText() when text != null:
return text(_that.text,_that.refusal,_that.citations,_that.type);case ContentReasoning() when reasoning != null:
return reasoning(_that.reasoning,_that.summary,_that.signature,_that.redacted,_that.text,_that.type);case ContentImage() when image != null:
return image(_that.image,_that.detail,_that.type);case ContentAudio() when audio != null:
return audio(_that.audio,_that.format,_that.type);case ContentVideo() when video != null:
return video(_that.video,_that.format,_that.type);case ContentDocument() when document != null:
return document(_that.document,_that.filename,_that.mimeType,_that.type);case ContentData() when data != null:
return data(_that.data,_that.type);case ContentToolUse() when toolUse != null:
return toolUse(_that.toolType,_that.id,_that.name,_that.context,_that.arguments,_that.result,_that.error,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text,  bool refusal,  List<Object>? citations,  String type)  text,required TResult Function( String reasoning,  String? summary,  String? signature,  bool redacted,  String? text,  String type)  reasoning,required TResult Function( String image,  String detail,  String type)  image,required TResult Function( String audio,  String format,  String type)  audio,required TResult Function( String video,  String format,  String type)  video,required TResult Function( String document,  String? filename, @JsonKey(name: 'mime_type')  String? mimeType,  String type)  document,required TResult Function( Map<String, dynamic> data,  String type)  data,required TResult Function(@JsonKey(name: 'tool_type')  String toolType,  String id,  String name,  Map<String, dynamic>? context,  Map<String, dynamic> arguments,  Object? result,  Object? error,  String type)  toolUse,}) {final _that = this;
switch (_that) {
case ContentText():
return text(_that.text,_that.refusal,_that.citations,_that.type);case ContentReasoning():
return reasoning(_that.reasoning,_that.summary,_that.signature,_that.redacted,_that.text,_that.type);case ContentImage():
return image(_that.image,_that.detail,_that.type);case ContentAudio():
return audio(_that.audio,_that.format,_that.type);case ContentVideo():
return video(_that.video,_that.format,_that.type);case ContentDocument():
return document(_that.document,_that.filename,_that.mimeType,_that.type);case ContentData():
return data(_that.data,_that.type);case ContentToolUse():
return toolUse(_that.toolType,_that.id,_that.name,_that.context,_that.arguments,_that.result,_that.error,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text,  bool refusal,  List<Object>? citations,  String type)?  text,TResult? Function( String reasoning,  String? summary,  String? signature,  bool redacted,  String? text,  String type)?  reasoning,TResult? Function( String image,  String detail,  String type)?  image,TResult? Function( String audio,  String format,  String type)?  audio,TResult? Function( String video,  String format,  String type)?  video,TResult? Function( String document,  String? filename, @JsonKey(name: 'mime_type')  String? mimeType,  String type)?  document,TResult? Function( Map<String, dynamic> data,  String type)?  data,TResult? Function(@JsonKey(name: 'tool_type')  String toolType,  String id,  String name,  Map<String, dynamic>? context,  Map<String, dynamic> arguments,  Object? result,  Object? error,  String type)?  toolUse,}) {final _that = this;
switch (_that) {
case ContentText() when text != null:
return text(_that.text,_that.refusal,_that.citations,_that.type);case ContentReasoning() when reasoning != null:
return reasoning(_that.reasoning,_that.summary,_that.signature,_that.redacted,_that.text,_that.type);case ContentImage() when image != null:
return image(_that.image,_that.detail,_that.type);case ContentAudio() when audio != null:
return audio(_that.audio,_that.format,_that.type);case ContentVideo() when video != null:
return video(_that.video,_that.format,_that.type);case ContentDocument() when document != null:
return document(_that.document,_that.filename,_that.mimeType,_that.type);case ContentData() when data != null:
return data(_that.data,_that.type);case ContentToolUse() when toolUse != null:
return toolUse(_that.toolType,_that.id,_that.name,_that.context,_that.arguments,_that.result,_that.error,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ContentText extends Content {
  const ContentText({required this.text, this.refusal = false, final  List<Object>? citations, this.type = 'text'}): _citations = citations,super._();
  factory ContentText.fromJson(Map<String, dynamic> json) => _$ContentTextFromJson(json);

/// Text content.
 final  String text;
/// Was this a refusal message?
@JsonKey() final  bool refusal;
/// Citations supporting the text block.
 final  List<Object>? _citations;
/// Citations supporting the text block.
 List<Object>? get citations {
  final value = _citations;
  if (value == null) return null;
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTextCopyWith<ContentText> get copyWith => _$ContentTextCopyWithImpl<ContentText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentText&&(identical(other.text, text) || other.text == text)&&(identical(other.refusal, refusal) || other.refusal == refusal)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,refusal,const DeepCollectionEquality().hash(_citations),type);

@override
String toString() {
  return 'Content.text(text: $text, refusal: $refusal, citations: $citations, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentTextCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentTextCopyWith(ContentText value, $Res Function(ContentText) _then) = _$ContentTextCopyWithImpl;
@override @useResult
$Res call({
 String text, bool refusal, List<Object>? citations, String type
});




}
/// @nodoc
class _$ContentTextCopyWithImpl<$Res>
    implements $ContentTextCopyWith<$Res> {
  _$ContentTextCopyWithImpl(this._self, this._then);

  final ContentText _self;
  final $Res Function(ContentText) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? refusal = null,Object? citations = freezed,Object? type = null,}) {
  return _then(ContentText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,refusal: null == refusal ? _self.refusal : refusal // ignore: cast_nullable_to_non_nullable
as bool,citations: freezed == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Object>?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentReasoning extends Content {
  const ContentReasoning({required this.reasoning, this.summary, this.signature, this.redacted = false, this.text, this.type = 'reasoning'}): super._();
  factory ContentReasoning.fromJson(Map<String, dynamic> json) => _$ContentReasoningFromJson(json);

/// Reasoning content.
 final  String reasoning;
/// Reasoning summary.
 final  String? summary;
/// Signature for reasoning content.
 final  String? signature;
/// Indicates that the explicit content of this reasoning block has been redacted.
@JsonKey() final  bool redacted;
/// Pure text rendering of reasoning.
 final  String? text;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentReasoningCopyWith<ContentReasoning> get copyWith => _$ContentReasoningCopyWithImpl<ContentReasoning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentReasoningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentReasoning&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.redacted, redacted) || other.redacted == redacted)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reasoning,summary,signature,redacted,text,type);

@override
String toString() {
  return 'Content.reasoning(reasoning: $reasoning, summary: $summary, signature: $signature, redacted: $redacted, text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentReasoningCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentReasoningCopyWith(ContentReasoning value, $Res Function(ContentReasoning) _then) = _$ContentReasoningCopyWithImpl;
@override @useResult
$Res call({
 String reasoning, String? summary, String? signature, bool redacted, String? text, String type
});




}
/// @nodoc
class _$ContentReasoningCopyWithImpl<$Res>
    implements $ContentReasoningCopyWith<$Res> {
  _$ContentReasoningCopyWithImpl(this._self, this._then);

  final ContentReasoning _self;
  final $Res Function(ContentReasoning) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reasoning = null,Object? summary = freezed,Object? signature = freezed,Object? redacted = null,Object? text = freezed,Object? type = null,}) {
  return _then(ContentReasoning(
reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,redacted: null == redacted ? _self.redacted : redacted // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentImage extends Content {
  const ContentImage({required this.image, this.detail = 'auto', this.type = 'image'}): super._();
  factory ContentImage.fromJson(Map<String, dynamic> json) => _$ContentImageFromJson(json);

/// Either a URL of the image or the base64 encoded image data.
 final  String image;
/// Specifies the detail level of the image.
@JsonKey() final  String detail;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentImageCopyWith<ContentImage> get copyWith => _$ContentImageCopyWithImpl<ContentImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentImage&&(identical(other.image, image) || other.image == image)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,image,detail,type);

@override
String toString() {
  return 'Content.image(image: $image, detail: $detail, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentImageCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentImageCopyWith(ContentImage value, $Res Function(ContentImage) _then) = _$ContentImageCopyWithImpl;
@override @useResult
$Res call({
 String image, String detail, String type
});




}
/// @nodoc
class _$ContentImageCopyWithImpl<$Res>
    implements $ContentImageCopyWith<$Res> {
  _$ContentImageCopyWithImpl(this._self, this._then);

  final ContentImage _self;
  final $Res Function(ContentImage) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? image = null,Object? detail = null,Object? type = null,}) {
  return _then(ContentImage(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentAudio extends Content {
  const ContentAudio({required this.audio, required this.format, this.type = 'audio'}): super._();
  factory ContentAudio.fromJson(Map<String, dynamic> json) => _$ContentAudioFromJson(json);

/// Audio file path or base64 encoded data URL.
 final  String audio;
/// Format of audio data (‘mp3’ or ‘wav’).
 final  String format;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentAudioCopyWith<ContentAudio> get copyWith => _$ContentAudioCopyWithImpl<ContentAudio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentAudioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentAudio&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.format, format) || other.format == format)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audio,format,type);

@override
String toString() {
  return 'Content.audio(audio: $audio, format: $format, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentAudioCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentAudioCopyWith(ContentAudio value, $Res Function(ContentAudio) _then) = _$ContentAudioCopyWithImpl;
@override @useResult
$Res call({
 String audio, String format, String type
});




}
/// @nodoc
class _$ContentAudioCopyWithImpl<$Res>
    implements $ContentAudioCopyWith<$Res> {
  _$ContentAudioCopyWithImpl(this._self, this._then);

  final ContentAudio _self;
  final $Res Function(ContentAudio) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? audio = null,Object? format = null,Object? type = null,}) {
  return _then(ContentAudio(
audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentVideo extends Content {
  const ContentVideo({required this.video, required this.format, this.type = 'video'}): super._();
  factory ContentVideo.fromJson(Map<String, dynamic> json) => _$ContentVideoFromJson(json);

/// Video file path or base64 encoded data URL.
 final  String video;
/// Format of video data (‘mp4’, ‘mpeg’, or ‘mov’).
 final  String format;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentVideoCopyWith<ContentVideo> get copyWith => _$ContentVideoCopyWithImpl<ContentVideo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentVideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentVideo&&(identical(other.video, video) || other.video == video)&&(identical(other.format, format) || other.format == format)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,video,format,type);

@override
String toString() {
  return 'Content.video(video: $video, format: $format, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentVideoCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentVideoCopyWith(ContentVideo value, $Res Function(ContentVideo) _then) = _$ContentVideoCopyWithImpl;
@override @useResult
$Res call({
 String video, String format, String type
});




}
/// @nodoc
class _$ContentVideoCopyWithImpl<$Res>
    implements $ContentVideoCopyWith<$Res> {
  _$ContentVideoCopyWithImpl(this._self, this._then);

  final ContentVideo _self;
  final $Res Function(ContentVideo) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? video = null,Object? format = null,Object? type = null,}) {
  return _then(ContentVideo(
video: null == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentDocument extends Content {
  const ContentDocument({required this.document, this.filename, @JsonKey(name: 'mime_type') this.mimeType, this.type = 'document'}): super._();
  factory ContentDocument.fromJson(Map<String, dynamic> json) => _$ContentDocumentFromJson(json);

/// Document file path or base64 encoded data URL.
 final  String document;
/// Document filename.
 final  String? filename;
/// Document mime type.
@JsonKey(name: 'mime_type') final  String? mimeType;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentDocumentCopyWith<ContentDocument> get copyWith => _$ContentDocumentCopyWithImpl<ContentDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentDocument&&(identical(other.document, document) || other.document == document)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,document,filename,mimeType,type);

@override
String toString() {
  return 'Content.document(document: $document, filename: $filename, mimeType: $mimeType, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentDocumentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentDocumentCopyWith(ContentDocument value, $Res Function(ContentDocument) _then) = _$ContentDocumentCopyWithImpl;
@override @useResult
$Res call({
 String document, String? filename,@JsonKey(name: 'mime_type') String? mimeType, String type
});




}
/// @nodoc
class _$ContentDocumentCopyWithImpl<$Res>
    implements $ContentDocumentCopyWith<$Res> {
  _$ContentDocumentCopyWithImpl(this._self, this._then);

  final ContentDocument _self;
  final $Res Function(ContentDocument) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? document = null,Object? filename = freezed,Object? mimeType = freezed,Object? type = null,}) {
  return _then(ContentDocument(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as String,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentData extends Content {
  const ContentData({required final  Map<String, dynamic> data, this.type = 'data'}): _data = data,super._();
  factory ContentData.fromJson(Map<String, dynamic> json) => _$ContentDataFromJson(json);

/// Model provider specific payload.
 final  Map<String, dynamic> _data;
/// Model provider specific payload.
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentDataCopyWith<ContentData> get copyWith => _$ContentDataCopyWithImpl<ContentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentData&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),type);

@override
String toString() {
  return 'Content.data(data: $data, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentDataCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentDataCopyWith(ContentData value, $Res Function(ContentData) _then) = _$ContentDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> data, String type
});




}
/// @nodoc
class _$ContentDataCopyWithImpl<$Res>
    implements $ContentDataCopyWith<$Res> {
  _$ContentDataCopyWithImpl(this._self, this._then);

  final ContentData _self;
  final $Res Function(ContentData) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? type = null,}) {
  return _then(ContentData(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ContentToolUse extends Content {
  const ContentToolUse({@JsonKey(name: 'tool_type') required this.toolType, required this.id, required this.name, final  Map<String, dynamic>? context, required final  Map<String, dynamic> arguments, this.result, this.error, this.type = 'tool_use'}): _context = context,_arguments = arguments,super._();
  factory ContentToolUse.fromJson(Map<String, dynamic> json) => _$ContentToolUseFromJson(json);

/// The type of the tool call.
@JsonKey(name: 'tool_type') final  String toolType;
/// The unique ID of the tool call.
 final  String id;
/// Name of the tool.
 final  String name;
/// Tool context (e.g. MCP Server).
 final  Map<String, dynamic>? _context;
/// Tool context (e.g. MCP Server).
 Map<String, dynamic>? get context {
  final value = _context;
  if (value == null) return null;
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Arguments passed to the tool.
 final  Map<String, dynamic> _arguments;
/// Arguments passed to the tool.
 Map<String, dynamic> get arguments {
  if (_arguments is EqualUnmodifiableMapView) return _arguments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_arguments);
}

/// Result from the tool call.
 final  Object? result;
/// The error from the tool call (if any).
 final  Object? error;
/// Content type.
@override@JsonKey() final  String type;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentToolUseCopyWith<ContentToolUse> get copyWith => _$ContentToolUseCopyWithImpl<ContentToolUse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentToolUseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentToolUse&&(identical(other.toolType, toolType) || other.toolType == toolType)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._context, _context)&&const DeepCollectionEquality().equals(other._arguments, _arguments)&&const DeepCollectionEquality().equals(other.result, result)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toolType,id,name,const DeepCollectionEquality().hash(_context),const DeepCollectionEquality().hash(_arguments),const DeepCollectionEquality().hash(result),const DeepCollectionEquality().hash(error),type);

@override
String toString() {
  return 'Content.toolUse(toolType: $toolType, id: $id, name: $name, context: $context, arguments: $arguments, result: $result, error: $error, type: $type)';
}


}

/// @nodoc
abstract mixin class $ContentToolUseCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ContentToolUseCopyWith(ContentToolUse value, $Res Function(ContentToolUse) _then) = _$ContentToolUseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tool_type') String toolType, String id, String name, Map<String, dynamic>? context, Map<String, dynamic> arguments, Object? result, Object? error, String type
});




}
/// @nodoc
class _$ContentToolUseCopyWithImpl<$Res>
    implements $ContentToolUseCopyWith<$Res> {
  _$ContentToolUseCopyWithImpl(this._self, this._then);

  final ContentToolUse _self;
  final $Res Function(ContentToolUse) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toolType = null,Object? id = null,Object? name = null,Object? context = freezed,Object? arguments = null,Object? result = freezed,Object? error = freezed,Object? type = null,}) {
  return _then(ContentToolUse(
toolType: null == toolType ? _self.toolType : toolType // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,context: freezed == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,arguments: null == arguments ? _self._arguments : arguments // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,result: freezed == result ? _self.result : result ,error: freezed == error ? _self.error : error ,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EvalSampleScore {

/// Score value.
 Object get value;/// Model's answer (for logging).
 String? get answer;/// Why this score was given.
 String? get explanation;/// Additional metadata.
 Map<String, dynamic> get metadata;/// History of scores (if applicable).
 List<Object> get history;/// Sample ID.
@JsonKey(name: 'sample_id') Object? get sampleId;
/// Create a copy of EvalSampleScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSampleScoreCopyWith<EvalSampleScore> get copyWith => _$EvalSampleScoreCopyWithImpl<EvalSampleScore>(this as EvalSampleScore, _$identity);

  /// Serializes this EvalSampleScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSampleScore&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.history, history)&&const DeepCollectionEquality().equals(other.sampleId, sampleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),answer,explanation,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(history),const DeepCollectionEquality().hash(sampleId));

@override
String toString() {
  return 'EvalSampleScore(value: $value, answer: $answer, explanation: $explanation, metadata: $metadata, history: $history, sampleId: $sampleId)';
}


}

/// @nodoc
abstract mixin class $EvalSampleScoreCopyWith<$Res>  {
  factory $EvalSampleScoreCopyWith(EvalSampleScore value, $Res Function(EvalSampleScore) _then) = _$EvalSampleScoreCopyWithImpl;
@useResult
$Res call({
 Object value, String? answer, String? explanation, Map<String, dynamic> metadata, List<Object> history,@JsonKey(name: 'sample_id') Object? sampleId
});




}
/// @nodoc
class _$EvalSampleScoreCopyWithImpl<$Res>
    implements $EvalSampleScoreCopyWith<$Res> {
  _$EvalSampleScoreCopyWithImpl(this._self, this._then);

  final EvalSampleScore _self;
  final $Res Function(EvalSampleScore) _then;

/// Create a copy of EvalSampleScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? answer = freezed,Object? explanation = freezed,Object? metadata = null,Object? history = null,Object? sampleId = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value ,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<Object>,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSampleScore].
extension EvalSampleScorePatterns on EvalSampleScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSampleScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSampleScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSampleScore value)  $default,){
final _that = this;
switch (_that) {
case _EvalSampleScore():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSampleScore value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSampleScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic> metadata,  List<Object> history, @JsonKey(name: 'sample_id')  Object? sampleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSampleScore() when $default != null:
return $default(_that.value,_that.answer,_that.explanation,_that.metadata,_that.history,_that.sampleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic> metadata,  List<Object> history, @JsonKey(name: 'sample_id')  Object? sampleId)  $default,) {final _that = this;
switch (_that) {
case _EvalSampleScore():
return $default(_that.value,_that.answer,_that.explanation,_that.metadata,_that.history,_that.sampleId);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic> metadata,  List<Object> history, @JsonKey(name: 'sample_id')  Object? sampleId)?  $default,) {final _that = this;
switch (_that) {
case _EvalSampleScore() when $default != null:
return $default(_that.value,_that.answer,_that.explanation,_that.metadata,_that.history,_that.sampleId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSampleScore extends EvalSampleScore {
  const _EvalSampleScore({required this.value, this.answer, this.explanation, final  Map<String, dynamic> metadata = const {}, final  List<Object> history = const [], @JsonKey(name: 'sample_id') this.sampleId}): _metadata = metadata,_history = history,super._();
  factory _EvalSampleScore.fromJson(Map<String, dynamic> json) => _$EvalSampleScoreFromJson(json);

/// Score value.
@override final  Object value;
/// Model's answer (for logging).
@override final  String? answer;
/// Why this score was given.
@override final  String? explanation;
/// Additional metadata.
 final  Map<String, dynamic> _metadata;
/// Additional metadata.
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// History of scores (if applicable).
 final  List<Object> _history;
/// History of scores (if applicable).
@override@JsonKey() List<Object> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

/// Sample ID.
@override@JsonKey(name: 'sample_id') final  Object? sampleId;

/// Create a copy of EvalSampleScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSampleScoreCopyWith<_EvalSampleScore> get copyWith => __$EvalSampleScoreCopyWithImpl<_EvalSampleScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSampleScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSampleScore&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._history, _history)&&const DeepCollectionEquality().equals(other.sampleId, sampleId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),answer,explanation,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(sampleId));

@override
String toString() {
  return 'EvalSampleScore(value: $value, answer: $answer, explanation: $explanation, metadata: $metadata, history: $history, sampleId: $sampleId)';
}


}

/// @nodoc
abstract mixin class _$EvalSampleScoreCopyWith<$Res> implements $EvalSampleScoreCopyWith<$Res> {
  factory _$EvalSampleScoreCopyWith(_EvalSampleScore value, $Res Function(_EvalSampleScore) _then) = __$EvalSampleScoreCopyWithImpl;
@override @useResult
$Res call({
 Object value, String? answer, String? explanation, Map<String, dynamic> metadata, List<Object> history,@JsonKey(name: 'sample_id') Object? sampleId
});




}
/// @nodoc
class __$EvalSampleScoreCopyWithImpl<$Res>
    implements _$EvalSampleScoreCopyWith<$Res> {
  __$EvalSampleScoreCopyWithImpl(this._self, this._then);

  final _EvalSampleScore _self;
  final $Res Function(_EvalSampleScore) _then;

/// Create a copy of EvalSampleScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? answer = freezed,Object? explanation = freezed,Object? metadata = null,Object? history = null,Object? sampleId = freezed,}) {
  return _then(_EvalSampleScore(
value: null == value ? _self.value : value ,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<Object>,sampleId: freezed == sampleId ? _self.sampleId : sampleId ,
  ));
}


}


/// @nodoc
mixin _$Score {

/// Score value.
 Object get value;/// Model's answer (for logging).
 String? get answer;/// Why this score was given.
 String? get explanation;/// Additional metadata.
 Map<String, dynamic>? get metadata;
/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreCopyWith<Score> get copyWith => _$ScoreCopyWithImpl<Score>(this as Score, _$identity);

  /// Serializes this Score to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Score&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),answer,explanation,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Score(value: $value, answer: $answer, explanation: $explanation, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ScoreCopyWith<$Res>  {
  factory $ScoreCopyWith(Score value, $Res Function(Score) _then) = _$ScoreCopyWithImpl;
@useResult
$Res call({
 Object value, String? answer, String? explanation, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ScoreCopyWithImpl<$Res>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._self, this._then);

  final Score _self;
  final $Res Function(Score) _then;

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? answer = freezed,Object? explanation = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value ,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Score].
extension ScorePatterns on Score {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Score value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Score() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Score value)  $default,){
final _that = this;
switch (_that) {
case _Score():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Score value)?  $default,){
final _that = this;
switch (_that) {
case _Score() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Score() when $default != null:
return $default(_that.value,_that.answer,_that.explanation,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _Score():
return $default(_that.value,_that.answer,_that.explanation,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object value,  String? answer,  String? explanation,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _Score() when $default != null:
return $default(_that.value,_that.answer,_that.explanation,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Score extends Score {
  const _Score({required this.value, this.answer, this.explanation, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  factory _Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

/// Score value.
@override final  Object value;
/// Model's answer (for logging).
@override final  String? answer;
/// Why this score was given.
@override final  String? explanation;
/// Additional metadata.
 final  Map<String, dynamic>? _metadata;
/// Additional metadata.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreCopyWith<_Score> get copyWith => __$ScoreCopyWithImpl<_Score>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Score&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),answer,explanation,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Score(value: $value, answer: $answer, explanation: $explanation, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ScoreCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$ScoreCopyWith(_Score value, $Res Function(_Score) _then) = __$ScoreCopyWithImpl;
@override @useResult
$Res call({
 Object value, String? answer, String? explanation, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ScoreCopyWithImpl<$Res>
    implements _$ScoreCopyWith<$Res> {
  __$ScoreCopyWithImpl(this._self, this._then);

  final _Score _self;
  final $Res Function(_Score) _then;

/// Create a copy of Score
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? answer = freezed,Object? explanation = freezed,Object? metadata = freezed,}) {
  return _then(_Score(
value: null == value ? _self.value : value ,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ToolCall {

/// Unique ID of tool call.
 String get id;/// Name of function called.
 String get function;/// Arguments passed to function.
 Map<String, dynamic> get arguments;/// Type of tool call.
 String get type;
/// Create a copy of ToolCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolCallCopyWith<ToolCall> get copyWith => _$ToolCallCopyWithImpl<ToolCall>(this as ToolCall, _$identity);

  /// Serializes this ToolCall to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolCall&&(identical(other.id, id) || other.id == id)&&(identical(other.function, function) || other.function == function)&&const DeepCollectionEquality().equals(other.arguments, arguments)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,function,const DeepCollectionEquality().hash(arguments),type);

@override
String toString() {
  return 'ToolCall(id: $id, function: $function, arguments: $arguments, type: $type)';
}


}

/// @nodoc
abstract mixin class $ToolCallCopyWith<$Res>  {
  factory $ToolCallCopyWith(ToolCall value, $Res Function(ToolCall) _then) = _$ToolCallCopyWithImpl;
@useResult
$Res call({
 String id, String function, Map<String, dynamic> arguments, String type
});




}
/// @nodoc
class _$ToolCallCopyWithImpl<$Res>
    implements $ToolCallCopyWith<$Res> {
  _$ToolCallCopyWithImpl(this._self, this._then);

  final ToolCall _self;
  final $Res Function(ToolCall) _then;

/// Create a copy of ToolCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? function = null,Object? arguments = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,function: null == function ? _self.function : function // ignore: cast_nullable_to_non_nullable
as String,arguments: null == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolCall].
extension ToolCallPatterns on ToolCall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolCall value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolCall() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolCall value)  $default,){
final _that = this;
switch (_that) {
case _ToolCall():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolCall value)?  $default,){
final _that = this;
switch (_that) {
case _ToolCall() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String function,  Map<String, dynamic> arguments,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolCall() when $default != null:
return $default(_that.id,_that.function,_that.arguments,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String function,  Map<String, dynamic> arguments,  String type)  $default,) {final _that = this;
switch (_that) {
case _ToolCall():
return $default(_that.id,_that.function,_that.arguments,_that.type);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String function,  Map<String, dynamic> arguments,  String type)?  $default,) {final _that = this;
switch (_that) {
case _ToolCall() when $default != null:
return $default(_that.id,_that.function,_that.arguments,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToolCall extends ToolCall {
  const _ToolCall({required this.id, required this.function, required final  Map<String, dynamic> arguments, this.type = 'call'}): _arguments = arguments,super._();
  factory _ToolCall.fromJson(Map<String, dynamic> json) => _$ToolCallFromJson(json);

/// Unique ID of tool call.
@override final  String id;
/// Name of function called.
@override final  String function;
/// Arguments passed to function.
 final  Map<String, dynamic> _arguments;
/// Arguments passed to function.
@override Map<String, dynamic> get arguments {
  if (_arguments is EqualUnmodifiableMapView) return _arguments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_arguments);
}

/// Type of tool call.
@override@JsonKey() final  String type;

/// Create a copy of ToolCall
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolCallCopyWith<_ToolCall> get copyWith => __$ToolCallCopyWithImpl<_ToolCall>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolCallToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolCall&&(identical(other.id, id) || other.id == id)&&(identical(other.function, function) || other.function == function)&&const DeepCollectionEquality().equals(other._arguments, _arguments)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,function,const DeepCollectionEquality().hash(_arguments),type);

@override
String toString() {
  return 'ToolCall(id: $id, function: $function, arguments: $arguments, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ToolCallCopyWith<$Res> implements $ToolCallCopyWith<$Res> {
  factory _$ToolCallCopyWith(_ToolCall value, $Res Function(_ToolCall) _then) = __$ToolCallCopyWithImpl;
@override @useResult
$Res call({
 String id, String function, Map<String, dynamic> arguments, String type
});




}
/// @nodoc
class __$ToolCallCopyWithImpl<$Res>
    implements _$ToolCallCopyWith<$Res> {
  __$ToolCallCopyWithImpl(this._self, this._then);

  final _ToolCall _self;
  final $Res Function(_ToolCall) _then;

/// Create a copy of ToolCall
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? function = null,Object? arguments = null,Object? type = null,}) {
  return _then(_ToolCall(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,function: null == function ? _self.function : function // ignore: cast_nullable_to_non_nullable
as String,arguments: null == arguments ? _self._arguments : arguments // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ToolCallError {

/// Error message.
 String get message;/// Error code.
 int? get code;/// Additional error data.
@JsonKey(name: 'data') Map<String, dynamic>? get data;
/// Create a copy of ToolCallError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolCallErrorCopyWith<ToolCallError> get copyWith => _$ToolCallErrorCopyWithImpl<ToolCallError>(this as ToolCallError, _$identity);

  /// Serializes this ToolCallError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolCallError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,code,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ToolCallError(message: $message, code: $code, data: $data)';
}


}

/// @nodoc
abstract mixin class $ToolCallErrorCopyWith<$Res>  {
  factory $ToolCallErrorCopyWith(ToolCallError value, $Res Function(ToolCallError) _then) = _$ToolCallErrorCopyWithImpl;
@useResult
$Res call({
 String message, int? code,@JsonKey(name: 'data') Map<String, dynamic>? data
});




}
/// @nodoc
class _$ToolCallErrorCopyWithImpl<$Res>
    implements $ToolCallErrorCopyWith<$Res> {
  _$ToolCallErrorCopyWithImpl(this._self, this._then);

  final ToolCallError _self;
  final $Res Function(ToolCallError) _then;

/// Create a copy of ToolCallError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? code = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolCallError].
extension ToolCallErrorPatterns on ToolCallError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolCallError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolCallError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolCallError value)  $default,){
final _that = this;
switch (_that) {
case _ToolCallError():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolCallError value)?  $default,){
final _that = this;
switch (_that) {
case _ToolCallError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  int? code, @JsonKey(name: 'data')  Map<String, dynamic>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolCallError() when $default != null:
return $default(_that.message,_that.code,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  int? code, @JsonKey(name: 'data')  Map<String, dynamic>? data)  $default,) {final _that = this;
switch (_that) {
case _ToolCallError():
return $default(_that.message,_that.code,_that.data);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  int? code, @JsonKey(name: 'data')  Map<String, dynamic>? data)?  $default,) {final _that = this;
switch (_that) {
case _ToolCallError() when $default != null:
return $default(_that.message,_that.code,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToolCallError extends ToolCallError {
  const _ToolCallError({required this.message, this.code, @JsonKey(name: 'data') final  Map<String, dynamic>? data}): _data = data,super._();
  factory _ToolCallError.fromJson(Map<String, dynamic> json) => _$ToolCallErrorFromJson(json);

/// Error message.
@override final  String message;
/// Error code.
@override final  int? code;
/// Additional error data.
 final  Map<String, dynamic>? _data;
/// Additional error data.
@override@JsonKey(name: 'data') Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ToolCallError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolCallErrorCopyWith<_ToolCallError> get copyWith => __$ToolCallErrorCopyWithImpl<_ToolCallError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolCallErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolCallError&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,code,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ToolCallError(message: $message, code: $code, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ToolCallErrorCopyWith<$Res> implements $ToolCallErrorCopyWith<$Res> {
  factory _$ToolCallErrorCopyWith(_ToolCallError value, $Res Function(_ToolCallError) _then) = __$ToolCallErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, int? code,@JsonKey(name: 'data') Map<String, dynamic>? data
});




}
/// @nodoc
class __$ToolCallErrorCopyWithImpl<$Res>
    implements _$ToolCallErrorCopyWith<$Res> {
  __$ToolCallErrorCopyWithImpl(this._self, this._then);

  final _ToolCallError _self;
  final $Res Function(_ToolCallError) _then;

/// Create a copy of ToolCallError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,Object? data = freezed,}) {
  return _then(_ToolCallError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$GenerateConfig {

/// Maximum number of times to retry a request.
@JsonKey(name: 'max_retries') int? get maxRetries;/// Request timeout (in seconds).
 int? get timeout;/// Timeout for each individual request attempt (in seconds).
@JsonKey(name: 'attempt_timeout') int? get attemptTimeout;/// Maximum number of concurrent connections to the model API.
@JsonKey(name: 'max_connections') int? get maxConnections;/// System message to provide to the model.
@JsonKey(name: 'system_message') String? get systemMessage;/// Maximum number of tokens to generate.
@JsonKey(name: 'max_tokens') int? get maxTokens;/// Top-p sampling parameter.
@JsonKey(name: 'top_p') double? get topP;/// Temperature sampling parameter.
 double? get temperature;/// Sequences that should stop generation.
@JsonKey(name: 'stop_seqs') List<String>? get stopSeqs;/// Number of completions to generate and choose the best from.
@JsonKey(name: 'best_of') int? get bestOf;/// Frequency penalty parameter.
@JsonKey(name: 'frequency_penalty') double? get frequencyPenalty;/// Presence penalty parameter.
@JsonKey(name: 'presence_penalty') double? get presencePenalty;/// Logit bias parameter.
@JsonKey(name: 'logit_bias') Map<String, double>? get logitBias;/// Random seed for generation.
 int? get seed;/// Top-k sampling parameter.
@JsonKey(name: 'top_k') int? get topK;/// Number of completion choices to return.
@JsonKey(name: 'num_choices') int? get numChoices;/// Whether to return logprobs.
 bool? get logprobs;/// Number of top logprobs to return.
@JsonKey(name: 'top_logprobs') int? get topLogprobs;/// Whether to allow parallel tool calls.
@JsonKey(name: 'parallel_tool_calls') bool? get parallelToolCalls;/// Whether to allow internal model tools.
@JsonKey(name: 'internal_tools') bool? get internalTools;/// Maximum number of characters to retain for tool output.
@JsonKey(name: 'max_tool_output') int? get maxToolOutput;/// Cache the prompt (if supported by the provider).
@JsonKey(name: 'cache_prompt') Object? get cachePrompt;
/// Create a copy of GenerateConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerateConfigCopyWith<GenerateConfig> get copyWith => _$GenerateConfigCopyWithImpl<GenerateConfig>(this as GenerateConfig, _$identity);

  /// Serializes this GenerateConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateConfig&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.attemptTimeout, attemptTimeout) || other.attemptTimeout == attemptTimeout)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&(identical(other.topP, topP) || other.topP == topP)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&const DeepCollectionEquality().equals(other.stopSeqs, stopSeqs)&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&(identical(other.frequencyPenalty, frequencyPenalty) || other.frequencyPenalty == frequencyPenalty)&&(identical(other.presencePenalty, presencePenalty) || other.presencePenalty == presencePenalty)&&const DeepCollectionEquality().equals(other.logitBias, logitBias)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.topK, topK) || other.topK == topK)&&(identical(other.numChoices, numChoices) || other.numChoices == numChoices)&&(identical(other.logprobs, logprobs) || other.logprobs == logprobs)&&(identical(other.topLogprobs, topLogprobs) || other.topLogprobs == topLogprobs)&&(identical(other.parallelToolCalls, parallelToolCalls) || other.parallelToolCalls == parallelToolCalls)&&(identical(other.internalTools, internalTools) || other.internalTools == internalTools)&&(identical(other.maxToolOutput, maxToolOutput) || other.maxToolOutput == maxToolOutput)&&const DeepCollectionEquality().equals(other.cachePrompt, cachePrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,maxRetries,timeout,attemptTimeout,maxConnections,systemMessage,maxTokens,topP,temperature,const DeepCollectionEquality().hash(stopSeqs),bestOf,frequencyPenalty,presencePenalty,const DeepCollectionEquality().hash(logitBias),seed,topK,numChoices,logprobs,topLogprobs,parallelToolCalls,internalTools,maxToolOutput,const DeepCollectionEquality().hash(cachePrompt)]);

@override
String toString() {
  return 'GenerateConfig(maxRetries: $maxRetries, timeout: $timeout, attemptTimeout: $attemptTimeout, maxConnections: $maxConnections, systemMessage: $systemMessage, maxTokens: $maxTokens, topP: $topP, temperature: $temperature, stopSeqs: $stopSeqs, bestOf: $bestOf, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, logitBias: $logitBias, seed: $seed, topK: $topK, numChoices: $numChoices, logprobs: $logprobs, topLogprobs: $topLogprobs, parallelToolCalls: $parallelToolCalls, internalTools: $internalTools, maxToolOutput: $maxToolOutput, cachePrompt: $cachePrompt)';
}


}

/// @nodoc
abstract mixin class $GenerateConfigCopyWith<$Res>  {
  factory $GenerateConfigCopyWith(GenerateConfig value, $Res Function(GenerateConfig) _then) = _$GenerateConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'max_retries') int? maxRetries, int? timeout,@JsonKey(name: 'attempt_timeout') int? attemptTimeout,@JsonKey(name: 'max_connections') int? maxConnections,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'max_tokens') int? maxTokens,@JsonKey(name: 'top_p') double? topP, double? temperature,@JsonKey(name: 'stop_seqs') List<String>? stopSeqs,@JsonKey(name: 'best_of') int? bestOf,@JsonKey(name: 'frequency_penalty') double? frequencyPenalty,@JsonKey(name: 'presence_penalty') double? presencePenalty,@JsonKey(name: 'logit_bias') Map<String, double>? logitBias, int? seed,@JsonKey(name: 'top_k') int? topK,@JsonKey(name: 'num_choices') int? numChoices, bool? logprobs,@JsonKey(name: 'top_logprobs') int? topLogprobs,@JsonKey(name: 'parallel_tool_calls') bool? parallelToolCalls,@JsonKey(name: 'internal_tools') bool? internalTools,@JsonKey(name: 'max_tool_output') int? maxToolOutput,@JsonKey(name: 'cache_prompt') Object? cachePrompt
});




}
/// @nodoc
class _$GenerateConfigCopyWithImpl<$Res>
    implements $GenerateConfigCopyWith<$Res> {
  _$GenerateConfigCopyWithImpl(this._self, this._then);

  final GenerateConfig _self;
  final $Res Function(GenerateConfig) _then;

/// Create a copy of GenerateConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxRetries = freezed,Object? timeout = freezed,Object? attemptTimeout = freezed,Object? maxConnections = freezed,Object? systemMessage = freezed,Object? maxTokens = freezed,Object? topP = freezed,Object? temperature = freezed,Object? stopSeqs = freezed,Object? bestOf = freezed,Object? frequencyPenalty = freezed,Object? presencePenalty = freezed,Object? logitBias = freezed,Object? seed = freezed,Object? topK = freezed,Object? numChoices = freezed,Object? logprobs = freezed,Object? topLogprobs = freezed,Object? parallelToolCalls = freezed,Object? internalTools = freezed,Object? maxToolOutput = freezed,Object? cachePrompt = freezed,}) {
  return _then(_self.copyWith(
maxRetries: freezed == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int?,attemptTimeout: freezed == attemptTimeout ? _self.attemptTimeout : attemptTimeout // ignore: cast_nullable_to_non_nullable
as int?,maxConnections: freezed == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,maxTokens: freezed == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int?,topP: freezed == topP ? _self.topP : topP // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,stopSeqs: freezed == stopSeqs ? _self.stopSeqs : stopSeqs // ignore: cast_nullable_to_non_nullable
as List<String>?,bestOf: freezed == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int?,frequencyPenalty: freezed == frequencyPenalty ? _self.frequencyPenalty : frequencyPenalty // ignore: cast_nullable_to_non_nullable
as double?,presencePenalty: freezed == presencePenalty ? _self.presencePenalty : presencePenalty // ignore: cast_nullable_to_non_nullable
as double?,logitBias: freezed == logitBias ? _self.logitBias : logitBias // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,topK: freezed == topK ? _self.topK : topK // ignore: cast_nullable_to_non_nullable
as int?,numChoices: freezed == numChoices ? _self.numChoices : numChoices // ignore: cast_nullable_to_non_nullable
as int?,logprobs: freezed == logprobs ? _self.logprobs : logprobs // ignore: cast_nullable_to_non_nullable
as bool?,topLogprobs: freezed == topLogprobs ? _self.topLogprobs : topLogprobs // ignore: cast_nullable_to_non_nullable
as int?,parallelToolCalls: freezed == parallelToolCalls ? _self.parallelToolCalls : parallelToolCalls // ignore: cast_nullable_to_non_nullable
as bool?,internalTools: freezed == internalTools ? _self.internalTools : internalTools // ignore: cast_nullable_to_non_nullable
as bool?,maxToolOutput: freezed == maxToolOutput ? _self.maxToolOutput : maxToolOutput // ignore: cast_nullable_to_non_nullable
as int?,cachePrompt: freezed == cachePrompt ? _self.cachePrompt : cachePrompt ,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerateConfig].
extension GenerateConfigPatterns on GenerateConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerateConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerateConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerateConfig value)  $default,){
final _that = this;
switch (_that) {
case _GenerateConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerateConfig value)?  $default,){
final _that = this;
switch (_that) {
case _GenerateConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_retries')  int? maxRetries,  int? timeout, @JsonKey(name: 'attempt_timeout')  int? attemptTimeout, @JsonKey(name: 'max_connections')  int? maxConnections, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'max_tokens')  int? maxTokens, @JsonKey(name: 'top_p')  double? topP,  double? temperature, @JsonKey(name: 'stop_seqs')  List<String>? stopSeqs, @JsonKey(name: 'best_of')  int? bestOf, @JsonKey(name: 'frequency_penalty')  double? frequencyPenalty, @JsonKey(name: 'presence_penalty')  double? presencePenalty, @JsonKey(name: 'logit_bias')  Map<String, double>? logitBias,  int? seed, @JsonKey(name: 'top_k')  int? topK, @JsonKey(name: 'num_choices')  int? numChoices,  bool? logprobs, @JsonKey(name: 'top_logprobs')  int? topLogprobs, @JsonKey(name: 'parallel_tool_calls')  bool? parallelToolCalls, @JsonKey(name: 'internal_tools')  bool? internalTools, @JsonKey(name: 'max_tool_output')  int? maxToolOutput, @JsonKey(name: 'cache_prompt')  Object? cachePrompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerateConfig() when $default != null:
return $default(_that.maxRetries,_that.timeout,_that.attemptTimeout,_that.maxConnections,_that.systemMessage,_that.maxTokens,_that.topP,_that.temperature,_that.stopSeqs,_that.bestOf,_that.frequencyPenalty,_that.presencePenalty,_that.logitBias,_that.seed,_that.topK,_that.numChoices,_that.logprobs,_that.topLogprobs,_that.parallelToolCalls,_that.internalTools,_that.maxToolOutput,_that.cachePrompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_retries')  int? maxRetries,  int? timeout, @JsonKey(name: 'attempt_timeout')  int? attemptTimeout, @JsonKey(name: 'max_connections')  int? maxConnections, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'max_tokens')  int? maxTokens, @JsonKey(name: 'top_p')  double? topP,  double? temperature, @JsonKey(name: 'stop_seqs')  List<String>? stopSeqs, @JsonKey(name: 'best_of')  int? bestOf, @JsonKey(name: 'frequency_penalty')  double? frequencyPenalty, @JsonKey(name: 'presence_penalty')  double? presencePenalty, @JsonKey(name: 'logit_bias')  Map<String, double>? logitBias,  int? seed, @JsonKey(name: 'top_k')  int? topK, @JsonKey(name: 'num_choices')  int? numChoices,  bool? logprobs, @JsonKey(name: 'top_logprobs')  int? topLogprobs, @JsonKey(name: 'parallel_tool_calls')  bool? parallelToolCalls, @JsonKey(name: 'internal_tools')  bool? internalTools, @JsonKey(name: 'max_tool_output')  int? maxToolOutput, @JsonKey(name: 'cache_prompt')  Object? cachePrompt)  $default,) {final _that = this;
switch (_that) {
case _GenerateConfig():
return $default(_that.maxRetries,_that.timeout,_that.attemptTimeout,_that.maxConnections,_that.systemMessage,_that.maxTokens,_that.topP,_that.temperature,_that.stopSeqs,_that.bestOf,_that.frequencyPenalty,_that.presencePenalty,_that.logitBias,_that.seed,_that.topK,_that.numChoices,_that.logprobs,_that.topLogprobs,_that.parallelToolCalls,_that.internalTools,_that.maxToolOutput,_that.cachePrompt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'max_retries')  int? maxRetries,  int? timeout, @JsonKey(name: 'attempt_timeout')  int? attemptTimeout, @JsonKey(name: 'max_connections')  int? maxConnections, @JsonKey(name: 'system_message')  String? systemMessage, @JsonKey(name: 'max_tokens')  int? maxTokens, @JsonKey(name: 'top_p')  double? topP,  double? temperature, @JsonKey(name: 'stop_seqs')  List<String>? stopSeqs, @JsonKey(name: 'best_of')  int? bestOf, @JsonKey(name: 'frequency_penalty')  double? frequencyPenalty, @JsonKey(name: 'presence_penalty')  double? presencePenalty, @JsonKey(name: 'logit_bias')  Map<String, double>? logitBias,  int? seed, @JsonKey(name: 'top_k')  int? topK, @JsonKey(name: 'num_choices')  int? numChoices,  bool? logprobs, @JsonKey(name: 'top_logprobs')  int? topLogprobs, @JsonKey(name: 'parallel_tool_calls')  bool? parallelToolCalls, @JsonKey(name: 'internal_tools')  bool? internalTools, @JsonKey(name: 'max_tool_output')  int? maxToolOutput, @JsonKey(name: 'cache_prompt')  Object? cachePrompt)?  $default,) {final _that = this;
switch (_that) {
case _GenerateConfig() when $default != null:
return $default(_that.maxRetries,_that.timeout,_that.attemptTimeout,_that.maxConnections,_that.systemMessage,_that.maxTokens,_that.topP,_that.temperature,_that.stopSeqs,_that.bestOf,_that.frequencyPenalty,_that.presencePenalty,_that.logitBias,_that.seed,_that.topK,_that.numChoices,_that.logprobs,_that.topLogprobs,_that.parallelToolCalls,_that.internalTools,_that.maxToolOutput,_that.cachePrompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerateConfig extends GenerateConfig {
  const _GenerateConfig({@JsonKey(name: 'max_retries') this.maxRetries, this.timeout, @JsonKey(name: 'attempt_timeout') this.attemptTimeout, @JsonKey(name: 'max_connections') this.maxConnections, @JsonKey(name: 'system_message') this.systemMessage, @JsonKey(name: 'max_tokens') this.maxTokens, @JsonKey(name: 'top_p') this.topP, this.temperature, @JsonKey(name: 'stop_seqs') final  List<String>? stopSeqs, @JsonKey(name: 'best_of') this.bestOf, @JsonKey(name: 'frequency_penalty') this.frequencyPenalty, @JsonKey(name: 'presence_penalty') this.presencePenalty, @JsonKey(name: 'logit_bias') final  Map<String, double>? logitBias, this.seed, @JsonKey(name: 'top_k') this.topK, @JsonKey(name: 'num_choices') this.numChoices, this.logprobs, @JsonKey(name: 'top_logprobs') this.topLogprobs, @JsonKey(name: 'parallel_tool_calls') this.parallelToolCalls, @JsonKey(name: 'internal_tools') this.internalTools, @JsonKey(name: 'max_tool_output') this.maxToolOutput, @JsonKey(name: 'cache_prompt') this.cachePrompt}): _stopSeqs = stopSeqs,_logitBias = logitBias,super._();
  factory _GenerateConfig.fromJson(Map<String, dynamic> json) => _$GenerateConfigFromJson(json);

/// Maximum number of times to retry a request.
@override@JsonKey(name: 'max_retries') final  int? maxRetries;
/// Request timeout (in seconds).
@override final  int? timeout;
/// Timeout for each individual request attempt (in seconds).
@override@JsonKey(name: 'attempt_timeout') final  int? attemptTimeout;
/// Maximum number of concurrent connections to the model API.
@override@JsonKey(name: 'max_connections') final  int? maxConnections;
/// System message to provide to the model.
@override@JsonKey(name: 'system_message') final  String? systemMessage;
/// Maximum number of tokens to generate.
@override@JsonKey(name: 'max_tokens') final  int? maxTokens;
/// Top-p sampling parameter.
@override@JsonKey(name: 'top_p') final  double? topP;
/// Temperature sampling parameter.
@override final  double? temperature;
/// Sequences that should stop generation.
 final  List<String>? _stopSeqs;
/// Sequences that should stop generation.
@override@JsonKey(name: 'stop_seqs') List<String>? get stopSeqs {
  final value = _stopSeqs;
  if (value == null) return null;
  if (_stopSeqs is EqualUnmodifiableListView) return _stopSeqs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Number of completions to generate and choose the best from.
@override@JsonKey(name: 'best_of') final  int? bestOf;
/// Frequency penalty parameter.
@override@JsonKey(name: 'frequency_penalty') final  double? frequencyPenalty;
/// Presence penalty parameter.
@override@JsonKey(name: 'presence_penalty') final  double? presencePenalty;
/// Logit bias parameter.
 final  Map<String, double>? _logitBias;
/// Logit bias parameter.
@override@JsonKey(name: 'logit_bias') Map<String, double>? get logitBias {
  final value = _logitBias;
  if (value == null) return null;
  if (_logitBias is EqualUnmodifiableMapView) return _logitBias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Random seed for generation.
@override final  int? seed;
/// Top-k sampling parameter.
@override@JsonKey(name: 'top_k') final  int? topK;
/// Number of completion choices to return.
@override@JsonKey(name: 'num_choices') final  int? numChoices;
/// Whether to return logprobs.
@override final  bool? logprobs;
/// Number of top logprobs to return.
@override@JsonKey(name: 'top_logprobs') final  int? topLogprobs;
/// Whether to allow parallel tool calls.
@override@JsonKey(name: 'parallel_tool_calls') final  bool? parallelToolCalls;
/// Whether to allow internal model tools.
@override@JsonKey(name: 'internal_tools') final  bool? internalTools;
/// Maximum number of characters to retain for tool output.
@override@JsonKey(name: 'max_tool_output') final  int? maxToolOutput;
/// Cache the prompt (if supported by the provider).
@override@JsonKey(name: 'cache_prompt') final  Object? cachePrompt;

/// Create a copy of GenerateConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerateConfigCopyWith<_GenerateConfig> get copyWith => __$GenerateConfigCopyWithImpl<_GenerateConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerateConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateConfig&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.attemptTimeout, attemptTimeout) || other.attemptTimeout == attemptTimeout)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&(identical(other.systemMessage, systemMessage) || other.systemMessage == systemMessage)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&(identical(other.topP, topP) || other.topP == topP)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&const DeepCollectionEquality().equals(other._stopSeqs, _stopSeqs)&&(identical(other.bestOf, bestOf) || other.bestOf == bestOf)&&(identical(other.frequencyPenalty, frequencyPenalty) || other.frequencyPenalty == frequencyPenalty)&&(identical(other.presencePenalty, presencePenalty) || other.presencePenalty == presencePenalty)&&const DeepCollectionEquality().equals(other._logitBias, _logitBias)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.topK, topK) || other.topK == topK)&&(identical(other.numChoices, numChoices) || other.numChoices == numChoices)&&(identical(other.logprobs, logprobs) || other.logprobs == logprobs)&&(identical(other.topLogprobs, topLogprobs) || other.topLogprobs == topLogprobs)&&(identical(other.parallelToolCalls, parallelToolCalls) || other.parallelToolCalls == parallelToolCalls)&&(identical(other.internalTools, internalTools) || other.internalTools == internalTools)&&(identical(other.maxToolOutput, maxToolOutput) || other.maxToolOutput == maxToolOutput)&&const DeepCollectionEquality().equals(other.cachePrompt, cachePrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,maxRetries,timeout,attemptTimeout,maxConnections,systemMessage,maxTokens,topP,temperature,const DeepCollectionEquality().hash(_stopSeqs),bestOf,frequencyPenalty,presencePenalty,const DeepCollectionEquality().hash(_logitBias),seed,topK,numChoices,logprobs,topLogprobs,parallelToolCalls,internalTools,maxToolOutput,const DeepCollectionEquality().hash(cachePrompt)]);

@override
String toString() {
  return 'GenerateConfig(maxRetries: $maxRetries, timeout: $timeout, attemptTimeout: $attemptTimeout, maxConnections: $maxConnections, systemMessage: $systemMessage, maxTokens: $maxTokens, topP: $topP, temperature: $temperature, stopSeqs: $stopSeqs, bestOf: $bestOf, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, logitBias: $logitBias, seed: $seed, topK: $topK, numChoices: $numChoices, logprobs: $logprobs, topLogprobs: $topLogprobs, parallelToolCalls: $parallelToolCalls, internalTools: $internalTools, maxToolOutput: $maxToolOutput, cachePrompt: $cachePrompt)';
}


}

/// @nodoc
abstract mixin class _$GenerateConfigCopyWith<$Res> implements $GenerateConfigCopyWith<$Res> {
  factory _$GenerateConfigCopyWith(_GenerateConfig value, $Res Function(_GenerateConfig) _then) = __$GenerateConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'max_retries') int? maxRetries, int? timeout,@JsonKey(name: 'attempt_timeout') int? attemptTimeout,@JsonKey(name: 'max_connections') int? maxConnections,@JsonKey(name: 'system_message') String? systemMessage,@JsonKey(name: 'max_tokens') int? maxTokens,@JsonKey(name: 'top_p') double? topP, double? temperature,@JsonKey(name: 'stop_seqs') List<String>? stopSeqs,@JsonKey(name: 'best_of') int? bestOf,@JsonKey(name: 'frequency_penalty') double? frequencyPenalty,@JsonKey(name: 'presence_penalty') double? presencePenalty,@JsonKey(name: 'logit_bias') Map<String, double>? logitBias, int? seed,@JsonKey(name: 'top_k') int? topK,@JsonKey(name: 'num_choices') int? numChoices, bool? logprobs,@JsonKey(name: 'top_logprobs') int? topLogprobs,@JsonKey(name: 'parallel_tool_calls') bool? parallelToolCalls,@JsonKey(name: 'internal_tools') bool? internalTools,@JsonKey(name: 'max_tool_output') int? maxToolOutput,@JsonKey(name: 'cache_prompt') Object? cachePrompt
});




}
/// @nodoc
class __$GenerateConfigCopyWithImpl<$Res>
    implements _$GenerateConfigCopyWith<$Res> {
  __$GenerateConfigCopyWithImpl(this._self, this._then);

  final _GenerateConfig _self;
  final $Res Function(_GenerateConfig) _then;

/// Create a copy of GenerateConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxRetries = freezed,Object? timeout = freezed,Object? attemptTimeout = freezed,Object? maxConnections = freezed,Object? systemMessage = freezed,Object? maxTokens = freezed,Object? topP = freezed,Object? temperature = freezed,Object? stopSeqs = freezed,Object? bestOf = freezed,Object? frequencyPenalty = freezed,Object? presencePenalty = freezed,Object? logitBias = freezed,Object? seed = freezed,Object? topK = freezed,Object? numChoices = freezed,Object? logprobs = freezed,Object? topLogprobs = freezed,Object? parallelToolCalls = freezed,Object? internalTools = freezed,Object? maxToolOutput = freezed,Object? cachePrompt = freezed,}) {
  return _then(_GenerateConfig(
maxRetries: freezed == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int?,timeout: freezed == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int?,attemptTimeout: freezed == attemptTimeout ? _self.attemptTimeout : attemptTimeout // ignore: cast_nullable_to_non_nullable
as int?,maxConnections: freezed == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int?,systemMessage: freezed == systemMessage ? _self.systemMessage : systemMessage // ignore: cast_nullable_to_non_nullable
as String?,maxTokens: freezed == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int?,topP: freezed == topP ? _self.topP : topP // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,stopSeqs: freezed == stopSeqs ? _self._stopSeqs : stopSeqs // ignore: cast_nullable_to_non_nullable
as List<String>?,bestOf: freezed == bestOf ? _self.bestOf : bestOf // ignore: cast_nullable_to_non_nullable
as int?,frequencyPenalty: freezed == frequencyPenalty ? _self.frequencyPenalty : frequencyPenalty // ignore: cast_nullable_to_non_nullable
as double?,presencePenalty: freezed == presencePenalty ? _self.presencePenalty : presencePenalty // ignore: cast_nullable_to_non_nullable
as double?,logitBias: freezed == logitBias ? _self._logitBias : logitBias // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,topK: freezed == topK ? _self.topK : topK // ignore: cast_nullable_to_non_nullable
as int?,numChoices: freezed == numChoices ? _self.numChoices : numChoices // ignore: cast_nullable_to_non_nullable
as int?,logprobs: freezed == logprobs ? _self.logprobs : logprobs // ignore: cast_nullable_to_non_nullable
as bool?,topLogprobs: freezed == topLogprobs ? _self.topLogprobs : topLogprobs // ignore: cast_nullable_to_non_nullable
as int?,parallelToolCalls: freezed == parallelToolCalls ? _self.parallelToolCalls : parallelToolCalls // ignore: cast_nullable_to_non_nullable
as bool?,internalTools: freezed == internalTools ? _self.internalTools : internalTools // ignore: cast_nullable_to_non_nullable
as bool?,maxToolOutput: freezed == maxToolOutput ? _self.maxToolOutput : maxToolOutput // ignore: cast_nullable_to_non_nullable
as int?,cachePrompt: freezed == cachePrompt ? _self.cachePrompt : cachePrompt ,
  ));
}


}


/// @nodoc
mixin _$Logprobs {

/// Logprob content.
 List<Object> get content;
/// Create a copy of Logprobs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogprobsCopyWith<Logprobs> get copyWith => _$LogprobsCopyWithImpl<Logprobs>(this as Logprobs, _$identity);

  /// Serializes this Logprobs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Logprobs&&const DeepCollectionEquality().equals(other.content, content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content));

@override
String toString() {
  return 'Logprobs(content: $content)';
}


}

/// @nodoc
abstract mixin class $LogprobsCopyWith<$Res>  {
  factory $LogprobsCopyWith(Logprobs value, $Res Function(Logprobs) _then) = _$LogprobsCopyWithImpl;
@useResult
$Res call({
 List<Object> content
});




}
/// @nodoc
class _$LogprobsCopyWithImpl<$Res>
    implements $LogprobsCopyWith<$Res> {
  _$LogprobsCopyWithImpl(this._self, this._then);

  final Logprobs _self;
  final $Res Function(Logprobs) _then;

/// Create a copy of Logprobs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}

}


/// Adds pattern-matching-related methods to [Logprobs].
extension LogprobsPatterns on Logprobs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Logprobs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Logprobs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Logprobs value)  $default,){
final _that = this;
switch (_that) {
case _Logprobs():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Logprobs value)?  $default,){
final _that = this;
switch (_that) {
case _Logprobs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Object> content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Logprobs() when $default != null:
return $default(_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Object> content)  $default,) {final _that = this;
switch (_that) {
case _Logprobs():
return $default(_that.content);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Object> content)?  $default,) {final _that = this;
switch (_that) {
case _Logprobs() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Logprobs extends Logprobs {
  const _Logprobs({required final  List<Object> content}): _content = content,super._();
  factory _Logprobs.fromJson(Map<String, dynamic> json) => _$LogprobsFromJson(json);

/// Logprob content.
 final  List<Object> _content;
/// Logprob content.
@override List<Object> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}


/// Create a copy of Logprobs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogprobsCopyWith<_Logprobs> get copyWith => __$LogprobsCopyWithImpl<_Logprobs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogprobsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Logprobs&&const DeepCollectionEquality().equals(other._content, _content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content));

@override
String toString() {
  return 'Logprobs(content: $content)';
}


}

/// @nodoc
abstract mixin class _$LogprobsCopyWith<$Res> implements $LogprobsCopyWith<$Res> {
  factory _$LogprobsCopyWith(_Logprobs value, $Res Function(_Logprobs) _then) = __$LogprobsCopyWithImpl;
@override @useResult
$Res call({
 List<Object> content
});




}
/// @nodoc
class __$LogprobsCopyWithImpl<$Res>
    implements _$LogprobsCopyWith<$Res> {
  __$LogprobsCopyWithImpl(this._self, this._then);

  final _Logprobs _self;
  final $Res Function(_Logprobs) _then;

/// Create a copy of Logprobs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(_Logprobs(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}


}


/// @nodoc
mixin _$ProvenanceData {

/// Source location.
 String get location;/// Static hash.
 String get shash;
/// Create a copy of ProvenanceData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProvenanceDataCopyWith<ProvenanceData> get copyWith => _$ProvenanceDataCopyWithImpl<ProvenanceData>(this as ProvenanceData, _$identity);

  /// Serializes this ProvenanceData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProvenanceData&&(identical(other.location, location) || other.location == location)&&(identical(other.shash, shash) || other.shash == shash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,shash);

@override
String toString() {
  return 'ProvenanceData(location: $location, shash: $shash)';
}


}

/// @nodoc
abstract mixin class $ProvenanceDataCopyWith<$Res>  {
  factory $ProvenanceDataCopyWith(ProvenanceData value, $Res Function(ProvenanceData) _then) = _$ProvenanceDataCopyWithImpl;
@useResult
$Res call({
 String location, String shash
});




}
/// @nodoc
class _$ProvenanceDataCopyWithImpl<$Res>
    implements $ProvenanceDataCopyWith<$Res> {
  _$ProvenanceDataCopyWithImpl(this._self, this._then);

  final ProvenanceData _self;
  final $Res Function(ProvenanceData) _then;

/// Create a copy of ProvenanceData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? shash = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,shash: null == shash ? _self.shash : shash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProvenanceData].
extension ProvenanceDataPatterns on ProvenanceData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProvenanceData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProvenanceData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProvenanceData value)  $default,){
final _that = this;
switch (_that) {
case _ProvenanceData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProvenanceData value)?  $default,){
final _that = this;
switch (_that) {
case _ProvenanceData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String location,  String shash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProvenanceData() when $default != null:
return $default(_that.location,_that.shash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String location,  String shash)  $default,) {final _that = this;
switch (_that) {
case _ProvenanceData():
return $default(_that.location,_that.shash);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String location,  String shash)?  $default,) {final _that = this;
switch (_that) {
case _ProvenanceData() when $default != null:
return $default(_that.location,_that.shash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProvenanceData extends ProvenanceData {
  const _ProvenanceData({required this.location, required this.shash}): super._();
  factory _ProvenanceData.fromJson(Map<String, dynamic> json) => _$ProvenanceDataFromJson(json);

/// Source location.
@override final  String location;
/// Static hash.
@override final  String shash;

/// Create a copy of ProvenanceData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProvenanceDataCopyWith<_ProvenanceData> get copyWith => __$ProvenanceDataCopyWithImpl<_ProvenanceData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProvenanceDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProvenanceData&&(identical(other.location, location) || other.location == location)&&(identical(other.shash, shash) || other.shash == shash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,shash);

@override
String toString() {
  return 'ProvenanceData(location: $location, shash: $shash)';
}


}

/// @nodoc
abstract mixin class _$ProvenanceDataCopyWith<$Res> implements $ProvenanceDataCopyWith<$Res> {
  factory _$ProvenanceDataCopyWith(_ProvenanceData value, $Res Function(_ProvenanceData) _then) = __$ProvenanceDataCopyWithImpl;
@override @useResult
$Res call({
 String location, String shash
});




}
/// @nodoc
class __$ProvenanceDataCopyWithImpl<$Res>
    implements _$ProvenanceDataCopyWith<$Res> {
  __$ProvenanceDataCopyWithImpl(this._self, this._then);

  final _ProvenanceData _self;
  final $Res Function(_ProvenanceData) _then;

/// Create a copy of ProvenanceData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? shash = null,}) {
  return _then(_ProvenanceData(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,shash: null == shash ? _self.shash : shash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EvalSampleLimit {

/// The type of limit.
 String get type;/// The limit value.
 double get limit;
/// Create a copy of EvalSampleLimit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSampleLimitCopyWith<EvalSampleLimit> get copyWith => _$EvalSampleLimitCopyWithImpl<EvalSampleLimit>(this as EvalSampleLimit, _$identity);

  /// Serializes this EvalSampleLimit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSampleLimit&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit);

@override
String toString() {
  return 'EvalSampleLimit(type: $type, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $EvalSampleLimitCopyWith<$Res>  {
  factory $EvalSampleLimitCopyWith(EvalSampleLimit value, $Res Function(EvalSampleLimit) _then) = _$EvalSampleLimitCopyWithImpl;
@useResult
$Res call({
 String type, double limit
});




}
/// @nodoc
class _$EvalSampleLimitCopyWithImpl<$Res>
    implements $EvalSampleLimitCopyWith<$Res> {
  _$EvalSampleLimitCopyWithImpl(this._self, this._then);

  final EvalSampleLimit _self;
  final $Res Function(EvalSampleLimit) _then;

/// Create a copy of EvalSampleLimit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? limit = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSampleLimit].
extension EvalSampleLimitPatterns on EvalSampleLimit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSampleLimit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSampleLimit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSampleLimit value)  $default,){
final _that = this;
switch (_that) {
case _EvalSampleLimit():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSampleLimit value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSampleLimit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  double limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSampleLimit() when $default != null:
return $default(_that.type,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  double limit)  $default,) {final _that = this;
switch (_that) {
case _EvalSampleLimit():
return $default(_that.type,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  double limit)?  $default,) {final _that = this;
switch (_that) {
case _EvalSampleLimit() when $default != null:
return $default(_that.type,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSampleLimit extends EvalSampleLimit {
  const _EvalSampleLimit({required this.type, required this.limit}): super._();
  factory _EvalSampleLimit.fromJson(Map<String, dynamic> json) => _$EvalSampleLimitFromJson(json);

/// The type of limit.
@override final  String type;
/// The limit value.
@override final  double limit;

/// Create a copy of EvalSampleLimit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSampleLimitCopyWith<_EvalSampleLimit> get copyWith => __$EvalSampleLimitCopyWithImpl<_EvalSampleLimit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSampleLimitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSampleLimit&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,limit);

@override
String toString() {
  return 'EvalSampleLimit(type: $type, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$EvalSampleLimitCopyWith<$Res> implements $EvalSampleLimitCopyWith<$Res> {
  factory _$EvalSampleLimitCopyWith(_EvalSampleLimit value, $Res Function(_EvalSampleLimit) _then) = __$EvalSampleLimitCopyWithImpl;
@override @useResult
$Res call({
 String type, double limit
});




}
/// @nodoc
class __$EvalSampleLimitCopyWithImpl<$Res>
    implements _$EvalSampleLimitCopyWith<$Res> {
  __$EvalSampleLimitCopyWithImpl(this._self, this._then);

  final _EvalSampleLimit _self;
  final $Res Function(_EvalSampleLimit) _then;

/// Create a copy of EvalSampleLimit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? limit = null,}) {
  return _then(_EvalSampleLimit(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EvalSetInfo {

/// Globally unique id for eval set.
@JsonKey(name: 'eval_set_id') String get evalSetId;/// Tasks in the eval set.
 List<EvalSetTask> get tasks;
/// Create a copy of EvalSetInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSetInfoCopyWith<EvalSetInfo> get copyWith => _$EvalSetInfoCopyWithImpl<EvalSetInfo>(this as EvalSetInfo, _$identity);

  /// Serializes this EvalSetInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSetInfo&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,evalSetId,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'EvalSetInfo(evalSetId: $evalSetId, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $EvalSetInfoCopyWith<$Res>  {
  factory $EvalSetInfoCopyWith(EvalSetInfo value, $Res Function(EvalSetInfo) _then) = _$EvalSetInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'eval_set_id') String evalSetId, List<EvalSetTask> tasks
});




}
/// @nodoc
class _$EvalSetInfoCopyWithImpl<$Res>
    implements $EvalSetInfoCopyWith<$Res> {
  _$EvalSetInfoCopyWithImpl(this._self, this._then);

  final EvalSetInfo _self;
  final $Res Function(EvalSetInfo) _then;

/// Create a copy of EvalSetInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? evalSetId = null,Object? tasks = null,}) {
  return _then(_self.copyWith(
evalSetId: null == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EvalSetTask>,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSetInfo].
extension EvalSetInfoPatterns on EvalSetInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSetInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSetInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSetInfo value)  $default,){
final _that = this;
switch (_that) {
case _EvalSetInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSetInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSetInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'eval_set_id')  String evalSetId,  List<EvalSetTask> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSetInfo() when $default != null:
return $default(_that.evalSetId,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'eval_set_id')  String evalSetId,  List<EvalSetTask> tasks)  $default,) {final _that = this;
switch (_that) {
case _EvalSetInfo():
return $default(_that.evalSetId,_that.tasks);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'eval_set_id')  String evalSetId,  List<EvalSetTask> tasks)?  $default,) {final _that = this;
switch (_that) {
case _EvalSetInfo() when $default != null:
return $default(_that.evalSetId,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSetInfo extends EvalSetInfo {
  const _EvalSetInfo({@JsonKey(name: 'eval_set_id') required this.evalSetId, required final  List<EvalSetTask> tasks}): _tasks = tasks,super._();
  factory _EvalSetInfo.fromJson(Map<String, dynamic> json) => _$EvalSetInfoFromJson(json);

/// Globally unique id for eval set.
@override@JsonKey(name: 'eval_set_id') final  String evalSetId;
/// Tasks in the eval set.
 final  List<EvalSetTask> _tasks;
/// Tasks in the eval set.
@override List<EvalSetTask> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of EvalSetInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSetInfoCopyWith<_EvalSetInfo> get copyWith => __$EvalSetInfoCopyWithImpl<_EvalSetInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSetInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSetInfo&&(identical(other.evalSetId, evalSetId) || other.evalSetId == evalSetId)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,evalSetId,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'EvalSetInfo(evalSetId: $evalSetId, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$EvalSetInfoCopyWith<$Res> implements $EvalSetInfoCopyWith<$Res> {
  factory _$EvalSetInfoCopyWith(_EvalSetInfo value, $Res Function(_EvalSetInfo) _then) = __$EvalSetInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'eval_set_id') String evalSetId, List<EvalSetTask> tasks
});




}
/// @nodoc
class __$EvalSetInfoCopyWithImpl<$Res>
    implements _$EvalSetInfoCopyWith<$Res> {
  __$EvalSetInfoCopyWithImpl(this._self, this._then);

  final _EvalSetInfo _self;
  final $Res Function(_EvalSetInfo) _then;

/// Create a copy of EvalSetInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? evalSetId = null,Object? tasks = null,}) {
  return _then(_EvalSetInfo(
evalSetId: null == evalSetId ? _self.evalSetId : evalSetId // ignore: cast_nullable_to_non_nullable
as String,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EvalSetTask>,
  ));
}


}


/// @nodoc
mixin _$EvalSetTask {

/// Task name.
 String? get name;/// Unique task id.
@JsonKey(name: 'task_id') String get taskId;/// Task source file.
@JsonKey(name: 'task_file') String? get taskFile;/// Task arguments.
@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> get taskArgs;/// Model used for evaluation.
 String get model;/// Model specific arguments.
@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> get modelArgs;/// Model roles.
@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles;/// Sequence number of task in eval set.
 int get sequence;
/// Create a copy of EvalSetTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvalSetTaskCopyWith<EvalSetTask> get copyWith => _$EvalSetTaskCopyWithImpl<EvalSetTask>(this as EvalSetTask, _$identity);

  /// Serializes this EvalSetTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvalSetTask&&(identical(other.name, name) || other.name == name)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskFile, taskFile) || other.taskFile == taskFile)&&const DeepCollectionEquality().equals(other.taskArgs, taskArgs)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.modelArgs, modelArgs)&&const DeepCollectionEquality().equals(other.modelRoles, modelRoles)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,taskId,taskFile,const DeepCollectionEquality().hash(taskArgs),model,const DeepCollectionEquality().hash(modelArgs),const DeepCollectionEquality().hash(modelRoles),sequence);

@override
String toString() {
  return 'EvalSetTask(name: $name, taskId: $taskId, taskFile: $taskFile, taskArgs: $taskArgs, model: $model, modelArgs: $modelArgs, modelRoles: $modelRoles, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class $EvalSetTaskCopyWith<$Res>  {
  factory $EvalSetTaskCopyWith(EvalSetTask value, $Res Function(EvalSetTask) _then) = _$EvalSetTaskCopyWithImpl;
@useResult
$Res call({
 String? name,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'task_file') String? taskFile,@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> taskArgs, String model,@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, int sequence
});




}
/// @nodoc
class _$EvalSetTaskCopyWithImpl<$Res>
    implements $EvalSetTaskCopyWith<$Res> {
  _$EvalSetTaskCopyWithImpl(this._self, this._then);

  final EvalSetTask _self;
  final $Res Function(EvalSetTask) _then;

/// Create a copy of EvalSetTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? taskId = null,Object? taskFile = freezed,Object? taskArgs = null,Object? model = null,Object? modelArgs = null,Object? modelRoles = freezed,Object? sequence = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskFile: freezed == taskFile ? _self.taskFile : taskFile // ignore: cast_nullable_to_non_nullable
as String?,taskArgs: null == taskArgs ? _self.taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,modelArgs: null == modelArgs ? _self.modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,modelRoles: freezed == modelRoles ? _self.modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EvalSetTask].
extension EvalSetTaskPatterns on EvalSetTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvalSetTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvalSetTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvalSetTask value)  $default,){
final _that = this;
switch (_that) {
case _EvalSetTask():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvalSetTask value)?  $default,){
final _that = this;
switch (_that) {
case _EvalSetTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs,  String model, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  int sequence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvalSetTask() when $default != null:
return $default(_that.name,_that.taskId,_that.taskFile,_that.taskArgs,_that.model,_that.modelArgs,_that.modelRoles,_that.sequence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs,  String model, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  int sequence)  $default,) {final _that = this;
switch (_that) {
case _EvalSetTask():
return $default(_that.name,_that.taskId,_that.taskFile,_that.taskArgs,_that.model,_that.modelArgs,_that.modelRoles,_that.sequence);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name, @JsonKey(name: 'task_id')  String taskId, @JsonKey(name: 'task_file')  String? taskFile, @JsonKey(name: 'task_args', defaultValue: {})  Map<String, dynamic> taskArgs,  String model, @JsonKey(name: 'model_args', defaultValue: {})  Map<String, dynamic> modelArgs, @JsonKey(name: 'model_roles')  Map<String, String>? modelRoles,  int sequence)?  $default,) {final _that = this;
switch (_that) {
case _EvalSetTask() when $default != null:
return $default(_that.name,_that.taskId,_that.taskFile,_that.taskArgs,_that.model,_that.modelArgs,_that.modelRoles,_that.sequence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvalSetTask extends EvalSetTask {
  const _EvalSetTask({this.name, @JsonKey(name: 'task_id') required this.taskId, @JsonKey(name: 'task_file') this.taskFile, @JsonKey(name: 'task_args', defaultValue: {}) final  Map<String, dynamic> taskArgs = const {}, required this.model, @JsonKey(name: 'model_args', defaultValue: {}) final  Map<String, dynamic> modelArgs = const {}, @JsonKey(name: 'model_roles') final  Map<String, String>? modelRoles, required this.sequence}): _taskArgs = taskArgs,_modelArgs = modelArgs,_modelRoles = modelRoles,super._();
  factory _EvalSetTask.fromJson(Map<String, dynamic> json) => _$EvalSetTaskFromJson(json);

/// Task name.
@override final  String? name;
/// Unique task id.
@override@JsonKey(name: 'task_id') final  String taskId;
/// Task source file.
@override@JsonKey(name: 'task_file') final  String? taskFile;
/// Task arguments.
 final  Map<String, dynamic> _taskArgs;
/// Task arguments.
@override@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> get taskArgs {
  if (_taskArgs is EqualUnmodifiableMapView) return _taskArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskArgs);
}

/// Model used for evaluation.
@override final  String model;
/// Model specific arguments.
 final  Map<String, dynamic> _modelArgs;
/// Model specific arguments.
@override@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> get modelArgs {
  if (_modelArgs is EqualUnmodifiableMapView) return _modelArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modelArgs);
}

/// Model roles.
 final  Map<String, String>? _modelRoles;
/// Model roles.
@override@JsonKey(name: 'model_roles') Map<String, String>? get modelRoles {
  final value = _modelRoles;
  if (value == null) return null;
  if (_modelRoles is EqualUnmodifiableMapView) return _modelRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Sequence number of task in eval set.
@override final  int sequence;

/// Create a copy of EvalSetTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvalSetTaskCopyWith<_EvalSetTask> get copyWith => __$EvalSetTaskCopyWithImpl<_EvalSetTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvalSetTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvalSetTask&&(identical(other.name, name) || other.name == name)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskFile, taskFile) || other.taskFile == taskFile)&&const DeepCollectionEquality().equals(other._taskArgs, _taskArgs)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._modelArgs, _modelArgs)&&const DeepCollectionEquality().equals(other._modelRoles, _modelRoles)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,taskId,taskFile,const DeepCollectionEquality().hash(_taskArgs),model,const DeepCollectionEquality().hash(_modelArgs),const DeepCollectionEquality().hash(_modelRoles),sequence);

@override
String toString() {
  return 'EvalSetTask(name: $name, taskId: $taskId, taskFile: $taskFile, taskArgs: $taskArgs, model: $model, modelArgs: $modelArgs, modelRoles: $modelRoles, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class _$EvalSetTaskCopyWith<$Res> implements $EvalSetTaskCopyWith<$Res> {
  factory _$EvalSetTaskCopyWith(_EvalSetTask value, $Res Function(_EvalSetTask) _then) = __$EvalSetTaskCopyWithImpl;
@override @useResult
$Res call({
 String? name,@JsonKey(name: 'task_id') String taskId,@JsonKey(name: 'task_file') String? taskFile,@JsonKey(name: 'task_args', defaultValue: {}) Map<String, dynamic> taskArgs, String model,@JsonKey(name: 'model_args', defaultValue: {}) Map<String, dynamic> modelArgs,@JsonKey(name: 'model_roles') Map<String, String>? modelRoles, int sequence
});




}
/// @nodoc
class __$EvalSetTaskCopyWithImpl<$Res>
    implements _$EvalSetTaskCopyWith<$Res> {
  __$EvalSetTaskCopyWithImpl(this._self, this._then);

  final _EvalSetTask _self;
  final $Res Function(_EvalSetTask) _then;

/// Create a copy of EvalSetTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? taskId = null,Object? taskFile = freezed,Object? taskArgs = null,Object? model = null,Object? modelArgs = null,Object? modelRoles = freezed,Object? sequence = null,}) {
  return _then(_EvalSetTask(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskFile: freezed == taskFile ? _self.taskFile : taskFile // ignore: cast_nullable_to_non_nullable
as String?,taskArgs: null == taskArgs ? _self._taskArgs : taskArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,modelArgs: null == modelArgs ? _self._modelArgs : modelArgs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,modelRoles: freezed == modelRoles ? _self._modelRoles : modelRoles // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
