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
import 'run.dart' as _i2;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i3;

/// Metadata for the outcomes of a given [Run]. This is a separate table from [Run] because
/// otherwise each of these columns would have to be nullable on [Run], as they are generated
/// after the run is completed.
abstract class RunSummary implements _i1.SerializableModel {
  RunSummary._({
    this.id,
    required this.runId,
    this.run,
    required this.totalTasks,
    required this.totalSamples,
    required this.avgAccuracy,
    required this.totalTokens,
    required this.inputTokens,
    required this.outputTokens,
    required this.reasoningTokens,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RunSummary({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required int totalTasks,
    required int totalSamples,
    required double avgAccuracy,
    required int totalTokens,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) = _RunSummaryImpl;

  factory RunSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return RunSummary(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      runId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['runId']),
      run: jsonSerialization['run'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Run>(jsonSerialization['run']),
      totalTasks: jsonSerialization['totalTasks'] as int,
      totalSamples: jsonSerialization['totalSamples'] as int,
      avgAccuracy: (jsonSerialization['avgAccuracy'] as num).toDouble(),
      totalTokens: jsonSerialization['totalTokens'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      reasoningTokens: jsonSerialization['reasoningTokens'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue runId;

  /// Run this summary belongs to.
  _i2.Run? run;

  /// Number of tasks in this run.
  int totalTasks;

  /// Total number of samples evaluated.
  int totalSamples;

  /// Average accuracy across all tasks (0.0 to 1.0).
  double avgAccuracy;

  /// Total token usage.
  int totalTokens;

  /// Input tokens used.
  int inputTokens;

  /// Output tokens generated.
  int outputTokens;

  /// Reasoning tokens used (for models that support it).
  int reasoningTokens;

  /// Creation time for this record.
  DateTime createdAt;

  /// Returns a shallow copy of this [RunSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RunSummary copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? runId,
    _i2.Run? run,
    int? totalTasks,
    int? totalSamples,
    double? avgAccuracy,
    int? totalTokens,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RunSummary',
      if (id != null) 'id': id?.toJson(),
      'runId': runId.toJson(),
      if (run != null) 'run': run?.toJson(),
      'totalTasks': totalTasks,
      'totalSamples': totalSamples,
      'avgAccuracy': avgAccuracy,
      'totalTokens': totalTokens,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'reasoningTokens': reasoningTokens,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RunSummaryImpl extends RunSummary {
  _RunSummaryImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue runId,
    _i2.Run? run,
    required int totalTasks,
    required int totalSamples,
    required double avgAccuracy,
    required int totalTokens,
    required int inputTokens,
    required int outputTokens,
    required int reasoningTokens,
    DateTime? createdAt,
  }) : super._(
         id: id,
         runId: runId,
         run: run,
         totalTasks: totalTasks,
         totalSamples: totalSamples,
         avgAccuracy: avgAccuracy,
         totalTokens: totalTokens,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         reasoningTokens: reasoningTokens,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RunSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RunSummary copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? runId,
    Object? run = _Undefined,
    int? totalTasks,
    int? totalSamples,
    double? avgAccuracy,
    int? totalTokens,
    int? inputTokens,
    int? outputTokens,
    int? reasoningTokens,
    DateTime? createdAt,
  }) {
    return RunSummary(
      id: id is _i1.UuidValue? ? id : this.id,
      runId: runId ?? this.runId,
      run: run is _i2.Run? ? run : this.run?.copyWith(),
      totalTasks: totalTasks ?? this.totalTasks,
      totalSamples: totalSamples ?? this.totalSamples,
      avgAccuracy: avgAccuracy ?? this.avgAccuracy,
      totalTokens: totalTokens ?? this.totalTokens,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
