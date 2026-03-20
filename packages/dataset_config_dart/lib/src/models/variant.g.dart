// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Variant _$VariantFromJson(Map<String, dynamic> json) => _Variant(
  name: json['name'] as String? ?? 'baseline',
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => ContextFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mcpServers:
      (json['mcp_servers'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  taskParameters: json['task_parameters'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$VariantToJson(_Variant instance) => <String, dynamic>{
  'name': instance.name,
  'files': instance.files,
  'mcp_servers': instance.mcpServers,
  'skills': instance.skills,
  'task_parameters': instance.taskParameters,
};
