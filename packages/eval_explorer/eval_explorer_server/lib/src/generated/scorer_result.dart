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
import 'scorer.dart' as _i2;
import 'evaluation.dart' as _i3;
import 'package:eval_explorer_shared/eval_explorer_shared.dart' as _i4;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i5;

/// A scorer's assessment of a task.
abstract class ScorerResult
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ScorerResult._({
    this.id,
    required this.scorerId,
    this.scorer,
    required this.evaluationId,
    this.evaluation,
    required this.data,
  });

  factory ScorerResult({
    _i1.UuidValue? id,
    required _i1.UuidValue scorerId,
    _i2.Scorer? scorer,
    required _i1.UuidValue evaluationId,
    _i3.Evaluation? evaluation,
    required _i4.ScorerResultData data,
  }) = _ScorerResultImpl;

  factory ScorerResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScorerResult(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      scorerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['scorerId'],
      ),
      scorer: jsonSerialization['scorer'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Scorer>(jsonSerialization['scorer']),
      evaluationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['evaluationId'],
      ),
      evaluation: jsonSerialization['evaluation'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Evaluation>(
              jsonSerialization['evaluation'],
            ),
      data: _i4.ScorerResultData.fromJson(jsonSerialization['data']),
    );
  }

  static final t = ScorerResultTable();

  static const db = ScorerResultRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue scorerId;

  /// Scorer this summary belongs to.
  _i2.Scorer? scorer;

  _i1.UuidValue evaluationId;

  /// Whether this scorer data is for a baseline run.
  _i3.Evaluation? evaluation;

  /// Flexible data archived by the scorer.
  _i4.ScorerResultData data;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ScorerResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScorerResult copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? scorerId,
    _i2.Scorer? scorer,
    _i1.UuidValue? evaluationId,
    _i3.Evaluation? evaluation,
    _i4.ScorerResultData? data,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScorerResult',
      if (id != null) 'id': id?.toJson(),
      'scorerId': scorerId.toJson(),
      if (scorer != null) 'scorer': scorer?.toJson(),
      'evaluationId': evaluationId.toJson(),
      if (evaluation != null) 'evaluation': evaluation?.toJson(),
      'data': data.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScorerResult',
      if (id != null) 'id': id?.toJson(),
      'scorerId': scorerId.toJson(),
      if (scorer != null) 'scorer': scorer?.toJsonForProtocol(),
      'evaluationId': evaluationId.toJson(),
      if (evaluation != null) 'evaluation': evaluation?.toJsonForProtocol(),
      'data':
          // ignore: unnecessary_type_check
          data is _i1.ProtocolSerialization
          ? (data as _i1.ProtocolSerialization).toJsonForProtocol()
          : data.toJson(),
    };
  }

  static ScorerResultInclude include({
    _i2.ScorerInclude? scorer,
    _i3.EvaluationInclude? evaluation,
  }) {
    return ScorerResultInclude._(
      scorer: scorer,
      evaluation: evaluation,
    );
  }

  static ScorerResultIncludeList includeList({
    _i1.WhereExpressionBuilder<ScorerResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerResultTable>? orderByList,
    ScorerResultInclude? include,
  }) {
    return ScorerResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScorerResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScorerResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScorerResultImpl extends ScorerResult {
  _ScorerResultImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue scorerId,
    _i2.Scorer? scorer,
    required _i1.UuidValue evaluationId,
    _i3.Evaluation? evaluation,
    required _i4.ScorerResultData data,
  }) : super._(
         id: id,
         scorerId: scorerId,
         scorer: scorer,
         evaluationId: evaluationId,
         evaluation: evaluation,
         data: data,
       );

  /// Returns a shallow copy of this [ScorerResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScorerResult copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? scorerId,
    Object? scorer = _Undefined,
    _i1.UuidValue? evaluationId,
    Object? evaluation = _Undefined,
    _i4.ScorerResultData? data,
  }) {
    return ScorerResult(
      id: id is _i1.UuidValue? ? id : this.id,
      scorerId: scorerId ?? this.scorerId,
      scorer: scorer is _i2.Scorer? ? scorer : this.scorer?.copyWith(),
      evaluationId: evaluationId ?? this.evaluationId,
      evaluation: evaluation is _i3.Evaluation?
          ? evaluation
          : this.evaluation?.copyWith(),
      data: data ?? this.data.copyWith(),
    );
  }
}

