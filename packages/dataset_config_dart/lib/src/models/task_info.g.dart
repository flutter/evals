// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => _TaskInfo(
  file: json['file'] as String,
  name: json['name'] as String,
  attribs: json['attribs'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$TaskInfoToJson(_TaskInfo instance) => <String, dynamic>{
  'file': instance.file,
  'name': instance.name,
  'attribs': instance.attribs,
};
