/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'run.dart' as _i2;
import 'task.dart' as _i3;
import 'sample.dart' as _i4;
import 'model.dart' as _i5;
import 'dataset.dart' as _i6;
import 'variant.dart' as _i7;
import 'tool_call_data.dart' as _i8;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i9;

/// Result of evaluating one sample.
abstract class Evaluation
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = EvaluationTable();

  static const db = EvaluationRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Evaluation',
      if (id != null) 'id': id?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJsonForProtocol(),
      'taskId': taskId.toJson(),
      if (task != null) 'task': task?.toJsonForProtocol(),
      'sampleId': sampleId.toJson(),
      if (sample != null) 'sample': sample?.toJsonForProtocol(),
      'modelId': modelId.toJson(),
      if (model != null) 'model': model?.toJsonForProtocol(),
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJsonForProtocol(),
      'variant': variant.toJson(valueToJson: (v) => v.toJson()),
      'output': output,
      'toolCalls': toolCalls.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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

  static EvaluationInclude include({
    _i2.RunInclude? run,
    _i3.TaskInclude? task,
    _i4.SampleInclude? sample,
    _i5.ModelInclude? model,
    _i6.DatasetInclude? dataset,
  }) {
    return EvaluationInclude._(
      run: run,
      task: task,
      sample: sample,
      model: model,
      dataset: dataset,
    );
  }

  static EvaluationIncludeList includeList({
    _i1.WhereExpressionBuilder<EvaluationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvaluationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvaluationTable>? orderByList,
    EvaluationInclude? include,
  }) {
    return EvaluationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Evaluation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Evaluation.t),
      include: include,
    );
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

