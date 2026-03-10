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
import 'model.dart' as _i2;
import 'dataset.dart' as _i3;
import 'run.dart' as _i4;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i5;

/// Results from evaluating one model against one dataset.
abstract class Task
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Task._({
    this.id,
    required this.inspectId,
    required this.modelId,
    this.model,
    required this.datasetId,
    this.dataset,
    required this.runId,
    this.run,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       _evalsRunsTasksEvalsRunsId = null;

  factory Task({
    _i1.UuidValue? id,
    required String inspectId,
    required _i1.UuidValue modelId,
    _i2.Model? model,
    required _i1.UuidValue datasetId,
    _i3.Dataset? dataset,
    required _i1.UuidValue runId,
    _i4.Run? run,
    DateTime? createdAt,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskImplicit._(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      inspectId: jsonSerialization['inspectId'] as String,
      modelId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['modelId'],
      ),
      model: jsonSerialization['model'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Model>(jsonSerialization['model']),
      datasetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['datasetId'],
      ),
      dataset: jsonSerialization['dataset'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Dataset>(
              jsonSerialization['dataset'],
            ),
      runId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['runId']),
      run: jsonSerialization['run'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Run>(jsonSerialization['run']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      $_evalsRunsTasksEvalsRunsId:
          jsonSerialization['_evalsRunsTasksEvalsRunsId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['_evalsRunsTasksEvalsRunsId'],
            ),
    );
  }

  static final t = TaskTable();

  static const db = TaskRepository._();

  @override
  _i1.UuidValue? id;

  /// InspectAI-generated Id.
  String inspectId;

  _i1.UuidValue modelId;

  /// Model identifier (e.g., "google/gemini-2.5-pro").
  _i2.Model? model;

  _i1.UuidValue datasetId;

  /// Dataset identifier (e.g., "flutter_qa_dataset").
  _i3.Dataset? dataset;

  _i1.UuidValue runId;

  /// Run this task belongs to.
  _i4.Run? run;

  /// When this task was evaluated.
  DateTime createdAt;

  final _i1.UuidValue? _evalsRunsTasksEvalsRunsId;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    _i1.UuidValue? id,
    String? inspectId,
    _i1.UuidValue? modelId,
    _i2.Model? model,
    _i1.UuidValue? datasetId,
    _i3.Dataset? dataset,
    _i1.UuidValue? runId,
    _i4.Run? run,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'modelId': modelId.toJson(),
      if (model != null) 'model': model?.toJson(),
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJson(),
      'createdAt': createdAt.toJson(),
      if (_evalsRunsTasksEvalsRunsId != null)
        '_evalsRunsTasksEvalsRunsId': _evalsRunsTasksEvalsRunsId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'modelId': modelId.toJson(),
      if (model != null) 'model': model?.toJsonForProtocol(),
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJsonForProtocol(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static TaskInclude include({
    _i2.ModelInclude? model,
    _i3.DatasetInclude? dataset,
    _i4.RunInclude? run,
  }) {
    return TaskInclude._(
      model: model,
      dataset: dataset,
      run: run,
    );
  }

  static TaskIncludeList includeList({
    _i1.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskTable>? orderByList,
    TaskInclude? include,
  }) {
    return TaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Task.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Task.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    _i1.UuidValue? id,
    required String inspectId,
    required _i1.UuidValue modelId,
    _i2.Model? model,
    required _i1.UuidValue datasetId,
    _i3.Dataset? dataset,
    required _i1.UuidValue runId,
    _i4.Run? run,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectId: inspectId,
         modelId: modelId,
         model: model,
         datasetId: datasetId,
         dataset: dataset,
         runId: runId,
         run: run,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    String? inspectId,
    _i1.UuidValue? modelId,
    Object? model = _Undefined,
    _i1.UuidValue? datasetId,
    Object? dataset = _Undefined,
    _i1.UuidValue? runId,
    Object? run = _Undefined,
    DateTime? createdAt,
  }) {
    return TaskImplicit._(
      id: id is _i1.UuidValue? ? id : this.id,
      inspectId: inspectId ?? this.inspectId,
      modelId: modelId ?? this.modelId,
      model: model is _i2.Model? ? model : this.model?.copyWith(),
      datasetId: datasetId ?? this.datasetId,
      dataset: dataset is _i3.Dataset? ? dataset : this.dataset?.copyWith(),
      runId: runId ?? this.runId,
      run: run is _i4.Run? ? run : this.run?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      $_evalsRunsTasksEvalsRunsId: this._evalsRunsTasksEvalsRunsId,
    );
  }
}

class TaskImplicit extends _TaskImpl {
  TaskImplicit._({
    _i1.UuidValue? id,
    required String inspectId,
    required _i1.UuidValue modelId,
    _i2.Model? model,
    required _i1.UuidValue datasetId,
    _i3.Dataset? dataset,
    required _i1.UuidValue runId,
    _i4.Run? run,
    DateTime? createdAt,
    _i1.UuidValue? $_evalsRunsTasksEvalsRunsId,
  }) : _evalsRunsTasksEvalsRunsId = $_evalsRunsTasksEvalsRunsId,
       super(
         id: id,
         inspectId: inspectId,
         modelId: modelId,
         model: model,
         datasetId: datasetId,
         dataset: dataset,
         runId: runId,
         run: run,
         createdAt: createdAt,
       );

  factory TaskImplicit(
    Task task, {
    _i1.UuidValue? $_evalsRunsTasksEvalsRunsId,
  }) {
    return TaskImplicit._(
      id: task.id,
      inspectId: task.inspectId,
      modelId: task.modelId,
      model: task.model,
      datasetId: task.datasetId,
      dataset: task.dataset,
      runId: task.runId,
      run: task.run,
      createdAt: task.createdAt,
      $_evalsRunsTasksEvalsRunsId: $_evalsRunsTasksEvalsRunsId,
    );
  }

  @override
  final _i1.UuidValue? _evalsRunsTasksEvalsRunsId;
}

class TaskUpdateTable extends _i1.UpdateTable<TaskTable> {
  TaskUpdateTable(super.table);

  _i1.ColumnValue<String, String> inspectId(String value) => _i1.ColumnValue(
    table.inspectId,
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

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> runId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.runId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> $_evalsRunsTasksEvalsRunsId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.$_evalsRunsTasksEvalsRunsId,
    value,
  );
}

class TaskTable extends _i1.Table<_i1.UuidValue?> {
  TaskTable({super.tableRelation}) : super(tableName: 'evals_tasks') {
    updateTable = TaskUpdateTable(this);
    inspectId = _i1.ColumnString(
      'inspectId',
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
    runId = _i1.ColumnUuid(
      'runId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    $_evalsRunsTasksEvalsRunsId = _i1.ColumnUuid(
      '_evalsRunsTasksEvalsRunsId',
      this,
    );
  }

  late final TaskUpdateTable updateTable;

  /// InspectAI-generated Id.
  late final _i1.ColumnString inspectId;

  late final _i1.ColumnUuid modelId;

  /// Model identifier (e.g., "google/gemini-2.5-pro").
  _i2.ModelTable? _model;

  late final _i1.ColumnUuid datasetId;

  /// Dataset identifier (e.g., "flutter_qa_dataset").
  _i3.DatasetTable? _dataset;

  late final _i1.ColumnUuid runId;

  /// Run this task belongs to.
  _i4.RunTable? _run;

  /// When this task was evaluated.
  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnUuid $_evalsRunsTasksEvalsRunsId;

  _i2.ModelTable get model {
    if (_model != null) return _model!;
    _model = _i1.createRelationTable(
      relationFieldName: 'model',
      field: Task.t.modelId,
      foreignField: _i2.Model.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ModelTable(tableRelation: foreignTableRelation),
    );
    return _model!;
  }

  _i3.DatasetTable get dataset {
    if (_dataset != null) return _dataset!;
    _dataset = _i1.createRelationTable(
      relationFieldName: 'dataset',
      field: Task.t.datasetId,
      foreignField: _i3.Dataset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DatasetTable(tableRelation: foreignTableRelation),
    );
    return _dataset!;
  }

  _i4.RunTable get run {
    if (_run != null) return _run!;
    _run = _i1.createRelationTable(
      relationFieldName: 'run',
      field: Task.t.runId,
      foreignField: _i4.Run.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RunTable(tableRelation: foreignTableRelation),
    );
    return _run!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    inspectId,
    modelId,
    datasetId,
    runId,
    createdAt,
    $_evalsRunsTasksEvalsRunsId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    inspectId,
    modelId,
    datasetId,
    runId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'model') {
      return model;
    }
    if (relationField == 'dataset') {
      return dataset;
    }
    if (relationField == 'run') {
      return run;
    }
    return null;
  }
}

class TaskInclude extends _i1.IncludeObject {
  TaskInclude._({
    _i2.ModelInclude? model,
    _i3.DatasetInclude? dataset,
    _i4.RunInclude? run,
  }) {
    _model = model;
    _dataset = dataset;
    _run = run;
  }

  _i2.ModelInclude? _model;

  _i3.DatasetInclude? _dataset;

  _i4.RunInclude? _run;

  @override
  Map<String, _i1.Include?> get includes => {
    'model': _model,
    'dataset': _dataset,
    'run': _run,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Task.t;
}

class TaskIncludeList extends _i1.IncludeList {
  TaskIncludeList._({
    _i1.WhereExpressionBuilder<TaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Task.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Task.t;
}

class TaskRepository {
  const TaskRepository._();

  final attachRow = const TaskAttachRowRepository._();

  /// Returns a list of [Task]s matching the given query parameters.
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
  Future<List<Task>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskTable>? orderByList,
    _i1.Transaction? transaction,
    TaskInclude? include,
  }) async {
    return session.db.find<Task>(
      where: where?.call(Task.t),
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Task] matching the given query parameters.
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
  Future<Task?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskTable>? where,
    int? offset,
    _i1.OrderByBuilder<TaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskTable>? orderByList,
    _i1.Transaction? transaction,
    TaskInclude? include,
  }) async {
    return session.db.findFirstRow<Task>(
      where: where?.call(Task.t),
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Task] by its [id] or null if no such row exists.
  Future<Task?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TaskInclude? include,
  }) async {
    return session.db.findById<Task>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Task]s in the list and returns the inserted rows.
  ///
  /// The returned [Task]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Task>> insert(
    _i1.Session session,
    List<Task> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Task>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Task] and returns the inserted row.
  ///
  /// The returned [Task] will have its `id` field set.
  Future<Task> insertRow(
    _i1.Session session,
    Task row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Task>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Task]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Task>> update(
    _i1.Session session,
    List<Task> rows, {
    _i1.ColumnSelections<TaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Task>(
      rows,
      columns: columns?.call(Task.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Task]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Task> updateRow(
    _i1.Session session,
    Task row, {
    _i1.ColumnSelections<TaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Task>(
      row,
      columns: columns?.call(Task.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Task] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Task?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TaskUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Task>(
      id,
      columnValues: columnValues(Task.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Task]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Task>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TaskUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TaskTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskTable>? orderBy,
    _i1.OrderByListBuilder<TaskTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Task>(
      columnValues: columnValues(Task.t.updateTable),
      where: where(Task.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Task]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Task>> delete(
    _i1.Session session,
    List<Task> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Task>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Task].
  Future<Task> deleteRow(
    _i1.Session session,
    Task row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Task>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Task>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TaskTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Task>(
      where: where(Task.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Task>(
      where: where?.call(Task.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TaskAttachRowRepository {
  const TaskAttachRowRepository._();

  /// Creates a relation between the given [Task] and [Model]
  /// by setting the [Task]'s foreign key `modelId` to refer to the [Model].
  Future<void> model(
    _i1.Session session,
    Task task,
    _i2.Model model, {
    _i1.Transaction? transaction,
  }) async {
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }
    if (model.id == null) {
      throw ArgumentError.notNull('model.id');
    }

    var $task = task.copyWith(modelId: model.id);
    await session.db.updateRow<Task>(
      $task,
      columns: [Task.t.modelId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Task] and [Dataset]
  /// by setting the [Task]'s foreign key `datasetId` to refer to the [Dataset].
  Future<void> dataset(
    _i1.Session session,
    Task task,
    _i3.Dataset dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }
    if (dataset.id == null) {
      throw ArgumentError.notNull('dataset.id');
    }

    var $task = task.copyWith(datasetId: dataset.id);
    await session.db.updateRow<Task>(
      $task,
      columns: [Task.t.datasetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Task] and [Run]
  /// by setting the [Task]'s foreign key `runId` to refer to the [Run].
  Future<void> run(
    _i1.Session session,
    Task task,
    _i4.Run run, {
    _i1.Transaction? transaction,
  }) async {
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $task = task.copyWith(runId: run.id);
    await session.db.updateRow<Task>(
      $task,
      columns: [Task.t.runId],
      transaction: transaction,
    );
  }
}
