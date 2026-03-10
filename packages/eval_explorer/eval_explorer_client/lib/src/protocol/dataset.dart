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

/// A dataset is an Inspect AI term that refers to a collection of samples.
///
/// In our case, each dataset corresponds to a collection of sample types.
/// (i.e. "dart_qa_dataset", "flutter_code_execution") And each sample type
/// refers to a specific file in the /datasets directory.
abstract class Dataset implements _i1.SerializableModel {
  Dataset._({
    this.id,
    required this.name,
    bool? isActive,
  }) : isActive = isActive ?? true;

  factory Dataset({
    _i1.UuidValue? id,
    required String name,
    bool? isActive,
  }) = _DatasetImpl;

  factory Dataset.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dataset(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      isActive: jsonSerialization['isActive'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String name;

  bool isActive;

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
    };
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
    return Dataset(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }
}
