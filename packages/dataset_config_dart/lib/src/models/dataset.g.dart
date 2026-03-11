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
);

Map<String, dynamic> _$DatasetToJson(_Dataset instance) => <String, dynamic>{
  'samples': instance.samples.map((e) => e.toJson()).toList(),
  'name': instance.name,
  'location': instance.location,
  'shuffled': instance.shuffled,
};
