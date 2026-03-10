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
import 'status_enum.dart' as _i2;
import 'model.dart' as _i3;
import 'dataset.dart' as _i4;
import 'task.dart' as _i5;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i6;

/// A collection of tasks executed together.
abstract class Run implements _i1.SerializableModel {
  Run._({
    this.id,
    required this.inspectId,
    required this.status,
    required this.variants,
    required this.mcpServerVersion,
    required this.batchRuntimeSeconds,
    this.models,
    this.datasets,
    this.tasks,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Run({
    _i1.UuidValue? id,
    required String inspectId,
    required _i2.Status status,
    required List<String> variants,
    required String mcpServerVersion,
    required int batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  }) = _RunImpl;

  factory Run.fromJson(Map<String, dynamic> jsonSerialization) {
    return Run(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      inspectId: jsonSerialization['inspectId'] as String,
      status: _i2.Status.fromJson((jsonSerialization['status'] as String)),
      variants: _i6.Protocol().deserialize<List<String>>(
        jsonSerialization['variants'],
      ),
      mcpServerVersion: jsonSerialization['mcpServerVersion'] as String,
      batchRuntimeSeconds: jsonSerialization['batchRuntimeSeconds'] as int,
      models: jsonSerialization['models'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i3.Model>>(
              jsonSerialization['models'],
            ),
      datasets: jsonSerialization['datasets'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i4.Dataset>>(
              jsonSerialization['datasets'],
            ),
      tasks: jsonSerialization['tasks'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.Task>>(
              jsonSerialization['tasks'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  /// InspectAI-generated Id.
  String inspectId;

  /// Run status (e.g., "complete", "inProgress", "failed").
  _i2.Status status;

  /// The variant configurations used in this run.
  List<String> variants;

  /// Version of the MCP server used during evaluation.
  String mcpServerVersion;

  /// Total script runtime in seconds.
  int batchRuntimeSeconds;

  /// List of models evaluated in this run.
  List<_i3.Model>? models;

  /// List of datasets evaluated in this run.
  List<_i4.Dataset>? datasets;

  /// List of Inspect AI task names that were run.
  List<_i5.Task>? tasks;

  /// Creation time for this record.
  DateTime createdAt;

  /// Returns a shallow copy of this [Run]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Run copyWith({
    _i1.UuidValue? id,
    String? inspectId,
    _i2.Status? status,
    List<String>? variants,
    String? mcpServerVersion,
    int? batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Run',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'status': status.toJson(),
      'variants': variants.toJson(),
      'mcpServerVersion': mcpServerVersion,
      'batchRuntimeSeconds': batchRuntimeSeconds,
      if (models != null)
        'models': models?.toJson(valueToJson: (v) => v.toJson()),
      if (datasets != null)
        'datasets': datasets?.toJson(valueToJson: (v) => v.toJson()),
      if (tasks != null) 'tasks': tasks?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RunImpl extends Run {
  _RunImpl({
    _i1.UuidValue? id,
    required String inspectId,
    required _i2.Status status,
    required List<String> variants,
    required String mcpServerVersion,
    required int batchRuntimeSeconds,
    List<_i3.Model>? models,
    List<_i4.Dataset>? datasets,
    List<_i5.Task>? tasks,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectId: inspectId,
         status: status,
         variants: variants,
         mcpServerVersion: mcpServerVersion,
         batchRuntimeSeconds: batchRuntimeSeconds,
         models: models,
         datasets: datasets,
         tasks: tasks,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Run]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Run copyWith({
    Object? id = _Undefined,
    String? inspectId,
    _i2.Status? status,
    List<String>? variants,
    String? mcpServerVersion,
    int? batchRuntimeSeconds,
    Object? models = _Undefined,
    Object? datasets = _Undefined,
    Object? tasks = _Undefined,
    DateTime? createdAt,
  }) {
    return Run(
      id: id is _i1.UuidValue? ? id : this.id,
      inspectId: inspectId ?? this.inspectId,
      status: status ?? this.status,
      variants: variants ?? this.variants.map((e0) => e0).toList(),
      mcpServerVersion: mcpServerVersion ?? this.mcpServerVersion,
      batchRuntimeSeconds: batchRuntimeSeconds ?? this.batchRuntimeSeconds,
      models: models is List<_i3.Model>?
          ? models
          : this.models?.map((e0) => e0.copyWith()).toList(),
      datasets: datasets is List<_i4.Dataset>?
          ? datasets
          : this.datasets?.map((e0) => e0.copyWith()).toList(),
      tasks: tasks is List<_i5.Task>?
          ? tasks
          : this.tasks?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
