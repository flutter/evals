// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_spec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldSpec {

/// Name of the field containing the sample input.
 String? get input;/// Name of the field containing the sample target.
 String? get target;/// Name of the field containing the list of answer choices.
 String? get choices;/// Name of the field containing the unique sample identifier.
 String? get id;/// List of additional field names that should be read as metadata.
 List<String>? get metadata;/// Sandbox type along with optional config file.
 String? get sandbox;/// Name of the field containing files that go with the sample.
 String? get files;/// Name of the field containing the setup script.
 String? get setup;
/// Create a copy of FieldSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldSpecCopyWith<FieldSpec> get copyWith => _$FieldSpecCopyWithImpl<FieldSpec>(this as FieldSpec, _$identity);

  /// Serializes this FieldSpec to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldSpec&&(identical(other.input, input) || other.input == input)&&(identical(other.target, target) || other.target == target)&&(identical(other.choices, choices) || other.choices == choices)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.sandbox, sandbox) || other.sandbox == sandbox)&&(identical(other.files, files) || other.files == files)&&(identical(other.setup, setup) || other.setup == setup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,input,target,choices,id,const DeepCollectionEquality().hash(metadata),sandbox,files,setup);

@override
String toString() {
  return 'FieldSpec(input: $input, target: $target, choices: $choices, id: $id, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup)';
}


}

/// @nodoc
abstract mixin class $FieldSpecCopyWith<$Res>  {
  factory $FieldSpecCopyWith(FieldSpec value, $Res Function(FieldSpec) _then) = _$FieldSpecCopyWithImpl;
@useResult
$Res call({
 String? input, String? target, String? choices, String? id, List<String>? metadata, String? sandbox, String? files, String? setup
});




}
/// @nodoc
class _$FieldSpecCopyWithImpl<$Res>
    implements $FieldSpecCopyWith<$Res> {
  _$FieldSpecCopyWithImpl(this._self, this._then);

  final FieldSpec _self;
  final $Res Function(FieldSpec) _then;

/// Create a copy of FieldSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? input = freezed,Object? target = freezed,Object? choices = freezed,Object? id = freezed,Object? metadata = freezed,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,}) {
  return _then(_self.copyWith(
input: freezed == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,choices: freezed == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<String>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox // ignore: cast_nullable_to_non_nullable
as String?,files: freezed == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldSpec].
extension FieldSpecPatterns on FieldSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldSpec value)  $default,){
final _that = this;
switch (_that) {
case _FieldSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldSpec value)?  $default,){
final _that = this;
switch (_that) {
case _FieldSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? input,  String? target,  String? choices,  String? id,  List<String>? metadata,  String? sandbox,  String? files,  String? setup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldSpec() when $default != null:
return $default(_that.input,_that.target,_that.choices,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? input,  String? target,  String? choices,  String? id,  List<String>? metadata,  String? sandbox,  String? files,  String? setup)  $default,) {final _that = this;
switch (_that) {
case _FieldSpec():
return $default(_that.input,_that.target,_that.choices,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? input,  String? target,  String? choices,  String? id,  List<String>? metadata,  String? sandbox,  String? files,  String? setup)?  $default,) {final _that = this;
switch (_that) {
case _FieldSpec() when $default != null:
return $default(_that.input,_that.target,_that.choices,_that.id,_that.metadata,_that.sandbox,_that.files,_that.setup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldSpec implements FieldSpec {
  const _FieldSpec({this.input, this.target, this.choices, this.id, final  List<String>? metadata, this.sandbox, this.files, this.setup}): _metadata = metadata;
  factory _FieldSpec.fromJson(Map<String, dynamic> json) => _$FieldSpecFromJson(json);

/// Name of the field containing the sample input.
@override final  String? input;
/// Name of the field containing the sample target.
@override final  String? target;
/// Name of the field containing the list of answer choices.
@override final  String? choices;
/// Name of the field containing the unique sample identifier.
@override final  String? id;
/// List of additional field names that should be read as metadata.
 final  List<String>? _metadata;
/// List of additional field names that should be read as metadata.
@override List<String>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableListView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Sandbox type along with optional config file.
@override final  String? sandbox;
/// Name of the field containing files that go with the sample.
@override final  String? files;
/// Name of the field containing the setup script.
@override final  String? setup;

/// Create a copy of FieldSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldSpecCopyWith<_FieldSpec> get copyWith => __$FieldSpecCopyWithImpl<_FieldSpec>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldSpecToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldSpec&&(identical(other.input, input) || other.input == input)&&(identical(other.target, target) || other.target == target)&&(identical(other.choices, choices) || other.choices == choices)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.sandbox, sandbox) || other.sandbox == sandbox)&&(identical(other.files, files) || other.files == files)&&(identical(other.setup, setup) || other.setup == setup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,input,target,choices,id,const DeepCollectionEquality().hash(_metadata),sandbox,files,setup);

@override
String toString() {
  return 'FieldSpec(input: $input, target: $target, choices: $choices, id: $id, metadata: $metadata, sandbox: $sandbox, files: $files, setup: $setup)';
}


}

/// @nodoc
abstract mixin class _$FieldSpecCopyWith<$Res> implements $FieldSpecCopyWith<$Res> {
  factory _$FieldSpecCopyWith(_FieldSpec value, $Res Function(_FieldSpec) _then) = __$FieldSpecCopyWithImpl;
@override @useResult
$Res call({
 String? input, String? target, String? choices, String? id, List<String>? metadata, String? sandbox, String? files, String? setup
});




}
/// @nodoc
class __$FieldSpecCopyWithImpl<$Res>
    implements _$FieldSpecCopyWith<$Res> {
  __$FieldSpecCopyWithImpl(this._self, this._then);

  final _FieldSpec _self;
  final $Res Function(_FieldSpec) _then;

/// Create a copy of FieldSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = freezed,Object? target = freezed,Object? choices = freezed,Object? id = freezed,Object? metadata = freezed,Object? sandbox = freezed,Object? files = freezed,Object? setup = freezed,}) {
  return _then(_FieldSpec(
input: freezed == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,choices: freezed == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<String>?,sandbox: freezed == sandbox ? _self.sandbox : sandbox // ignore: cast_nullable_to_non_nullable
as String?,files: freezed == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as String?,setup: freezed == setup ? _self.setup : setup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
