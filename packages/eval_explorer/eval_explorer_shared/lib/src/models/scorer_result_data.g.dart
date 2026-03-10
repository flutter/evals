// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scorer_result_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScorerResultData _$ScorerResultDataFromJson(Map<String, dynamic> json) =>
    _ScorerResultData(
      name: json['name'] as String,
      passed: json['passed'] as bool,
      explanation: json['explanation'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
    );

Map<String, dynamic> _$ScorerResultDataToJson(_ScorerResultData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'passed': instance.passed,
      'explanation': instance.explanation,
      'answer': instance.answer,
    };
