// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TagFilter {

@JsonKey(name: 'include_tags') List<String>? get includeTags;@JsonKey(name: 'exclude_tags') List<String>? get excludeTags;
/// Create a copy of TagFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagFilterCopyWith<TagFilter> get copyWith => _$TagFilterCopyWithImpl<TagFilter>(this as TagFilter, _$identity);

  /// Serializes this TagFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagFilter&&const DeepCollectionEquality().equals(other.includeTags, includeTags)&&const DeepCollectionEquality().equals(other.excludeTags, excludeTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(includeTags),const DeepCollectionEquality().hash(excludeTags));

@override
String toString() {
  return 'TagFilter(includeTags: $includeTags, excludeTags: $excludeTags)';
}


}

/// @nodoc
abstract mixin class $TagFilterCopyWith<$Res>  {
  factory $TagFilterCopyWith(TagFilter value, $Res Function(TagFilter) _then) = _$TagFilterCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'include_tags') List<String>? includeTags,@JsonKey(name: 'exclude_tags') List<String>? excludeTags
});




}
/// @nodoc
class _$TagFilterCopyWithImpl<$Res>
    implements $TagFilterCopyWith<$Res> {
  _$TagFilterCopyWithImpl(this._self, this._then);

  final TagFilter _self;
  final $Res Function(TagFilter) _then;

/// Create a copy of TagFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includeTags = freezed,Object? excludeTags = freezed,}) {
  return _then(_self.copyWith(
includeTags: freezed == includeTags ? _self.includeTags : includeTags // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeTags: freezed == excludeTags ? _self.excludeTags : excludeTags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TagFilter].
extension TagFilterPatterns on TagFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagFilter value)  $default,){
final _that = this;
switch (_that) {
case _TagFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TagFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'include_tags')  List<String>? includeTags, @JsonKey(name: 'exclude_tags')  List<String>? excludeTags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagFilter() when $default != null:
return $default(_that.includeTags,_that.excludeTags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'include_tags')  List<String>? includeTags, @JsonKey(name: 'exclude_tags')  List<String>? excludeTags)  $default,) {final _that = this;
switch (_that) {
case _TagFilter():
return $default(_that.includeTags,_that.excludeTags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'include_tags')  List<String>? includeTags, @JsonKey(name: 'exclude_tags')  List<String>? excludeTags)?  $default,) {final _that = this;
switch (_that) {
case _TagFilter() when $default != null:
return $default(_that.includeTags,_that.excludeTags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TagFilter implements TagFilter {
  const _TagFilter({@JsonKey(name: 'include_tags') final  List<String>? includeTags, @JsonKey(name: 'exclude_tags') final  List<String>? excludeTags}): _includeTags = includeTags,_excludeTags = excludeTags;
  factory _TagFilter.fromJson(Map<String, dynamic> json) => _$TagFilterFromJson(json);

 final  List<String>? _includeTags;
@override@JsonKey(name: 'include_tags') List<String>? get includeTags {
  final value = _includeTags;
  if (value == null) return null;
  if (_includeTags is EqualUnmodifiableListView) return _includeTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _excludeTags;
@override@JsonKey(name: 'exclude_tags') List<String>? get excludeTags {
  final value = _excludeTags;
  if (value == null) return null;
  if (_excludeTags is EqualUnmodifiableListView) return _excludeTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TagFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagFilterCopyWith<_TagFilter> get copyWith => __$TagFilterCopyWithImpl<_TagFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TagFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagFilter&&const DeepCollectionEquality().equals(other._includeTags, _includeTags)&&const DeepCollectionEquality().equals(other._excludeTags, _excludeTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_includeTags),const DeepCollectionEquality().hash(_excludeTags));

@override
String toString() {
  return 'TagFilter(includeTags: $includeTags, excludeTags: $excludeTags)';
}


}

/// @nodoc
abstract mixin class _$TagFilterCopyWith<$Res> implements $TagFilterCopyWith<$Res> {
  factory _$TagFilterCopyWith(_TagFilter value, $Res Function(_TagFilter) _then) = __$TagFilterCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'include_tags') List<String>? includeTags,@JsonKey(name: 'exclude_tags') List<String>? excludeTags
});




}
/// @nodoc
class __$TagFilterCopyWithImpl<$Res>
    implements _$TagFilterCopyWith<$Res> {
  __$TagFilterCopyWithImpl(this._self, this._then);

  final _TagFilter _self;
  final $Res Function(_TagFilter) _then;

/// Create a copy of TagFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? includeTags = freezed,Object? excludeTags = freezed,}) {
  return _then(_TagFilter(
includeTags: freezed == includeTags ? _self._includeTags : includeTags // ignore: cast_nullable_to_non_nullable
as List<String>?,excludeTags: freezed == excludeTags ? _self._excludeTags : excludeTags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
