import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';

import '../eval_state.dart';
import '../evaluator.dart';

/// Grades an eval by verifying that the model called specific MCP tools.
///
/// Inspects the conversation trajectory for tool-call messages and checks
/// that every tool in [requiredTools] was invoked.
///
/// Tool names in [requiredTools] may be specified as either:
/// - The fully-qualified `'{serverName}/{toolName}'` form (e.g.
///   `'dart/pub_dev_search'`), which is informative about the tool's origin.
/// - The local `'{toolName}'` form (e.g. `'pub_dev_search'`).
///
/// Matching is done by **suffix**: `'dart/pub_dev_search'` matches a
/// trajectory tool call of either `'dart/pub_dev_search'` or
/// `'pub_dev_search'`. This handles the fact that Genkit strips the server
/// prefix when presenting tools to the Google AI API, so the model-generated
/// tool call name is always the un-prefixed local name.
///
/// Returns [Score.correct] if all required tools were called,
/// [Score.incorrect] with an explanation listing missing tools otherwise.
///
/// ```dart
/// McpToolUsageEvaluator(
///   requiredTools: ['dart/pub_dev_search'],
/// )
/// ```
class McpToolUsageEvaluator extends Evaluator {
  /// MCP tool names that MUST appear in the conversation trajectory.
  ///
  /// Supports both fully-qualified (`'dart/pub_dev_search'`) and local
  /// (`'pub_dev_search'`) names. Matching is by suffix — see class docs.
  ///
  /// If empty, any tool call with a `'/'` in its name counts as a pass.
  final List<String> requiredTools;

  const McpToolUsageEvaluator({this.requiredTools = const []});

  @override
  Future<Score> evaluate(EvalState state) async {
    final allToolsCalled = <String>[];

    // Scan messages on state for tool-call parts.
    for (final message in state.messages) {
      if (message.role != ai.Role.model) continue;
      _extractToolCalls(message, allToolsCalled);
    }

    // Also check the output Result messages if available.
    if (state.output != null) {
      for (final message in state.output!.messages) {
        if (message.role != ai.Role.model) continue;
        _extractToolCalls(message, allToolsCalled);
      }
    }

    // Check required tools using suffix matching.
    if (requiredTools.isNotEmpty) {
      final missing =
          requiredTools
              .where(
                (required) =>
                    !allToolsCalled.any((called) => _matches(required, called)),
              )
              .toList();

      final used =
          requiredTools
              .where(
                (required) =>
                    allToolsCalled.any((called) => _matches(required, called)),
              )
              .toList();

      if (missing.isNotEmpty) {
        return Score.incorrect(
          answer: used.isEmpty ? 'none' : used.join(', '),
          explanation:
              'Required MCP tool(s) NOT used: $missing. '
              'MCP tools called: ${used.isEmpty ? 'none' : used}. '
              'All tools called: ${allToolsCalled.isEmpty ? 'none' : allToolsCalled}',
        );
      }

      return Score.correct(
        answer: used.join(', '),
        explanation: 'MCP tool(s) were used: $used',
      );
    }

    // General check — was any tool with a '/' in its name used?
    // This heuristic applies when requiredTools is empty. When server
    // prefixes are stripped (the normal path), prefer using requiredTools.
    final mcpToolsUsed =
        allToolsCalled.where((t) => t.contains('/')).toList();

    return mcpToolsUsed.isNotEmpty
        ? Score.correct(
            answer: mcpToolsUsed.join(', '),
            explanation: 'MCP tool(s) were used: $mcpToolsUsed',
          )
        : Score.incorrect(
            answer: 'none',
            explanation:
                'No MCP tool was used. '
                'All tools called: ${allToolsCalled.isEmpty ? 'none' : allToolsCalled}',
          );
  }

  /// Returns `true` if [called] (the name from the trajectory) satisfies
  /// [required] (the name from [requiredTools]).
  ///
  /// Handles both exact matches and the case where [required] is a
  /// fully-qualified `server/tool` name while [called] is just `tool`
  /// (because Genkit strips the server prefix when presenting to the model).
  bool _matches(String required, String called) {
    if (required == called) return true;
    // 'dart/pub_dev_search' should match 'pub_dev_search'.
    if (required.contains('/')) {
      return required.split('/').last == called;
    }
    // 'pub_dev_search' should match 'dart/pub_dev_search'.
    if (called.contains('/')) {
      return called.split('/').last == required;
    }
    return false;
  }

  /// Extracts all tool-call names from a model [message] into [allToolsCalled].
  void _extractToolCalls(ai.Message message, List<String> allToolsCalled) {
    for (final part in message.content) {
      if (part case ai.ToolRequestPart(:final name)) {
        allToolsCalled.add(name);
      }
    }
  }
}
