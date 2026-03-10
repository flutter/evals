/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'task.dart' as _i2;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i3;

abstract class TaskSummary implements _i1.SerializableModel {
  TaskSummary._({
    this.id,
    required this.taskId,
    this.task,
    required this.totalSamples,
    required this.passedSamples,
    required this.accuracy,
    this.taskName,
    required this.inputTokens,
    required this.outputTokens,
    required this.totalTokens,
    required this.reasoningTokens,
    this.variant,
    required this.executionTimeSeconds,
    required this.samplesWithRetries,
    required this.samplesNeverSucceeded,
    required this.totalRetries,
  });

  factory TaskSummary({
    _i1.UuidValue? id,
    required _i1.UuidValue taskId,
    _i2.Task? task,
    required int totalSamples,
    required int passedSamples,
    required double accuracy,
    String? taskName,
    required int inputTokens,
    required int outputTokens,
    required int totalTokens,
    required int reasoningTokens,
    String? variant,
    required int executionTimeSeconds,
    required int samplesWithRetries,
    required int samplesNeverSucceeded,
    required int totalRetries,
  }) = _TaskSummaryImpl;

  factory TaskSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskSummary(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      taskId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['taskId']),
      task: jsonSerialization['task'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Task>(jsonSerialization['task']),
      totalSamples: jsonSerialization['totalSamples'] as int,
      passedSamples: jsonSerialization['passedSamples'] as int,
      accuracy: (jsonSerialization['accuracy'] as num).toDouble(),
      taskName: jsonSerialization['taskName'] as String?,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      totalTokens: jsonSerialization['totalTokens'] as int,
      reasoningTokens: jsonSerialization['reasoningTokens'] as int,
      variant: jsonSerialization['variant'] as String?,
      executionTimeSeconds: jsonSerialization['executionTimeSeconds'] as int,
      samplesWithRetries: jsonSerialization['samplesWithRetries'] as int,
      samplesNeverSucceeded: jsonSerialization['samplesNeverSucceeded'] as int,
      totalRetries: jsonSerialization['totalRetries'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue taskId;

  /// Task this summary belongs to.
  _i2.Task? task;

  /// Total number of samples in this task.
  int totalSamples;

  /// Number of samples that passed.
  int passedSamples;

  /// Accuracy as a value from 0.0 to 1.0.
  double accuracy;

  /// The Inspect AI task function name (e.g., "qa_task").
  String? taskName;

  /// Input tokens used.
  int inputTokens;

  /// Output tokens generated.
  int outputTokens;

  /// Total tokens used.
  int totalTokens;

  /// Reasoning tokens used (for models that support it).
  int reasoningTokens;

  /// Variant configuration used (e.g., "baseline", "dart_mcp").
  String? variant;

  /// Total execution time in seconds.
  int executionTimeSeconds;

  /// Number of samples that needed retries.
  int samplesWithRetries;

  /// Number of samples that failed all retries (excluded from accuracy).
  int samplesNeverSucceeded;

  /// Total number of retries across all samples.
  int totalRetries;

  /// Returns a shallow copy of this [TaskSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaskSummary copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? taskId,
    _i2.Task? task,
    int? totalSamples,
    int? passedSamples,
    double? accuracy,
    String? taskName,
    int? inputTokens,
    int? outputTokens,
    int? totalTokens,
    int? reasoningTokens,
    String? variant,
    int? executionTimeSeconds,
    int? samplesWithRetries,
    int? samplesNeverSucceeded,
    int? totalRetries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaskSummary',
      if (id != null) 'id': id?.toJson(),
      'taskId': taskId.toJson(),
      if (task != null) 'task': task?.toJson(),
      'totalSamples': totalSamples,
      'passedSamples': passedSamples,
      'accuracy': accuracy,
      if (taskName != null) 'taskName': taskName,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'totalTokens': totalTokens,
      'reasoningTokens': reasoningTokens,
      if (variant != null) 'variant': variant,
      'executionTimeSeconds': executionTimeSeconds,
      'samplesWithRetries': samplesWithRetries,
      'samplesNeverSucceeded': samplesNeverSucceeded,
      'totalRetries': totalRetries,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskSummaryImpl extends TaskSummary {
  _TaskSummaryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue taskId,
    _i2.Task? task,
    required int totalSamples,
    required int passedSamples,
    required double accuracy,
    String? taskName,
    required int inputTokens,
    required int outputTokens,
    required int totalTokens,
    required int reasoningTokens,
    String? variant,
    required int executionTimeSeconds,
    required int samplesWithRetries,
    required int samplesNeverSucceeded,
    required int totalRetries,
  }) : super._(
         id: id,
         taskId: taskId,
         task: task,
         totalSamples: totalSamples,
         passedSamples: passedSamples,
         accuracy: accuracy,
         taskName: taskName,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         totalTokens: totalTokens,
         reasoningTokens: reasoningTokens,
         variant: variant,
         executionTimeSeconds: executionTimeSeconds,
         samplesWithRetries: samplesWithRetries,
         samplesNeverSucceeded: samplesNeverSucceeded,
         totalRetries: totalRetries,
       );

  /// Returns a shallow copy of this [TaskSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaskSummary copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? taskId,
    Object? task = _Undefined,
    int? totalSamples,
    int? passedSamples,
    double? accuracy,
    Object? taskName = _Undefined,
    int? inputTokens,
    int? outputTokens,
    int? totalTokens,
    int? reasoningTokens,
    Object? variant = _Undefined,
    int? executionTimeSeconds,
    int? samplesWithRetries,
    int? samplesNeverSucceeded,
    int? totalRetries,
  }) {
    return TaskSummary(
      id: id is _i1.UuidValue? ? id : this.id,
      taskId: taskId ?? this.taskId,
      task: task is _i2.Task? ? task : this.task?.copyWith(),
      totalSamples: totalSamples ?? this.totalSamples,
      passedSamples: passedSamples ?? this.passedSamples,
      accuracy: accuracy ?? this.accuracy,
      taskName: taskName is String? ? taskName : this.taskName,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      totalTokens: totalTokens ?? this.totalTokens,
      reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      variant: variant is String? ? variant : this.variant,
      executionTimeSeconds: executionTimeSeconds ?? this.executionTimeSeconds,
      samplesWithRetries: samplesWithRetries ?? this.samplesWithRetries,
      samplesNeverSucceeded:
          samplesNeverSucceeded ?? this.samplesNeverSucceeded,
      totalRetries: totalRetries ?? this.totalRetries,
    );
  }
}
