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
@JsonKey(name: 'context_files') List<ContextFile> get contextFiles;/// MCP server keys to enable (e.g., `['dart']`).
@JsonKey(name: 'mcp_servers') List<String> get mcpServers;/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
@JsonKey(name: 'skill_paths') List<String> get skillPaths;/// SDK branch/channel to use (e.g., `'stable'`, `'beta'`, `'main'`).
/// `null` means use the default image from the job's sandbox.
@JsonKey(name: 'branch') String? get branch;
/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantCopyWith<Variant> get copyWith => _$VariantCopyWithImpl<Variant>(this as Variant, _$identity);

  /// Serializes this Variant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Variant&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.contextFiles, contextFiles)&&const DeepCollectionEquality().equals(other.mcpServers, mcpServers)&&const DeepCollectionEquality().equals(other.skillPaths, skillPaths)&&(identical(other.branch, branch) || other.branch == branch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(contextFiles),const DeepCollectionEquality().hash(mcpServers),const DeepCollectionEquality().hash(skillPaths),branch);

@override
String toString() {
  return 'Variant(name: $name, contextFiles: $contextFiles, mcpServers: $mcpServers, skillPaths: $skillPaths, branch: $branch)';
}


}

/// @nodoc
abstract mixin class $VariantCopyWith<$Res>  {
  factory $VariantCopyWith(Variant value, $Res Function(Variant) _then) = _$VariantCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'context_files') List<ContextFile> contextFiles,@JsonKey(name: 'mcp_servers') List<String> mcpServers,@JsonKey(name: 'skill_paths') List<String> skillPaths,@JsonKey(name: 'branch') String? branch
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
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? contextFiles = null,Object? mcpServers = null,Object? skillPaths = null,Object? branch = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contextFiles: null == contextFiles ? _self.contextFiles : contextFiles // ignore: cast_nullable_to_non_nullable
as List<ContextFile>,mcpServers: null == mcpServers ? _self.mcpServers : mcpServers // ignore: cast_nullable_to_non_nullable
as List<String>,skillPaths: null == skillPaths ? _self.skillPaths : skillPaths // ignore: cast_nullable_to_non_nullable
as List<String>,branch: freezed == branch ? _self.branch : branch // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'context_files')  List<ContextFile> contextFiles, @JsonKey(name: 'mcp_servers')  List<String> mcpServers, @JsonKey(name: 'skill_paths')  List<String> skillPaths, @JsonKey(name: 'branch')  String? branch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.name,_that.contextFiles,_that.mcpServers,_that.skillPaths,_that.branch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'context_files')  List<ContextFile> contextFiles, @JsonKey(name: 'mcp_servers')  List<String> mcpServers, @JsonKey(name: 'skill_paths')  List<String> skillPaths, @JsonKey(name: 'branch')  String? branch)  $default,) {final _that = this;
switch (_that) {
case _Variant():
return $default(_that.name,_that.contextFiles,_that.mcpServers,_that.skillPaths,_that.branch);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'context_files')  List<ContextFile> contextFiles, @JsonKey(name: 'mcp_servers')  List<String> mcpServers, @JsonKey(name: 'skill_paths')  List<String> skillPaths, @JsonKey(name: 'branch')  String? branch)?  $default,) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.name,_that.contextFiles,_that.mcpServers,_that.skillPaths,_that.branch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Variant extends Variant {
  const _Variant({this.name = 'baseline', @JsonKey(name: 'context_files') final  List<ContextFile> contextFiles = const [], @JsonKey(name: 'mcp_servers') final  List<String> mcpServers = const [], @JsonKey(name: 'skill_paths') final  List<String> skillPaths = const [], @JsonKey(name: 'branch') this.branch}): _contextFiles = contextFiles,_mcpServers = mcpServers,_skillPaths = skillPaths,super._();
  factory _Variant.fromJson(Map<String, dynamic> json) => _$VariantFromJson(json);

/// User-defined variant name from the job file.
@override@JsonKey() final  String name;
/// Loaded context files (paths resolved by config resolver).
 final  List<ContextFile> _contextFiles;
/// Loaded context files (paths resolved by config resolver).
@override@JsonKey(name: 'context_files') List<ContextFile> get contextFiles {
  if (_contextFiles is EqualUnmodifiableListView) return _contextFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contextFiles);
}

/// MCP server keys to enable (e.g., `['dart']`).
 final  List<String> _mcpServers;
/// MCP server keys to enable (e.g., `['dart']`).
@override@JsonKey(name: 'mcp_servers') List<String> get mcpServers {
  if (_mcpServers is EqualUnmodifiableListView) return _mcpServers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mcpServers);
}

/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
 final  List<String> _skillPaths;
/// Resolved paths to agent skill directories.
/// Each directory must contain a `SKILL.md` file.
@override@JsonKey(name: 'skill_paths') List<String> get skillPaths {
  if (_skillPaths is EqualUnmodifiableListView) return _skillPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skillPaths);
}

/// SDK branch/channel to use (e.g., `'stable'`, `'beta'`, `'main'`).
/// `null` means use the default image from the job's sandbox.
@override@JsonKey(name: 'branch') final  String? branch;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Variant&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._contextFiles, _contextFiles)&&const DeepCollectionEquality().equals(other._mcpServers, _mcpServers)&&const DeepCollectionEquality().equals(other._skillPaths, _skillPaths)&&(identical(other.branch, branch) || other.branch == branch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_contextFiles),const DeepCollectionEquality().hash(_mcpServers),const DeepCollectionEquality().hash(_skillPaths),branch);

@override
String toString() {
  return 'Variant(name: $name, contextFiles: $contextFiles, mcpServers: $mcpServers, skillPaths: $skillPaths, branch: $branch)';
}


}

/// @nodoc
abstract mixin class _$VariantCopyWith<$Res> implements $VariantCopyWith<$Res> {
  factory _$VariantCopyWith(_Variant value, $Res Function(_Variant) _then) = __$VariantCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'context_files') List<ContextFile> contextFiles,@JsonKey(name: 'mcp_servers') List<String> mcpServers,@JsonKey(name: 'skill_paths') List<String> skillPaths,@JsonKey(name: 'branch') String? branch
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? contextFiles = null,Object? mcpServers = null,Object? skillPaths = null,Object? branch = freezed,}) {
  return _then(_Variant(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contextFiles: null == contextFiles ? _self._contextFiles : contextFiles // ignore: cast_nullable_to_non_nullable
as List<ContextFile>,mcpServers: null == mcpServers ? _self._mcpServers : mcpServers // ignore: cast_nullable_to_non_nullable
as List<String>,skillPaths: null == skillPaths ? _self._skillPaths : skillPaths // ignore: cast_nullable_to_non_nullable
as List<String>,branch: freezed == branch ? _self.branch : branch // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
