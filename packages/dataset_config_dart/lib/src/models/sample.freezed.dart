// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sample {

/// The input to be submitted to the model.
///
/// Can be a simple string or a list of `ChatMessage` objects.
 Object get input;/// List of available answer choices (used only for multiple-choice evals).
 List<String>? get choices;/// Ideal target output.
///
/// May be a literal value or narrative text to be used by a model grader.
/// Can be a single string or a list of strings.
 Object get target;/// Unique identifier for the sample.
 Object? get id;/// Arbitrary metadata associated with the sample.
 Map<String, dynamic>? get metadata;/// Sandbox environment type and optional config file.
 Object? get sandbox;/// Files that go along with the sample (copied to `SandboxEnvironment`).
///
/// Keys are destination paths, values are source paths, inline text,
/// or inline binary (base64-encoded data URLs).
 Map<String, String>? get files;/// Setup script to run for sample (run within default
/// `SandboxEnvironment`).
 String? get setup;
/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleCopyWith<Sample> get copyWith => _$SampleCopyWithImpl<Sample>(this as Sample, _$identity);

  /// Serializes this Sample to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sample&&const DeepCollectionEquality().equals(other.input, input)&&const DeepCollectionEquality().equals(other.choices, choices)&&const DeepCollectionEquality().equals(other.target, target)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other.files, files)&&(identical(other.setup, setup) || other.setup == setup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(input),const DeepCollectionEquality().hash(choices),const DeepCollectionEquality().hash(target),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(files),setup);

@override
String toString() {
  return 'Sample(input: $input, choices: $choices, target: $target, id: $id, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup)';
}


}

/// @nodoc
abstract mixin class $SampleCopyWith<$Res>  {
  factory $SampleCopyWith(Sample value, $Res Function(Sample) _then) = _$SampleCopyWithImpl;
@useResult
$Res call({
 Object input, List<String>? choices, Object target, Object? id, Map<String, dynamic>? metadata, Object? sandbox, Map<String, String>? files, String? setup
});




}
/// @nodoc
class _$SampleCopyWithImpl<$Res>
    implements $SampleCopyWith<$Res> {
  _$SampleCopyWithImpl(this._self, this._then);

  final Sample _self;
  final $Res Function(Sample) _then;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? input = null,Object? choices = freezed,Object? target = null,Object? id = freezed,Object? metadata = freezed,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,}) {
  return _then(_self.copyWith(
input: null == input ? _self.input : input ,choices: freezed == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,target: null == target ? _self.target : target ,id: freezed == id ? _self.id : id ,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,files: freezed == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Sample].
extension SamplePatterns on Sample {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sample value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sample() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sample value)  $default,){
final _that = this;
switch (_that) {
case _Sample():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sample value)?  $default,){
final _that = this;
switch (_that) {
case _Sample() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object input,  List<String>? choices,  Object target,  Object? id,  Map<String, dynamic>? metadata,  Object? sandbox,  Map<String, String>? files,  String? setup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sample() when $default != null:
return $default(_that.input,_that.choices,_that.target,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object input,  List<String>? choices,  Object target,  Object? id,  Map<String, dynamic>? metadata,  Object? sandbox,  Map<String, String>? files,  String? setup)  $default,) {final _that = this;
switch (_that) {
case _Sample():
return $default(_that.input,_that.choices,_that.target,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object input,  List<String>? choices,  Object target,  Object? id,  Map<String, dynamic>? metadata,  Object? sandbox,  Map<String, String>? files,  String? setup)?  $default,) {final _that = this;
switch (_that) {
case _Sample() when $default != null:
return $default(_that.input,_that.choices,_that.target,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sample implements Sample {
  const _Sample({required this.input, final  List<String>? choices, this.target = '', this.id, final  Map<String, dynamic>? metadata, this.sandbox, final  Map<String, String>? files, this.setup}): _choices = choices,_metadata = metadata,_files = files;
  factory _Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);

/// The input to be submitted to the model.
///
/// Can be a simple string or a list of `ChatMessage` objects.
@override final  Object input;
/// List of available answer choices (used only for multiple-choice evals).
 final  List<String>? _choices;
/// List of available answer choices (used only for multiple-choice evals).
@override List<String>? get choices {
  final value = _choices;
  if (value == null) return null;
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Ideal target output.
///
/// May be a literal value or narrative text to be used by a model grader.
/// Can be a single string or a list of strings.
@override@JsonKey() final  Object target;
/// Unique identifier for the sample.
@override final  Object? id;
/// Arbitrary metadata associated with the sample.
 final  Map<String, dynamic>? _metadata;
/// Arbitrary metadata associated with the sample.
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Sandbox environment type and optional config file.
@override final  Object? sandbox;
/// Files that go along with the sample (copied to `SandboxEnvironment`).
///
/// Keys are destination paths, values are source paths, inline text,
/// or inline binary (base64-encoded data URLs).
 final  Map<String, String>? _files;
/// Files that go along with the sample (copied to `SandboxEnvironment`).
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

/// Setup script to run for sample (run within default
/// `SandboxEnvironment`).
@override final  String? setup;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleCopyWith<_Sample> get copyWith => __$SampleCopyWithImpl<_Sample>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sample&&const DeepCollectionEquality().equals(other.input, input)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other.target, target)&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other.sandbox, sandbox)&&const DeepCollectionEquality().equals(other._files, _files)&&(identical(other.setup, setup) || other.setup == setup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(input),const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(target),const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(sandbox),const DeepCollectionEquality().hash(_files),setup);

@override
String toString() {
  return 'Sample(input: $input, choices: $choices, target: $target, id: $id, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup)';
}


}

/// @nodoc
abstract mixin class _$SampleCopyWith<$Res> implements $SampleCopyWith<$Res> {
  factory _$SampleCopyWith(_Sample value, $Res Function(_Sample) _then) = __$SampleCopyWithImpl;
@override @useResult
$Res call({
 Object input, List<String>? choices, Object target, Object? id, Map<String, dynamic>? metadata, Object? sandbox, Map<String, String>? files, String? setup
});




}
/// @nodoc
class __$SampleCopyWithImpl<$Res>
    implements _$SampleCopyWith<$Res> {
  __$SampleCopyWithImpl(this._self, this._then);

  final _Sample _self;
  final $Res Function(_Sample) _then;

/// Create a copy of Sample
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? choices = freezed,Object? target = null,Object? id = freezed,Object? metadata = freezed,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,}) {
  return _then(_Sample(
input: null == input ? _self.input : input ,choices: freezed == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,target: null == target ? _self.target : target ,id: freezed == id ? _self.id : id ,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox ,files: freezed == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
