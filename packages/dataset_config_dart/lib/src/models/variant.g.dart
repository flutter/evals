// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Variant _$VariantFromJson(Map<String, dynamic> json) => _Variant(
  name: json['name'] as String? ?? 'baseline',
  contextFiles:
      (json['context_files'] as List<dynamic>?)
          ?.map((e) => ContextFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mcpServers:
      (json['mcp_servers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  skillPaths:
      (json['skill_paths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  branch: json['branch'] as String?,
);

Map<String, dynamic> _$VariantToJson(_Variant instance) => <String, dynamic>{
  'name': instance.name,
  'context_files': instance.contextFiles,
  'mcp_servers': instance.mcpServers,
  'skill_paths': instance.skillPaths,
  'branch': instance.branch,
};
