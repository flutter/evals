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
import 'dataset.dart' as _i2;
import 'sample_tag_xref.dart' as _i3;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i4;

/// A single challenge to be presented to a [Model] and evaluated by one or more [Scorer]s.
abstract class Sample
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Sample._({
    this.id,
    required this.name,
    required this.datasetId,
    this.dataset,
    required this.input,
    required this.target,
    this.tagsXref,
    bool? isActive,
    DateTime? createdAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory Sample({
    _i1.UuidValue? id,
    required String name,
    required _i1.UuidValue datasetId,
    _i2.Dataset? dataset,
    required String input,
    required String target,
    List<_i3.SampleTagXref>? tagsXref,
    bool? isActive,
    DateTime? createdAt,
  }) = _SampleImpl;

  factory Sample.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sample(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      datasetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['datasetId'],
      ),
      dataset: jsonSerialization['dataset'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Dataset>(
              jsonSerialization['dataset'],
            ),
      input: jsonSerialization['input'] as String,
      target: jsonSerialization['target'] as String,
      tagsXref: jsonSerialization['tagsXref'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.SampleTagXref>>(
              jsonSerialization['tagsXref'],
            ),
      isActive: jsonSerialization['isActive'] as bool?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SampleTable();

  static const db = SampleRepository._();

  @override
  _i1.UuidValue? id;

  /// Short sample name/ID (e.g., "dart_futures_vs_streams").
  String name;

  _i1.UuidValue datasetId;

  /// The dataset this sample belongs to (e.g., "dart_qa_dataset").
  _i2.Dataset? dataset;

  /// The input prompt/question for the model.
  String input;

  /// The expected answer or grading guidance.
  String target;

  /// Tags associated with this sample (e.g., ["dart", "flutter"]).
  /// Technically, this relationship only reaches the cross-reference table,
  /// not the tags themselves.
  List<_i3.SampleTagXref>? tagsXref;

  /// True if the sample is still active and included in eval runs.
  bool isActive;

  /// Creation time for this record.
  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Sample]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Sample copyWith({
    _i1.UuidValue? id,
    String? name,
    _i1.UuidValue? datasetId,
    _i2.Dataset? dataset,
    String? input,
    String? target,
    List<_i3.SampleTagXref>? tagsXref,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sample',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJson(),
      'input': input,
      'target': target,
      if (tagsXref != null)
        'tagsXref': tagsXref?.toJson(valueToJson: (v) => v.toJson()),
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Sample',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJsonForProtocol(),
      'input': input,
      'target': target,
      if (tagsXref != null)
        'tagsXref': tagsXref?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static SampleInclude include({
    _i2.DatasetInclude? dataset,
    _i3.SampleTagXrefIncludeList? tagsXref,
  }) {
    return SampleInclude._(
      dataset: dataset,
      tagsXref: tagsXref,
    );
  }

  static SampleIncludeList includeList({
    _i1.WhereExpressionBuilder<SampleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTable>? orderByList,
    SampleInclude? include,
  }) {
    return SampleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sample.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Sample.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SampleImpl extends Sample {
  _SampleImpl({
    _i1.UuidValue? id,
    required String name,
    required _i1.UuidValue datasetId,
    _i2.Dataset? dataset,
    required String input,
    required String target,
    List<_i3.SampleTagXref>? tagsXref,
    bool? isActive,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         datasetId: datasetId,
         dataset: dataset,
         input: input,
         target: target,
         tagsXref: tagsXref,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Sample]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Sample copyWith({
    Object? id = _Undefined,
    String? name,
    _i1.UuidValue? datasetId,
    Object? dataset = _Undefined,
    String? input,
    String? target,
    Object? tagsXref = _Undefined,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Sample(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      datasetId: datasetId ?? this.datasetId,
      dataset: dataset is _i2.Dataset? ? dataset : this.dataset?.copyWith(),
      input: input ?? this.input,
      target: target ?? this.target,
      tagsXref: tagsXref is List<_i3.SampleTagXref>?
          ? tagsXref
          : this.tagsXref?.map((e0) => e0.copyWith()).toList(),
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SampleUpdateTable extends _i1.UpdateTable<SampleTable> {
  SampleUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> datasetId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.datasetId,
    value,
  );

  _i1.ColumnValue<String, String> input(String value) => _i1.ColumnValue(
    table.input,
    value,
  );

  _i1.ColumnValue<String, String> target(String value) => _i1.ColumnValue(
    table.target,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SampleTable extends _i1.Table<_i1.UuidValue?> {
  SampleTable({super.tableRelation}) : super(tableName: 'evals_samples') {
    updateTable = SampleUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    datasetId = _i1.ColumnUuid(
      'datasetId',
      this,
    );
    input = _i1.ColumnString(
      'input',
      this,
    );
    target = _i1.ColumnString(
      'target',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SampleUpdateTable updateTable;

  /// Short sample name/ID (e.g., "dart_futures_vs_streams").
  late final _i1.ColumnString name;

  late final _i1.ColumnUuid datasetId;

  /// The dataset this sample belongs to (e.g., "dart_qa_dataset").
  _i2.DatasetTable? _dataset;

  /// The input prompt/question for the model.
  late final _i1.ColumnString input;

  /// The expected answer or grading guidance.
  late final _i1.ColumnString target;

  /// Tags associated with this sample (e.g., ["dart", "flutter"]).
  /// Technically, this relationship only reaches the cross-reference table,
  /// not the tags themselves.
  _i3.SampleTagXrefTable? ___tagsXref;

  /// Tags associated with this sample (e.g., ["dart", "flutter"]).
  /// Technically, this relationship only reaches the cross-reference table,
  /// not the tags themselves.
  _i1.ManyRelation<_i3.SampleTagXrefTable>? _tagsXref;

  /// True if the sample is still active and included in eval runs.
  late final _i1.ColumnBool isActive;

  /// Creation time for this record.
  late final _i1.ColumnDateTime createdAt;

  _i2.DatasetTable get dataset {
    if (_dataset != null) return _dataset!;
    _dataset = _i1.createRelationTable(
      relationFieldName: 'dataset',
      field: Sample.t.datasetId,
      foreignField: _i2.Dataset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.DatasetTable(tableRelation: foreignTableRelation),
    );
    return _dataset!;
  }

  _i3.SampleTagXrefTable get __tagsXref {
    if (___tagsXref != null) return ___tagsXref!;
    ___tagsXref = _i1.createRelationTable(
      relationFieldName: '__tagsXref',
      field: Sample.t.id,
      foreignField: _i3.SampleTagXref.t.sampleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SampleTagXrefTable(tableRelation: foreignTableRelation),
    );
    return ___tagsXref!;
  }

  _i1.ManyRelation<_i3.SampleTagXrefTable> get tagsXref {
    if (_tagsXref != null) return _tagsXref!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'tagsXref',
      field: Sample.t.id,
      foreignField: _i3.SampleTagXref.t.sampleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SampleTagXrefTable(tableRelation: foreignTableRelation),
    );
    _tagsXref = _i1.ManyRelation<_i3.SampleTagXrefTable>(
      tableWithRelations: relationTable,
      table: _i3.SampleTagXrefTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _tagsXref!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    datasetId,
    input,
    target,
    isActive,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'dataset') {
      return dataset;
    }
    if (relationField == 'tagsXref') {
      return __tagsXref;
    }
    return null;
  }
}

class SampleInclude extends _i1.IncludeObject {
  SampleInclude._({
    _i2.DatasetInclude? dataset,
    _i3.SampleTagXrefIncludeList? tagsXref,
  }) {
    _dataset = dataset;
    _tagsXref = tagsXref;
  }

  _i2.DatasetInclude? _dataset;

  _i3.SampleTagXrefIncludeList? _tagsXref;

  @override
  Map<String, _i1.Include?> get includes => {
    'dataset': _dataset,
    'tagsXref': _tagsXref,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Sample.t;
}

class SampleIncludeList extends _i1.IncludeList {
  SampleIncludeList._({
    _i1.WhereExpressionBuilder<SampleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Sample.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Sample.t;
}

class SampleRepository {
  const SampleRepository._();

  final attach = const SampleAttachRepository._();

  final attachRow = const SampleAttachRowRepository._();

  final detach = const SampleDetachRepository._();

  final detachRow = const SampleDetachRowRepository._();

  /// Returns a list of [Sample]s matching the given query parameters.
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
  Future<List<Sample>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTable>? orderByList,
    _i1.Transaction? transaction,
    SampleInclude? include,
  }) async {
    return session.db.find<Sample>(
      where: where?.call(Sample.t),
      orderBy: orderBy?.call(Sample.t),
      orderByList: orderByList?.call(Sample.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Sample] matching the given query parameters.
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
  Future<Sample?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTable>? where,
    int? offset,
    _i1.OrderByBuilder<SampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTable>? orderByList,
    _i1.Transaction? transaction,
    SampleInclude? include,
  }) async {
    return session.db.findFirstRow<Sample>(
      where: where?.call(Sample.t),
      orderBy: orderBy?.call(Sample.t),
      orderByList: orderByList?.call(Sample.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Sample] by its [id] or null if no such row exists.
  Future<Sample?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    SampleInclude? include,
  }) async {
    return session.db.findById<Sample>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Sample]s in the list and returns the inserted rows.
  ///
  /// The returned [Sample]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Sample>> insert(
    _i1.Session session,
    List<Sample> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Sample>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Sample] and returns the inserted row.
  ///
  /// The returned [Sample] will have its `id` field set.
  Future<Sample> insertRow(
    _i1.Session session,
    Sample row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Sample>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Sample]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Sample>> update(
    _i1.Session session,
    List<Sample> rows, {
    _i1.ColumnSelections<SampleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Sample>(
      rows,
      columns: columns?.call(Sample.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sample]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Sample> updateRow(
    _i1.Session session,
    Sample row, {
    _i1.ColumnSelections<SampleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Sample>(
      row,
      columns: columns?.call(Sample.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sample] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Sample?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SampleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Sample>(
      id,
      columnValues: columnValues(Sample.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Sample]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Sample>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SampleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SampleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTable>? orderBy,
    _i1.OrderByListBuilder<SampleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Sample>(
      columnValues: columnValues(Sample.t.updateTable),
      where: where(Sample.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sample.t),
      orderByList: orderByList?.call(Sample.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Sample]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Sample>> delete(
    _i1.Session session,
    List<Sample> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Sample>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Sample].
  Future<Sample> deleteRow(
    _i1.Session session,
    Sample row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Sample>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Sample>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SampleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Sample>(
      where: where(Sample.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Sample>(
      where: where?.call(Sample.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SampleAttachRepository {
  const SampleAttachRepository._();

  /// Creates a relation between this [Sample] and the given [SampleTagXref]s
  /// by setting each [SampleTagXref]'s foreign key `sampleId` to refer to this [Sample].
  Future<void> tagsXref(
    _i1.Session session,
    Sample sample,
    List<_i3.SampleTagXref> sampleTagXref, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.any((e) => e.id == null)) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }
    if (sample.id == null) {
      throw ArgumentError.notNull('sample.id');
    }

    var $sampleTagXref = sampleTagXref
        .map((e) => e.copyWith(sampleId: sample.id))
        .toList();
    await session.db.update<_i3.SampleTagXref>(
      $sampleTagXref,
      columns: [_i3.SampleTagXref.t.sampleId],
      transaction: transaction,
    );
  }
}

class SampleAttachRowRepository {
  const SampleAttachRowRepository._();

  /// Creates a relation between the given [Sample] and [Dataset]
  /// by setting the [Sample]'s foreign key `datasetId` to refer to the [Dataset].
  Future<void> dataset(
    _i1.Session session,
    Sample sample,
    _i2.Dataset dataset, {
    _i1.Transaction? transaction,
  }) async {
    if (sample.id == null) {
      throw ArgumentError.notNull('sample.id');
    }
    if (dataset.id == null) {
      throw ArgumentError.notNull('dataset.id');
    }

    var $sample = sample.copyWith(datasetId: dataset.id);
    await session.db.updateRow<Sample>(
      $sample,
      columns: [Sample.t.datasetId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Sample] and the given [SampleTagXref]
  /// by setting the [SampleTagXref]'s foreign key `sampleId` to refer to this [Sample].
  Future<void> tagsXref(
    _i1.Session session,
    Sample sample,
    _i3.SampleTagXref sampleTagXref, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.id == null) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }
    if (sample.id == null) {
      throw ArgumentError.notNull('sample.id');
    }

    var $sampleTagXref = sampleTagXref.copyWith(sampleId: sample.id);
    await session.db.updateRow<_i3.SampleTagXref>(
      $sampleTagXref,
      columns: [_i3.SampleTagXref.t.sampleId],
      transaction: transaction,
    );
  }
}

class SampleDetachRepository {
  const SampleDetachRepository._();

  /// Detaches the relation between this [Sample] and the given [SampleTagXref]
  /// by setting the [SampleTagXref]'s foreign key `sampleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tagsXref(
    _i1.Session session,
    List<_i3.SampleTagXref> sampleTagXref, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.any((e) => e.id == null)) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }

    var $sampleTagXref = sampleTagXref
        .map((e) => e.copyWith(sampleId: null))
        .toList();
    await session.db.update<_i3.SampleTagXref>(
      $sampleTagXref,
      columns: [_i3.SampleTagXref.t.sampleId],
      transaction: transaction,
    );
  }
}

class SampleDetachRowRepository {
  const SampleDetachRowRepository._();

  /// Detaches the relation between this [Sample] and the given [SampleTagXref]
  /// by setting the [SampleTagXref]'s foreign key `sampleId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tagsXref(
    _i1.Session session,
    _i3.SampleTagXref sampleTagXref, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.id == null) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }

    var $sampleTagXref = sampleTagXref.copyWith(sampleId: null);
    await session.db.updateRow<_i3.SampleTagXref>(
      $sampleTagXref,
      columns: [_i3.SampleTagXref.t.sampleId],
      transaction: transaction,
    );
  }
}
