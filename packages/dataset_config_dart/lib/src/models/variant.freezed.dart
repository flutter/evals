// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Variant {

/// User-defined variant name from the job file.
 String get name;/// Loaded context files (paths resolved by config resolver).
@JsonKey(name: 'files') List<ContextFile> get files;/// MCP server configurations (list of config maps or ref strings).
@JsonKey(name: 'mcp_servers') List<Map<String, dynamic>> get mcpServers;/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
@JsonKey(name: 'skills') List<String> get skills;/// Optional parameters merged into the task config dict at runtime.
@JsonKey(name: 'task_parameters') Map<String, dynamic> get taskParameters;
/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantCopyWith<Variant> get copyWith => _$VariantCopyWithImpl<Variant>(this as Variant, _$identity);

  /// Serializes this Variant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Variant&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.files, files)&&const DeepCollectionEquality().equals(other.mcpServers, mcpServers)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.taskParameters, taskParameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(files),const DeepCollectionEquality().hash(mcpServers),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(taskParameters));

@override
String toString() {
  return 'Variant(name: $name, files: $files, mcpServers: $mcpServers, skills: $skills, taskParameters: $taskParameters)';
}


}

/// @nodoc
abstract mixin class $VariantCopyWith<$Res>  {
  factory $VariantCopyWith(Variant value, $Res Function(Variant) _then) = _$VariantCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'files') List<ContextFile> files,@JsonKey(name: 'mcp_servers') List<Map<String, dynamic>> mcpServers,@JsonKey(name: 'skills') List<String> skills,@JsonKey(name: 'task_parameters') Map<String, dynamic> taskParameters
});




}
/// @nodoc
class _$VariantCopyWithImpl<$Res>
    implements $VariantCopyWith<$Res> {
  _$VariantCopyWithImpl(this._self, this._then);

  final Variant _self;
  final $Res Function(Variant) _then;

/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? files = null,Object? mcpServers = null,Object? skills = null,Object? taskParameters = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<ContextFile>,mcpServers: null == mcpServers ? _self.mcpServers : mcpServers // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,taskParameters: null == taskParameters ? _self.taskParameters : taskParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Variant].
extension VariantPatterns on Variant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Variant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Variant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Variant value)  $default,){
final _that = this;
switch (_that) {
case _Variant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Variant value)?  $default,){
final _that = this;
switch (_that) {
case _Variant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'files')  List<ContextFile> files, @JsonKey(name: 'mcp_servers')  List<Map<String, dynamic>> mcpServers, @JsonKey(name: 'skills')  List<String> skills, @JsonKey(name: 'task_parameters')  Map<String, dynamic> taskParameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.name,_that.files,_that.mcpServers,_that.skills,_that.taskParameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'files')  List<ContextFile> files, @JsonKey(name: 'mcp_servers')  List<Map<String, dynamic>> mcpServers, @JsonKey(name: 'skills')  List<String> skills, @JsonKey(name: 'task_parameters')  Map<String, dynamic> taskParameters)  $default,) {final _that = this;
switch (_that) {
case _Variant():
return $default(_that.name,_that.files,_that.mcpServers,_that.skills,_that.taskParameters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'files')  List<ContextFile> files, @JsonKey(name: 'mcp_servers')  List<Map<String, dynamic>> mcpServers, @JsonKey(name: 'skills')  List<String> skills, @JsonKey(name: 'task_parameters')  Map<String, dynamic> taskParameters)?  $default,) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.name,_that.files,_that.mcpServers,_that.skills,_that.taskParameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Variant extends Variant {
  const _Variant({this.name = 'baseline', @JsonKey(name: 'files') final  List<ContextFile> files = const [], @JsonKey(name: 'mcp_servers') final  List<Map<String, dynamic>> mcpServers = const [], @JsonKey(name: 'skills') final  List<String> skills = const [], @JsonKey(name: 'task_parameters') final  Map<String, dynamic> taskParameters = const {}}): _files = files,_mcpServers = mcpServers,_skills = skills,_taskParameters = taskParameters,super._();
  factory _Variant.fromJson(Map<String, dynamic> json) => _$VariantFromJson(json);

/// User-defined variant name from the job file.
@override@JsonKey() final  String name;
/// Loaded context files (paths resolved by config resolver).
 final  List<ContextFile> _files;
/// Loaded context files (paths resolved by config resolver).
@override@JsonKey(name: 'files') List<ContextFile> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

/// MCP server configurations (list of config maps or ref strings).
 final  List<Map<String, dynamic>> _mcpServers;
/// MCP server configurations (list of config maps or ref strings).
@override@JsonKey(name: 'mcp_servers') List<Map<String, dynamic>> get mcpServers {
  if (_mcpServers is EqualUnmodifiableListView) return _mcpServers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mcpServers);
}

/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
 final  List<String> _skills;
/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
@override@JsonKey(name: 'skills') List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

/// Optional parameters merged into the task config dict at runtime.
 final  Map<String, dynamic> _taskParameters;
/// Optional parameters merged into the task config dict at runtime.
@override@JsonKey(name: 'task_parameters') Map<String, dynamic> get taskParameters {
  if (_taskParameters is EqualUnmodifiableMapView) return _taskParameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_taskParameters);
}


/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VariantCopyWith<_Variant> get copyWith => __$VariantCopyWithImpl<_Variant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Variant&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._files, _files)&&const DeepCollectionEquality().equals(other._mcpServers, _mcpServers)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._taskParameters, _taskParameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_files),const DeepCollectionEquality().hash(_mcpServers),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_taskParameters));

@override
String toString() {
  return 'Variant(name: $name, files: $files, mcpServers: $mcpServers, skills: $skills, taskParameters: $taskParameters)';
}


}

/// @nodoc
abstract mixin class _$VariantCopyWith<$Res> implements $VariantCopyWith<$Res> {
  factory _$VariantCopyWith(_Variant value, $Res Function(_Variant) _then) = __$VariantCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'files') List<ContextFile> files,@JsonKey(name: 'mcp_servers') List<Map<String, dynamic>> mcpServers,@JsonKey(name: 'skills') List<String> skills,@JsonKey(name: 'task_parameters') Map<String, dynamic> taskParameters
});




}
/// @nodoc
class __$VariantCopyWithImpl<$Res>
    implements _$VariantCopyWith<$Res> {
  __$VariantCopyWithImpl(this._self, this._then);

  final _Variant _self;
  final $Res Function(_Variant) _then;

/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? files = null,Object? mcpServers = null,Object? skills = null,Object? taskParameters = null,}) {
  return _then(_Variant(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<ContextFile>,mcpServers: null == mcpServers ? _self._mcpServers : mcpServers // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,taskParameters: null == taskParameters ? _self._taskParameters : taskParameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
