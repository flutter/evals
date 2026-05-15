import 'package:equatable/equatable.dart';

/// Statistics for a single generation call.
class Usage extends Equatable {
  final int inputTokens;
  final int outputTokens;
  final int totalTokens;

  const Usage({
    this.inputTokens = 0,
    this.outputTokens = 0,
    this.totalTokens = 0,
  });

  const Usage.zero() : inputTokens = 0, outputTokens = 0, totalTokens = 0;

  Usage operator +(Usage other) => Usage(
    inputTokens: inputTokens + other.inputTokens,
    outputTokens: outputTokens + other.outputTokens,
    totalTokens: totalTokens + other.totalTokens,
  );

  @override
  List<Object?> get props => [inputTokens, outputTokens, totalTokens];
}
