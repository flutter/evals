import 'package:ai/agents.dart' as ai;
import 'package:ai/ai.dart' as ai;

import 'agent.dart';

/// Wraps an [ai.Agent] for use in the eval framework.
///
/// This adapter bridges the framework-agnostic [ai.Agent] (from `package:ai`)
/// with the eval-specific [Agent] contract.
///
/// [SdkAgentAdapter] delegates all generation logic to the underlying
/// [ai.Agent] and returns its [ai.Result] directly — no conversion needed.
///
/// This is an internal implementation detail of [GenkitBackend]. Eval
/// authors do not construct this directly.
class SdkAgentAdapter extends Agent {
  /// The underlying framework-agnostic agent.
  final ai.Agent inner;

  const SdkAgentAdapter(this.inner);

  @override
  String get model => inner.model;

  @override
  SdkAgentAdapter copyWith({String? model}) =>
      SdkAgentAdapter(inner.copyWith(model: model));

  @override
  Future<ai.Result> run({
    required String task,
    String systemMessage = '',
    List<ai.Tool> additionalTools = const [],
  }) => inner.run(
    task: task,
    systemMessage: systemMessage,
    additionalTools: additionalTools,
  );
}
