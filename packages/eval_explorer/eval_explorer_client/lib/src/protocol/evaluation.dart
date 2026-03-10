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
import 'run.dart' as _i2;
import 'task.dart' as _i3;
import 'sample.dart' as _i4;
import 'model.dart' as _i5;
import 'dataset.dart' as _i6;
import 'variant.dart' as _i7;
import 'tool_call_data.dart' as _i8;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i9;

/// Result of evaluating one sample.
abstract class Evaluation implements _i1.SerializableModel {
  Evaluation._({
    this.id,
    required this.runId,
    this.run,
    required this.taskId,
    this.task,
    required this.sampleId,
    this.sample,
    required this.modelId,
    this.model,
    required this.datasetId,
    this.dataset,
    required this.variant,
    required this.output,
    required this.toolCalls,
    required this.retryCount,
    this.error,
    required this.neverSucceeded,
    required this.durationSeconds,
    this.analyzerPassed,
    this.testsPassed,
    this.testsTotal,
    this.structureScore,
    this.failureReason,
    required this.inputTokens,
    required this.outputTokens,
    required this.reasoningTokens,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Evaluation({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required _i1.UuidValue taskId,
    _i3.Task? task,
    required _i1.UuidValue sampleId,
    _i4.Sample? sample,
    required _i1.UuidValue modelId,
    _i5.Model? model,
    required _i1.UuidValue datasetId,
    _i6.Dataset? dataset,
    required List<_i7.Variant> variant,
    required String output,
    required List<_i8.ToolCallData> toolCalls,
    required int retryCount,
    String? error,
    required bool neverSucceeded,
    required double durationSeconds,
    bool? analyzerPassed,
    int? testsPassed,
    int? testsTotal,
    double? structureScore,
    String? failureReason,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) = _EvaluationImpl;

  factory Evaluation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Evaluation(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      runId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['runId']),
      run: jsonSerialization['run'] == null
          ? null
          : _i9.Protocol().deserialize<_i2.Run>(jsonSerialization['run']),
      taskId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['taskId']),
      task: jsonSerialization['task'] == null
          ? null
          : _i9.Protocol().deserialize<_i3.Task>(jsonSerialization['task']),
      sampleId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['sampleId'],
      ),
      sample: jsonSerialization['sample'] == null
          ? null
          : _i9.Protocol().deserialize<_i4.Sample>(jsonSerialization['sample']),
      modelId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['modelId'],
      ),
      model: jsonSerialization['model'] == null
          ? null
          : _i9.Protocol().deserialize<_i5.Model>(jsonSerialization['model']),
      datasetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['datasetId'],
      ),
      dataset: jsonSerialization['dataset'] == null
          ? null
          : _i9.Protocol().deserialize<_i6.Dataset>(
              jsonSerialization['dataset'],
            ),
      variant: _i9.Protocol().deserialize<List<_i7.Variant>>(
        jsonSerialization['variant'],
      ),
      output: jsonSerialization['output'] as String,
      toolCalls: _i9.Protocol().deserialize<List<_i8.ToolCallData>>(
        jsonSerialization['toolCalls'],
      ),
      retryCount: jsonSerialization['retryCount'] as int,
      error: jsonSerialization['error'] as String?,
      neverSucceeded: jsonSerialization['neverSucceeded'] as bool,
      durationSeconds: (jsonSerialization['durationSeconds'] as num).toDouble(),
      analyzerPassed: jsonSerialization['analyzerPassed'] as bool?,
      testsPassed: jsonSerialization['testsPassed'] as int?,
      testsTotal: jsonSerialization['testsTotal'] as int?,
      structureScore: (jsonSerialization['structureScore'] as num?)?.toDouble(),
      failureReason: jsonSerialization['failureReason'] as String?,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      reasoningTokens: jsonSerialization['reasoningTokens'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue runId;

  /// The parent run.
  _i2.Run? run;

  _i1.UuidValue taskId;

  /// The parent task.
  _i3.Task? task;

  _i1.UuidValue sampleId;

  /// The sample that was evaluated.
  _i4.Sample? sample;

  _i1.UuidValue modelId;

  /// The model that was evaluated.
  _i5.Model? model;

  _i1.UuidValue datasetId;

  /// The dataset this sample belongs to (e.g., "flutter_qa_dataset").
  _i6.Dataset? dataset;

  /// Variant configuration.
  List<_i7.Variant> variant;

  /// The actual output generated by the model.
  String output;

  /// Tool calls made during evaluation.
  List<_i8.ToolCallData> toolCalls;

  /// Number of times this sample was retried.
  int retryCount;

  /// Error message if sample failed.
  String? error;

  /// True if all retries failed (exclude from accuracy calculations).
  bool neverSucceeded;

  /// Total time for this sample in seconds.
  double durationSeconds;

  /// Did flutter analyze pass?
  bool? analyzerPassed;

  /// Number of tests passed.
  int? testsPassed;

  /// Total number of tests.
  int? testsTotal;

  /// Code structure validation score (0.0-1.0).
  double? structureScore;

  /// Categorized failure reason: "analyzer_error", "test_failure", "missing_structure".
  String? failureReason;

  /// Input tokens for this sample.
  int inputTokens;

  /// Output tokens for this sample.
  int outputTokens;

  /// Reasoning tokens for this sample.
  int reasoningTokens;

  /// When this evaluation was run.
  DateTime createdAt;

  /// Returns a shallow copy of this [Evaluation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Evaluation copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? runId,
    _i2.Run? run,
    _i1.UuidValue? taskId,
    _i3.Task? task,
    _i1.UuidValue? sampleId,
    _i4.Sample? sample,
    _i1.UuidValue? modelId,
    _i5.Model? model,
    _i1.UuidValue? datasetId,
    _i6.Dataset? dataset,
    List<_i7.Variant>? variant,
    String? output,
    List<_i8.ToolCallData>? toolCalls,
    int? retryCount,
    String? error,
    bool? neverSucceeded,
    double? durationSeconds,
    bool? analyzerPassed,
    int? testsPassed,
    int? testsTotal,
    double? structureScore,
    String? failureReason,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Evaluation',
      if (id != null) 'id': id?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJson(),
      'taskId': taskId.toJson(),
      if (task != null) 'task': task?.toJson(),
      'sampleId': sampleId.toJson(),
      if (sample != null) 'sample': sample?.toJson(),
      'modelId': modelId.toJson(),
      if (model != null) 'model': model?.toJson(),
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJson(),
      'variant': variant.toJson(valueToJson: (v) => v.toJson()),
      'output': output,
      'toolCalls': toolCalls.toJson(valueToJson: (v) => v.toJson()),
      'retryCount': retryCount,
      if (error != null) 'error': error,
      'neverSucceeded': neverSucceeded,
      'durationSeconds': durationSeconds,
      if (analyzerPassed != null) 'analyzerPassed': analyzerPassed,
      if (testsPassed != null) 'testsPassed': testsPassed,
      if (testsTotal != null) 'testsTotal': testsTotal,
      if (structureScore != null) 'structureScore': structureScore,
      if (failureReason != null) 'failureReason': failureReason,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'reasoningTokens': reasoningTokens,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvaluationImpl extends Evaluation {
  _EvaluationImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required _i1.UuidValue taskId,
    _i3.Task? task,
    required _i1.UuidValue sampleId,
    _i4.Sample? sample,
    required _i1.UuidValue modelId,
    _i5.Model? model,
    required _i1.UuidValue datasetId,
    _i6.Dataset? dataset,
    required List<_i7.Variant> variant,
    required String output,
    required List<_i8.ToolCallData> toolCalls,
    required int retryCount,
    String? error,
    required bool neverSucceeded,
    required double durationSeconds,
    bool? analyzerPassed,
    int? testsPassed,
    int? testsTotal,
    double? structureScore,
    String? failureReason,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) : super._(
         id: id,
         runId: runId,
         run: run,
         taskId: taskId,
         task: task,
         sampleId: sampleId,
         sample: sample,
         modelId: modelId,
         model: model,
         datasetId: datasetId,
         dataset: dataset,
         variant: variant,
         output: output,
         toolCalls: toolCalls,
         retryCount: retryCount,
         error: error,
         neverSucceeded: neverSucceeded,
         durationSeconds: durationSeconds,
         analyzerPassed: analyzerPassed,
         testsPassed: testsPassed,
         testsTotal: testsTotal,
         structureScore: structureScore,
         failureReason: failureReason,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         reasoningTokens: reasoningTokens,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Evaluation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Evaluation copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? runId,
    Object? run = _Undefined,
    _i1.UuidValue? taskId,
    Object? task = _Undefined,
    _i1.UuidValue? sampleId,
    Object? sample = _Undefined,
    _i1.UuidValue? modelId,
    Object? model = _Undefined,
    _i1.UuidValue? datasetId,
    Object? dataset = _Undefined,
    List<_i7.Variant>? variant,
    String? output,
    List<_i8.ToolCallData>? toolCalls,
    int? retryCount,
    Object? error = _Undefined,
    bool? neverSucceeded,
    double? durationSeconds,
    Object? analyzerPassed = _Undefined,
    Object? testsPassed = _Undefined,
    Object? testsTotal = _Undefined,
    Object? structureScore = _Undefined,
    Object? failureReason = _Undefined,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  }) {
    return Evaluation(
      id: id is _i1.UuidValue? ? id : this.id,
      runId: runId ?? this.runId,
      run: run is _i2.Run? ? run : this.run?.copyWith(),
      taskId: taskId ?? this.taskId,
      task: task is _i3.Task? ? task : this.task?.copyWith(),
      sampleId: sampleId ?? this.sampleId,
      sample: sample is _i4.Sample? ? sample : this.sample?.copyWith(),
      modelId: modelId ?? this.modelId,
      model: model is _i5.Model? ? model : this.model?.copyWith(),
      datasetId: datasetId ?? this.datasetId,
      dataset: dataset is _i6.Dataset? ? dataset : this.dataset?.copyWith(),
      variant: variant ?? this.variant.map((e0) => e0).toList(),
      output: output ?? this.output,
      toolCalls:
          toolCalls ?? this.toolCalls.map((e0) => e0.copyWith()).toList(),
      retryCount: retryCount ?? this.retryCount,
      error: error is String? ? error : this.error,
      neverSucceeded: neverSucceeded ?? this.neverSucceeded,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      analyzerPassed: analyzerPassed is bool?
          ? analyzerPassed
          : this.analyzerPassed,
      testsPassed: testsPassed is int? ? testsPassed : this.testsPassed,
      testsTotal: testsTotal is int? ? testsTotal : this.testsTotal,
      structureScore: structureScore is double?
          ? structureScore
          : this.structureScore,
      failureReason: failureReason is String?
          ? failureReason
          : this.failureReason,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
