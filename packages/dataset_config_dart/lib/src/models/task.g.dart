// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  dataset: json['dataset'] == null
      ? null
      : Dataset.fromJson(json['dataset'] as Map<String, dynamic>),
  files: (json['files'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  setup: json['setup'],
  solver: json['solver'],
  cleanup: json['cleanup'],
  scorer: json['scorer'],
  metrics: json['metrics'],
  model: json['model'] as String?,
  config: json['config'],
  modelRoles: (json['model_roles'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  sandbox: json['sandbox'],
  approval: json['approval'],
  epochs: json['epochs'],
  failOnError: json['fail_on_error'],
  continueOnFail: json['continue_on_fail'] as bool?,
  messageLimit: (json['message_limit'] as num?)?.toInt(),
  tokenLimit: (json['token_limit'] as num?)?.toInt(),
  timeLimit: (json['time_limit'] as num?)?.toInt(),
  workingLimit: (json['working_limit'] as num?)?.toInt(),
  costLimit: (json['cost_limit'] as num?)?.toDouble(),
  earlyStopping: json['early_stopping'],
  displayName: json['display_name'] as String?,
  func: json['func'] as String?,
  systemMessage: json['system_message'] as String?,
  sandboxParameters: json['sandbox_parameters'] as Map<String, dynamic>?,
  name: json['name'] as String?,
  version: json['version'] as Object? ?? 0,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'dataset': instance.dataset,
  'files': instance.files,
  'setup': instance.setup,
  'solver': instance.solver,
  'cleanup': instance.cleanup,
  'scorer': instance.scorer,
  'metrics': instance.metrics,
  'model': instance.model,
  'config': instance.config,
  'model_roles': instance.modelRoles,
  'sandbox': instance.sandbox,
  'approval': instance.approval,
  'epochs': instance.epochs,
  'fail_on_error': instance.failOnError,
  'continue_on_fail': instance.continueOnFail,
  'message_limit': instance.messageLimit,
  'token_limit': instance.tokenLimit,
  'time_limit': instance.timeLimit,
  'working_limit': instance.workingLimit,
  'cost_limit': instance.costLimit,
  'early_stopping': instance.earlyStopping,
  'display_name': instance.displayName,
  'func': instance.func,
  'system_message': instance.systemMessage,
  'sandbox_parameters': instance.sandboxParameters,
  'name': instance.name,
  'version': instance.version,
  'metadata': instance.metadata,
};
