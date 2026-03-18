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
 String? get description;/// Directory to write evaluation logs to.
@JsonKey(name: 'log_dir') String get logDir;/// Maximum concurrent API connections.
@JsonKey(name: 'max_connections') int get maxConnections;/// Models to run. `null` means use defaults from registries.
 List<String>? get models;/// Named variant map. Keys are variant names, values are config dicts.
/// `null` means baseline only.
 Map<String, Map<String, dynamic>>? get variants;/// Glob patterns for discovering task directories (relative to dataset root).
@JsonKey(name: 'task_paths') List<String>? get taskPaths;/// Per-task configurations with inline overrides.
/// `null` means run all tasks.
 Map<String, JobTask>? get tasks;/// If `true`, copy final workspace to `<logDir>/examples/` after each sample.
@JsonKey(name: 'save_examples') bool get saveExamples;// ------------------------------------------------------------------
// Sandbox configuration
// ------------------------------------------------------------------
/// Sandbox config with keys: environment, parameters, image_prefix.
 Map<String, dynamic>? get sandbox;// ------------------------------------------------------------------
// Inspect eval arguments (passed through to eval_set())
// ------------------------------------------------------------------
/// All Inspect AI eval_set() parameters, nested under one key.
@JsonKey(name: 'inspect_eval_arguments') Map<String, dynamic>? get inspectEvalArguments;// ------------------------------------------------------------------
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.description, description) || other.description == description)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&const DeepCollectionEquality().equals(other.models, models)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.taskPaths, taskPaths)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.saveExamples, saveExamples) || other.saveExamples == saveExamples)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other.inspectEvalArguments, inspectEvalArguments)&&(identical(other.taskFilters, taskFilters) || other.taskFilters == taskFilters)&&(identical(other.sampleFilters, sampleFilters) || other.sampleFilters == sampleFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,logDir,maxConnections,const DeepCollectionEquality().hash(models),const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(taskPaths),const DeepCollectionEquality().hash(tasks),saveExamples,const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(inspectEvalArguments),taskFilters,sampleFilters);

