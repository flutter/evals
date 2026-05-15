import 'package:equatable/equatable.dart';

import 'agent_status.dart';
import 'message.dart';
import 'role.dart';
import 'usage.dart';

/// The result of an [Agent] run.
///
/// Contains the full conversation trajectory, exit status, and usage
/// statistics. Use [toJson] to serialize for trajectory logging and analysis.
class Result extends Equatable {
  /// The complete message history of the agent run.
  ///
  /// Includes the system message, user task, all model responses, and all
  /// tool call/response pairs — in chronological order.
  final List<Message> messages;

  /// Why the agent stopped.
  final AgentStatus status;

  /// Number of generate calls made to the model.
  final int steps;

  /// Accumulated token usage across all generate calls.
  ///
  /// `null` for process-based agents (e.g. CLI agents) that don't have
  /// direct access to token usage information.
  final Usage? usage;

  /// The error message, if [status] is [AgentStatus.error].
  final String? error;

  const Result({
    required this.messages,
    required this.status,
    required this.steps,
    this.usage,
    this.error,
  });

  /// Deserialises a [Result] from a JSON map.
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    messages: (json['messages'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Message.fromJson)
        .toList(),
    status: AgentStatus.fromJson(json['status'] as String),
    steps: json['steps'] as int,
    usage: json['usage'] != null
        ? Usage(
            inputTokens: (json['usage'] as Map<String, dynamic>)['inputTokens'] as int? ?? 0,
            outputTokens: (json['usage'] as Map<String, dynamic>)['outputTokens'] as int? ?? 0,
            totalTokens: (json['usage'] as Map<String, dynamic>)['totalTokens'] as int? ?? 0,
          )
        : null,
    error: json['error'] as String?,
  );

  /// The agent's answer text, resolved in order of preference:
  ///
  /// 1. The last model message that contains text — the natural output for
  ///    CLI agents (GCLI, Claude Code, Antigravity) which always produce a
  ///    final text summary.
  /// 2. The last tool-response message that contains text — handles SDK
  ///    agents whose loop terminates after a tool call without a follow-up
  ///    model summary (e.g. `bash echo "fl_chart"` as the final step).
  ///
  /// Returns `null` only if neither source produced any text.
  String? get outputText {
    // 1. Prefer the last model text response.
    for (final message in messages.reversed) {
      if (message.role == Role.model) {
        final text = message.text;
        if (text != null && text.isNotEmpty) return text;
      }
    }
    // 2. Fall back: last tool response containing text.
    //    Covers the case where the agent answers via a tool call (e.g. a
    //    bash echo) and then stops without producing a follow-up text turn.
    for (final message in messages.reversed) {
      if (message.role == Role.tool) {
        final text = message.text;
        if (text != null && text.isNotEmpty) return text;
      }
    }
    return null;
  }

  /// Serialize to a JSON-compatible map for trajectory export.
  Map<String, dynamic> toJson() => {
    'status': status.toJson(),
    'steps': steps,
    if (usage != null)
      'usage': {
        'inputTokens': usage!.inputTokens,
        'outputTokens': usage!.outputTokens,
        'totalTokens': usage!.totalTokens,
      },
    if (error != null) 'error': error,
    'messages': messages.map((m) => m.toJson()).toList(),
  };

  @override
  List<Object?> get props => [messages, status, steps, usage, error];
}
