import 'package:ai/ai.dart' show Message;
import 'package:equatable/equatable.dart';

import 'score.dart';

/// The result of running a single [Eval].
///
/// An [EvalResult] captures the full record of one eval execution:
/// the input, model output, conversation history, scores, timing,
/// and any error that occurred.
///
/// This is the per-eval unit of data in an [EvalSetResult].
class EvalResult extends Equatable {
  /// Unique identifier for this result
  /// (e.g. `'add_feature_gemini-flash_baseline'`).
  final String id;

  /// The eval name.
  final String evalName;

  /// The model identifier used for this eval.
  final String model;

  /// The scenario name (or `'default'` if no scenarios were configured).
  final String scenario;

  /// The input prompt sent to the model.
  final String input;

  /// The expected target output (for evaluator grading).
  final String target;

  /// The model's final text output.
  final String output;

  /// Scores from evaluators, keyed by evaluator name.
  final Map<String, Score> scores;

  /// Arbitrary per-eval key-value store (metadata from the eval run).
  ///
  /// Keys beginning with `_` are considered **private/transient** and are
  /// excluded from JSON serialization. Use this convention for data that is
  /// only needed during the eval run (e.g. intermediate state) and should
  /// not persist to disk.
  final Map<String, dynamic> store;

  /// When this eval started.
  final DateTime startedAt;

  /// When this eval completed.
  final DateTime completedAt;

  /// Error message if the eval failed, or `null` on success.
  final String? error;

  /// The full agent conversation trajectory, if available.
  ///
  /// This is `null` for single-turn evals that don't produce a trajectory.
  final List<Message>? trajectory;

  /// The number of steps successfully completed in a multi-step evaluation.
  ///
  /// This is `null` for standard single-step evals.
  final int? stepsCompleted;

  /// Creates an [EvalResult].
  const EvalResult({
    required this.id,
    required this.evalName,
    required this.model,
    required this.scenario,
    required this.input,
    this.target = '',
    required this.output,
    this.scores = const {},
    this.store = const {},
    required this.startedAt,
    required this.completedAt,
    this.error,
    this.trajectory,
    this.stepsCompleted,
  });

  /// Deserialises an [EvalResult] from a JSON map.
  factory EvalResult.fromJson(Map<String, dynamic> json) => EvalResult(
    id: json['id'] as String,
    evalName: json['eval_name'] as String,
    model: json['model'] as String,
    scenario: json['scenario'] as String,
    input: json['input'] as String,
    target: json['target'] as String? ?? '',
    output: json['output'] as String,
    scores: (json['scores'] as Map<String, dynamic>?)?.map(
          (k, v) => MapEntry(k, Score.fromJson(v as Map<String, dynamic>)),
        ) ??
        const {},
    store: json['store'] as Map<String, dynamic>? ?? const {},
    startedAt: DateTime.parse(json['started_at'] as String),
    completedAt: DateTime.parse(json['completed_at'] as String),
    error: json['error'] as String?,
    trajectory: (json['trajectory'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>()
        .map(Message.fromJson)
        .toList(),
    stepsCompleted: json['steps_completed'] as int?,
  );

  /// Total duration of this eval.
  Duration get duration => completedAt.difference(startedAt);

  /// Serialises this result to a JSON-compatible map.
  ///
  /// Keys in [store] that start with `_` are excluded (see [store] docs).
  Map<String, dynamic> toJson() => {
    'id': id,
    'eval_name': evalName,
    'model': model,
    'scenario': scenario,
    'input': input,
    'target': target,
    'output': output,
    'scores': {
      for (final e in scores.entries) e.key: e.value.toJson(),
    },
    'store': {
      for (final e in store.entries)
        if (!e.key.startsWith('_')) e.key: e.value,
    },
    'started_at': startedAt.toIso8601String(),
    'completed_at': completedAt.toIso8601String(),
    if (error != null) 'error': error,
    if (trajectory != null)
      'trajectory': trajectory!.map((m) => m.toJson()).toList(),
    if (stepsCompleted != null) 'steps_completed': stepsCompleted,
  };

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'EvalResult($id, scores: ${scores.length})';
}
