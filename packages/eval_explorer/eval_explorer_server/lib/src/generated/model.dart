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

/// An LLM being evaluated.
abstract class Model
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Model._({
    this.id,
    required this.name,
  }) : _evalsRunsModelsEvalsRunsId = null;

  factory Model({
    _i1.UuidValue? id,
    required String name,
  }) = _ModelImpl;

  factory Model.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModelImplicit._(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      $_evalsRunsModelsEvalsRunsId:
          jsonSerialization['_evalsRunsModelsEvalsRunsId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['_evalsRunsModelsEvalsRunsId'],
            ),
    );
  }

  static final t = ModelTable();

  static const db = ModelRepository._();

  @override
  _i1.UuidValue? id;

  /// Unique identifier for the model.
  String name;

  final _i1.UuidValue? _evalsRunsModelsEvalsRunsId;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Model]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Model copyWith({
    _i1.UuidValue? id,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Model',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (_evalsRunsModelsEvalsRunsId != null)
        '_evalsRunsModelsEvalsRunsId': _evalsRunsModelsEvalsRunsId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Model',
      if (id != null) 'id': id?.toJson(),
      'name': name,
    };
  }

  static ModelInclude include() {
    return ModelInclude._();
  }

  static ModelIncludeList includeList({
    _i1.WhereExpressionBuilder<ModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModelTable>? orderByList,
    ModelInclude? include,
  }) {
    return ModelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Model.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Model.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModelImpl extends Model {
  _ModelImpl({
    _i1.UuidValue? id,
    required String name,
  }) : super._(
         id: id,
         name: name,
       );

  /// Returns a shallow copy of this [Model]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Model copyWith({
    Object? id = _Undefined,
    String? name,
  }) {
    return ModelImplicit._(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      $_evalsRunsModelsEvalsRunsId: this._evalsRunsModelsEvalsRunsId,
    );
  }
}

class ModelImplicit extends _ModelImpl {
  ModelImplicit._({
    _i1.UuidValue? id,
    required String name,
    _i1.UuidValue? $_evalsRunsModelsEvalsRunsId,
  }) : _evalsRunsModelsEvalsRunsId = $_evalsRunsModelsEvalsRunsId,
       super(
         id: id,
         name: name,
       );

  factory ModelImplicit(
    Model model, {
    _i1.UuidValue? $_evalsRunsModelsEvalsRunsId,
  }) {
    return ModelImplicit._(
      id: model.id,
      name: model.name,
      $_evalsRunsModelsEvalsRunsId: $_evalsRunsModelsEvalsRunsId,
    );
  }

  @override
  final _i1.UuidValue? _evalsRunsModelsEvalsRunsId;
}

class ModelUpdateTable extends _i1.UpdateTable<ModelTable> {
  ModelUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> $_evalsRunsModelsEvalsRunsId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.$_evalsRunsModelsEvalsRunsId,
    value,
  );
}

class ModelTable extends _i1.Table<_i1.UuidValue?> {
  ModelTable({super.tableRelation}) : super(tableName: 'evals_models') {
    updateTable = ModelUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    $_evalsRunsModelsEvalsRunsId = _i1.ColumnUuid(
      '_evalsRunsModelsEvalsRunsId',
      this,
    );
  }

  late final ModelUpdateTable updateTable;

  /// Unique identifier for the model.
  late final _i1.ColumnString name;

  late final _i1.ColumnUuid $_evalsRunsModelsEvalsRunsId;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    $_evalsRunsModelsEvalsRunsId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    name,
  ];
}

class ModelInclude extends _i1.IncludeObject {
  ModelInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Model.t;
}

class ModelIncludeList extends _i1.IncludeList {
  ModelIncludeList._({
    _i1.WhereExpressionBuilder<ModelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Model.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Model.t;
}

class ModelRepository {
  const ModelRepository._();

  /// Returns a list of [Model]s matching the given query parameters.
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
  Future<List<Model>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Model>(
      where: where?.call(Model.t),
      orderBy: orderBy?.call(Model.t),
      orderByList: orderByList?.call(Model.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Model] matching the given query parameters.
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
  Future<Model?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModelTable>? where,
    int? offset,
    _i1.OrderByBuilder<ModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Model>(
      where: where?.call(Model.t),
      orderBy: orderBy?.call(Model.t),
      orderByList: orderByList?.call(Model.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Model] by its [id] or null if no such row exists.
  Future<Model?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Model>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Model]s in the list and returns the inserted rows.
  ///
  /// The returned [Model]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Model>> insert(
    _i1.Session session,
    List<Model> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Model>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Model] and returns the inserted row.
  ///
  /// The returned [Model] will have its `id` field set.
  Future<Model> insertRow(
    _i1.Session session,
    Model row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Model>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Model]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Model>> update(
    _i1.Session session,
    List<Model> rows, {
    _i1.ColumnSelections<ModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Model>(
      rows,
      columns: columns?.call(Model.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Model]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Model> updateRow(
    _i1.Session session,
    Model row, {
    _i1.ColumnSelections<ModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Model>(
      row,
      columns: columns?.call(Model.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Model] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Model?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ModelUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Model>(
      id,
      columnValues: columnValues(Model.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Model]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Model>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ModelUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ModelTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModelTable>? orderBy,
    _i1.OrderByListBuilder<ModelTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Model>(
      columnValues: columnValues(Model.t.updateTable),
      where: where(Model.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Model.t),
      orderByList: orderByList?.call(Model.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Model]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Model>> delete(
    _i1.Session session,
    List<Model> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Model>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Model].
  Future<Model> deleteRow(
    _i1.Session session,
    Model row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Model>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Model>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ModelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Model>(
      where: where(Model.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ModelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Model>(
      where: where?.call(Model.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
