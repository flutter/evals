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
import 'task.dart' as _i2;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i3;

abstract class TaskSummary
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = TaskSummaryTable();

  static const db = TaskSummaryRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaskSummary',
      if (id != null) 'id': id?.toJson(),
      'taskId': taskId.toJson(),
      if (task != null) 'task': task?.toJsonForProtocol(),
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

  static TaskSummaryInclude include({_i2.TaskInclude? task}) {
    return TaskSummaryInclude._(task: task);
  }

  static TaskSummaryIncludeList includeList({
    _i1.WhereExpressionBuilder<TaskSummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskSummaryTable>? orderByList,
    TaskSummaryInclude? include,
  }) {
    return TaskSummaryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaskSummary.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TaskSummary.t),
      include: include,
    );
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

class TaskSummaryUpdateTable extends _i1.UpdateTable<TaskSummaryTable> {
  TaskSummaryUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> taskId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.taskId,
        value,
      );

  _i1.ColumnValue<int, int> totalSamples(int value) => _i1.ColumnValue(
    table.totalSamples,
    value,
  );

  _i1.ColumnValue<int, int> passedSamples(int value) => _i1.ColumnValue(
    table.passedSamples,
    value,
  );

  _i1.ColumnValue<double, double> accuracy(double value) => _i1.ColumnValue(
    table.accuracy,
    value,
  );

  _i1.ColumnValue<String, String> taskName(String? value) => _i1.ColumnValue(
    table.taskName,
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

  _i1.ColumnValue<int, int> totalTokens(int value) => _i1.ColumnValue(
    table.totalTokens,
    value,
  );

  _i1.ColumnValue<int, int> reasoningTokens(int value) => _i1.ColumnValue(
    table.reasoningTokens,
    value,
  );

  _i1.ColumnValue<String, String> variant(String? value) => _i1.ColumnValue(
    table.variant,
    value,
  );

  _i1.ColumnValue<int, int> executionTimeSeconds(int value) => _i1.ColumnValue(
    table.executionTimeSeconds,
    value,
  );

  _i1.ColumnValue<int, int> samplesWithRetries(int value) => _i1.ColumnValue(
    table.samplesWithRetries,
    value,
  );

  _i1.ColumnValue<int, int> samplesNeverSucceeded(int value) => _i1.ColumnValue(
    table.samplesNeverSucceeded,
    value,
  );

  _i1.ColumnValue<int, int> totalRetries(int value) => _i1.ColumnValue(
    table.totalRetries,
    value,
  );
}

class TaskSummaryTable extends _i1.Table<_i1.UuidValue?> {
  TaskSummaryTable({super.tableRelation})
    : super(tableName: 'evals_task_summaries') {
    updateTable = TaskSummaryUpdateTable(this);
    taskId = _i1.ColumnUuid(
      'taskId',
      this,
    );
    totalSamples = _i1.ColumnInt(
      'totalSamples',
      this,
    );
    passedSamples = _i1.ColumnInt(
      'passedSamples',
      this,
    );
    accuracy = _i1.ColumnDouble(
      'accuracy',
      this,
    );
    taskName = _i1.ColumnString(
      'taskName',
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
    totalTokens = _i1.ColumnInt(
      'totalTokens',
      this,
    );
    reasoningTokens = _i1.ColumnInt(
      'reasoningTokens',
      this,
    );
    variant = _i1.ColumnString(
      'variant',
      this,
    );
    executionTimeSeconds = _i1.ColumnInt(
      'executionTimeSeconds',
      this,
    );
    samplesWithRetries = _i1.ColumnInt(
      'samplesWithRetries',
      this,
    );
    samplesNeverSucceeded = _i1.ColumnInt(
      'samplesNeverSucceeded',
      this,
    );
    totalRetries = _i1.ColumnInt(
      'totalRetries',
      this,
    );
  }

  late final TaskSummaryUpdateTable updateTable;

  late final _i1.ColumnUuid taskId;

  /// Task this summary belongs to.
  _i2.TaskTable? _task;

  /// Total number of samples in this task.
  late final _i1.ColumnInt totalSamples;

  /// Number of samples that passed.
  late final _i1.ColumnInt passedSamples;

  /// Accuracy as a value from 0.0 to 1.0.
  late final _i1.ColumnDouble accuracy;

  /// The Inspect AI task function name (e.g., "qa_task").
  late final _i1.ColumnString taskName;

  /// Input tokens used.
  late final _i1.ColumnInt inputTokens;

  /// Output tokens generated.
  late final _i1.ColumnInt outputTokens;

  /// Total tokens used.
  late final _i1.ColumnInt totalTokens;

  /// Reasoning tokens used (for models that support it).
  late final _i1.ColumnInt reasoningTokens;

  /// Variant configuration used (e.g., "baseline", "dart_mcp").
  late final _i1.ColumnString variant;

  /// Total execution time in seconds.
  late final _i1.ColumnInt executionTimeSeconds;

  /// Number of samples that needed retries.
  late final _i1.ColumnInt samplesWithRetries;

  /// Number of samples that failed all retries (excluded from accuracy).
  late final _i1.ColumnInt samplesNeverSucceeded;

  /// Total number of retries across all samples.
  late final _i1.ColumnInt totalRetries;

  _i2.TaskTable get task {
    if (_task != null) return _task!;
    _task = _i1.createRelationTable(
      relationFieldName: 'task',
      field: TaskSummary.t.taskId,
      foreignField: _i2.Task.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TaskTable(tableRelation: foreignTableRelation),
    );
    return _task!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    taskId,
    totalSamples,
    passedSamples,
    accuracy,
    taskName,
    inputTokens,
    outputTokens,
    totalTokens,
    reasoningTokens,
    variant,
    executionTimeSeconds,
    samplesWithRetries,
    samplesNeverSucceeded,
    totalRetries,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'task') {
      return task;
    }
    return null;
  }
}

