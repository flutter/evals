// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TagFilter _$TagFilterFromJson(Map<String, dynamic> json) => _TagFilter(
  includeTags: (json['include_tags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  excludeTags: (json['exclude_tags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$TagFilterToJson(_TagFilter instance) =>
    <String, dynamic>{
      'include_tags': instance.includeTags,
      'exclude_tags': instance.excludeTags,
    };
