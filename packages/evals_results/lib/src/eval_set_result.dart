import 'package:equatable/equatable.dart';

import 'eval_result.dart';
import 'evaluator_summary.dart';
import 'run_status.dart';

/// The complete log of an eval run.
///
/// An [EvalSetResult] contains all [EvalResult]s produced by a single
/// [EvalSet.run()] invocation, along with aggregate [EvaluatorSummary]
/// data and run-level metadata.
class EvalSetResult extends Equatable {
  /// Run status.
  final RunStatus status;

  /// Display name for this run (typically the eval names joined).
  final String name;

  /// Unique identifier for this run.
  final String runId;

  /// Model identifiers used in this run.
  final List<String> models;

  /// Names of evaluators used in this run.
  final List<String> evaluators;

  /// Individual eval results.
  final List<EvalResult> results;

  /// Aggregate evaluator summaries across all results.
  final List<EvaluatorSummary> summaries;

  /// When the run started.
  final DateTime startedAt;

  /// When the run completed.
  final DateTime completedAt;

  /// Creates an [EvalSetResult].
  const EvalSetResult({
    this.status = RunStatus.success,
    required this.name,
    required this.runId,
    this.models = const [],
    this.evaluators = const [],
    this.results = const [],
    this.summaries = const [],
    required this.startedAt,
    required this.completedAt,
  });

  /// Deserialises an [EvalSetResult] from a JSON map.
  factory EvalSetResult.fromJson(Map<String, dynamic> json) => EvalSetResult(
    status: RunStatus.fromJson(json['status'] as String),
    name: json['name'] as String,
    runId: json['run_id'] as String,
    models: (json['models'] as List<dynamic>?)?.cast<String>() ?? const [],
    evaluators:
        (json['evaluators'] as List<dynamic>?)?.cast<String>() ?? const [],
    results: (json['results'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map(EvalResult.fromJson)
            .toList() ??
        const [],
    summaries: (json['summaries'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map(EvaluatorSummary.fromJson)
            .toList() ??
        const [],
    startedAt: DateTime.parse(json['started_at'] as String),
    completedAt: DateTime.parse(json['completed_at'] as String),
  );

  /// Total duration of the run.
  Duration get duration => completedAt.difference(startedAt);

  /// Total number of eval results.
  int get totalResults => results.length;

  /// Serialises this log to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'status': status.toJson(),
    'name': name,
    'run_id': runId,
    'models': models,
    'evaluators': evaluators,
    'results': results.map((r) => r.toJson()).toList(),
    'summaries': summaries.map((s) => s.toJson()).toList(),
    'started_at': startedAt.toIso8601String(),
    'completed_at': completedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [runId];

  @override
  String toString() => 'EvalSetResult($name, results: ${results.length})';
}