class TaskSummaryInclude extends _i1.IncludeObject {
  TaskSummaryInclude._({_i2.TaskInclude? task}) {
    _task = task;
  }

  _i2.TaskInclude? _task;

  @override
  Map<String, _i1.Include?> get includes => {'task': _task};

  @override
  _i1.Table<_i1.UuidValue?> get table => TaskSummary.t;
}

class TaskSummaryIncludeList extends _i1.IncludeList {
  TaskSummaryIncludeList._({
    _i1.WhereExpressionBuilder<TaskSummaryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TaskSummary.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TaskSummary.t;
}

class TaskSummaryRepository {
  const TaskSummaryRepository._();

  final attachRow = const TaskSummaryAttachRowRepository._();

  /// Returns a list of [TaskSummary]s matching the given query parameters.
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
  Future<List<TaskSummary>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskSummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskSummaryTable>? orderByList,
    _i1.Transaction? transaction,
    TaskSummaryInclude? include,
  }) async {
    return session.db.find<TaskSummary>(
      where: where?.call(TaskSummary.t),
      orderBy: orderBy?.call(TaskSummary.t),
      orderByList: orderByList?.call(TaskSummary.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TaskSummary] matching the given query parameters.
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
  Future<TaskSummary?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskSummaryTable>? where,
    int? offset,
    _i1.OrderByBuilder<TaskSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskSummaryTable>? orderByList,
    _i1.Transaction? transaction,
    TaskSummaryInclude? include,
  }) async {
    return session.db.findFirstRow<TaskSummary>(
      where: where?.call(TaskSummary.t),
      orderBy: orderBy?.call(TaskSummary.t),
      orderByList: orderByList?.call(TaskSummary.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TaskSummary] by its [id] or null if no such row exists.
  Future<TaskSummary?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TaskSummaryInclude? include,
  }) async {
    return session.db.findById<TaskSummary>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TaskSummary]s in the list and returns the inserted rows.
  ///
  /// The returned [TaskSummary]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TaskSummary>> insert(
    _i1.Session session,
    List<TaskSummary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TaskSummary>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TaskSummary] and returns the inserted row.
  ///
  /// The returned [TaskSummary] will have its `id` field set.
  Future<TaskSummary> insertRow(
    _i1.Session session,
    TaskSummary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TaskSummary>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TaskSummary]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TaskSummary>> update(
    _i1.Session session,
    List<TaskSummary> rows, {
    _i1.ColumnSelections<TaskSummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TaskSummary>(
      rows,
      columns: columns?.call(TaskSummary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaskSummary]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TaskSummary> updateRow(
    _i1.Session session,
    TaskSummary row, {
    _i1.ColumnSelections<TaskSummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TaskSummary>(
      row,
      columns: columns?.call(TaskSummary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaskSummary] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TaskSummary?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TaskSummaryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TaskSummary>(
      id,
      columnValues: columnValues(TaskSummary.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TaskSummary]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TaskSummary>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TaskSummaryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TaskSummaryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskSummaryTable>? orderBy,
    _i1.OrderByListBuilder<TaskSummaryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TaskSummary>(
      columnValues: columnValues(TaskSummary.t.updateTable),
      where: where(TaskSummary.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaskSummary.t),
      orderByList: orderByList?.call(TaskSummary.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TaskSummary]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TaskSummary>> delete(
    _i1.Session session,
    List<TaskSummary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TaskSummary>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TaskSummary].
  Future<TaskSummary> deleteRow(
    _i1.Session session,
    TaskSummary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TaskSummary>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TaskSummary>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TaskSummaryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TaskSummary>(
      where: where(TaskSummary.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskSummaryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TaskSummary>(
      where: where?.call(TaskSummary.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TaskSummaryAttachRowRepository {
  const TaskSummaryAttachRowRepository._();

  /// Creates a relation between the given [TaskSummary] and [Task]
  /// by setting the [TaskSummary]'s foreign key `taskId` to refer to the [Task].
  Future<void> task(
    _i1.Session session,
    TaskSummary taskSummary,
    _i2.Task task, {
    _i1.Transaction? transaction,
  }) async {
    if (taskSummary.id == null) {
      throw ArgumentError.notNull('taskSummary.id');
    }
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }

    var $taskSummary = taskSummary.copyWith(taskId: task.id);
    await session.db.updateRow<TaskSummary>(
      $taskSummary,
      columns: [TaskSummary.t.taskId],
      transaction: transaction,
    );
  }
}
