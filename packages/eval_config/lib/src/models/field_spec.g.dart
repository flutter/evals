// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldSpec _$FieldSpecFromJson(Map<String, dynamic> json) => _FieldSpec(
  input: json['input'] as String?,
  target: json['target'] as String?,
  choices: json['choices'] as String?,
  id: json['id'] as String?,
  metadata: (json['metadata'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sandbox: json['sandbox'] as String?,
  files: json['files'] as String?,
  setup: json['setup'] as String?,
);

Map<String, dynamic> _$FieldSpecToJson(_FieldSpec instance) =>
    <String, dynamic>{
      'input': instance.input,
      'target': instance.target,
      'choices': instance.choices,
      'id': instance.id,
      'metadata': instance.metadata,
      'sandbox': instance.sandbox,
      'files': instance.files,
      'setup': instance.setup,
    };
