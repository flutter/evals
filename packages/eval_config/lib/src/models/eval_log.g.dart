// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eval_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EvalLog _$EvalLogFromJson(Map<String, dynamic> json) => _EvalLog(
  version: (json['version'] as num?)?.toInt() ?? 2,
  status: json['status'] as String? ?? 'started',
  eval: EvalSpec.fromJson(json['eval'] as Map<String, dynamic>),
  plan: json['plan'] == null
      ? null
      : EvalPlan.fromJson(json['plan'] as Map<String, dynamic>),
  results: json['results'] == null
      ? null
      : EvalResults.fromJson(json['results'] as Map<String, dynamic>),
  stats: json['stats'] == null
      ? null
      : EvalStats.fromJson(json['stats'] as Map<String, dynamic>),
  error: json['error'] == null
      ? null
      : EvalError.fromJson(json['error'] as Map<String, dynamic>),
  invalidated: json['invalidated'] as bool? ?? false,
  samples: (json['samples'] as List<dynamic>?)
      ?.map((e) => EvalSample.fromJson(e as Map<String, dynamic>))
      .toList(),
  reductions: (json['reductions'] as List<dynamic>?)
      ?.map((e) => EvalSampleReductions.fromJson(e as Map<String, dynamic>))
      .toList(),
  location: json['location'] as String?,
  etag: json['etag'] as String?,
  evalSetInfo: json['eval_set_info'] == null
      ? null
      : EvalSetInfo.fromJson(json['eval_set_info'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EvalLogToJson(_EvalLog instance) => <String, dynamic>{
  'version': instance.version,
  'status': instance.status,
  'eval': instance.eval.toJson(),
  'plan': instance.plan?.toJson(),
  'results': instance.results?.toJson(),
  'stats': instance.stats?.toJson(),
  'error': instance.error?.toJson(),
  'invalidated': instance.invalidated,
  'samples': instance.samples?.map((e) => e.toJson()).toList(),
  'reductions': instance.reductions?.map((e) => e.toJson()).toList(),
  'location': instance.location,
  'etag': instance.etag,
  'eval_set_info': instance.evalSetInfo?.toJson(),
};

_EvalSpec _$EvalSpecFromJson(Map<String, dynamic> json) => _EvalSpec(
  evalSetId: json['eval_set_id'] as String?,
  evalId: json['eval_id'] as String,
  runId: json['run_id'] as String,
  created: json['created'] as String,
  task: json['task'] as String,
  taskId: json['task_id'] as String,
  taskVersion: json['task_version'] as Object? ?? 0,
  taskFile: json['task_file'] as String?,
  taskDisplayName: json['task_display_name'] as String?,
  taskRegistryName: json['task_registry_name'] as String?,
  taskAttribs: json['task_attribs'] as Map<String, dynamic>? ?? {},
  taskArgs: json['task_args'] as Map<String, dynamic>? ?? {},
  taskArgsPassed: json['task_args_passed'] as Map<String, dynamic>? ?? {},
  solver: json['solver'] as String?,
  solverArgs: json['solver_args'] as Map<String, dynamic>? ?? {},
  solverArgsPassed: json['solver_args_passed'] as Map<String, dynamic>? ?? {},
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dataset: json['dataset'] == null
      ? null
      : EvalDataset.fromJson(json['dataset'] as Map<String, dynamic>),
  sandbox: json['sandbox'],
  model: json['model'] as String,
  modelGenerateConfig: json['model_generate_config'] == null
      ? null
      : GenerateConfig.fromJson(
          json['model_generate_config'] as Map<String, dynamic>,
        ),
  modelBaseUrl: json['model_base_url'] as String?,
  modelArgs: json['model_args'] as Map<String, dynamic>? ?? {},
  modelRoles: (json['model_roles'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  config: json['config'] == null
      ? const EvalConfig()
      : EvalConfig.fromJson(json['config'] as Map<String, dynamic>),
  revision: json['revision'] == null
      ? null
      : EvalRevision.fromJson(json['revision'] as Map<String, dynamic>),
  packages:
      (json['packages'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      {},
  metadata: json['metadata'] as Map<String, dynamic>?,
  scorers:
      (json['scorers'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
      const [],
  metrics:
      (json['metrics'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
      const [],
);

Map<String, dynamic> _$EvalSpecToJson(_EvalSpec instance) => <String, dynamic>{
  'eval_set_id': instance.evalSetId,
  'eval_id': instance.evalId,
  'run_id': instance.runId,
  'created': instance.created,
  'task': instance.task,
  'task_id': instance.taskId,
  'task_version': instance.taskVersion,
  'task_file': instance.taskFile,
  'task_display_name': instance.taskDisplayName,
  'task_registry_name': instance.taskRegistryName,
  'task_attribs': instance.taskAttribs,
  'task_args': instance.taskArgs,
  'task_args_passed': instance.taskArgsPassed,
  'solver': instance.solver,
  'solver_args': instance.solverArgs,
  'solver_args_passed': instance.solverArgsPassed,
  'tags': instance.tags,
  'dataset': instance.dataset?.toJson(),
  'sandbox': instance.sandbox,
  'model': instance.model,
  'model_generate_config': instance.modelGenerateConfig?.toJson(),
  'model_base_url': instance.modelBaseUrl,
  'model_args': instance.modelArgs,
  'model_roles': instance.modelRoles,
  'config': instance.config.toJson(),
  'revision': instance.revision?.toJson(),
  'packages': instance.packages,
  'metadata': instance.metadata,
  'scorers': instance.scorers,
  'metrics': instance.metrics,
};

_EvalDataset _$EvalDatasetFromJson(Map<String, dynamic> json) => _EvalDataset(
  name: json['name'] as String?,
  location: json['location'] as String?,
  samples: (json['samples'] as num).toInt(),
  sampleIds: (json['sample_ids'] as List<dynamic>?)
      ?.map((e) => e as Object)
      .toList(),
  shuffled: json['shuffled'] as bool? ?? false,
);

Map<String, dynamic> _$EvalDatasetToJson(_EvalDataset instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'samples': instance.samples,
      'sample_ids': instance.sampleIds,
      'shuffled': instance.shuffled,
    };

_EvalConfig _$EvalConfigFromJson(Map<String, dynamic> json) => _EvalConfig(
  limit: json['limit'],
  sampleId: json['sample_id'],
  sampleShuffle: json['sample_shuffle'] as bool?,
  epochs: (json['epochs'] as num?)?.toInt(),
  epochsReducer: (json['epochs_reducer'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  approval: json['approval'] as String?,
  failOnError: json['fail_on_error'],
  continueOnFail: json['continue_on_fail'] as bool?,
  retryOnError: (json['retry_on_error'] as num?)?.toInt(),
  messageLimit: (json['message_limit'] as num?)?.toInt(),
  tokenLimit: (json['token_limit'] as num?)?.toInt(),
  timeLimit: (json['time_limit'] as num?)?.toInt(),
  workingLimit: (json['working_limit'] as num?)?.toInt(),
  maxSamples: (json['max_samples'] as num?)?.toInt(),
  maxTasks: (json['max_tasks'] as num?)?.toInt(),
  maxSubprocesses: (json['max_subprocesses'] as num?)?.toInt(),
  maxSandboxes: (json['max_sandboxes'] as num?)?.toInt(),
  sandboxCleanup: json['sandbox_cleanup'] as bool?,
  logSamples: json['log_samples'] as bool?,
  logRealtime: json['log_realtime'] as bool?,
  logImages: json['log_images'] as bool?,
  logBuffer: (json['log_buffer'] as num?)?.toInt(),
  logShared: (json['log_shared'] as num?)?.toInt(),
  scoreDisplay: json['score_display'] as bool?,
);

Map<String, dynamic> _$EvalConfigToJson(_EvalConfig instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'sample_id': instance.sampleId,
      'sample_shuffle': instance.sampleShuffle,
      'epochs': instance.epochs,
      'epochs_reducer': instance.epochsReducer,
      'approval': instance.approval,
      'fail_on_error': instance.failOnError,
      'continue_on_fail': instance.continueOnFail,
      'retry_on_error': instance.retryOnError,
      'message_limit': instance.messageLimit,
      'token_limit': instance.tokenLimit,
      'time_limit': instance.timeLimit,
      'working_limit': instance.workingLimit,
      'max_samples': instance.maxSamples,
      'max_tasks': instance.maxTasks,
      'max_subprocesses': instance.maxSubprocesses,
      'max_sandboxes': instance.maxSandboxes,
      'sandbox_cleanup': instance.sandboxCleanup,
      'log_samples': instance.logSamples,
      'log_realtime': instance.logRealtime,
      'log_images': instance.logImages,
      'log_buffer': instance.logBuffer,
      'log_shared': instance.logShared,
      'score_display': instance.scoreDisplay,
    };

_EvalRevision _$EvalRevisionFromJson(Map<String, dynamic> json) =>
    _EvalRevision(
      type: json['type'] as String,
      origin: json['origin'] as String,
      commit: json['commit'] as String,
      dirty: json['dirty'] as bool? ?? false,
    );

Map<String, dynamic> _$EvalRevisionToJson(_EvalRevision instance) =>
    <String, dynamic>{
      'type': instance.type,
      'origin': instance.origin,
      'commit': instance.commit,
      'dirty': instance.dirty,
    };

_EvalPlan _$EvalPlanFromJson(Map<String, dynamic> json) => _EvalPlan(
  name: json['name'] as String? ?? 'plan',
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => EvalPlanStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  finish: json['finish'] == null
      ? null
      : EvalPlanStep.fromJson(json['finish'] as Map<String, dynamic>),
  config: json['config'] == null
      ? const GenerateConfig()
      : GenerateConfig.fromJson(json['config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EvalPlanToJson(_EvalPlan instance) => <String, dynamic>{
  'name': instance.name,
  'steps': instance.steps.map((e) => e.toJson()).toList(),
  'finish': instance.finish?.toJson(),
  'config': instance.config.toJson(),
};

_EvalPlanStep _$EvalPlanStepFromJson(Map<String, dynamic> json) =>
    _EvalPlanStep(
      solver: json['solver'] as String,
      params: json['params'] as Map<String, dynamic>? ?? const {},
      paramsPassed: json['params_passed'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EvalPlanStepToJson(_EvalPlanStep instance) =>
    <String, dynamic>{
      'solver': instance.solver,
      'params': instance.params,
      'params_passed': instance.paramsPassed,
    };

_EvalResults _$EvalResultsFromJson(Map<String, dynamic> json) => _EvalResults(
  totalSamples: (json['total_samples'] as num?)?.toInt() ?? 0,
  completedSamples: (json['completed_samples'] as num?)?.toInt() ?? 0,
  earlyStopping: json['early_stopping'] == null
      ? null
      : EarlyStoppingSummary.fromJson(
          json['early_stopping'] as Map<String, dynamic>,
        ),
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => EvalScore.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  sampleReductions: (json['sample_reductions'] as List<dynamic>?)
      ?.map((e) => EvalSampleReductions.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EvalResultsToJson(_EvalResults instance) =>
    <String, dynamic>{
      'total_samples': instance.totalSamples,
      'completed_samples': instance.completedSamples,
      'early_stopping': instance.earlyStopping?.toJson(),
      'scores': instance.scores.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata,
      'sample_reductions': instance.sampleReductions
          ?.map((e) => e.toJson())
          .toList(),
    };

_EarlyStoppingSummary _$EarlyStoppingSummaryFromJson(
  Map<String, dynamic> json,
) => _EarlyStoppingSummary(
  type: json['type'] as String,
  limit: (json['limit'] as num?)?.toDouble(),
  score: (json['score'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$EarlyStoppingSummaryToJson(
  _EarlyStoppingSummary instance,
) => <String, dynamic>{
  'type': instance.type,
  'limit': instance.limit,
  'score': instance.score,
  'metadata': instance.metadata,
};

_EvalScore _$EvalScoreFromJson(Map<String, dynamic> json) => _EvalScore(
  name: json['name'] as String,
  scorer: json['scorer'] as String,
  reducer: json['reducer'] as String?,
  scoredSamples: (json['scored_samples'] as num?)?.toInt(),
  unscoredSamples: (json['unscored_samples'] as num?)?.toInt(),
  params: json['params'] as Map<String, dynamic>? ?? const {},
  metrics: json['metrics'] == null
      ? const []
      : _metricsFromJson(json['metrics']),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$EvalScoreToJson(_EvalScore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'scorer': instance.scorer,
      'reducer': instance.reducer,
      'scored_samples': instance.scoredSamples,
      'unscored_samples': instance.unscoredSamples,
      'params': instance.params,
      'metrics': instance.metrics.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata,
    };

_EvalMetric _$EvalMetricFromJson(Map<String, dynamic> json) => _EvalMetric(
  name: json['name'] as String,
  value: json['value'] as Object,
  params: json['params'] as Map<String, dynamic>? ?? const {},
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$EvalMetricToJson(_EvalMetric instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'params': instance.params,
      'metadata': instance.metadata,
    };

_EvalSampleReductions _$EvalSampleReductionsFromJson(
  Map<String, dynamic> json,
) => _EvalSampleReductions(
  scorer: json['scorer'] as String,
  reducer: json['reducer'] as String?,
  samples: (json['samples'] as List<dynamic>)
      .map((e) => EvalSampleScore.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EvalSampleReductionsToJson(
  _EvalSampleReductions instance,
) => <String, dynamic>{
  'scorer': instance.scorer,
  'reducer': instance.reducer,
  'samples': instance.samples.map((e) => e.toJson()).toList(),
};

_EvalStats _$EvalStatsFromJson(Map<String, dynamic> json) => _EvalStats(
  startedAt: json['started_at'] as String,
  completedAt: json['completed_at'] as String,
  modelUsage:
      (json['model_usage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ModelUsage.fromJson(e as Map<String, dynamic>)),
      ) ??
      {},
);

Map<String, dynamic> _$EvalStatsToJson(_EvalStats instance) =>
    <String, dynamic>{
      'started_at': instance.startedAt,
      'completed_at': instance.completedAt,
      'model_usage': instance.modelUsage.map((k, e) => MapEntry(k, e.toJson())),
    };

_EvalError _$EvalErrorFromJson(Map<String, dynamic> json) => _EvalError(
  message: json['message'] as String,
  traceback: json['traceback'] as String,
  tracebackAnsi: json['traceback_ansi'] as String,
);

Map<String, dynamic> _$EvalErrorToJson(_EvalError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'traceback': instance.traceback,
      'traceback_ansi': instance.tracebackAnsi,
    };

_EvalSample _$EvalSampleFromJson(Map<String, dynamic> json) => _EvalSample(
  id: json['id'] as Object,
  epoch: (json['epoch'] as num).toInt(),
  input: json['input'] as Object,
  choices: (json['choices'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  target: json['target'],
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  sandbox: json['sandbox'],
  files: (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
  setup: json['setup'] as String?,
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  output: ModelOutput.fromJson(json['output'] as Map<String, dynamic>),
  scores: (json['scores'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, Score.fromJson(e as Map<String, dynamic>)),
  ),
  store: json['store'] as Map<String, dynamic>? ?? const {},
  events:
      (json['events'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
      const [],
  modelUsage:
      (json['model_usage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ModelUsage.fromJson(e as Map<String, dynamic>)),
      ) ??
      {},
  startedAt: json['started_at'] as String?,
  completedAt: json['completed_at'] as String?,
  totalTime: (json['total_time'] as num?)?.toDouble(),
  workingTime: (json['working_time'] as num?)?.toDouble(),
  uuid: json['uuid'] as String?,
  invalidation: json['invalidation'] == null
      ? null
      : ProvenanceData.fromJson(json['invalidation'] as Map<String, dynamic>),
  error: json['error'] == null
      ? null
      : EvalError.fromJson(json['error'] as Map<String, dynamic>),
  errorRetries: (json['error_retries'] as List<dynamic>?)
      ?.map((e) => EvalError.fromJson(e as Map<String, dynamic>))
      .toList(),
  attachments:
      (json['attachments'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  limit: json['limit'] == null
      ? null
      : EvalSampleLimit.fromJson(json['limit'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EvalSampleToJson(_EvalSample instance) =>
    <String, dynamic>{
      'id': instance.id,
      'epoch': instance.epoch,
      'input': instance.input,
      'choices': instance.choices,
      'target': instance.target,
      'metadata': instance.metadata,
      'sandbox': instance.sandbox,
      'files': instance.files,
      'setup': instance.setup,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'output': instance.output.toJson(),
      'scores': instance.scores?.map((k, e) => MapEntry(k, e.toJson())),
      'store': instance.store,
      'events': instance.events,
      'model_usage': instance.modelUsage.map((k, e) => MapEntry(k, e.toJson())),
      'started_at': instance.startedAt,
      'completed_at': instance.completedAt,
      'total_time': instance.totalTime,
      'working_time': instance.workingTime,
      'uuid': instance.uuid,
      'invalidation': instance.invalidation?.toJson(),
      'error': instance.error?.toJson(),
      'error_retries': instance.errorRetries?.map((e) => e.toJson()).toList(),
      'attachments': instance.attachments,
      'limit': instance.limit?.toJson(),
    };

_ModelOutput _$ModelOutputFromJson(Map<String, dynamic> json) => _ModelOutput(
  model: json['model'] as String,
  choices:
      (json['choices'] as List<dynamic>?)
          ?.map((e) => ChatCompletionChoice.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  usage: json['usage'] == null
      ? null
      : ModelUsage.fromJson(json['usage'] as Map<String, dynamic>),
  completion: json['completion'] as String,
  stopReason: json['stop_reason'] as String? ?? 'unknown',
  time: (json['time'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  error: json['error'] as String?,
  message: json['message'] == null
      ? null
      : ChatMessageAssistant.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ModelOutputToJson(_ModelOutput instance) =>
    <String, dynamic>{
      'model': instance.model,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
      'completion': instance.completion,
      'stop_reason': instance.stopReason,
      'time': instance.time,
      'metadata': instance.metadata,
      'error': instance.error,
      'message': instance.message?.toJson(),
    };

_ChatCompletionChoice _$ChatCompletionChoiceFromJson(
  Map<String, dynamic> json,
) => _ChatCompletionChoice(
  message: ChatMessageAssistant.fromJson(
    json['message'] as Map<String, dynamic>,
  ),
  stopReason: json['stop_reason'] as String? ?? 'unknown',
  logprobs: json['logprobs'] == null
      ? null
      : Logprobs.fromJson(json['logprobs'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatCompletionChoiceToJson(
  _ChatCompletionChoice instance,
) => <String, dynamic>{
  'message': instance.message.toJson(),
  'stop_reason': instance.stopReason,
  'logprobs': instance.logprobs?.toJson(),
};

_ModelUsage _$ModelUsageFromJson(Map<String, dynamic> json) => _ModelUsage(
  inputTokens: (json['input_tokens'] as num?)?.toInt() ?? 0,
  outputTokens: (json['output_tokens'] as num?)?.toInt() ?? 0,
  totalTokens: (json['total_tokens'] as num?)?.toInt() ?? 0,
  inputTokensCacheWrite: (json['input_tokens_cache_write'] as num?)?.toInt(),
  inputTokensCacheRead: (json['input_tokens_cache_read'] as num?)?.toInt(),
  reasoningTokens: (json['reasoning_tokens'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ModelUsageToJson(_ModelUsage instance) =>
    <String, dynamic>{
      'input_tokens': instance.inputTokens,
      'output_tokens': instance.outputTokens,
      'total_tokens': instance.totalTokens,
      'input_tokens_cache_write': instance.inputTokensCacheWrite,
      'input_tokens_cache_read': instance.inputTokensCacheRead,
      'reasoning_tokens': instance.reasoningTokens,
    };

ChatMessageSystem _$ChatMessageSystemFromJson(Map<String, dynamic> json) =>
    ChatMessageSystem(
      id: json['id'] as String?,
      content: json['content'] as Object,
      source: json['source'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      role: json['role'] as String? ?? 'system',
    );

Map<String, dynamic> _$ChatMessageSystemToJson(ChatMessageSystem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'source': instance.source,
      'metadata': instance.metadata,
      'role': instance.role,
    };

ChatMessageUser _$ChatMessageUserFromJson(Map<String, dynamic> json) =>
    ChatMessageUser(
      id: json['id'] as String?,
      content: json['content'] as Object,
      source: json['source'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      role: json['role'] as String? ?? 'user',
      toolCallId: json['tool_call_id'],
    );

Map<String, dynamic> _$ChatMessageUserToJson(ChatMessageUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'source': instance.source,
      'metadata': instance.metadata,
      'role': instance.role,
      'tool_call_id': instance.toolCallId,
    };

ChatMessageAssistant _$ChatMessageAssistantFromJson(
  Map<String, dynamic> json,
) => ChatMessageAssistant(
  id: json['id'] as String?,
  content: json['content'] as Object,
  source: json['source'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  role: json['role'] as String? ?? 'assistant',
  toolCalls: (json['tool_calls'] as List<dynamic>?)
      ?.map((e) => ToolCall.fromJson(e as Map<String, dynamic>))
      .toList(),
  model: json['model'] as String?,
);

Map<String, dynamic> _$ChatMessageAssistantToJson(
  ChatMessageAssistant instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'source': instance.source,
  'metadata': instance.metadata,
  'role': instance.role,
  'tool_calls': instance.toolCalls?.map((e) => e.toJson()).toList(),
  'model': instance.model,
};

ChatMessageTool _$ChatMessageToolFromJson(Map<String, dynamic> json) =>
    ChatMessageTool(
      id: json['id'] as String?,
      content: json['content'] as Object,
      source: json['source'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      role: json['role'] as String? ?? 'tool',
      toolCallId: json['tool_call_id'] as String?,
      function: json['function'] as String?,
      error: json['error'] == null
          ? null
          : ToolCallError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageToolToJson(ChatMessageTool instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'source': instance.source,
      'metadata': instance.metadata,
      'role': instance.role,
      'tool_call_id': instance.toolCallId,
      'function': instance.function,
      'error': instance.error?.toJson(),
    };

ContentText _$ContentTextFromJson(Map<String, dynamic> json) => ContentText(
  text: json['text'] as String,
  refusal: json['refusal'] as bool? ?? false,
  citations: (json['citations'] as List<dynamic>?)
      ?.map((e) => e as Object)
      .toList(),
  type: json['type'] as String? ?? 'text',
);

Map<String, dynamic> _$ContentTextToJson(ContentText instance) =>
    <String, dynamic>{
      'text': instance.text,
      'refusal': instance.refusal,
      'citations': instance.citations,
      'type': instance.type,
    };

ContentReasoning _$ContentReasoningFromJson(Map<String, dynamic> json) =>
    ContentReasoning(
      reasoning: json['reasoning'] as String,
      summary: json['summary'] as String?,
      signature: json['signature'] as String?,
      redacted: json['redacted'] as bool? ?? false,
      text: json['text'] as String?,
      type: json['type'] as String? ?? 'reasoning',
    );

Map<String, dynamic> _$ContentReasoningToJson(ContentReasoning instance) =>
    <String, dynamic>{
      'reasoning': instance.reasoning,
      'summary': instance.summary,
      'signature': instance.signature,
      'redacted': instance.redacted,
      'text': instance.text,
      'type': instance.type,
    };

ContentImage _$ContentImageFromJson(Map<String, dynamic> json) => ContentImage(
  image: json['image'] as String,
  detail: json['detail'] as String? ?? 'auto',
  type: json['type'] as String? ?? 'image',
);

Map<String, dynamic> _$ContentImageToJson(ContentImage instance) =>
    <String, dynamic>{
      'image': instance.image,
      'detail': instance.detail,
      'type': instance.type,
    };

ContentAudio _$ContentAudioFromJson(Map<String, dynamic> json) => ContentAudio(
  audio: json['audio'] as String,
  format: json['format'] as String,
  type: json['type'] as String? ?? 'audio',
);

Map<String, dynamic> _$ContentAudioToJson(ContentAudio instance) =>
    <String, dynamic>{
      'audio': instance.audio,
      'format': instance.format,
      'type': instance.type,
    };

ContentVideo _$ContentVideoFromJson(Map<String, dynamic> json) => ContentVideo(
  video: json['video'] as String,
  format: json['format'] as String,
  type: json['type'] as String? ?? 'video',
);

Map<String, dynamic> _$ContentVideoToJson(ContentVideo instance) =>
    <String, dynamic>{
      'video': instance.video,
      'format': instance.format,
      'type': instance.type,
    };

ContentDocument _$ContentDocumentFromJson(Map<String, dynamic> json) =>
    ContentDocument(
      document: json['document'] as String,
      filename: json['filename'] as String?,
      mimeType: json['mime_type'] as String?,
      type: json['type'] as String? ?? 'document',
    );

Map<String, dynamic> _$ContentDocumentToJson(ContentDocument instance) =>
    <String, dynamic>{
      'document': instance.document,
      'filename': instance.filename,
      'mime_type': instance.mimeType,
      'type': instance.type,
    };

ContentData _$ContentDataFromJson(Map<String, dynamic> json) => ContentData(
  data: json['data'] as Map<String, dynamic>,
  type: json['type'] as String? ?? 'data',
);

Map<String, dynamic> _$ContentDataToJson(ContentData instance) =>
    <String, dynamic>{'data': instance.data, 'type': instance.type};

ContentToolUse _$ContentToolUseFromJson(Map<String, dynamic> json) =>
    ContentToolUse(
      toolType: json['tool_type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      context: json['context'] as Map<String, dynamic>?,
      arguments: json['arguments'] as Map<String, dynamic>,
      result: json['result'],
      error: json['error'],
      type: json['type'] as String? ?? 'tool_use',
    );

Map<String, dynamic> _$ContentToolUseToJson(ContentToolUse instance) =>
    <String, dynamic>{
      'tool_type': instance.toolType,
      'id': instance.id,
      'name': instance.name,
      'context': instance.context,
      'arguments': instance.arguments,
      'result': instance.result,
      'error': instance.error,
      'type': instance.type,
    };

_EvalSampleScore _$EvalSampleScoreFromJson(Map<String, dynamic> json) =>
    _EvalSampleScore(
      value: json['value'] as Object,
      answer: json['answer'] as String?,
      explanation: json['explanation'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      history:
          (json['history'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          const [],
      sampleId: json['sample_id'],
    );

Map<String, dynamic> _$EvalSampleScoreToJson(_EvalSampleScore instance) =>
    <String, dynamic>{
      'value': instance.value,
      'answer': instance.answer,
      'explanation': instance.explanation,
      'metadata': instance.metadata,
      'history': instance.history,
      'sample_id': instance.sampleId,
    };

_Score _$ScoreFromJson(Map<String, dynamic> json) => _Score(
  value: json['value'] as Object,
  answer: json['answer'] as String?,
  explanation: json['explanation'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ScoreToJson(_Score instance) => <String, dynamic>{
  'value': instance.value,
  'answer': instance.answer,
  'explanation': instance.explanation,
  'metadata': instance.metadata,
};

_ToolCall _$ToolCallFromJson(Map<String, dynamic> json) => _ToolCall(
  id: json['id'] as String,
  function: json['function'] as String,
  arguments: json['arguments'] as Map<String, dynamic>,
  type: json['type'] as String? ?? 'call',
);

Map<String, dynamic> _$ToolCallToJson(_ToolCall instance) => <String, dynamic>{
  'id': instance.id,
  'function': instance.function,
  'arguments': instance.arguments,
  'type': instance.type,
};

_ToolCallError _$ToolCallErrorFromJson(Map<String, dynamic> json) =>
    _ToolCallError(
      message: json['message'] as String,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ToolCallErrorToJson(_ToolCallError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };

_GenerateConfig _$GenerateConfigFromJson(Map<String, dynamic> json) =>
    _GenerateConfig(
      maxRetries: (json['max_retries'] as num?)?.toInt(),
      timeout: (json['timeout'] as num?)?.toInt(),
      attemptTimeout: (json['attempt_timeout'] as num?)?.toInt(),
      maxConnections: (json['max_connections'] as num?)?.toInt(),
      systemMessage: json['system_message'] as String?,
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      topP: (json['top_p'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      stopSeqs: (json['stop_seqs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bestOf: (json['best_of'] as num?)?.toInt(),
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble(),
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble(),
      logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      seed: (json['seed'] as num?)?.toInt(),
      topK: (json['top_k'] as num?)?.toInt(),
      numChoices: (json['num_choices'] as num?)?.toInt(),
      logprobs: json['logprobs'] as bool?,
      topLogprobs: (json['top_logprobs'] as num?)?.toInt(),
      parallelToolCalls: json['parallel_tool_calls'] as bool?,
      internalTools: json['internal_tools'] as bool?,
      maxToolOutput: (json['max_tool_output'] as num?)?.toInt(),
      cachePrompt: json['cache_prompt'],
    );

Map<String, dynamic> _$GenerateConfigToJson(_GenerateConfig instance) =>
    <String, dynamic>{
      'max_retries': instance.maxRetries,
      'timeout': instance.timeout,
      'attempt_timeout': instance.attemptTimeout,
      'max_connections': instance.maxConnections,
      'system_message': instance.systemMessage,
      'max_tokens': instance.maxTokens,
      'top_p': instance.topP,
      'temperature': instance.temperature,
      'stop_seqs': instance.stopSeqs,
      'best_of': instance.bestOf,
      'frequency_penalty': instance.frequencyPenalty,
      'presence_penalty': instance.presencePenalty,
      'logit_bias': instance.logitBias,
      'seed': instance.seed,
      'top_k': instance.topK,
      'num_choices': instance.numChoices,
      'logprobs': instance.logprobs,
      'top_logprobs': instance.topLogprobs,
      'parallel_tool_calls': instance.parallelToolCalls,
      'internal_tools': instance.internalTools,
      'max_tool_output': instance.maxToolOutput,
      'cache_prompt': instance.cachePrompt,
    };

_Logprobs _$LogprobsFromJson(Map<String, dynamic> json) => _Logprobs(
  content: (json['content'] as List<dynamic>).map((e) => e as Object).toList(),
);

Map<String, dynamic> _$LogprobsToJson(_Logprobs instance) => <String, dynamic>{
  'content': instance.content,
};

_ProvenanceData _$ProvenanceDataFromJson(Map<String, dynamic> json) =>
    _ProvenanceData(
      location: json['location'] as String,
      shash: json['shash'] as String,
    );

Map<String, dynamic> _$ProvenanceDataToJson(_ProvenanceData instance) =>
    <String, dynamic>{'location': instance.location, 'shash': instance.shash};

_EvalSampleLimit _$EvalSampleLimitFromJson(Map<String, dynamic> json) =>
    _EvalSampleLimit(
      type: json['type'] as String,
      limit: (json['limit'] as num).toDouble(),
    );

Map<String, dynamic> _$EvalSampleLimitToJson(_EvalSampleLimit instance) =>
    <String, dynamic>{'type': instance.type, 'limit': instance.limit};

_EvalSetInfo _$EvalSetInfoFromJson(Map<String, dynamic> json) => _EvalSetInfo(
  evalSetId: json['eval_set_id'] as String,
  tasks: (json['tasks'] as List<dynamic>)
      .map((e) => EvalSetTask.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EvalSetInfoToJson(_EvalSetInfo instance) =>
    <String, dynamic>{
      'eval_set_id': instance.evalSetId,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };

_EvalSetTask _$EvalSetTaskFromJson(Map<String, dynamic> json) => _EvalSetTask(
  name: json['name'] as String?,
  taskId: json['task_id'] as String,
  taskFile: json['task_file'] as String?,
  taskArgs: json['task_args'] as Map<String, dynamic>? ?? {},
  model: json['model'] as String,
  modelArgs: json['model_args'] as Map<String, dynamic>? ?? {},
  modelRoles: (json['model_roles'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  sequence: (json['sequence'] as num).toInt(),
);

Map<String, dynamic> _$EvalSetTaskToJson(_EvalSetTask instance) =>
    <String, dynamic>{
      'name': instance.name,
      'task_id': instance.taskId,
      'task_file': instance.taskFile,
      'task_args': instance.taskArgs,
      'model': instance.model,
      'model_args': instance.modelArgs,
      'model_roles': instance.modelRoles,
      'sequence': instance.sequence,
    };
