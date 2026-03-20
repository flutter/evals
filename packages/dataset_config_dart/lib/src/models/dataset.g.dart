// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dataset _$DatasetFromJson(Map<String, dynamic> json) => _Dataset(
  samples:
      (json['samples'] as List<dynamic>?)
          ?.map((e) => Sample.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  name: json['name'] as String?,
  location: json['location'] as String?,
  shuffled: json['shuffled'] as bool? ?? false,
  format: json['format'] as String? ?? 'memory',
  source: json['source'] as String?,
  args: json['args'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DatasetToJson(_Dataset instance) => <String, dynamic>{
  'samples': instance.samples,
  'name': instance.name,
  'location': instance.location,
  'shuffled': instance.shuffled,
  'format': instance.format,
  'source': instance.source,
  'args': instance.args,
};