class EvaluationUpdateTable extends _i1.UpdateTable<EvaluationTable> {
  EvaluationUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> runId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.runId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> taskId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.taskId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> sampleId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.sampleId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> modelId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.modelId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> datasetId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.datasetId,
    value,
  );

  _i1.ColumnValue<List<_i7.Variant>, List<_i7.Variant>> variant(
    List<_i7.Variant> value,
  ) => _i1.ColumnValue(
    table.variant,
    value,
  );

  _i1.ColumnValue<String, String> output(String value) => _i1.ColumnValue(
    table.output,
    value,
  );

  _i1.ColumnValue<List<_i8.ToolCallData>, List<_i8.ToolCallData>> toolCalls(
    List<_i8.ToolCallData> value,
  ) => _i1.ColumnValue(
    table.toolCalls,
    value,
  );

  _i1.ColumnValue<int, int> retryCount(int value) => _i1.ColumnValue(
    table.retryCount,
    value,
  );

  _i1.ColumnValue<String, String> error(String? value) => _i1.ColumnValue(
    table.error,
    value,
  );

  _i1.ColumnValue<bool, bool> neverSucceeded(bool value) => _i1.ColumnValue(
    table.neverSucceeded,
    value,
  );

  _i1.ColumnValue<double, double> durationSeconds(double value) =>
      _i1.ColumnValue(
        table.durationSeconds,
        value,
      );

  _i1.ColumnValue<bool, bool> analyzerPassed(bool? value) => _i1.ColumnValue(
    table.analyzerPassed,
    value,
  );

  _i1.ColumnValue<int, int> testsPassed(int? value) => _i1.ColumnValue(
    table.testsPassed,
    value,
  );

  _i1.ColumnValue<int, int> testsTotal(int? value) => _i1.ColumnValue(
    table.testsTotal,
    value,
  );

  _i1.ColumnValue<double, double> structureScore(double? value) =>
      _i1.ColumnValue(
        table.structureScore,
        value,
      );

  _i1.ColumnValue<String, String> failureReason(String? value) =>
      _i1.ColumnValue(
        table.failureReason,
        value,
      );

  _i1.ColumnValue<int, int> inputTokens(int value) => _i1.ColumnValue(
    table.inputTokens,
    value,
  );

  _i1.ColumnValue<int, int> outputTokens(int value) => _i1.ColumnValue(
    table.outputTokens,
    value,
  );

  _i1.ColumnValue<int, int> reasoningTokens(int value) => _i1.ColumnValue(
    table.reasoningTokens,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class EvaluationTable extends _i1.Table<_i1.UuidValue?> {
  EvaluationTable({super.tableRelation})
    : super(tableName: 'evals_evaluations') {
    updateTable = EvaluationUpdateTable(this);
    runId = _i1.ColumnUuid(
      'runId',
      this,
    );
    taskId = _i1.ColumnUuid(
      'taskId',
      this,
    );
    sampleId = _i1.ColumnUuid(
      'sampleId',
      this,
    );
    modelId = _i1.ColumnUuid(
      'modelId',
      this,
    );
    datasetId = _i1.ColumnUuid(
      'datasetId',
      this,
    );
    variant = _i1.ColumnSerializable<List<_i7.Variant>>(
      'variant',
      this,
    );
    output = _i1.ColumnString(
      'output',
      this,
    );
    toolCalls = _i1.ColumnSerializable<List<_i8.ToolCallData>>(
      'toolCalls',
      this,
    );
    retryCount = _i1.ColumnInt(
      'retryCount',
      this,
    );
    error = _i1.ColumnString(
      'error',
      this,
    );
    neverSucceeded = _i1.ColumnBool(
      'neverSucceeded',
      this,
    );
    durationSeconds = _i1.ColumnDouble(
      'durationSeconds',
      this,
    );
    analyzerPassed = _i1.ColumnBool(
      'analyzerPassed',
      this,
    );
    testsPassed = _i1.ColumnInt(
      'testsPassed',
      this,
    );
    testsTotal = _i1.ColumnInt(
      'testsTotal',
      this,
    );
    structureScore = _i1.ColumnDouble(
      'structureScore',
      this,
    );
    failureReason = _i1.ColumnString(
      'failureReason',
      this,
    );
    inputTokens = _i1.ColumnInt(
      'inputTokens',
      this,
    );
    outputTokens = _i1.ColumnInt(
      'outputTokens',
      this,
    );
    reasoningTokens = _i1.ColumnInt(
      'reasoningTokens',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final EvaluationUpdateTable updateTable;

  late final _i1.ColumnUuid runId;

  /// The parent run.
  _i2.RunTable? _run;

  late final _i1.ColumnUuid taskId;

  /// The parent task.
  _i3.TaskTable? _task;

  late final _i1.ColumnUuid sampleId;

  /// The sample that was evaluated.
  _i4.SampleTable? _sample;

  late final _i1.ColumnUuid modelId;

  /// The model that was evaluated.
  _i5.ModelTable? _model;

  late final _i1.ColumnUuid datasetId;

  /// The dataset this sample belongs to (e.g., "flutter_qa_dataset").
  _i6.DatasetTable? _dataset;

  /// Variant configuration.
  late final _i1.ColumnSerializable<List<_i7.Variant>> variant;

  /// The actual output generated by the model.
  late final _i1.ColumnString output;

  /// Tool calls made during evaluation.
  late final _i1.ColumnSerializable<List<_i8.ToolCallData>> toolCalls;

  /// Number of times this sample was retried.
  late final _i1.ColumnInt retryCount;

  /// Error message if sample failed.
  late final _i1.ColumnString error;

  /// True if all retries failed (exclude from accuracy calculations).
  late final _i1.ColumnBool neverSucceeded;

  /// Total time for this sample in seconds.
  late final _i1.ColumnDouble durationSeconds;

  /// Did flutter analyze pass?
  late final _i1.ColumnBool analyzerPassed;

  /// Number of tests passed.
  late final _i1.ColumnInt testsPassed;

  /// Total number of tests.
  late final _i1.ColumnInt testsTotal;

  /// Code structure validation score (0.0-1.0).
  late final _i1.ColumnDouble structureScore;

  /// Categorized failure reason: "analyzer_error", "test_failure", "missing_structure".
  late final _i1.ColumnString failureReason;

  /// Input tokens for this sample.
  late final _i1.ColumnInt inputTokens;

  /// Output tokens for this sample.
  late final _i1.ColumnInt outputTokens;

  /// Reasoning tokens for this sample.
  late final _i1.ColumnInt reasoningTokens;

  /// When this evaluation was run.
  late final _i1.ColumnDateTime createdAt;

  _i2.RunTable get run {
    if (_run != null) return _run!;
    _run = _i1.createRelationTable(
      relationFieldName: 'run',
      field: Evaluation.t.runId,
      foreignField: _i2.Run.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RunTable(tableRelation: foreignTableRelation),
    );
    return _run!;
  }

  _i3.TaskTable get task {
    if (_task != null) return _task!;
    _task = _i1.createRelationTable(
      relationFieldName: 'task',
      field: Evaluation.t.taskId,
      foreignField: _i3.Task.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TaskTable(tableRelation: foreignTableRelation),
    );
    return _task!;
  }

  _i4.SampleTable get sample {
    if (_sample != null) return _sample!;
    _sample = _i1.createRelationTable(
      relationFieldName: 'sample',
      field: Evaluation.t.sampleId,
      foreignField: _i4.Sample.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SampleTable(tableRelation: foreignTableRelation),
    );
    return _sample!;
  }

  _i5.ModelTable get model {
    if (_model != null) return _model!;
    _model = _i1.createRelationTable(
      relationFieldName: 'model',
      field: Evaluation.t.modelId,
      foreignField: _i5.Model.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.ModelTable(tableRelation: foreignTableRelation),
    );
    return _model!;
  }

  _i6.DatasetTable get dataset {
    if (_dataset != null) return _dataset!;
    _dataset = _i1.createRelationTable(
      relationFieldName: 'dataset',
      field: Evaluation.t.datasetId,
      foreignField: _i6.Dataset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6.DatasetTable(tableRelation: foreignTableRelation),
    );
    return _dataset!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    runId,
    taskId,
    sampleId,
    modelId,
    datasetId,
    variant,
    output,
    toolCalls,
    retryCount,
    error,
    neverSucceeded,
    durationSeconds,
    analyzerPassed,
    testsPassed,
    testsTotal,
    structureScore,
    failureReason,
    inputTokens,
    outputTokens,
    reasoningTokens,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'run') {
      return run;
    }
    if (relationField == 'task') {
      return task;
    }
    if (relationField == 'sample') {
      return sample;
    }
    if (relationField == 'model') {
      return model;
    }
    if (relationField == 'dataset') {
      return dataset;
    }
    return null;
  }
}

class EvaluationInclude extends _i1.IncludeObject {
  EvaluationInclude._({
    _i2.RunInclude? run,
    _i3.TaskInclude? task,
    _i4.SampleInclude? sample,
    _i5.ModelInclude? model,
    _i6.DatasetInclude? dataset,
  }) {
    _run = run;
    _task = task;
    _sample = sample;
    _model = model;
    _dataset = dataset;
  }

  _i2.RunInclude? _run;

  _i3.TaskInclude? _task;

  _i4.SampleInclude? _sample;

  _i5.ModelInclude? _model;

  _i6.DatasetInclude? _dataset;

  @override
  Map<String, _i1.Include?> get includes => {
    'run': _run,
    'task': _task,
    'sample': _sample,
    'model': _model,
    'dataset': _dataset,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Evaluation.t;
}

class EvaluationIncludeList extends _i1.IncludeList {
  EvaluationIncludeList._({
    _i1.WhereExpressionBuilder<EvaluationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Evaluation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Evaluation.t;
}

class EvaluationRepository {
  const EvaluationRepository._();

  final attachRow = const EvaluationAttachRowRepository._();

  /// Returns a list of [Evaluation]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Evaluation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvaluationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvaluationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvaluationTable>? orderByList,
    _i1.Transaction? transaction,
    EvaluationInclude? include,
  }) async {
    return session.db.find<Evaluation>(
      where: where?.call(Evaluation.t),
      orderBy: orderBy?.call(Evaluation.t),
      orderByList: orderByList?.call(Evaluation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Evaluation] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Evaluation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvaluationTable>? where,
    int? offset,
    _i1.OrderByBuilder<EvaluationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EvaluationTable>? orderByList,
    _i1.Transaction? transaction,
    EvaluationInclude? include,
  }) async {
    return session.db.findFirstRow<Evaluation>(
      where: where?.call(Evaluation.t),
      orderBy: orderBy?.call(Evaluation.t),
      orderByList: orderByList?.call(Evaluation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Evaluation] by its [id] or null if no such row exists.
  Future<Evaluation?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    EvaluationInclude? include,
  }) async {
    return session.db.findById<Evaluation>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Evaluation]s in the list and returns the inserted rows.
  ///
  /// The returned [Evaluation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Evaluation>> insert(
    _i1.Session session,
    List<Evaluation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Evaluation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Evaluation] and returns the inserted row.
  ///
  /// The returned [Evaluation] will have its `id` field set.
  Future<Evaluation> insertRow(
    _i1.Session session,
    Evaluation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Evaluation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Evaluation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Evaluation>> update(
    _i1.Session session,
    List<Evaluation> rows, {
    _i1.ColumnSelections<EvaluationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Evaluation>(
      rows,
      columns: columns?.call(Evaluation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Evaluation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Evaluation> updateRow(
    _i1.Session session,
    Evaluation row, {
    _i1.ColumnSelections<EvaluationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Evaluation>(
      row,
      columns: columns?.call(Evaluation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Evaluation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Evaluation?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<EvaluationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Evaluation>(
      id,
      columnValues: columnValues(Evaluation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Evaluation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Evaluation>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<EvaluationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EvaluationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EvaluationTable>? orderBy,
    _i1.OrderByListBuilder<EvaluationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Evaluation>(
      columnValues: columnValues(Evaluation.t.updateTable),
      where: where(Evaluation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Evaluation.t),
      orderByList: orderByList?.call(Evaluation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Evaluation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Evaluation>> delete(
    _i1.Session session,
    List<Evaluation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Evaluation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Evaluation].
  Future<Evaluation> deleteRow(
    _i1.Session session,
    Evaluation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Evaluation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Evaluation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EvaluationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Evaluation>(
      where: where(Evaluation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EvaluationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Evaluation>(
      where: where?.call(Evaluation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class EvaluationAttachRowRepository {
  const EvaluationAttachRowRepository._();

  /// Creates a relation between the given [Evaluation] and [Run]
  /// by setting the [Evaluation]'s foreign key `runId` to refer to the [Run].
  Future<void> run(
    _i1.Session session,
    Evaluation evaluation,
    _i2.Run run, {
    _i1.Transaction? transaction,
  }) async {
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $evaluation = evaluation.copyWith(runId: run.id);
    await session.db.updateRow<Evaluation>(
      $evaluation,
      columns: [Evaluation.t.runId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Evaluation] and [Task]
  /// by setting the [Evaluation]'s foreign key `taskId` to refer to the [Task].
  Future<void> task(
    _i1.Session session,
    Evaluation evaluation,
    _i3.Task task, {
    _i1.Transaction? transaction,
  }) async {
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }

    var $evaluation = evaluation.copyWith(taskId: task.id);
    await session.db.updateRow<Evaluation>(
      $evaluation,
      columns: [Evaluation.t.taskId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Evaluation] and [Sample]
  /// by setting the [Evaluation]'s foreign key `sampleId` to refer to the [Sample].
  Future<void> sample(
    _i1.Session session,
    Evaluation evaluation,
    _i4.Sample sample, {
    _i1.Transaction? transaction,
  }) async {
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }
    if (sample.id == null) {
      throw ArgumentError.notNull('sample.id');
    }

    var $evaluation = evaluation.copyWith(sampleId: sample.id);
    await session.db.updateRow<Evaluation>(
      $evaluation,
      columns: [Evaluation.t.sampleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Evaluation] and [Model]
  /// by setting the [Evaluation]'s foreign key `modelId` to refer to the [Model].
  Future<void> model(
    _i1.Session session,
    Evaluation evaluation,
    _i5.Model model, {
    _i1.Transaction? transaction,
  }) async {
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }
    if (model.id == null) {
      throw ArgumentError.notNull('model.id');
    }

    var $evaluation = evaluation.copyWith(modelId: model.id);
    await session.db.updateRow<Evaluation>(
      $evaluation,
      columns: [Evaluation.t.modelId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Evaluation] and [Dataset]
  /// by setting the [Evaluation]'s foreign key `datasetId` to refer to the [Dataset].
  Future<void> dataset(
    _i1.Session session,
    Evaluation evaluation,
    _i6.Dataset dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }
    if (dataset.id == null) {
      throw ArgumentError.notNull('dataset.id');
    }

    var $evaluation = evaluation.copyWith(datasetId: dataset.id);
    await session.db.updateRow<Evaluation>(
      $evaluation,
      columns: [Evaluation.t.datasetId],
      transaction: transaction,
    );
  }
}
