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
import 'sample.dart' as _i2;
import 'tag.dart' as _i3;
import 'package:eval_explorer_server/src/generated/protocol.dart' as _i4;

/// Cross reference table for samples and tags.
abstract class SampleTagXref
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SampleTagXref._({
    this.id,
    required this.sampleId,
    this.sample,
    required this.tagId,
    this.tag,
  });

  factory SampleTagXref({
    int? id,
    required _i1.UuidValue sampleId,
    _i2.Sample? sample,
    required _i1.UuidValue tagId,
    _i3.Tag? tag,
  }) = _SampleTagXrefImpl;

  factory SampleTagXref.fromJson(Map<String, dynamic> jsonSerialization) {
    return SampleTagXref(
      id: jsonSerialization['id'] as int?,
      sampleId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['sampleId'],
      ),
      sample: jsonSerialization['sample'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Sample>(jsonSerialization['sample']),
      tagId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['tagId']),
      tag: jsonSerialization['tag'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Tag>(jsonSerialization['tag']),
    );
  }

  static final t = SampleTagXrefTable();

  static const db = SampleTagXrefRepository._();

  @override
  int? id;

  _i1.UuidValue sampleId;

  _i2.Sample? sample;

  _i1.UuidValue tagId;

  _i3.Tag? tag;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SampleTagXref]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SampleTagXref copyWith({
    int? id,
    _i1.UuidValue? sampleId,
    _i2.Sample? sample,
    _i1.UuidValue? tagId,
    _i3.Tag? tag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SampleTagXref',
      if (id != null) 'id': id,
      'sampleId': sampleId.toJson(),
      if (sample != null) 'sample': sample?.toJson(),
      'tagId': tagId.toJson(),
      if (tag != null) 'tag': tag?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SampleTagXref',
      if (id != null) 'id': id,
      'sampleId': sampleId.toJson(),
      if (sample != null) 'sample': sample?.toJsonForProtocol(),
      'tagId': tagId.toJson(),
      if (tag != null) 'tag': tag?.toJsonForProtocol(),
    };
  }

  static SampleTagXrefInclude include({
    _i2.SampleInclude? sample,
    _i3.TagInclude? tag,
  }) {
    return SampleTagXrefInclude._(
      sample: sample,
      tag: tag,
    );
  }

  static SampleTagXrefIncludeList includeList({
    _i1.WhereExpressionBuilder<SampleTagXrefTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTagXrefTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTagXrefTable>? orderByList,
    SampleTagXrefInclude? include,
  }) {
    return SampleTagXrefIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SampleTagXref.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SampleTagXref.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SampleTagXrefImpl extends SampleTagXref {
  _SampleTagXrefImpl({
    int? id,
    required _i1.UuidValue sampleId,
    _i2.Sample? sample,
    required _i1.UuidValue tagId,
    _i3.Tag? tag,
  }) : super._(
         id: id,
         sampleId: sampleId,
         sample: sample,
         tagId: tagId,
         tag: tag,
       );

  /// Returns a shallow copy of this [SampleTagXref]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SampleTagXref copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? sampleId,
    Object? sample = _Undefined,
    _i1.UuidValue? tagId,
    Object? tag = _Undefined,
  }) {
    return SampleTagXref(
      id: id is int? ? id : this.id,
      sampleId: sampleId ?? this.sampleId,
      sample: sample is _i2.Sample? ? sample : this.sample?.copyWith(),
      tagId: tagId ?? this.tagId,
      tag: tag is _i3.Tag? ? tag : this.tag?.copyWith(),
    );
  }
}

class SampleTagXrefUpdateTable extends _i1.UpdateTable<SampleTagXrefTable> {
  SampleTagXrefUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> sampleId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.sampleId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> tagId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.tagId,
        value,
      );
}

class SampleTagXrefTable extends _i1.Table<int?> {
  SampleTagXrefTable({super.tableRelation})
    : super(tableName: 'evals_samples_tags_xref') {
    updateTable = SampleTagXrefUpdateTable(this);
    sampleId = _i1.ColumnUuid(
      'sampleId',
      this,
    );
    tagId = _i1.ColumnUuid(
      'tagId',
      this,
    );
  }

  late final SampleTagXrefUpdateTable updateTable;

  late final _i1.ColumnUuid sampleId;

  _i2.SampleTable? _sample;

  late final _i1.ColumnUuid tagId;

  _i3.TagTable? _tag;

  _i2.SampleTable get sample {
    if (_sample != null) return _sample!;
    _sample = _i1.createRelationTable(
      relationFieldName: 'sample',
      field: SampleTagXref.t.sampleId,
      foreignField: _i2.Sample.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SampleTable(tableRelation: foreignTableRelation),
    );
    return _sample!;
  }

  _i3.TagTable get tag {
    if (_tag != null) return _tag!;
    _tag = _i1.createRelationTable(
      relationFieldName: 'tag',
      field: SampleTagXref.t.tagId,
      foreignField: _i3.Tag.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TagTable(tableRelation: foreignTableRelation),
    );
    return _tag!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    sampleId,
    tagId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'sample') {
      return sample;
    }
    if (relationField == 'tag') {
      return tag;
    }
    return null;
  }
}

class SampleTagXrefInclude extends _i1.IncludeObject {
  SampleTagXrefInclude._({
    _i2.SampleInclude? sample,
    _i3.TagInclude? tag,
  }) {
    _sample = sample;
    _tag = tag;
  }

