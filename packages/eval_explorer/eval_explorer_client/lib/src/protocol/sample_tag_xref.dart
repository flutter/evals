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
import 'sample.dart' as _i2;
import 'tag.dart' as _i3;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i4;

/// Cross reference table for samples and tags.
abstract class SampleTagXref implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue sampleId;

  _i2.Sample? sample;

  _i1.UuidValue tagId;

  _i3.Tag? tag;

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