@override
String toString() {
  return 'Job(description: $description, logDir: $logDir, maxConnections: $maxConnections, models: $models, variants: $variants, taskPaths: $taskPaths, tasks: $tasks, saveExamples: $saveExamples, sandbox: $sandbox, inspectEvalArguments: $inspectEvalArguments, taskFilters: $taskFilters, sampleFilters: $sampleFilters)';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String? description,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'max_connections') int maxConnections, List<String>? models, Map<String, Map<String, dynamic>>? variants,@JsonKey(name: 'task_paths') List<String>? taskPaths, Map<String, JobTask>? tasks,@JsonKey(name: 'save_examples') bool saveExamples, Map<String, dynamic>? sandbox,@JsonKey(name: 'inspect_eval_arguments') Map<String, dynamic>? inspectEvalArguments,@JsonKey(name: 'task_filters') TagFilter? taskFilters,@JsonKey(name: 'sample_filters') TagFilter? sampleFilters
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
@pragma('vm:prefer-inline') @override $Res call({Object? description = freezed,Object? logDir = null,Object? maxConnections = null,Object? models = freezed,Object? variants = freezed,Object? taskPaths = freezed,Object? tasks = freezed,Object? saveExamples = null,Object? sandbox = freezed,Object? inspectEvalArguments = freezed,Object? taskFilters = freezed,Object? sampleFilters = freezed,}) {
  return _then(_self.copyWith(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,maxConnections: null == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int,models: freezed == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<String>?,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,taskPaths: freezed == taskPaths ? _self.taskPaths : taskPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,tasks: freezed == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, JobTask>?,saveExamples: null == saveExamples ? _self.saveExamples : saveExamples // ignore: cast_nullable_to_non_nullable
as bool,sandbox: freezed == sandbox ? _self.sandbox : sandbox // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,inspectEvalArguments: freezed == inspectEvalArguments ? _self.inspectEvalArguments : inspectEvalArguments // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? description, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples,  Map<String, dynamic>? sandbox, @JsonKey(name: 'inspect_eval_arguments')  Map<String, dynamic>? inspectEvalArguments, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.description,_that.logDir,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.sandbox,_that.inspectEvalArguments,_that.taskFilters,_that.sampleFilters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? description, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples,  Map<String, dynamic>? sandbox, @JsonKey(name: 'inspect_eval_arguments')  Map<String, dynamic>? inspectEvalArguments, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.description,_that.logDir,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.sandbox,_that.inspectEvalArguments,_that.taskFilters,_that.sampleFilters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? description, @JsonKey(name: 'log_dir')  String logDir, @JsonKey(name: 'max_connections')  int maxConnections,  List<String>? models,  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths')  List<String>? taskPaths,  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples')  bool saveExamples,  Map<String, dynamic>? sandbox, @JsonKey(name: 'inspect_eval_arguments')  Map<String, dynamic>? inspectEvalArguments, @JsonKey(name: 'task_filters')  TagFilter? taskFilters, @JsonKey(name: 'sample_filters')  TagFilter? sampleFilters)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.description,_that.logDir,_that.maxConnections,_that.models,_that.variants,_that.taskPaths,_that.tasks,_that.saveExamples,_that.sandbox,_that.inspectEvalArguments,_that.taskFilters,_that.sampleFilters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Job implements Job {
  const _Job({this.description, @JsonKey(name: 'log_dir') required this.logDir, @JsonKey(name: 'max_connections') this.maxConnections = 10, final  List<String>? models, final  Map<String, Map<String, dynamic>>? variants, @JsonKey(name: 'task_paths') final  List<String>? taskPaths, final  Map<String, JobTask>? tasks, @JsonKey(name: 'save_examples') this.saveExamples = false, final  Map<String, dynamic>? sandbox, @JsonKey(name: 'inspect_eval_arguments') final  Map<String, dynamic>? inspectEvalArguments, @JsonKey(name: 'task_filters') this.taskFilters, @JsonKey(name: 'sample_filters') this.sampleFilters}): _models = models,_variants = variants,_taskPaths = taskPaths,_tasks = tasks,_sandbox = sandbox,_inspectEvalArguments = inspectEvalArguments;
  factory _Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

// ------------------------------------------------------------------
// Core job settings
// ------------------------------------------------------------------
/// Human-readable description of this job.
@override final  String? description;
/// Directory to write evaluation logs to.
@override@JsonKey(name: 'log_dir') final  String logDir;
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
// Sandbox configuration
// ------------------------------------------------------------------
/// Sandbox config with keys: environment, parameters, image_prefix.
 final  Map<String, dynamic>? _sandbox;
// ------------------------------------------------------------------
// Sandbox configuration
// ------------------------------------------------------------------
/// Sandbox config with keys: environment, parameters, image_prefix.
@override Map<String, dynamic>? get sandbox {
  final value = _sandbox;
  if (value == null) return null;
  if (_sandbox is EqualUnmodifiableMapView) return _sandbox;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// ------------------------------------------------------------------
// Inspect eval arguments (passed through to eval_set())
// ------------------------------------------------------------------
/// All Inspect AI eval_set() parameters, nested under one key.
 final  Map<String, dynamic>? _inspectEvalArguments;
// ------------------------------------------------------------------
// Inspect eval arguments (passed through to eval_set())
// ------------------------------------------------------------------
/// All Inspect AI eval_set() parameters, nested under one key.
@override@JsonKey(name: 'inspect_eval_arguments') Map<String, dynamic>? get inspectEvalArguments {
  final value = _inspectEvalArguments;
  if (value == null) return null;
  if (_inspectEvalArguments is EqualUnmodifiableMapView) return _inspectEvalArguments;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.description, description) || other.description == description)&&(identical(other.logDir, logDir) || other.logDir == logDir)&&(identical(other.maxConnections, maxConnections) || other.maxConnections == maxConnections)&&const DeepCollectionEquality().equals(other._models, _models)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._taskPaths, _taskPaths)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.saveExamples, saveExamples) || other.saveExamples == saveExamples)&&const DeepCollectionEquality().equals(other._sandbox, _sandbox)&&const DeepCollectionEquality().equals(other._inspectEvalArguments, _inspectEvalArguments)&&(identical(other.taskFilters, taskFilters) || other.taskFilters == taskFilters)&&(identical(other.sampleFilters, sampleFilters) || other.sampleFilters == sampleFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,logDir,maxConnections,const DeepCollectionEquality().hash(_models),const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_taskPaths),const DeepCollectionEquality().hash(_tasks),saveExamples,const DeepCollectionEquality().hash(_sandbox),const DeepCollectionEquality().hash(_inspectEvalArguments),taskFilters,sampleFilters);

