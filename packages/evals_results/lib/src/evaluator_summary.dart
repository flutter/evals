import 'package:equatable/equatable.dart';

/// Aggregate result for one evaluator across all evals in a run.
///
/// An [EvaluatorSummary] summarises how a single evaluator performed
/// across the entire run — including counts and computed metrics.
class EvaluatorSummary extends Equatable {
  /// Evaluator name.
  final String name;

  /// Number of evals scored by this evaluator.
  final int scored;

  /// Computed metrics (e.g. mean score).
  final List<EvaluatorMetric> metrics;

  /// Creates an [EvaluatorSummary].
  const EvaluatorSummary({
    required this.name,
    required this.scored,
    this.metrics = const [],
  });

  /// Deserialises an [EvaluatorSummary] from a JSON map.
  factory EvaluatorSummary.fromJson(Map<String, dynamic> json) =>
      EvaluatorSummary(
        name: json['name'] as String,
        scored: json['scored'] as int,
        metrics: (json['metrics'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>()
                .map(EvaluatorMetric.fromJson)
                .toList() ??
            const [],
      );

  /// Serialises this summary to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'name': name,
    'scored': scored,
    'metrics': metrics.map((m) => m.toJson()).toList(),
  };

  @override
  List<Object?> get props => [name, scored, metrics];

  @override
  String toString() => 'EvaluatorSummary($name, scored: $scored)';
}

/// A metric computed by an evaluator across a run.
class EvaluatorMetric extends Equatable {
  /// Metric name (e.g. `'mean'`).
  final String name;

  /// Metric value.
  final double value;

  /// Creates an [EvaluatorMetric].
  const EvaluatorMetric({
    required this.name,
    required this.value,
  });

  /// Deserialises an [EvaluatorMetric] from a JSON map.
  factory EvaluatorMetric.fromJson(Map<String, dynamic> json) =>
      EvaluatorMetric(
        name: json['name'] as String,
        value: (json['value'] as num).toDouble(),
      );

  /// Serialises this metric to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
  };

  @override
  List<Object?> get props => [name, value];

  @override
  String toString() => 'EvaluatorMetric($name: $value)';
}
