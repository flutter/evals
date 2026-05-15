import 'package:equatable/equatable.dart';

/// Score for evaluation.
///
/// Produced by an [Evaluator] for a single eval. Conventions:
/// - `1.0` → correct
/// - `0.0` → incorrect
/// - Values in between → partial credit
/// - [isError] `true` → the eval failed to complete (not a real score)
class Score extends Equatable {
  /// Numeric score value.
  final double value;

  /// Whether the eval failed to complete.
  ///
  /// When `true`, [value] is `0.0` and should not be treated as a real
  /// score — it indicates a failure rather than an incorrect answer.
  final bool isError;

  /// Model's answer (for logging).
  final String? answer;

  /// Why this score was given.
  final String? explanation;

  /// Additional metadata.
  final Map<String, dynamic>? metadata;

  /// Creates a score.
  const Score({
    required this.value,
    this.isError = false,
    this.answer,
    this.explanation,
    this.metadata,
  });

  /// A correct score (`1.0`).
  static Score correct({String? answer, String? explanation}) =>
      Score(value: 1.0, answer: answer, explanation: explanation);

  /// An incorrect score (`0.0`).
  static Score incorrect({String? answer, String? explanation}) =>
      Score(value: 0.0, answer: answer, explanation: explanation);

  /// A partial score between `0.0` and `1.0`.
  static Score partial(double value, {String? answer, String? explanation}) =>
      Score(value: value, answer: answer, explanation: explanation);

  /// A score that represents the eval failing to complete.
  ///
  /// Sets [isError] to `true` and [value] to `0.0`.
  static Score error({String? answer, String? explanation}) =>
      Score(value: 0.0, isError: true, answer: answer, explanation: explanation);

  /// Deserialises a [Score] from a JSON map.
  factory Score.fromJson(Map<String, dynamic> json) => Score(
    value: (json['value'] as num).toDouble(),
    isError: json['is_error'] as bool? ?? false,
    answer: json['answer'] as String?,
    explanation: json['explanation'] as String?,
    metadata: json['metadata'] as Map<String, dynamic>?,
  );

  /// Serialises this score to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'value': value,
    if (isError) 'is_error': true,
    if (answer != null) 'answer': answer,
    if (explanation != null) 'explanation': explanation,
    if (metadata != null) 'metadata': metadata,
  };

  @override
  List<Object?> get props => [value, isError, answer, explanation];

  @override
  String toString() => 'Score($value${isError ? ', error' : ''})';
}
