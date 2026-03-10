// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scorer_result_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScorerResultData {

 String get name; bool get passed; String get explanation; String get answer;
/// Create a copy of ScorerResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScorerResultDataCopyWith<ScorerResultData> get copyWith => _$ScorerResultDataCopyWithImpl<ScorerResultData>(this as ScorerResultData, _$identity);

  /// Serializes this ScorerResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScorerResultData&&(identical(other.name, name) || other.name == name)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,passed,explanation,answer);

@override
String toString() {
  return 'ScorerResultData(name: $name, passed: $passed, explanation: $explanation, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $ScorerResultDataCopyWith<$Res>  {
  factory $ScorerResultDataCopyWith(ScorerResultData value, $Res Function(ScorerResultData) _then) = _$ScorerResultDataCopyWithImpl;
@useResult
$Res call({
 String name, bool passed, String explanation, String answer
});




}
/// @nodoc
class _$ScorerResultDataCopyWithImpl<$Res>
    implements $ScorerResultDataCopyWith<$Res> {
  _$ScorerResultDataCopyWithImpl(this._self, this._then);

  final ScorerResultData _self;
  final $Res Function(ScorerResultData) _then;

/// Create a copy of ScorerResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? passed = null,Object? explanation = null,Object? answer = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScorerResultData].
extension ScorerResultDataPatterns on ScorerResultData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScorerResultData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScorerResultData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScorerResultData value)  $default,){
final _that = this;
switch (_that) {
case _ScorerResultData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScorerResultData value)?  $default,){
final _that = this;
switch (_that) {
case _ScorerResultData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool passed,  String explanation,  String answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScorerResultData() when $default != null:
return $default(_that.name,_that.passed,_that.explanation,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool passed,  String explanation,  String answer)  $default,) {final _that = this;
switch (_that) {
case _ScorerResultData():
return $default(_that.name,_that.passed,_that.explanation,_that.answer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool passed,  String explanation,  String answer)?  $default,) {final _that = this;
switch (_that) {
case _ScorerResultData() when $default != null:
return $default(_that.name,_that.passed,_that.explanation,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScorerResultData extends ScorerResultData {
  const _ScorerResultData({required this.name, required this.passed, this.explanation = '', this.answer = ''}): super._();
  factory _ScorerResultData.fromJson(Map<String, dynamic> json) => _$ScorerResultDataFromJson(json);

@override final  String name;
@override final  bool passed;
@override@JsonKey() final  String explanation;
@override@JsonKey() final  String answer;

/// Create a copy of ScorerResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScorerResultDataCopyWith<_ScorerResultData> get copyWith => __$ScorerResultDataCopyWithImpl<_ScorerResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScorerResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScorerResultData&&(identical(other.name, name) || other.name == name)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,passed,explanation,answer);

@override
String toString() {
  return 'ScorerResultData(name: $name, passed: $passed, explanation: $explanation, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$ScorerResultDataCopyWith<$Res> implements $ScorerResultDataCopyWith<$Res> {
  factory _$ScorerResultDataCopyWith(_ScorerResultData value, $Res Function(_ScorerResultData) _then) = __$ScorerResultDataCopyWithImpl;
@override @useResult
$Res call({
 String name, bool passed, String explanation, String answer
});




}
/// @nodoc
class __$ScorerResultDataCopyWithImpl<$Res>
    implements _$ScorerResultDataCopyWith<$Res> {
  __$ScorerResultDataCopyWithImpl(this._self, this._then);

  final _ScorerResultData _self;
  final $Res Function(_ScorerResultData) _then;

/// Create a copy of ScorerResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? passed = null,Object? explanation = null,Object? answer = null,}) {
  return _then(_ScorerResultData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
