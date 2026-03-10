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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dataset.dart' as _i2;
import 'sample_tag_xref.dart' as _i3;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i4;

/// A single challenge to be presented to a [Model] and evaluated by one or more [Scorer]s.
abstract class Sample implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
