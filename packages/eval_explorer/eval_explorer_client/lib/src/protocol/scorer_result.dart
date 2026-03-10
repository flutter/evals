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
import 'scorer.dart' as _i2;
import 'evaluation.dart' as _i3;
import 'package:eval_explorer_shared/eval_explorer_shared.dart' as _i4;
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i5;

/// A scorer's assessment of a task.
abstract class ScorerResult implements _i1.SerializableModel {
  ScorerResult._({
    this.id,
    required this.scorerId,
    this.scorer,
    required this.evaluationId,
    this.evaluation,
    required this.data,
  });

  factory ScorerResult({
    _i1.UuidValue? id,
    required _i1.UuidValue scorerId,
    _i2.Scorer? scorer,
    required _i1.UuidValue evaluationId,
    _i3.Evaluation? evaluation,
    required _i4.ScorerResultData data,
  }) = _ScorerResultImpl;

  factory ScorerResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScorerResult(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      scorerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['scorerId'],
      ),
      scorer: jsonSerialization['scorer'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Scorer>(jsonSerialization['scorer']),
      evaluationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['evaluationId'],
      ),
      evaluation: jsonSerialization['evaluation'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Evaluation>(
              jsonSerialization['evaluation'],
            ),
      data: _i4.ScorerResultData.fromJson(jsonSerialization['data']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue scorerId;

  /// Scorer this summary belongs to.
  _i2.Scorer? scorer;

  _i1.UuidValue evaluationId;

  /// Whether this scorer data is for a baseline run.
  _i3.Evaluation? evaluation;

  /// Flexible data archived by the scorer.
  _i4.ScorerResultData data;

  /// Returns a shallow copy of this [ScorerResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScorerResult copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? scorerId,
    _i2.Scorer? scorer,
    _i1.UuidValue? evaluationId,
    _i3.Evaluation? evaluation,
    _i4.ScorerResultData? data,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScorerResult',
      if (id != null) 'id': id?.toJson(),
      'scorerId': scorerId.toJson(),
      if (scorer != null) 'scorer': scorer?.toJson(),
      'evaluationId': evaluationId.toJson(),
      if (evaluation != null) 'evaluation': evaluation?.toJson(),
      'data': data.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScorerResultImpl extends ScorerResult {
  _ScorerResultImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue scorerId,
    _i2.Scorer? scorer,
    required _i1.UuidValue evaluationId,
    _i3.Evaluation? evaluation,
    required _i4.ScorerResultData data,
  }) : super._(
         id: id,
         scorerId: scorerId,
         scorer: scorer,
         evaluationId: evaluationId,
         evaluation: evaluation,
         data: data,
       );

  /// Returns a shallow copy of this [ScorerResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScorerResult copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? scorerId,
    Object? scorer = _Undefined,
    _i1.UuidValue? evaluationId,
    Object? evaluation = _Undefined,
    _i4.ScorerResultData? data,
  }) {
    return ScorerResult(
      id: id is _i1.UuidValue? ? id : this.id,
      scorerId: scorerId ?? this.scorerId,
      scorer: scorer is _i2.Scorer? ? scorer : this.scorer?.copyWith(),
      evaluationId: evaluationId ?? this.evaluationId,
      evaluation: evaluation is _i3.Evaluation?
          ? evaluation
          : this.evaluation?.copyWith(),
      data: data ?? this.data.copyWith(),
    );
  }
}
