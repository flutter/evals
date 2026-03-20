// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContextFileMetadata _$ContextFileMetadataFromJson(Map<String, dynamic> json) =>
    _ContextFileMetadata(
      title: json['title'] as String,
      version: json['version'] as String,
      description: json['description'] as String,
      dartVersion: json['dart_version'] as String?,
      flutterVersion: json['flutter_version'] as String?,
      updated: json['updated'] as String?,
    );

Map<String, dynamic> _$ContextFileMetadataToJson(
  _ContextFileMetadata instance,
) => <String, dynamic>{
  'title': instance.title,
  'version': instance.version,
  'description': instance.description,
  'dart_version': instance.dartVersion,
  'flutter_version': instance.flutterVersion,
  'updated': instance.updated,
};

_ContextFile _$ContextFileFromJson(Map<String, dynamic> json) => _ContextFile(
  metadata: ContextFileMetadata.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
  content: json['content'] as String,
  filePath: json['file_path'] as String,
);

Map<String, dynamic> _$ContextFileToJson(_ContextFile instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'content': instance.content,
      'file_path': instance.filePath,
    };
