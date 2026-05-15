import 'package:equatable/equatable.dart';

/// Configuration for an [Agent] run.
///
/// Controls guardrails (step limits, timeouts) and output formatting
/// (truncation). All values have sensible defaults for typical eval workloads.
///
/// ```dart
/// final config = AgentConfig(
///   maxSteps: 30,
///   commandTimeout: Duration(seconds: 120),
/// );
/// ```
class AgentConfig extends Equatable {
  /// Maximum number of generate→execute turns before the agent stops.
  ///
  /// Each "step" is one model call that may produce zero or more tool calls.
  /// Set to 0 for unlimited steps (rely on the model stopping naturally).
  final int maxSteps;

  /// Timeout for each individual command execution in the sandbox.
  final Duration commandTimeout;

  /// Maximum characters of command output before truncation.
  ///
  /// Prevents token budget exhaustion from large stdout/stderr dumps.
  final int maxOutputChars;

  const AgentConfig({
    this.maxSteps = 30,
    this.commandTimeout = const Duration(seconds: 60),
    this.maxOutputChars = 50000,
  });

  @override
  List<Object?> get props => [maxSteps, commandTimeout, maxOutputChars];
}
