// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskInfo {

/// File path where the task was loaded from.
 String get file;/// Task name (defaults to the function name).
 String get name;/// Task attributes (arguments passed to `@task`).
 Map<String, dynamic> get attribs;
/// Create a copy of TaskInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskInfoCopyWith<TaskInfo> get copyWith => _$TaskInfoCopyWithImpl<TaskInfo>(this as TaskInfo, _$identity);

  /// Serializes this TaskInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskInfo&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.attribs, attribs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,file,name,const DeepCollectionEquality().hash(attribs));

@override
String toString() {
  return 'TaskInfo(file: $file, name: $name, attribs: $attribs)';
}


}

/// @nodoc
abstract mixin class $TaskInfoCopyWith<$Res>  {
  factory $TaskInfoCopyWith(TaskInfo value, $Res Function(TaskInfo) _then) = _$TaskInfoCopyWithImpl;
@useResult
$Res call({
 String file, String name, Map<String, dynamic> attribs
});




}
/// @nodoc
class _$TaskInfoCopyWithImpl<$Res>
    implements $TaskInfoCopyWith<$Res> {
  _$TaskInfoCopyWithImpl(this._self, this._then);

  final TaskInfo _self;
  final $Res Function(TaskInfo) _then;

/// Create a copy of TaskInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,Object? name = null,Object? attribs = null,}) {
  return _then(_self.copyWith(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,attribs: null == attribs ? _self.attribs : attribs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskInfo].
extension TaskInfoPatterns on TaskInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskInfo value)  $default,){
final _that = this;
switch (_that) {
case _TaskInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TaskInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String file,  String name,  Map<String, dynamic> attribs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskInfo() when $default != null:
return $default(_that.file,_that.name,_that.attribs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String file,  String name,  Map<String, dynamic> attribs)  $default,) {final _that = this;
switch (_that) {
case _TaskInfo():
return $default(_that.file,_that.name,_that.attribs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String file,  String name,  Map<String, dynamic> attribs)?  $default,) {final _that = this;
switch (_that) {
case _TaskInfo() when $default != null:
return $default(_that.file,_that.name,_that.attribs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskInfo implements TaskInfo {
  const _TaskInfo({required this.file, required this.name, final  Map<String, dynamic> attribs = const {}}): _attribs = attribs;
  factory _TaskInfo.fromJson(Map<String, dynamic> json) => _$TaskInfoFromJson(json);

/// File path where the task was loaded from.
@override final  String file;
/// Task name (defaults to the function name).
@override final  String name;
/// Task attributes (arguments passed to `@task`).
 final  Map<String, dynamic> _attribs;
/// Task attributes (arguments passed to `@task`).
@override@JsonKey() Map<String, dynamic> get attribs {
  if (_attribs is EqualUnmodifiableMapView) return _attribs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attribs);
}


/// Create a copy of TaskInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskInfoCopyWith<_TaskInfo> get copyWith => __$TaskInfoCopyWithImpl<_TaskInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskInfo&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._attribs, _attribs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,file,name,const DeepCollectionEquality().hash(_attribs));

@override
String toString() {
  return 'TaskInfo(file: $file, name: $name, attribs: $attribs)';
}


}

/// @nodoc
abstract mixin class _$TaskInfoCopyWith<$Res> implements $TaskInfoCopyWith<$Res> {
  factory _$TaskInfoCopyWith(_TaskInfo value, $Res Function(_TaskInfo) _then) = __$TaskInfoCopyWithImpl;
@override @useResult
$Res call({
 String file, String name, Map<String, dynamic> attribs
});




}
/// @nodoc
class __$TaskInfoCopyWithImpl<$Res>
    implements _$TaskInfoCopyWith<$Res> {
  __$TaskInfoCopyWithImpl(this._self, this._then);

  final _TaskInfo _self;
  final $Res Function(_TaskInfo) _then;

/// Create a copy of TaskInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? name = null,Object? attribs = null,}) {
  return _then(_TaskInfo(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,attribs: null == attribs ? _self._attribs : attribs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