class ScorerResultUpdateTable extends _i1.UpdateTable<ScorerResultTable> {
  ScorerResultUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> scorerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.scorerId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> evaluationId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.evaluationId,
    value,
  );

  _i1.ColumnValue<_i4.ScorerResultData, _i4.ScorerResultData> data(
    _i4.ScorerResultData value,
  ) => _i1.ColumnValue(
    table.data,
    value,
  );
}

class ScorerResultTable extends _i1.Table<_i1.UuidValue?> {
  ScorerResultTable({super.tableRelation})
    : super(tableName: 'evals_scorer_results') {
    updateTable = ScorerResultUpdateTable(this);
    scorerId = _i1.ColumnUuid(
      'scorerId',
      this,
    );
    evaluationId = _i1.ColumnUuid(
      'evaluationId',
      this,
    );
    data = _i1.ColumnSerializable<_i4.ScorerResultData>(
      'data',
      this,
    );
  }

  late final ScorerResultUpdateTable updateTable;

  late final _i1.ColumnUuid scorerId;

  /// Scorer this summary belongs to.
  _i2.ScorerTable? _scorer;

  late final _i1.ColumnUuid evaluationId;

  /// Whether this scorer data is for a baseline run.
  _i3.EvaluationTable? _evaluation;

  /// Flexible data archived by the scorer.
  late final _i1.ColumnSerializable<_i4.ScorerResultData> data;

  _i2.ScorerTable get scorer {
    if (_scorer != null) return _scorer!;
    _scorer = _i1.createRelationTable(
      relationFieldName: 'scorer',
      field: ScorerResult.t.scorerId,
      foreignField: _i2.Scorer.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScorerTable(tableRelation: foreignTableRelation),
    );
    return _scorer!;
  }

  _i3.EvaluationTable get evaluation {
    if (_evaluation != null) return _evaluation!;
    _evaluation = _i1.createRelationTable(
      relationFieldName: 'evaluation',
      field: ScorerResult.t.evaluationId,
      foreignField: _i3.Evaluation.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EvaluationTable(tableRelation: foreignTableRelation),
    );
    return _evaluation!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    scorerId,
    evaluationId,
    data,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'scorer') {
      return scorer;
    }
    if (relationField == 'evaluation') {
      return evaluation;
    }
    return null;
  }
}

class ScorerResultInclude extends _i1.IncludeObject {
  ScorerResultInclude._({
    _i2.ScorerInclude? scorer,
    _i3.EvaluationInclude? evaluation,
  }) {
    _scorer = scorer;
    _evaluation = evaluation;
  }

  _i2.ScorerInclude? _scorer;

  _i3.EvaluationInclude? _evaluation;

