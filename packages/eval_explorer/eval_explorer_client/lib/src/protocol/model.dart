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

/// An LLM being evaluated.
abstract class Model implements _i1.SerializableModel {
  Model._({
    this.id,
    required this.name,
  });

  factory Model({
    _i1.UuidValue? id,
    required String name,
  }) = _ModelImpl;

  factory Model.fromJson(Map<String, dynamic> jsonSerialization) {
    return Model(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  /// Unique identifier for the model.
  String name;

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
    };
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
    return Model(
      id: id is _i1.UuidValue? ? id : this.id,
      name: name ?? this.name,
    );
  }
}
