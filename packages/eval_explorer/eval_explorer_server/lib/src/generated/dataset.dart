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

/// A dataset is an Inspect AI term that refers to a collection of samples.
///
/// In our case, each dataset corresponds to a collection of sample types.
/// (i.e. "dart_qa_dataset", "flutter_code_execution") And each sample type
/// refers to a specific file in the /datasets directory.
abstract class Dataset
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Dataset._({
    this.id,
    required this.name,
    bool? isActive,
  }) : isActive = isActive ?? true,
       _evalsRunsDatasetsEvalsRunsId = null;

  factory Dataset({
    _i1.UuidValue? id,
    required String name,
    bool? isActive,
  }) = _DatasetImpl;

  factory Dataset.fromJson(Map<String, dynamic> jsonSerialization) {
    return DatasetImplicit._(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      isActive: jsonSerialization['isActive'] as bool?,
      $_evalsRunsDatasetsEvalsRunsId:
          jsonSerialization['_evalsRunsDatasetsEvalsRunsId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['_evalsRunsDatasetsEvalsRunsId'],
            ),
    );
  }

  static final t = DatasetTable();

  static const db = DatasetRepository._();

  @override
  _i1.UuidValue? id;

  String name;

  bool isActive;

  final _i1.UuidValue? _evalsRunsDatasetsEvalsRunsId;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Dataset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dataset copyWith({
    _i1.UuidValue? id,
    String? name,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dataset',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'isActive': isActive,
      if (_evalsRunsDatasetsEvalsRunsId != null)
        '_evalsRunsDatasetsEvalsRunsId': _evalsRunsDatasetsEvalsRunsId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Dataset',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'isActive': isActive,
    };
  }

  static DatasetInclude include() {
    return DatasetInclude._();
  }

  static DatasetIncludeList includeList({
    _i1.WhereExpressionBuilder<DatasetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DatasetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DatasetTable>? orderByList,
    DatasetInclude? include,
  }) {
    return DatasetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dataset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Dataset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DatasetImpl extends Dataset {
  _DatasetImpl({
    _i1.UuidValue? id,
    required String name,
    bool? isActive,
  }) : super._(
         id: id,
         name: name,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [Dataset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dataset copyWith({
    Object? id = _Undefined,
    String? name,
    bool? isActive,
  }) {
    return DatasetImplicit._(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      $_evalsRunsDatasetsEvalsRunsId: this._evalsRunsDatasetsEvalsRunsId,
    );
  }
}

class DatasetImplicit extends _DatasetImpl {
  DatasetImplicit._({
    _i1.UuidValue? id,
    required String name,
    bool? isActive,
    _i1.UuidValue? $_evalsRunsDatasetsEvalsRunsId,
  }) : _evalsRunsDatasetsEvalsRunsId = $_evalsRunsDatasetsEvalsRunsId,
       super(
         id: id,
         name: name,
         isActive: isActive,
       );

  factory DatasetImplicit(
    Dataset dataset, {
    _i1.UuidValue? $_evalsRunsDatasetsEvalsRunsId,
  }) {
    return DatasetImplicit._(
      id: dataset.id,
      name: dataset.name,
      isActive: dataset.isActive,
      $_evalsRunsDatasetsEvalsRunsId: $_evalsRunsDatasetsEvalsRunsId,
    );
  }

  @override
  final _i1.UuidValue? _evalsRunsDatasetsEvalsRunsId;
}

class DatasetUpdateTable extends _i1.UpdateTable<DatasetTable> {
  DatasetUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> $_evalsRunsDatasetsEvalsRunsId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.$_evalsRunsDatasetsEvalsRunsId,
    value,
  );
}

class DatasetTable extends _i1.Table<_i1.UuidValue?> {
  DatasetTable({super.tableRelation}) : super(tableName: 'evals_datasets') {
    updateTable = DatasetUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    $_evalsRunsDatasetsEvalsRunsId = _i1.ColumnUuid(
      '_evalsRunsDatasetsEvalsRunsId',
      this,
    );
  }

  late final DatasetUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnUuid $_evalsRunsDatasetsEvalsRunsId;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    isActive,
    $_evalsRunsDatasetsEvalsRunsId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    name,
    isActive,
  ];
}

class DatasetInclude extends _i1.IncludeObject {
  DatasetInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Dataset.t;
}

class DatasetIncludeList extends _i1.IncludeList {
  DatasetIncludeList._({
    _i1.WhereExpressionBuilder<DatasetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Dataset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Dataset.t;
}

class DatasetRepository {
  const DatasetRepository._();

  /// Returns a list of [Dataset]s matching the given query parameters.
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
  Future<List<Dataset>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DatasetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DatasetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DatasetTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Dataset>(
      where: where?.call(Dataset.t),
      orderBy: orderBy?.call(Dataset.t),
      orderByList: orderByList?.call(Dataset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Dataset] matching the given query parameters.
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
  Future<Dataset?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DatasetTable>? where,
    int? offset,
    _i1.OrderByBuilder<DatasetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DatasetTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Dataset>(
      where: where?.call(Dataset.t),
      orderBy: orderBy?.call(Dataset.t),
      orderByList: orderByList?.call(Dataset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Dataset] by its [id] or null if no such row exists.
  Future<Dataset?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Dataset>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Dataset]s in the list and returns the inserted rows.
  ///
  /// The returned [Dataset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Dataset>> insert(
    _i1.Session session,
    List<Dataset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Dataset>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Dataset] and returns the inserted row.
  ///
  /// The returned [Dataset] will have its `id` field set.
  Future<Dataset> insertRow(
    _i1.Session session,
    Dataset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Dataset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Dataset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Dataset>> update(
    _i1.Session session,
    List<Dataset> rows, {
    _i1.ColumnSelections<DatasetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Dataset>(
      rows,
      columns: columns?.call(Dataset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dataset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Dataset> updateRow(
    _i1.Session session,
    Dataset row, {
    _i1.ColumnSelections<DatasetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Dataset>(
      row,
      columns: columns?.call(Dataset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dataset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Dataset?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<DatasetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Dataset>(
      id,
      columnValues: columnValues(Dataset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Dataset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Dataset>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DatasetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DatasetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DatasetTable>? orderBy,
    _i1.OrderByListBuilder<DatasetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Dataset>(
      columnValues: columnValues(Dataset.t.updateTable),
      where: where(Dataset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dataset.t),
      orderByList: orderByList?.call(Dataset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Dataset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Dataset>> delete(
    _i1.Session session,
    List<Dataset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Dataset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Dataset].
  Future<Dataset> deleteRow(
    _i1.Session session,
    Dataset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Dataset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Dataset>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DatasetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Dataset>(
      where: where(Dataset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DatasetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Dataset>(
      where: where?.call(Dataset.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
