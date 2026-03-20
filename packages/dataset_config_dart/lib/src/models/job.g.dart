// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Job _$JobFromJson(Map<String, dynamic> json) => _Job(
  description: json['description'] as String?,
  logDir: json['log_dir'] as String,
  maxConnections: (json['max_connections'] as num?)?.toInt() ?? 10,
  models: (json['models'] as List<dynamic>).map((e) => e as String).toList(),
  variants: (json['variants'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Map<String, dynamic>),
  ),
  taskPaths: (json['task_paths'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  tasks: (json['tasks'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, JobTask.fromJson(e as Map<String, dynamic>)),
  ),
  saveExamples: json['save_examples'] as bool? ?? false,
  sandbox: json['sandbox'] as Map<String, dynamic>?,
  inspectEvalArguments: json['inspect_eval_arguments'] as Map<String, dynamic>?,
  taskFilters: json['task_filters'] == null
      ? null
      : TagFilter.fromJson(json['task_filters'] as Map<String, dynamic>),
  sampleFilters: json['sample_filters'] == null
      ? null
      : TagFilter.fromJson(json['sample_filters'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JobToJson(_Job instance) => <String, dynamic>{
  'description': instance.description,
  'log_dir': instance.logDir,
  'max_connections': instance.maxConnections,
  'models': instance.models,
  'variants': instance.variants,
  'task_paths': instance.taskPaths,
  'tasks': instance.tasks,
  'save_examples': instance.saveExamples,
  'sandbox': instance.sandbox,
  'inspect_eval_arguments': instance.inspectEvalArguments,
  'task_filters': instance.taskFilters,
  'sample_filters': instance.sampleFilters,
};

_JobTask _$JobTaskFromJson(Map<String, dynamic> json) => _JobTask(
  id: json['id'] as String,
  includeSamples: (json['include_samples'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  excludeSamples: (json['exclude_samples'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  includeVariants: (json['include_variants'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  excludeVariants: (json['exclude_variants'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  args: json['args'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$JobTaskToJson(_JobTask instance) => <String, dynamic>{
  'id': instance.id,
  'include_samples': instance.includeSamples,
  'exclude_samples': instance.excludeSamples,
  'include_variants': instance.includeVariants,
  'exclude_variants': instance.excludeVariants,
  'args': instance.args,
};