  @override
  Map<String, _i1.Include?> get includes => {
    'scorer': _scorer,
    'evaluation': _evaluation,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => ScorerResult.t;
}

class ScorerResultIncludeList extends _i1.IncludeList {
  ScorerResultIncludeList._({
    _i1.WhereExpressionBuilder<ScorerResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScorerResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ScorerResult.t;
}

class ScorerResultRepository {
  const ScorerResultRepository._();

  final attachRow = const ScorerResultAttachRowRepository._();

  /// Returns a list of [ScorerResult]s matching the given query parameters.
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
  Future<List<ScorerResult>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerResultTable>? orderByList,
    _i1.Transaction? transaction,
    ScorerResultInclude? include,
  }) async {
    return session.db.find<ScorerResult>(
      where: where?.call(ScorerResult.t),
      orderBy: orderBy?.call(ScorerResult.t),
      orderByList: orderByList?.call(ScorerResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ScorerResult] matching the given query parameters.
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
  Future<ScorerResult?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScorerResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerResultTable>? orderByList,
    _i1.Transaction? transaction,
    ScorerResultInclude? include,
  }) async {
    return session.db.findFirstRow<ScorerResult>(
      where: where?.call(ScorerResult.t),
      orderBy: orderBy?.call(ScorerResult.t),
      orderByList: orderByList?.call(ScorerResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ScorerResult] by its [id] or null if no such row exists.
  Future<ScorerResult?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ScorerResultInclude? include,
  }) async {
    return session.db.findById<ScorerResult>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ScorerResult]s in the list and returns the inserted rows.
  ///
  /// The returned [ScorerResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScorerResult>> insert(
    _i1.Session session,
    List<ScorerResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScorerResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScorerResult] and returns the inserted row.
  ///
  /// The returned [ScorerResult] will have its `id` field set.
  Future<ScorerResult> insertRow(
    _i1.Session session,
    ScorerResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScorerResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScorerResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScorerResult>> update(
    _i1.Session session,
    List<ScorerResult> rows, {
    _i1.ColumnSelections<ScorerResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScorerResult>(
      rows,
      columns: columns?.call(ScorerResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScorerResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScorerResult> updateRow(
    _i1.Session session,
    ScorerResult row, {
    _i1.ColumnSelections<ScorerResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScorerResult>(
      row,
      columns: columns?.call(ScorerResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScorerResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScorerResult?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ScorerResultUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScorerResult>(
      id,
      columnValues: columnValues(ScorerResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScorerResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScorerResult>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ScorerResultUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ScorerResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerResultTable>? orderBy,
    _i1.OrderByListBuilder<ScorerResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScorerResult>(
      columnValues: columnValues(ScorerResult.t.updateTable),
      where: where(ScorerResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScorerResult.t),
      orderByList: orderByList?.call(ScorerResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScorerResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScorerResult>> delete(
    _i1.Session session,
    List<ScorerResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScorerResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScorerResult].
  Future<ScorerResult> deleteRow(
    _i1.Session session,
    ScorerResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScorerResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScorerResult>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScorerResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScorerResult>(
      where: where(ScorerResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScorerResult>(
      where: where?.call(ScorerResult.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ScorerResultAttachRowRepository {
  const ScorerResultAttachRowRepository._();

  /// Creates a relation between the given [ScorerResult] and [Scorer]
  /// by setting the [ScorerResult]'s foreign key `scorerId` to refer to the [Scorer].
  Future<void> scorer(
    _i1.Session session,
    ScorerResult scorerResult,
    _i2.Scorer scorer, {
    _i1.Transaction? transaction,
  }) async {
    if (scorerResult.id == null) {
      throw ArgumentError.notNull('scorerResult.id');
    }
    if (scorer.id == null) {
      throw ArgumentError.notNull('scorer.id');
    }

    var $scorerResult = scorerResult.copyWith(scorerId: scorer.id);
    await session.db.updateRow<ScorerResult>(
      $scorerResult,
      columns: [ScorerResult.t.scorerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScorerResult] and [Evaluation]
  /// by setting the [ScorerResult]'s foreign key `evaluationId` to refer to the [Evaluation].
  Future<void> evaluation(
    _i1.Session session,
    ScorerResult scorerResult,
    _i3.Evaluation evaluation, {
    _i1.Transaction? transaction,
  }) async {
    if (scorerResult.id == null) {
      throw ArgumentError.notNull('scorerResult.id');
    }
    if (evaluation.id == null) {
      throw ArgumentError.notNull('evaluation.id');
    }

    var $scorerResult = scorerResult.copyWith(evaluationId: evaluation.id);
    await session.db.updateRow<ScorerResult>(
      $scorerResult,
      columns: [ScorerResult.t.evaluationId],
      transaction: transaction,
    );
  }
}