@override
String toString() {
  return 'Job(description: $description, logDir: $logDir, maxConnections: $maxConnections, models: $models, variants: $variants, taskPaths: $taskPaths, tasks: $tasks, saveExamples: $saveExamples, sandbox: $sandbox, inspectEvalArguments: $inspectEvalArguments, taskFilters: $taskFilters, sampleFilters: $sampleFilters)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String? description,@JsonKey(name: 'log_dir') String logDir,@JsonKey(name: 'max_connections') int maxConnections, List<String>? models, Map<String, Map<String, dynamic>>? variants,@JsonKey(name: 'task_paths') List<String>? taskPaths, Map<String, JobTask>? tasks,@JsonKey(name: 'save_examples') bool saveExamples, Map<String, dynamic>? sandbox,@JsonKey(name: 'inspect_eval_arguments') Map<String, dynamic>? inspectEvalArguments,@JsonKey(name: 'task_filters') TagFilter? taskFilters,@JsonKey(name: 'sample_filters') TagFilter? sampleFilters
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
@override @pragma('vm:prefer-inline') $Res call({Object? description = freezed,Object? logDir = null,Object? maxConnections = null,Object? models = freezed,Object? variants = freezed,Object? taskPaths = freezed,Object? tasks = freezed,Object? saveExamples = null,Object? sandbox = freezed,Object? inspectEvalArguments = freezed,Object? taskFilters = freezed,Object? sampleFilters = freezed,}) {
  return _then(_Job(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,logDir: null == logDir ? _self.logDir : logDir // ignore: cast_nullable_to_non_nullable
as String,maxConnections: null == maxConnections ? _self.maxConnections : maxConnections // ignore: cast_nullable_to_non_nullable
as int,models: freezed == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<String>?,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,taskPaths: freezed == taskPaths ? _self._taskPaths : taskPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,tasks: freezed == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, JobTask>?,saveExamples: null == saveExamples ? _self.saveExamples : saveExamples // ignore: cast_nullable_to_non_nullable
as bool,sandbox: freezed == sandbox ? _self._sandbox : sandbox // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,inspectEvalArguments: freezed == inspectEvalArguments ? _self._inspectEvalArguments : inspectEvalArguments // ignore: cast_nullable_to_non_nullable
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
@JsonKey(name: 'exclude_samples') List<String>? get excludeSamples;/// Only run these variant names for this task.
@JsonKey(name: 'include_variants') List<String>? get includeVariants;/// Exclude these variant names for this task.
@JsonKey(name: 'exclude_variants') List<String>? get excludeVariants;/// Per-task argument overrides passed to the task function.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobTask&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.includeSamples, includeSamples)&&const DeepCollectionEquality().equals(other.excludeSamples, excludeSamples)&&const DeepCollectionEquality().equals(other.includeVariants, includeVariants)&&const DeepCollectionEquality().equals(other.excludeVariants, excludeVariants)&&const DeepCollectionEquality().equals(other.args, args));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(includeSamples),const DeepCollectionEquality().hash(excludeSamples),const DeepCollectionEquality().hash(includeVariants),const DeepCollectionEquality().hash(excludeVariants),const DeepCollectionEquality().hash(args));

@override
String toString() {
  return 'JobTask(id: $id, includeSamples: $includeSamples, excludeSamples: $excludeSamples, includeVariants: $includeVariants, excludeVariants: $excludeVariants, args: $args)';
}


}

/// @nodoc
abstract mixin class $JobTaskCopyWith<$Res>  {
  factory $JobTaskCopyWith(JobTask value, $Res Function(JobTask) _then) = _$JobTaskCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'include_samples') List<String>? includeSamples,@JsonKey(name: 'exclude_samples') List<String>? excludeSamples,@JsonKey(name: 'include_variants') List<String>? includeVariants,@JsonKey(name: 'exclude_variants') List<String>? excludeVariants,@JsonKey(name: 'args') Map<String, dynamic>? args
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? includeSamples = freezed,Object? excludeSamples = freezed,Object? includeVariants = freezed,Object? excludeVariants = freezed,Object? args = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,includeSamples: freezed == includeSamples ? _self.includeSamples : includeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeSamples: freezed == excludeSamples ? _self.excludeSamples : excludeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,includeVariants: freezed == includeVariants ? _self.includeVariants : includeVariants // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeVariants: freezed == excludeVariants ? _self.excludeVariants : excludeVariants // ignore: cast_nullable_to_non_nullable
as List<String>?,args: freezed == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'include_variants')  List<String>? includeVariants, @JsonKey(name: 'exclude_variants')  List<String>? excludeVariants, @JsonKey(name: 'args')  Map<String, dynamic>? args)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.includeVariants,_that.excludeVariants,_that.args);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'include_variants')  List<String>? includeVariants, @JsonKey(name: 'exclude_variants')  List<String>? excludeVariants, @JsonKey(name: 'args')  Map<String, dynamic>? args)  $default,) {final _that = this;
switch (_that) {
case _JobTask():
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.includeVariants,_that.excludeVariants,_that.args);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'include_samples')  List<String>? includeSamples, @JsonKey(name: 'exclude_samples')  List<String>? excludeSamples, @JsonKey(name: 'include_variants')  List<String>? includeVariants, @JsonKey(name: 'exclude_variants')  List<String>? excludeVariants, @JsonKey(name: 'args')  Map<String, dynamic>? args)?  $default,) {final _that = this;
switch (_that) {
case _JobTask() when $default != null:
return $default(_that.id,_that.includeSamples,_that.excludeSamples,_that.includeVariants,_that.excludeVariants,_that.args);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobTask implements JobTask {
  const _JobTask({required this.id, @JsonKey(name: 'include_samples') final  List<String>? includeSamples, @JsonKey(name: 'exclude_samples') final  List<String>? excludeSamples, @JsonKey(name: 'include_variants') final  List<String>? includeVariants, @JsonKey(name: 'exclude_variants') final  List<String>? excludeVariants, @JsonKey(name: 'args') final  Map<String, dynamic>? args}): _includeSamples = includeSamples,_excludeSamples = excludeSamples,_includeVariants = includeVariants,_excludeVariants = excludeVariants,_args = args;
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

/// Only run these variant names for this task.
 final  List<String>? _includeVariants;
/// Only run these variant names for this task.
@override@JsonKey(name: 'include_variants') List<String>? get includeVariants {
  final value = _includeVariants;
  if (value == null) return null;
  if (_includeVariants is EqualUnmodifiableListView) return _includeVariants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Exclude these variant names for this task.
 final  List<String>? _excludeVariants;
/// Exclude these variant names for this task.
@override@JsonKey(name: 'exclude_variants') List<String>? get excludeVariants {
  final value = _excludeVariants;
  if (value == null) return null;
  if (_excludeVariants is EqualUnmodifiableListView) return _excludeVariants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobTask&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._includeSamples, _includeSamples)&&const DeepCollectionEquality().equals(other._excludeSamples, _excludeSamples)&&const DeepCollectionEquality().equals(other._includeVariants, _includeVariants)&&const DeepCollectionEquality().equals(other._excludeVariants, _excludeVariants)&&const DeepCollectionEquality().equals(other._args, _args));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_includeSamples),const DeepCollectionEquality().hash(_excludeSamples),const DeepCollectionEquality().hash(_includeVariants),const DeepCollectionEquality().hash(_excludeVariants),const DeepCollectionEquality().hash(_args));

@override
String toString() {
  return 'JobTask(id: $id, includeSamples: $includeSamples, excludeSamples: $excludeSamples, includeVariants: $includeVariants, excludeVariants: $excludeVariants, args: $args)';
}


}

/// @nodoc
abstract mixin class _$JobTaskCopyWith<$Res> implements $JobTaskCopyWith<$Res> {
  factory _$JobTaskCopyWith(_JobTask value, $Res Function(_JobTask) _then) = __$JobTaskCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'include_samples') List<String>? includeSamples,@JsonKey(name: 'exclude_samples') List<String>? excludeSamples,@JsonKey(name: 'include_variants') List<String>? includeVariants,@JsonKey(name: 'exclude_variants') List<String>? excludeVariants,@JsonKey(name: 'args') Map<String, dynamic>? args
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? includeSamples = freezed,Object? excludeSamples = freezed,Object? includeVariants = freezed,Object? excludeVariants = freezed,Object? args = freezed,}) {
  return _then(_JobTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,includeSamples: freezed == includeSamples ? _self._includeSamples : includeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeSamples: freezed == excludeSamples ? _self._excludeSamples : excludeSamples // ignore: cast_nullable_to_non_nullable
as List<String>?,includeVariants: freezed == includeVariants ? _self._includeVariants : includeVariants // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeVariants: freezed == excludeVariants ? _self._excludeVariants : excludeVariants // ignore: cast_nullable_to_non_nullable
as List<String>?,args: freezed == args ? _self._args : args // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
