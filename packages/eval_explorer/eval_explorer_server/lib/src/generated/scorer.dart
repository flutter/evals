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
import 'package:serverpod/serverpod.dart' as _i1;

/// Ye who watch the watchers.
abstract class Scorer
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Scorer._({
    this.id,
    required this.name,
  });

  factory Scorer({
    _i1.UuidValue? id,
    required String name,
  }) = _ScorerImpl;

  factory Scorer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Scorer(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
    );
  }

  static final t = ScorerTable();

  static const db = ScorerRepository._();

  @override
  _i1.UuidValue? id;

  /// Name of the scorer (e.g., "bleu").
  String name;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Scorer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Scorer copyWith({
    _i1.UuidValue? id,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Scorer',
      if (id != null) 'id': id?.toJson(),
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Scorer',
      if (id != null) 'id': id?.toJson(),
      'name': name,
    };
  }

  static ScorerInclude include() {
    return ScorerInclude._();
  }

  static ScorerIncludeList includeList({
    _i1.WhereExpressionBuilder<ScorerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerTable>? orderByList,
    ScorerInclude? include,
  }) {
    return ScorerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Scorer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Scorer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScorerImpl extends Scorer {
  _ScorerImpl({
    _i1.UuidValue? id,
    required String name,
  }) : super._(
         id: id,
         name: name,
       );

  /// Returns a shallow copy of this [Scorer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Scorer copyWith({
    Object? id = _Undefined,
    String? name,
  }) {
    return Scorer(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
    );
  }
}

class ScorerUpdateTable extends _i1.UpdateTable<ScorerTable> {
  ScorerUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );
}

class ScorerTable extends _i1.Table<_i1.UuidValue?> {
  ScorerTable({super.tableRelation}) : super(tableName: 'evals_scorers') {
    updateTable = ScorerUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final ScorerUpdateTable updateTable;

  /// Name of the scorer (e.g., "bleu").
  late final _i1.ColumnString name;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
  ];
}

class ScorerInclude extends _i1.IncludeObject {
  ScorerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Scorer.t;
}

class ScorerIncludeList extends _i1.IncludeList {
  ScorerIncludeList._({
    _i1.WhereExpressionBuilder<ScorerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Scorer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Scorer.t;
}

class ScorerRepository {
  const ScorerRepository._();

  /// Returns a list of [Scorer]s matching the given query parameters.
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
  Future<List<Scorer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Scorer>(
      where: where?.call(Scorer.t),
      orderBy: orderBy?.call(Scorer.t),
      orderByList: orderByList?.call(Scorer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Scorer] matching the given query parameters.
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
  Future<Scorer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScorerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScorerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Scorer>(
      where: where?.call(Scorer.t),
      orderBy: orderBy?.call(Scorer.t),
      orderByList: orderByList?.call(Scorer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Scorer] by its [id] or null if no such row exists.
  Future<Scorer?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Scorer>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Scorer]s in the list and returns the inserted rows.
  ///
  /// The returned [Scorer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Scorer>> insert(
    _i1.Session session,
    List<Scorer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Scorer>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Scorer] and returns the inserted row.
  ///
  /// The returned [Scorer] will have its `id` field set.
  Future<Scorer> insertRow(
    _i1.Session session,
    Scorer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Scorer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Scorer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Scorer>> update(
    _i1.Session session,
    List<Scorer> rows, {
    _i1.ColumnSelections<ScorerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Scorer>(
      rows,
      columns: columns?.call(Scorer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Scorer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Scorer> updateRow(
    _i1.Session session,
    Scorer row, {
    _i1.ColumnSelections<ScorerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Scorer>(
      row,
      columns: columns?.call(Scorer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Scorer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Scorer?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ScorerUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Scorer>(
      id,
      columnValues: columnValues(Scorer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Scorer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Scorer>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ScorerUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ScorerTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScorerTable>? orderBy,
    _i1.OrderByListBuilder<ScorerTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Scorer>(
      columnValues: columnValues(Scorer.t.updateTable),
      where: where(Scorer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Scorer.t),
      orderByList: orderByList?.call(Scorer.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Scorer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Scorer>> delete(
    _i1.Session session,
    List<Scorer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Scorer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Scorer].
  Future<Scorer> deleteRow(
    _i1.Session session,
    Scorer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Scorer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Scorer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScorerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Scorer>(
      where: where(Scorer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScorerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Scorer>(
      where: where?.call(Scorer.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
