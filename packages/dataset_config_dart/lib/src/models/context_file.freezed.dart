// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContextFileMetadata {

/// Title of the context file.
 String get title;/// Version string.
 String get version;/// Description of the context file.
 String get description;/// Dart SDK version this context targets.
@JsonKey(name: 'dart_version') String? get dartVersion;/// Flutter SDK version this context targets.
@JsonKey(name: 'flutter_version') String? get flutterVersion;/// Last updated date string.
 String? get updated;
/// Create a copy of ContextFileMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextFileMetadataCopyWith<ContextFileMetadata> get copyWith => _$ContextFileMetadataCopyWithImpl<ContextFileMetadata>(this as ContextFileMetadata, _$identity);

  /// Serializes this ContextFileMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextFileMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.dartVersion, dartVersion) || other.dartVersion == dartVersion)&&(identical(other.flutterVersion, flutterVersion) || other.flutterVersion == flutterVersion)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,version,description,dartVersion,flutterVersion,updated);

@override
String toString() {
  return 'ContextFileMetadata(title: $title, version: $version, description: $description, dartVersion: $dartVersion, flutterVersion: $flutterVersion, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $ContextFileMetadataCopyWith<$Res>  {
  factory $ContextFileMetadataCopyWith(ContextFileMetadata value, $Res Function(ContextFileMetadata) _then) = _$ContextFileMetadataCopyWithImpl;
@useResult
$Res call({
 String title, String version, String description,@JsonKey(name: 'dart_version') String? dartVersion,@JsonKey(name: 'flutter_version') String? flutterVersion, String? updated
});




}
/// @nodoc
class _$ContextFileMetadataCopyWithImpl<$Res>
    implements $ContextFileMetadataCopyWith<$Res> {
  _$ContextFileMetadataCopyWithImpl(this._self, this._then);

  final ContextFileMetadata _self;
  final $Res Function(ContextFileMetadata) _then;

/// Create a copy of ContextFileMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? version = null,Object? description = null,Object? dartVersion = freezed,Object? flutterVersion = freezed,Object? updated = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,dartVersion: freezed == dartVersion ? _self.dartVersion : dartVersion // ignore: cast_nullable_to_non_nullable
as String?,flutterVersion: freezed == flutterVersion ? _self.flutterVersion : flutterVersion // ignore: cast_nullable_to_non_nullable
as String?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextFileMetadata].
extension ContextFileMetadataPatterns on ContextFileMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextFileMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextFileMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextFileMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ContextFileMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextFileMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ContextFileMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String version,  String description, @JsonKey(name: 'dart_version')  String? dartVersion, @JsonKey(name: 'flutter_version')  String? flutterVersion,  String? updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextFileMetadata() when $default != null:
return $default(_that.title,_that.version,_that.description,_that.dartVersion,_that.flutterVersion,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String version,  String description, @JsonKey(name: 'dart_version')  String? dartVersion, @JsonKey(name: 'flutter_version')  String? flutterVersion,  String? updated)  $default,) {final _that = this;
switch (_that) {
case _ContextFileMetadata():
return $default(_that.title,_that.version,_that.description,_that.dartVersion,_that.flutterVersion,_that.updated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String version,  String description, @JsonKey(name: 'dart_version')  String? dartVersion, @JsonKey(name: 'flutter_version')  String? flutterVersion,  String? updated)?  $default,) {final _that = this;
switch (_that) {
case _ContextFileMetadata() when $default != null:
return $default(_that.title,_that.version,_that.description,_that.dartVersion,_that.flutterVersion,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextFileMetadata implements ContextFileMetadata {
  const _ContextFileMetadata({required this.title, required this.version, required this.description, @JsonKey(name: 'dart_version') this.dartVersion, @JsonKey(name: 'flutter_version') this.flutterVersion, this.updated});
  factory _ContextFileMetadata.fromJson(Map<String, dynamic> json) => _$ContextFileMetadataFromJson(json);

/// Title of the context file.
@override final  String title;
/// Version string.
@override final  String version;
/// Description of the context file.
@override final  String description;
/// Dart SDK version this context targets.
@override@JsonKey(name: 'dart_version') final  String? dartVersion;
/// Flutter SDK version this context targets.
@override@JsonKey(name: 'flutter_version') final  String? flutterVersion;
/// Last updated date string.
@override final  String? updated;

/// Create a copy of ContextFileMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextFileMetadataCopyWith<_ContextFileMetadata> get copyWith => __$ContextFileMetadataCopyWithImpl<_ContextFileMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextFileMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextFileMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.description, description) || other.description == description)&&(identical(other.dartVersion, dartVersion) || other.dartVersion == dartVersion)&&(identical(other.flutterVersion, flutterVersion) || other.flutterVersion == flutterVersion)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,version,description,dartVersion,flutterVersion,updated);

@override
String toString() {
  return 'ContextFileMetadata(title: $title, version: $version, description: $description, dartVersion: $dartVersion, flutterVersion: $flutterVersion, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$ContextFileMetadataCopyWith<$Res> implements $ContextFileMetadataCopyWith<$Res> {
  factory _$ContextFileMetadataCopyWith(_ContextFileMetadata value, $Res Function(_ContextFileMetadata) _then) = __$ContextFileMetadataCopyWithImpl;
@override @useResult
$Res call({
 String title, String version, String description,@JsonKey(name: 'dart_version') String? dartVersion,@JsonKey(name: 'flutter_version') String? flutterVersion, String? updated
});




}
/// @nodoc
class __$ContextFileMetadataCopyWithImpl<$Res>
    implements _$ContextFileMetadataCopyWith<$Res> {
  __$ContextFileMetadataCopyWithImpl(this._self, this._then);

  final _ContextFileMetadata _self;
  final $Res Function(_ContextFileMetadata) _then;

/// Create a copy of ContextFileMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? version = null,Object? description = null,Object? dartVersion = freezed,Object? flutterVersion = freezed,Object? updated = freezed,}) {
  return _then(_ContextFileMetadata(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,dartVersion: freezed == dartVersion ? _self.dartVersion : dartVersion // ignore: cast_nullable_to_non_nullable
as String?,flutterVersion: freezed == flutterVersion ? _self.flutterVersion : flutterVersion // ignore: cast_nullable_to_non_nullable
as String?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContextFile {

/// Parsed frontmatter metadata.
 ContextFileMetadata get metadata;/// File content after the frontmatter section.
 String get content;/// Absolute path to the context file on disk.
@JsonKey(name: 'file_path') String get filePath;
/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextFileCopyWith<ContextFile> get copyWith => _$ContextFileCopyWithImpl<ContextFile>(this as ContextFile, _$identity);

  /// Serializes this ContextFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextFile&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.content, content) || other.content == content)&&(identical(other.filePath, filePath) || other.filePath == filePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,content,filePath);

@override
String toString() {
  return 'ContextFile(metadata: $metadata, content: $content, filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class $ContextFileCopyWith<$Res>  {
  factory $ContextFileCopyWith(ContextFile value, $Res Function(ContextFile) _then) = _$ContextFileCopyWithImpl;
@useResult
$Res call({
 ContextFileMetadata metadata, String content,@JsonKey(name: 'file_path') String filePath
});


$ContextFileMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ContextFileCopyWithImpl<$Res>
    implements $ContextFileCopyWith<$Res> {
  _$ContextFileCopyWithImpl(this._self, this._then);

  final ContextFile _self;
  final $Res Function(ContextFile) _then;

/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? content = null,Object? filePath = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ContextFileMetadata,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextFileMetadataCopyWith<$Res> get metadata {
  
  return $ContextFileMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContextFile].
extension ContextFilePatterns on ContextFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContextFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContextFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContextFile value)  $default,){
final _that = this;
switch (_that) {
case _ContextFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContextFile value)?  $default,){
final _that = this;
switch (_that) {
case _ContextFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContextFileMetadata metadata,  String content, @JsonKey(name: 'file_path')  String filePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContextFile() when $default != null:
return $default(_that.metadata,_that.content,_that.filePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContextFileMetadata metadata,  String content, @JsonKey(name: 'file_path')  String filePath)  $default,) {final _that = this;
switch (_that) {
case _ContextFile():
return $default(_that.metadata,_that.content,_that.filePath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContextFileMetadata metadata,  String content, @JsonKey(name: 'file_path')  String filePath)?  $default,) {final _that = this;
switch (_that) {
case _ContextFile() when $default != null:
return $default(_that.metadata,_that.content,_that.filePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContextFile extends ContextFile {
  const _ContextFile({required this.metadata, required this.content, @JsonKey(name: 'file_path') required this.filePath}): super._();
  factory _ContextFile.fromJson(Map<String, dynamic> json) => _$ContextFileFromJson(json);

/// Parsed frontmatter metadata.
@override final  ContextFileMetadata metadata;
/// File content after the frontmatter section.
@override final  String content;
/// Absolute path to the context file on disk.
@override@JsonKey(name: 'file_path') final  String filePath;

/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContextFileCopyWith<_ContextFile> get copyWith => __$ContextFileCopyWithImpl<_ContextFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContextFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContextFile&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.content, content) || other.content == content)&&(identical(other.filePath, filePath) || other.filePath == filePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,content,filePath);

@override
String toString() {
  return 'ContextFile(metadata: $metadata, content: $content, filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class _$ContextFileCopyWith<$Res> implements $ContextFileCopyWith<$Res> {
  factory _$ContextFileCopyWith(_ContextFile value, $Res Function(_ContextFile) _then) = __$ContextFileCopyWithImpl;
@override @useResult
$Res call({
 ContextFileMetadata metadata, String content,@JsonKey(name: 'file_path') String filePath
});


@override $ContextFileMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ContextFileCopyWithImpl<$Res>
    implements _$ContextFileCopyWith<$Res> {
  __$ContextFileCopyWithImpl(this._self, this._then);

  final _ContextFile _self;
  final $Res Function(_ContextFile) _then;

/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? content = null,Object? filePath = null,}) {
  return _then(_ContextFile(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ContextFileMetadata,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ContextFile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContextFileMetadataCopyWith<$Res> get metadata {
  
  return $ContextFileMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
