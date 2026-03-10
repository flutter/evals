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
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i3;

/// Metadata for the outcomes of a given [Run]. This is a separate table from [Run] because
/// otherwise each of these columns would have to be nullable on [Run], as they are generated
/// after the run is completed.
abstract class RunSummary
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  RunSummary._({
    this.id,
    required this.runId,
    this.run,
    required this.totalTasks,
    required this.totalSamples,
    required this.avgAccuracy,
    required this.totalTokens,
    required this.inputTokens,
    required this.outputTokens,
    required this.reasoningTokens,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RunSummary({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required int totalTasks,
    required int totalSamples,
    required double avgAccuracy,
    required int totalTokens,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) = _RunSummaryImpl;

  factory RunSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return RunSummary(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      runId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['runId']),
      run: jsonSerialization['run'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Run>(jsonSerialization['run']),
      totalTasks: jsonSerialization['totalTasks'] as int,
      totalSamples: jsonSerialization['totalSamples'] as int,
      avgAccuracy: (jsonSerialization['avgAccuracy'] as num).toDouble(),
      totalTokens: jsonSerialization['totalTokens'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      reasoningTokens: jsonSerialization['reasoningTokens'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RunSummaryTable();

  static const db = RunSummaryRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue runId;

  /// Run this summary belongs to.
  _i2.Run? run;

  /// Number of tasks in this run.
  int totalTasks;

  /// Total number of samples evaluated.
  int totalSamples;

  /// Average accuracy across all tasks (0.0 to 1.0).
  double avgAccuracy;

  /// Total token usage.
  int totalTokens;

  /// Input tokens used.
  int inputTokens;

  /// Output tokens generated.
  int outputTokens;

  /// Reasoning tokens used (for models that support it).
  int reasoningTokens;

  /// Creation time for this record.
  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [RunSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RunSummary copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? runId,
    _i2.Run? run,
    int? totalTasks,
    int? totalSamples,
    double? avgAccuracy,
    int? totalTokens,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RunSummary',
      if (id != null) 'id': id?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJson(),
      'totalTasks': totalTasks,
      'totalSamples': totalSamples,
      'avgAccuracy': avgAccuracy,
      'totalTokens': totalTokens,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'reasoningTokens': reasoningTokens,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RunSummary',
      if (id != null) 'id': id?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJsonForProtocol(),
      'totalTasks': totalTasks,
      'totalSamples': totalSamples,
      'avgAccuracy': avgAccuracy,
      'totalTokens': totalTokens,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'reasoningTokens': reasoningTokens,
      'createdAt': createdAt.toJson(),
    };
  }

  static RunSummaryInclude include({_i2.RunInclude? run}) {
    return RunSummaryInclude._(run: run);
  }

  static RunSummaryIncludeList includeList({
    _i1.WhereExpressionBuilder<RunSummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunSummaryTable>? orderByList,
    RunSummaryInclude? include,
  }) {
    return RunSummaryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RunSummary.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RunSummary.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RunSummaryImpl extends RunSummary {
  _RunSummaryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required int totalTasks,
    required int totalSamples,
    required double avgAccuracy,
    required int totalTokens,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) : super._(
         id: id,
         runId: runId,
         run: run,
         totalTasks: totalTasks,
         totalSamples: totalSamples,
         avgAccuracy: avgAccuracy,
         totalTokens: totalTokens,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         reasoningTokens: reasoningTokens,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RunSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RunSummary copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? runId,
    Object? run = _Undefined,
    int? totalTasks,
    int? totalSamples,
    double? avgAccuracy,
    int? totalTokens,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  }) {
    return RunSummary(
      id: id is _i1.UuidValue? ? id : this.id,
      runId: runId ?? this.runId,
      run: run is _i2.Run? ? run : this.run?.copyWith(),
      totalTasks: totalTasks ?? this.totalTasks,
      totalSamples: totalSamples ?? this.totalSamples,
      avgAccuracy: avgAccuracy ?? this.avgAccuracy,
      totalTokens: totalTokens ?? this.totalTokens,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RunSummaryUpdateTable extends _i1.UpdateTable<RunSummaryTable> {
  RunSummaryUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> runId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.runId,
        value,
      );

  _i1.ColumnValue<int, int> totalTasks(int value) => _i1.ColumnValue(
    table.totalTasks,
    value,
  );

  _i1.ColumnValue<int, int> totalSamples(int value) => _i1.ColumnValue(
    table.totalSamples,
    value,
  );

  _i1.ColumnValue<double, double> avgAccuracy(double value) => _i1.ColumnValue(
    table.avgAccuracy,
    value,
  );

  _i1.ColumnValue<int, int> totalTokens(int value) => _i1.ColumnValue(
    table.totalTokens,
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

class RunSummaryTable extends _i1.Table<_i1.UuidValue?> {
  RunSummaryTable({super.tableRelation})
    : super(tableName: 'evals_run_summaries') {
    updateTable = RunSummaryUpdateTable(this);
    runId = _i1.ColumnUuid(
      'runId',
      this,
    );
    totalTasks = _i1.ColumnInt(
      'totalTasks',
      this,
    );
    totalSamples = _i1.ColumnInt(
      'totalSamples',
      this,
    );
    avgAccuracy = _i1.ColumnDouble(
      'avgAccuracy',
      this,
    );
    totalTokens = _i1.ColumnInt(
      'totalTokens',
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

  late final RunSummaryUpdateTable updateTable;

  late final _i1.ColumnUuid runId;

  /// Run this summary belongs to.
  _i2.RunTable? _run;

  /// Number of tasks in this run.
  late final _i1.ColumnInt totalTasks;

  /// Total number of samples evaluated.
  late final _i1.ColumnInt totalSamples;

  /// Average accuracy across all tasks (0.0 to 1.0).
  late final _i1.ColumnDouble avgAccuracy;

  /// Total token usage.
  late final _i1.ColumnInt totalTokens;

  /// Input tokens used.
  late final _i1.ColumnInt inputTokens;

  /// Output tokens generated.
  late final _i1.ColumnInt outputTokens;

  /// Reasoning tokens used (for models that support it).
  late final _i1.ColumnInt reasoningTokens;

  /// Creation time for this record.
  late final _i1.ColumnDateTime createdAt;

  _i2.RunTable get run {
    if (_run != null) return _run!;
    _run = _i1.createRelationTable(
      relationFieldName: 'run',
      field: RunSummary.t.runId,
      foreignField: _i2.Run.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RunTable(tableRelation: foreignTableRelation),
    );
    return _run!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    runId,
    totalTasks,
    totalSamples,
    avgAccuracy,
    totalTokens,
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
    return null;
  }
}

class RunSummaryInclude extends _i1.IncludeObject {
  RunSummaryInclude._({_i2.RunInclude? run}) {
    _run = run;
  }

  _i2.RunInclude? _run;

  @override
  Map<String, _i1.Include?> get includes => {'run': _run};

  @override
  _i1.Table<_i1.UuidValue?> get table => RunSummary.t;
}

class RunSummaryIncludeList extends _i1.IncludeList {
  RunSummaryIncludeList._({
    _i1.WhereExpressionBuilder<RunSummaryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RunSummary.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => RunSummary.t;
}

class RunSummaryRepository {
  const RunSummaryRepository._();

  final attachRow = const RunSummaryAttachRowRepository._();

  /// Returns a list of [RunSummary]s matching the given query parameters.
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
  Future<List<RunSummary>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunSummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunSummaryTable>? orderByList,
    _i1.Transaction? transaction,
    RunSummaryInclude? include,
  }) async {
    return session.db.find<RunSummary>(
      where: where?.call(RunSummary.t),
      orderBy: orderBy?.call(RunSummary.t),
      orderByList: orderByList?.call(RunSummary.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RunSummary] matching the given query parameters.
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
  Future<RunSummary?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunSummaryTable>? where,
    int? offset,
    _i1.OrderByBuilder<RunSummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RunSummaryTable>? orderByList,
    _i1.Transaction? transaction,
    RunSummaryInclude? include,
  }) async {
    return session.db.findFirstRow<RunSummary>(
      where: where?.call(RunSummary.t),
      orderBy: orderBy?.call(RunSummary.t),
      orderByList: orderByList?.call(RunSummary.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RunSummary] by its [id] or null if no such row exists.
  Future<RunSummary?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    RunSummaryInclude? include,
  }) async {
    return session.db.findById<RunSummary>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RunSummary]s in the list and returns the inserted rows.
  ///
  /// The returned [RunSummary]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RunSummary>> insert(
    _i1.Session session,
    List<RunSummary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RunSummary>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RunSummary] and returns the inserted row.
  ///
  /// The returned [RunSummary] will have its `id` field set.
  Future<RunSummary> insertRow(
    _i1.Session session,
    RunSummary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RunSummary>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RunSummary]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RunSummary>> update(
    _i1.Session session,
    List<RunSummary> rows, {
    _i1.ColumnSelections<RunSummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RunSummary>(
      rows,
      columns: columns?.call(RunSummary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RunSummary]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RunSummary> updateRow(
    _i1.Session session,
    RunSummary row, {
    _i1.ColumnSelections<RunSummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RunSummary>(
      row,
      columns: columns?.call(RunSummary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RunSummary] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RunSummary?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<RunSummaryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RunSummary>(
      id,
      columnValues: columnValues(RunSummary.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RunSummary]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RunSummary>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<RunSummaryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RunSummaryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RunSummaryTable>? orderBy,
    _i1.OrderByListBuilder<RunSummaryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RunSummary>(
      columnValues: columnValues(RunSummary.t.updateTable),
      where: where(RunSummary.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RunSummary.t),
      orderByList: orderByList?.call(RunSummary.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RunSummary]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RunSummary>> delete(
    _i1.Session session,
    List<RunSummary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RunSummary>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RunSummary].
  Future<RunSummary> deleteRow(
    _i1.Session session,
    RunSummary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RunSummary>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RunSummary>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RunSummaryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RunSummary>(
      where: where(RunSummary.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RunSummaryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RunSummary>(
      where: where?.call(RunSummary.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RunSummaryAttachRowRepository {
  const RunSummaryAttachRowRepository._();

  /// Creates a relation between the given [RunSummary] and [Run]
  /// by setting the [RunSummary]'s foreign key `runId` to refer to the [Run].
  Future<void> run(
    _i1.Session session,
    RunSummary runSummary,
    _i2.Run run, {
    _i1.Transaction? transaction,
  }) async {
    if (runSummary.id == null) {
      throw ArgumentError.notNull('runSummary.id');
    }
    if (run.id == null) {
      throw ArgumentError.notNull('run.id');
    }

    var $runSummary = runSummary.copyWith(runId: run.id);
    await session.db.updateRow<RunSummary>(
      $runSummary,
      columns: [RunSummary.t.runId],
      transaction: transaction,
    );
  }
}
