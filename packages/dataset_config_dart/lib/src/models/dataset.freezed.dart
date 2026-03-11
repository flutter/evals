// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dataset {

/// The list of sample objects.
 List<Sample> get samples;/// Dataset name.
 String? get name;/// Dataset location (file path or remote URL).
 String? get location;/// Whether the dataset was shuffled after reading.
 bool get shuffled;
/// Create a copy of Dataset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatasetCopyWith<Dataset> get copyWith => _$DatasetCopyWithImpl<Dataset>(this as Dataset, _$identity);

  /// Serializes this Dataset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dataset&&const DeepCollectionEquality().equals(other.samples, samples)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(samples),name,location,shuffled);

@override
String toString() {
  return 'Dataset(samples: $samples, name: $name, location: $location, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class $DatasetCopyWith<$Res>  {
  factory $DatasetCopyWith(Dataset value, $Res Function(Dataset) _then) = _$DatasetCopyWithImpl;
@useResult
$Res call({
 List<Sample> samples, String? name, String? location, bool shuffled
});




}
/// @nodoc
class _$DatasetCopyWithImpl<$Res>
    implements $DatasetCopyWith<$Res> {
  _$DatasetCopyWithImpl(this._self, this._then);

  final Dataset _self;
  final $Res Function(Dataset) _then;

/// Create a copy of Dataset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? samples = null,Object? name = freezed,Object? location = freezed,Object? shuffled = null,}) {
  return _then(_self.copyWith(
samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as List<Sample>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Dataset].
extension DatasetPatterns on Dataset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dataset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dataset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dataset value)  $default,){
final _that = this;
switch (_that) {
case _Dataset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dataset value)?  $default,){
final _that = this;
switch (_that) {
case _Dataset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Sample> samples,  String? name,  String? location,  bool shuffled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dataset() when $default != null:
return $default(_that.samples,_that.name,_that.location,_that.shuffled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Sample> samples,  String? name,  String? location,  bool shuffled)  $default,) {final _that = this;
switch (_that) {
case _Dataset():
return $default(_that.samples,_that.name,_that.location,_that.shuffled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Sample> samples,  String? name,  String? location,  bool shuffled)?  $default,) {final _that = this;
switch (_that) {
case _Dataset() when $default != null:
return $default(_that.samples,_that.name,_that.location,_that.shuffled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Dataset implements Dataset {
  const _Dataset({final  List<Sample> samples = const [], this.name, this.location, this.shuffled = false}): _samples = samples;
  factory _Dataset.fromJson(Map<String, dynamic> json) => _$DatasetFromJson(json);

/// The list of sample objects.
 final  List<Sample> _samples;
/// The list of sample objects.
@override@JsonKey() List<Sample> get samples {
  if (_samples is EqualUnmodifiableListView) return _samples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_samples);
}

/// Dataset name.
@override final  String? name;
/// Dataset location (file path or remote URL).
@override final  String? location;
/// Whether the dataset was shuffled after reading.
@override@JsonKey() final  bool shuffled;

/// Create a copy of Dataset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatasetCopyWith<_Dataset> get copyWith => __$DatasetCopyWithImpl<_Dataset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DatasetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dataset&&const DeepCollectionEquality().equals(other._samples, _samples)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.shuffled, shuffled) || other.shuffled == shuffled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_samples),name,location,shuffled);

@override
String toString() {
  return 'Dataset(samples: $samples, name: $name, location: $location, shuffled: $shuffled)';
}


}

/// @nodoc
abstract mixin class _$DatasetCopyWith<$Res> implements $DatasetCopyWith<$Res> {
  factory _$DatasetCopyWith(_Dataset value, $Res Function(_Dataset) _then) = __$DatasetCopyWithImpl;
@override @useResult
$Res call({
 List<Sample> samples, String? name, String? location, bool shuffled
});




}
/// @nodoc
class __$DatasetCopyWithImpl<$Res>
    implements _$DatasetCopyWith<$Res> {
  __$DatasetCopyWithImpl(this._self, this._then);

  final _Dataset _self;
  final $Res Function(_Dataset) _then;

/// Create a copy of Dataset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? samples = null,Object? name = freezed,Object? location = freezed,Object? shuffled = null,}) {
  return _then(_Dataset(
samples: null == samples ? _self._samples : samples // ignore: cast_nullable_to_non_nullable
as List<Sample>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,shuffled: null == shuffled ? _self.shuffled : shuffled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
