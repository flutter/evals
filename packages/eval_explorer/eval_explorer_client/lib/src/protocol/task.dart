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
import 'model.dart' as _i2;
import 'dataset.dart' as _i3;
import 'run.dart' as _i4;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i5;

/// Results from evaluating one model against one dataset.
abstract class Task implements _i1.SerializableModel {
  Task._({
    this.id,
    required this.inspectId,
    required this.modelId,
    this.model,
    required this.datasetId,
    this.dataset,
    required this.runId,
    this.run,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Task({
    _i1.UuidValue? id,
    required String inspectId,
    required _i1.UuidValue modelId,
    _i2.Model? model,
    required _i1.UuidValue datasetId,
    _i3.Dataset? dataset,
    required _i1.UuidValue runId,
    _i4.Run? run,
    DateTime? createdAt,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      inspectId: jsonSerialization['inspectId'] as String,
      modelId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['modelId'],
      ),
      model: jsonSerialization['model'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Model>(jsonSerialization['model']),
      datasetId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['datasetId'],
      ),
      dataset: jsonSerialization['dataset'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Dataset>(
              jsonSerialization['dataset'],
            ),
      runId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['runId']),
      run: jsonSerialization['run'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Run>(jsonSerialization['run']),
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

  _i1.UuidValue modelId;

  /// Model identifier (e.g., "google/gemini-2.5-pro").
  _i2.Model? model;

  _i1.UuidValue datasetId;

  /// Dataset identifier (e.g., "flutter_qa_dataset").
  _i3.Dataset? dataset;

  _i1.UuidValue runId;

  /// Run this task belongs to.
  _i4.Run? run;

  /// When this task was evaluated.
  DateTime createdAt;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    _i1.UuidValue? id,
    String? inspectId,
    _i1.UuidValue? modelId,
    _i2.Model? model,
    _i1.UuidValue? datasetId,
    _i3.Dataset? dataset,
    _i1.UuidValue? runId,
    _i4.Run? run,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id?.toJson(),
      'inspectId': inspectId,
      'modelId': modelId.toJson(),
      if (model != null) 'model': model?.toJson(),
      'datasetId': datasetId.toJson(),
      if (dataset != null) 'dataset': dataset?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    _i1.UuidValue? id,
    required String inspectId,
    required _i1.UuidValue modelId,
    _i2.Model? model,
    required _i1.UuidValue datasetId,
    _i3.Dataset? dataset,
    required _i1.UuidValue runId,
    _i4.Run? run,
    DateTime? createdAt,
  }) : super._(
         id: id,
         inspectId: inspectId,
         modelId: modelId,
         model: model,
         datasetId: datasetId,
         dataset: dataset,
         runId: runId,
         run: run,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    String? inspectId,
    _i1.UuidValue? modelId,
    Object? model = _Undefined,
    _i1.UuidValue? datasetId,
    Object? dataset = _Undefined,
    _i1.UuidValue? runId,
    Object? run = _Undefined,
    DateTime? createdAt,
  }) {
    return Task(
      id: id is _i1.UuidValue? ? id : this.id,
      inspectId: inspectId ?? this.inspectId,
      modelId: modelId ?? this.modelId,
      model: model is _i2.Model? ? model : this.model?.copyWith(),
      datasetId: datasetId ?? this.datasetId,
      dataset: dataset is _i3.Dataset? ? dataset : this.dataset?.copyWith(),
      runId: runId ?? this.runId,
      run: run is _i4.Run? ? run : this.run?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
