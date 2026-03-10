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
import 'status_enum.dart' as _i2;
import 'model.dart' as _i3;
import 'dataset.dart' as _i4;
import 'task.dart' as _i5;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i6;

/// A collection of tasks executed together.
abstract class Run
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Run._({
    this.id,
    required this.inspectId,
    required this.status,
    required this.variants,
    required this.mcpServerVersion,
    required this.batchRuntimeSeconds,
    this.models,
    this.datasets,
    this.tasks,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Run({
    _i1.UuidValue? id,
    required String inspectId,
    required _i2.Status status,
    required List<String> variants,
    required String mcpServerVersion,
    required int batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  }) = _RunImpl;

  factory Run.fromJson(Map<String, dynamic> jsonSerialization) {
    return Run(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      inspectId: jsonSerialization['inspectId'] as String,
      status: _i2.Status.fromJson((jsonSerialization['status'] as String)),
      variants: _i6.Protocol().deserialize<List<String>>(
        jsonSerialization['variants'],
      ),
      mcpServerVersion: jsonSerialization['mcpServerVersion'] as String,
      batchRuntimeSeconds: jsonSerialization['batchRuntimeSeconds'] as int,
      models: jsonSerialization['models'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i3.Model>>(
              jsonSerialization['models'],
            ),
      datasets: jsonSerialization['datasets'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.Dataset>>(
              jsonSerialization['datasets'],
            ),
      tasks: jsonSerialization['tasks'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Task>>(
              jsonSerialization['tasks'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RunTable();

  static const db = RunRepository._();

  @override
  _i1.UuidValue? id;

  /// InspectAI-generated Id.
  String inspectId;

  /// Run status (e.g., "complete", "inProgress", "failed").
  _i2.Status status;

  /// The variant configurations used in this run.
  List<String> variants;

  /// Version of the MCP server used during evaluation.
  String mcpServerVersion;

  /// Total script runtime in seconds.
  int batchRuntimeSeconds;

  /// List of models evaluated in this run.
  List<_i3.Model>? models;

  /// List of datasets evaluated in this run.
  List<_i4.Dataset>? datasets;

  /// List of Inspect AI task names that were run.
  List<_i5.Task>? tasks;

  /// Creation time for this record.
  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Run]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Run copyWith({
    _i1.UuidValue? id,
    String? inspectId,
    _i2.Status? status,
    List<String>? variants,
    String? mcpServerVersion,
    int? batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Run',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'status': status.toJson(),
      'variants': variants.toJson(),
      'mcpServerVersion': mcpServerVersion,
      'batchRuntimeSeconds': batchRuntimeSeconds,
      if (models != null)
        'models': models?.toJson(valueToJson: (v) => v.toJson()),
      if (datasets != null)
        'datasets': datasets?.toJson(valueToJson: (v) => v.toJson()),
      if (tasks != null) 'tasks': tasks?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Run',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'status': status.toJson(),
      'variants': variants.toJson(),
      'mcpServerVersion': mcpServerVersion,
      'batchRuntimeSeconds': batchRuntimeSeconds,
      if (models != null)
        'models': models?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (datasets != null)
        'datasets': datasets?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (tasks != null)
        'tasks': tasks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  static RunInclude include({
    _i3.ModelIncludeList? models,
    _i4.DatasetIncludeList? datasets,
    _i5.TaskIncludeList? tasks,
  }) {
    return RunInclude._(
      models: models,
      datasets: datasets,
      tasks: tasks,
    );
  }

  static RunIncludeList includeList({
    _i1.WhereExpressionBuilder<RunTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunTable>? orderByList,
    RunInclude? include,
  }) {
    return RunIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Run.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Run.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RunImpl extends Run {
  _RunImpl({
    _i1.UuidValue? id,
    required String inspectId,
    required _i2.Status status,
    required List<String> variants,
    required String mcpServerVersion,
    required int batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectId: inspectId,
         status: status,
         variants: variants,
         mcpServerVersion: mcpServerVersion,
         batchRuntimeSeconds: batchRuntimeSeconds,
         models: models,
         datasets: datasets,
         tasks: tasks,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Run]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Run copyWith({
    Object? id = _Undefined,
    String? inspectId,
    _i2.Status? status,
    List<String>? variants,
    String? mcpServerVersion,
    int? batchRuntimeSeconds,
    Object? models = _Undefined,
    Object? datasets = _Undefined,
    Object? tasks = _Undefined,
    DateTime? createdAt,
  }) {
    return Run(
      id: id is _i1.UuidValue? ? id : this.id,
      inspectId: inspectId ?? this.inspectId,
      status: status ?? this.status,
      variants: variants ?? this.variants.map((e0) => e0).toList(),
      mcpServerVersion: mcpServerVersion ?? this.mcpServerVersion,
      batchRuntimeSeconds: batchRuntimeSeconds ?? this.batchRuntimeSeconds,
      models: models is List<_i3.Model>?
          ? models
          : this.models?.map((e0) => e0.copyWith()).toList(),
      datasets: datasets is List<_i4.Dataset>?
          ? datasets
          : this.datasets?.map((e0) => e0.copyWith()).toList(),
      tasks: tasks is List<_i5.Task>?
          ? tasks
          : this.tasks?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RunUpdateTable extends _i1.UpdateTable<RunTable> {
  RunUpdateTable(super.table);

  _i1.ColumnValue<String, String> inspectId(String value) => _i1.ColumnValue(
    table.inspectId,
    value,
  );

  _i1.ColumnValue<_i2.Status, _i2.Status> status(_i2.Status value) =>
      _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> variants(List<String> value) =>
      _i1.ColumnValue(
        table.variants,
        value,
      );

  _i1.ColumnValue<String, String> mcpServerVersion(String value) =>
      _i1.ColumnValue(
        table.mcpServerVersion,
        value,
      );

  _i1.ColumnValue<int, int> batchRuntimeSeconds(int value) => _i1.ColumnValue(
    table.batchRuntimeSeconds,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class RunTable extends _i1.Table<_i1.UuidValue?> {
  RunTable({super.tableRelation}) : super(tableName: 'evals_runs') {
    updateTable = RunUpdateTable(this);
    inspectId = _i1.ColumnString(
      'inspectId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    variants = _i1.ColumnSerializable<List<String>>(
      'variants',
      this,
    );
    mcpServerVersion = _i1.ColumnString(
      'mcpServerVersion',
      this,
    );
    batchRuntimeSeconds = _i1.ColumnInt(
      'batchRuntimeSeconds',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RunUpdateTable updateTable;

  /// InspectAI-generated Id.
  late final _i1.ColumnString inspectId;

  /// Run status (e.g., "complete", "inProgress", "failed").
  late final _i1.ColumnEnum<_i2.Status> status;

  /// The variant configurations used in this run.
  late final _i1.ColumnSerializable<List<String>> variants;

  /// Version of the MCP server used during evaluation.
  late final _i1.ColumnString mcpServerVersion;

  /// Total script runtime in seconds.
  late final _i1.ColumnInt batchRuntimeSeconds;

  /// List of models evaluated in this run.
  _i3.ModelTable? ___models;

  /// List of models evaluated in this run.
  _i1.ManyRelation<_i3.ModelTable>? _models;

  /// List of datasets evaluated in this run.
  _i4.DatasetTable? ___datasets;

  /// List of datasets evaluated in this run.
  _i1.ManyRelation<_i4.DatasetTable>? _datasets;

  /// List of Inspect AI task names that were run.
  _i5.TaskTable? ___tasks;

  /// List of Inspect AI task names that were run.
  _i1.ManyRelation<_i5.TaskTable>? _tasks;

  /// Creation time for this record.
  late final _i1.ColumnDateTime createdAt;

  _i3.ModelTable get __models {
    if (___models != null) return ___models!;
    ___models = _i1.createRelationTable(
      relationFieldName: '__models',
      field: Run.t.id,
      foreignField: _i3.Model.t.$_evalsRunsModelsEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ModelTable(tableRelation: foreignTableRelation),
    );
    return ___models!;
  }

  _i4.DatasetTable get __datasets {
    if (___datasets != null) return ___datasets!;
    ___datasets = _i1.createRelationTable(
      relationFieldName: '__datasets',
      field: Run.t.id,
      foreignField: _i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.DatasetTable(tableRelation: foreignTableRelation),
    );
    return ___datasets!;
  }

  _i5.TaskTable get __tasks {
    if (___tasks != null) return ___tasks!;
    ___tasks = _i1.createRelationTable(
      relationFieldName: '__tasks',
      field: Run.t.id,
      foreignField: _i5.Task.t.$_evalsRunsTasksEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.TaskTable(tableRelation: foreignTableRelation),
    );
    return ___tasks!;
  }

  _i1.ManyRelation<_i3.ModelTable> get models {
    if (_models != null) return _models!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'models',
      field: Run.t.id,
      foreignField: _i3.Model.t.$_evalsRunsModelsEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ModelTable(tableRelation: foreignTableRelation),
    );
    _models = _i1.ManyRelation<_i3.ModelTable>(
      tableWithRelations: relationTable,
      table: _i3.ModelTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _models!;
  }

  _i1.ManyRelation<_i4.DatasetTable> get datasets {
    if (_datasets != null) return _datasets!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'datasets',
      field: Run.t.id,
      foreignField: _i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.DatasetTable(tableRelation: foreignTableRelation),
    );
    _datasets = _i1.ManyRelation<_i4.DatasetTable>(
      tableWithRelations: relationTable,
      table: _i4.DatasetTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _datasets!;
  }

  _i1.ManyRelation<_i5.TaskTable> get tasks {
    if (_tasks != null) return _tasks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'tasks',
      field: Run.t.id,
      foreignField: _i5.Task.t.$_evalsRunsTasksEvalsRunsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.TaskTable(tableRelation: foreignTableRelation),
    );
    _tasks = _i1.ManyRelation<_i5.TaskTable>(
      tableWithRelations: relationTable,
      table: _i5.TaskTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _tasks!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    inspectId,
    status,
    variants,
    mcpServerVersion,
    batchRuntimeSeconds,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'models') {
      return __models;
    }
    if (relationField == 'datasets') {
      return __datasets;
    }
    if (relationField == 'tasks') {
      return __tasks;
    }
    return null;
  }
}

class RunInclude extends _i1.IncludeObject {
  RunInclude._({
    _i3.ModelIncludeList? models,
    _i4.DatasetIncludeList? datasets,
    _i5.TaskIncludeList? tasks,
  }) {
    _models = models;
    _datasets = datasets;
    _tasks = tasks;
  }

  _i3.ModelIncludeList? _models;

  _i4.DatasetIncludeList? _datasets;

  _i5.TaskIncludeList? _tasks;

  @override
  Map<String, _i1.Include?> get includes => {
    'models': _models,
    'datasets': _datasets,
    'tasks': _tasks,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Run.t;
}

class RunIncludeList extends _i1.IncludeList {
  RunIncludeList._({
    _i1.WhereExpressionBuilder<RunTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Run.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Run.t;
}

class RunRepository {
  const RunRepository._();

  final attach = const RunAttachRepository._();

  final attachRow = const RunAttachRowRepository._();

  final detach = const RunDetachRepository._();

  final detachRow = const RunDetachRowRepository._();

  /// Returns a list of [Run]s matching the given query parameters.
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
  Future<List<Run>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunTable>? orderByList,
    _i1.Transaction? transaction,
    RunInclude? include,
  }) async {
    return session.db.find<Run>(
      where: where?.call(Run.t),
      orderBy: orderBy?.call(Run.t),
      orderByList: orderByList?.call(Run.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Run] matching the given query parameters.
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
  Future<Run?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunTable>? where,
    int? offset,
    _i1.OrderByBuilder<RunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunTable>? orderByList,
    _i1.Transaction? transaction,
    RunInclude? include,
  }) async {
    return session.db.findFirstRow<Run>(
      where: where?.call(Run.t),
      orderBy: orderBy?.call(Run.t),
      orderByList: orderByList?.call(Run.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Run] by its [id] or null if no such row exists.
  Future<Run?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    RunInclude? include,
  }) async {
    return session.db.findById<Run>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Run]s in the list and returns the inserted rows.
  ///
  /// The returned [Run]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Run>> insert(
    _i1.Session session,
    List<Run> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Run>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Run] and returns the inserted row.
  ///
  /// The returned [Run] will have its `id` field set.
  Future<Run> insertRow(
    _i1.Session session,
    Run row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Run>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Run]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Run>> update(
    _i1.Session session,
    List<Run> rows, {
    _i1.ColumnSelections<RunTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Run>(
      rows,
      columns: columns?.call(Run.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Run]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Run> updateRow(
    _i1.Session session,
    Run row, {
    _i1.ColumnSelections<RunTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Run>(
      row,
      columns: columns?.call(Run.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Run] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Run?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<RunUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Run>(
      id,
      columnValues: columnValues(Run.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Run]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Run>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<RunUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RunTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunTable>? orderBy,
    _i1.OrderByListBuilder<RunTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Run>(
      columnValues: columnValues(Run.t.updateTable),
      where: where(Run.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Run.t),
      orderByList: orderByList?.call(Run.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Run]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Run>> delete(
    _i1.Session session,
    List<Run> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Run>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Run].
  Future<Run> deleteRow(
    _i1.Session session,
    Run row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Run>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Run>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RunTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Run>(
      where: where(Run.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Run>(
      where: where?.call(Run.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RunAttachRepository {
  const RunAttachRepository._();

  /// Creates a relation between this [Run] and the given [Model]s
  /// by setting each [Model]'s foreign key `_evalsRunsModelsEvalsRunsId` to refer to this [Run].
  Future<void> models(
    _i1.Session session,
    Run run,
    List<_i3.Model> model, {
    _i1.Transaction? transaction,
  }) async {
    if (model.any((e) => e.id == null)) {
      throw ArgumentError.notNull('model.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $model = model
        .map(
          (e) => _i3.ModelImplicit(
            e,
            $_evalsRunsModelsEvalsRunsId: run.id,
          ),
        )
        .toList();
    await session.db.update<_i3.Model>(
      $model,
      columns: [_i3.Model.t.$_evalsRunsModelsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Run] and the given [Dataset]s
  /// by setting each [Dataset]'s foreign key `_evalsRunsDatasetsEvalsRunsId` to refer to this [Run].
  Future<void> datasets(
    _i1.Session session,
    Run run,
    List<_i4.Dataset> dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (dataset.any((e) => e.id == null)) {
      throw ArgumentError.notNull('dataset.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $dataset = dataset
        .map(
          (e) => _i4.DatasetImplicit(
            e,
            $_evalsRunsDatasetsEvalsRunsId: run.id,
          ),
        )
        .toList();
    await session.db.update<_i4.Dataset>(
      $dataset,
      columns: [_i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Run] and the given [Task]s
  /// by setting each [Task]'s foreign key `_evalsRunsTasksEvalsRunsId` to refer to this [Run].
  Future<void> tasks(
    _i1.Session session,
    Run run,
    List<_i5.Task> task, {
    _i1.Transaction? transaction,
  }) async {
    if (task.any((e) => e.id == null)) {
      throw ArgumentError.notNull('task.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $task = task
        .map(
          (e) => _i5.TaskImplicit(
            e,
            $_evalsRunsTasksEvalsRunsId: run.id,
          ),
        )
        .toList();
    await session.db.update<_i5.Task>(
      $task,
      columns: [_i5.Task.t.$_evalsRunsTasksEvalsRunsId],
      transaction: transaction,
    );
  }
}

class RunAttachRowRepository {
  const RunAttachRowRepository._();

  /// Creates a relation between this [Run] and the given [Model]
  /// by setting the [Model]'s foreign key `_evalsRunsModelsEvalsRunsId` to refer to this [Run].
  Future<void> models(
    _i1.Session session,
    Run run,
    _i3.Model model, {
    _i1.Transaction? transaction,
  }) async {
    if (model.id == null) {
      throw ArgumentError.notNull('model.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $model = _i3.ModelImplicit(
      model,
      $_evalsRunsModelsEvalsRunsId: run.id,
    );
    await session.db.updateRow<_i3.Model>(
      $model,
      columns: [_i3.Model.t.$_evalsRunsModelsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Run] and the given [Dataset]
  /// by setting the [Dataset]'s foreign key `_evalsRunsDatasetsEvalsRunsId` to refer to this [Run].
  Future<void> datasets(
    _i1.Session session,
    Run run,
    _i4.Dataset dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (dataset.id == null) {
      throw ArgumentError.notNull('dataset.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $dataset = _i4.DatasetImplicit(
      dataset,
      $_evalsRunsDatasetsEvalsRunsId: run.id,
    );
    await session.db.updateRow<_i4.Dataset>(
      $dataset,
      columns: [_i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Run] and the given [Task]
  /// by setting the [Task]'s foreign key `_evalsRunsTasksEvalsRunsId` to refer to this [Run].
  Future<void> tasks(
    _i1.Session session,
    Run run,
    _i5.Task task, {
    _i1.Transaction? transaction,
  }) async {
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $task = _i5.TaskImplicit(
      task,
      $_evalsRunsTasksEvalsRunsId: run.id,
    );
    await session.db.updateRow<_i5.Task>(
      $task,
      columns: [_i5.Task.t.$_evalsRunsTasksEvalsRunsId],
      transaction: transaction,
    );
  }
}

class RunDetachRepository {
  const RunDetachRepository._();

  /// Detaches the relation between this [Run] and the given [Model]
  /// by setting the [Model]'s foreign key `_evalsRunsModelsEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> models(
    _i1.Session session,
    List<_i3.Model> model, {
    _i1.Transaction? transaction,
  }) async {
    if (model.any((e) => e.id == null)) {
      throw ArgumentError.notNull('model.id');
    }

    var $model = model
        .map(
          (e) => _i3.ModelImplicit(
            e,
            $_evalsRunsModelsEvalsRunsId: null,
          ),
        )
        .toList();
    await session.db.update<_i3.Model>(
      $model,
      columns: [_i3.Model.t.$_evalsRunsModelsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Run] and the given [Dataset]
  /// by setting the [Dataset]'s foreign key `_evalsRunsDatasetsEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> datasets(
    _i1.Session session,
    List<_i4.Dataset> dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (dataset.any((e) => e.id == null)) {
      throw ArgumentError.notNull('dataset.id');
    }

    var $dataset = dataset
        .map(
          (e) => _i4.DatasetImplicit(
            e,
            $_evalsRunsDatasetsEvalsRunsId: null,
          ),
        )
        .toList();
    await session.db.update<_i4.Dataset>(
      $dataset,
      columns: [_i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Run] and the given [Task]
  /// by setting the [Task]'s foreign key `_evalsRunsTasksEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tasks(
    _i1.Session session,
    List<_i5.Task> task, {
    _i1.Transaction? transaction,
  }) async {
    if (task.any((e) => e.id == null)) {
      throw ArgumentError.notNull('task.id');
    }

    var $task = task
        .map(
          (e) => _i5.TaskImplicit(
            e,
            $_evalsRunsTasksEvalsRunsId: null,
          ),
        )
        .toList();
    await session.db.update<_i5.Task>(
      $task,
      columns: [_i5.Task.t.$_evalsRunsTasksEvalsRunsId],
      transaction: transaction,
    );
  }
}

class RunDetachRowRepository {
  const RunDetachRowRepository._();

  /// Detaches the relation between this [Run] and the given [Model]
  /// by setting the [Model]'s foreign key `_evalsRunsModelsEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> models(
    _i1.Session session,
    _i3.Model model, {
    _i1.Transaction? transaction,
  }) async {
    if (model.id == null) {
      throw ArgumentError.notNull('model.id');
    }

    var $model = _i3.ModelImplicit(
      model,
      $_evalsRunsModelsEvalsRunsId: null,
    );
    await session.db.updateRow<_i3.Model>(
      $model,
      columns: [_i3.Model.t.$_evalsRunsModelsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Run] and the given [Dataset]
  /// by setting the [Dataset]'s foreign key `_evalsRunsDatasetsEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> datasets(
    _i1.Session session,
    _i4.Dataset dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (dataset.id == null) {
      throw ArgumentError.notNull('dataset.id');
    }

    var $dataset = _i4.DatasetImplicit(
      dataset,
      $_evalsRunsDatasetsEvalsRunsId: null,
    );
    await session.db.updateRow<_i4.Dataset>(
      $dataset,
      columns: [_i4.Dataset.t.$_evalsRunsDatasetsEvalsRunsId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Run] and the given [Task]
  /// by setting the [Task]'s foreign key `_evalsRunsTasksEvalsRunsId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tasks(
    _i1.Session session,
    _i5.Task task, {
    _i1.Transaction? transaction,
  }) async {
    if (task.id == null) {
      throw ArgumentError.notNull('task.id');
    }

    var $task = _i5.TaskImplicit(
      task,
      $_evalsRunsTasksEvalsRunsId: null,
    );
    await session.db.updateRow<_i5.Task>(
      $task,
      columns: [_i5.Task.t.$_evalsRunsTasksEvalsRunsId],
      transaction: transaction,
    );
  }
}
