/// Output types and I/O for dart-evals.
///
/// Provides [EvalResult], [EvalSetResult], [Score], and
/// [EvaluatorSummary] — the types that describe what an eval produces,
/// plus readers and writers for JSON/JSONL persistence.
library;

// Types
export 'src/eval_result.dart';
export 'src/eval_set_result.dart';
export 'src/evaluator_summary.dart';
export 'src/run_status.dart';
export 'src/score.dart';

// Aggregation
export 'src/result_builder.dart';

// I/O
export 'src/writers/result_writer.dart';
export 'src/writers/trajectory_writer.dart';
