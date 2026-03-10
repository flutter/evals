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
import 'sample_tag_xref.dart' as _i2;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i3;

/// Category for a sample.
abstract class Tag implements _i1.SerializableModel {
  Tag._({
    this.id,
    required this.name,
    this.samplesXref,
  });

  factory Tag({
    _i1.UuidValue? id,
    required String name,
    List<_i2.SampleTagXref>? samplesXref,
  }) = _TagImpl;

  factory Tag.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tag(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      samplesXref: jsonSerialization['samplesXref'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.SampleTagXref>>(
              jsonSerialization['samplesXref'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  /// Unique identifier for the tag.
  String name;

  /// Samples associated with this tag.
  /// Technically, this relationship only reaches the cross-reference table,
  /// not the samples themselves.
  List<_i2.SampleTagXref>? samplesXref;

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tag copyWith({
    _i1.UuidValue? id,
    String? name,
    List<_i2.SampleTagXref>? samplesXref,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Tag',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      if (samplesXref != null)
        'samplesXref': samplesXref?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TagImpl extends Tag {
  _TagImpl({
    _i1.UuidValue? id,
    required String name,
    List<_i2.SampleTagXref>? samplesXref,
  }) : super._(
         id: id,
         name: name,
         samplesXref: samplesXref,
       );

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tag copyWith({
    Object? id = _Undefined,
    String? name,
    Object? samplesXref = _Undefined,
  }) {
    return Tag(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      samplesXref: samplesXref is List<_i2.SampleTagXref>?
          ? samplesXref
          : this.samplesXref?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
