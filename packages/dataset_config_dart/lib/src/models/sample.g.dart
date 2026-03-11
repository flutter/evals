// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sample _$SampleFromJson(Map<String, dynamic> json) => _Sample(
  input: json['input'] as Object,
  choices: (json['choices'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  target: json['target'] as Object? ?? '',
  id: json['id'],
  metadata: json['metadata'] as Map<String, dynamic>?,
  sandbox: json['sandbox'],
  files: (json['files'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  setup: json['setup'] as String?,
);

Map<String, dynamic> _$SampleToJson(_Sample instance) => <String, dynamic>{
  'input': instance.input,
  'choices': instance.choices,
  'target': instance.target,
  'id': instance.id,
  'metadata': instance.metadata,
  'sandbox': instance.sandbox,
  'files': instance.files,
  'setup': instance.setup,
};