  _i2.SampleInclude? _sample;

  _i3.TagInclude? _tag;

  @override
  Map<String, _i1.Include?> get includes => {
    'sample': _sample,
    'tag': _tag,
  };

  @override
  _i1.Table<int?> get table => SampleTagXref.t;
}

class SampleTagXrefIncludeList extends _i1.IncludeList {
  SampleTagXrefIncludeList._({
    _i1.WhereExpressionBuilder<SampleTagXrefTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SampleTagXref.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SampleTagXref.t;
}

class SampleTagXrefRepository {
  const SampleTagXrefRepository._();

  final attachRow = const SampleTagXrefAttachRowRepository._();

  /// Returns a list of [SampleTagXref]s matching the given query parameters.
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
  Future<List<SampleTagXref>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTagXrefTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTagXrefTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTagXrefTable>? orderByList,
    _i1.Transaction? transaction,
    SampleTagXrefInclude? include,
  }) async {
    return session.db.find<SampleTagXref>(
      where: where?.call(SampleTagXref.t),
      orderBy: orderBy?.call(SampleTagXref.t),
      orderByList: orderByList?.call(SampleTagXref.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SampleTagXref] matching the given query parameters.
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
  Future<SampleTagXref?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTagXrefTable>? where,
    int? offset,
    _i1.OrderByBuilder<SampleTagXrefTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SampleTagXrefTable>? orderByList,
    _i1.Transaction? transaction,
    SampleTagXrefInclude? include,
  }) async {
    return session.db.findFirstRow<SampleTagXref>(
      where: where?.call(SampleTagXref.t),
      orderBy: orderBy?.call(SampleTagXref.t),
      orderByList: orderByList?.call(SampleTagXref.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SampleTagXref] by its [id] or null if no such row exists.
  Future<SampleTagXref?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SampleTagXrefInclude? include,
  }) async {
    return session.db.findById<SampleTagXref>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SampleTagXref]s in the list and returns the inserted rows.
  ///
  /// The returned [SampleTagXref]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SampleTagXref>> insert(
    _i1.Session session,
    List<SampleTagXref> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SampleTagXref>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SampleTagXref] and returns the inserted row.
  ///
  /// The returned [SampleTagXref] will have its `id` field set.
  Future<SampleTagXref> insertRow(
    _i1.Session session,
    SampleTagXref row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SampleTagXref>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SampleTagXref]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SampleTagXref>> update(
    _i1.Session session,
    List<SampleTagXref> rows, {
    _i1.ColumnSelections<SampleTagXrefTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SampleTagXref>(
      rows,
      columns: columns?.call(SampleTagXref.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SampleTagXref]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SampleTagXref> updateRow(
    _i1.Session session,
    SampleTagXref row, {
    _i1.ColumnSelections<SampleTagXrefTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SampleTagXref>(
      row,
      columns: columns?.call(SampleTagXref.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SampleTagXref] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SampleTagXref?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SampleTagXrefUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SampleTagXref>(
      id,
      columnValues: columnValues(SampleTagXref.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SampleTagXref]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SampleTagXref>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SampleTagXrefUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SampleTagXrefTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SampleTagXrefTable>? orderBy,
    _i1.OrderByListBuilder<SampleTagXrefTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SampleTagXref>(
      columnValues: columnValues(SampleTagXref.t.updateTable),
      where: where(SampleTagXref.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SampleTagXref.t),
      orderByList: orderByList?.call(SampleTagXref.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SampleTagXref]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SampleTagXref>> delete(
    _i1.Session session,
    List<SampleTagXref> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SampleTagXref>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SampleTagXref].
  Future<SampleTagXref> deleteRow(
    _i1.Session session,
    SampleTagXref row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SampleTagXref>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SampleTagXref>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SampleTagXrefTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SampleTagXref>(
      where: where(SampleTagXref.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SampleTagXrefTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SampleTagXref>(
      where: where?.call(SampleTagXref.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SampleTagXrefAttachRowRepository {
  const SampleTagXrefAttachRowRepository._();

  /// Creates a relation between the given [SampleTagXref] and [Sample]
  /// by setting the [SampleTagXref]'s foreign key `sampleId` to refer to the [Sample].
  Future<void> sample(
    _i1.Session session,
    SampleTagXref sampleTagXref,
    _i2.Sample sample, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.id == null) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }
    if (sample.id == null) {
      throw ArgumentError.notNull('sample.id');
    }

    var $sampleTagXref = sampleTagXref.copyWith(sampleId: sample.id);
    await session.db.updateRow<SampleTagXref>(
      $sampleTagXref,
      columns: [SampleTagXref.t.sampleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SampleTagXref] and [Tag]
  /// by setting the [SampleTagXref]'s foreign key `tagId` to refer to the [Tag].
  Future<void> tag(
    _i1.Session session,
    SampleTagXref sampleTagXref,
    _i3.Tag tag, {
    _i1.Transaction? transaction,
  }) async {
    if (sampleTagXref.id == null) {
      throw ArgumentError.notNull('sampleTagXref.id');
    }
    if (tag.id == null) {
      throw ArgumentError.notNull('tag.id');
    }

    var $sampleTagXref = sampleTagXref.copyWith(tagId: tag.id);
    await session.db.updateRow<SampleTagXref>(
      $sampleTagXref,
      columns: [SampleTagXref.t.tagId],
      transaction: transaction,
    );
  }
}
