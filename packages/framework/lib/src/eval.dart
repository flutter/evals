import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';

import 'eval_context.dart';
import 'eval_state.dart';
import 'evaluator.dart';
import 'logging/eval_log.dart';
import 'tools/sandbox_tools.dart';

/// A single evaluation sample.
///
/// Each [Eval] is one input → one run → one set of scores. The eval author
/// subclasses [Eval], provides the [input] and [systemMessage], and overrides
/// [run] to implement the evaluation logic using the pre-built [EvalState].
///
/// ## How tools work
///
/// All tools are resolved **before** [run] is called:
/// - [tools] — eval-level static tools
/// - [Scenario.tools] — scenario-level static tools
/// - [Scenario.mcpServers] — MCP server tools (started/stopped by [EvalSet])
/// - Sandbox tools — auto-injected when a sandbox is present
///
/// The merged set is available as [EvalState.tools]. The default [run]
/// implementation passes them to [Agent.run] automatically.
///
/// ## Example: simple single-turn eval (no override needed)
///
/// ```dart
/// class MyEval extends Eval {
///   @override String get name => 'my_eval';
///   @override String get input => 'What is Flutter?';
///   @override List<Evaluator> get evaluators => [MyEvaluator()];
/// }
/// ```
///
/// ## Example: agentic eval with custom metadata
///
/// ```dart
/// class AgenticEval extends Eval {
///   @override String get name => 'agentic_eval';
///   @override String get input => 'Add a reset button to the counter app.';
///
///   @override
///   Future<EvalState> run(EvalState state) async {
///     // state.tools already has sandbox + scenario + eval tools merged
///     final result = await state.agent.run(
///       task: input,
///       systemMessage: systemMessage,
///       additionalTools: state.tools,
///     );
///     state.store['steps'] = result.steps;
///     state.output = result;
///     return state;
///   }
/// }
/// ```
abstract class Eval {
  const Eval();

  /// Name of this eval (used in logs and directory names).
  String get name;

  /// The input prompt — the user message sent to the model.
  String get input;

  /// Expected target output, used by evaluators for grading.
  String get target => '';

  /// System message prepended to the conversation.
  String get systemMessage => '';

  /// Evaluators that grade the result after [run] returns.
  ///
  /// These are merged with [Scenario.evaluators] at scoring time.
  List<Evaluator> get evaluators => const [];

  /// Eval-level tools, merged with scenario tools before [run] is called.
  List<ai.Tool> get tools => const [];

  // ---------------------------------------------------------------------------
  // Framework — do not override unless you know what you're doing.
  // ---------------------------------------------------------------------------

  /// Runs the full eval lifecycle: setUp → run → score → cleanUp.
  ///
  /// The lifecycle is wrapped in try/catch/finally so that:
  /// - `cleanUp()` always runs, even if an earlier phase throws.
  /// - A failing phase is recorded in the result as a `Score.error()`.
  Future<EvalResult> execute(EvalContext context) async {
    var state = EvalState(context: context);

    // ── Resolve ALL tools ──────────────────────────────────────────
    // Merge eval-level + scenario-level + MCP + sandbox tools.
    state.tools = <ai.Tool>{
      ...tools,
      ...context.scenario.tools,
      ...context.mcpTools,
      if (context.sandbox != null) ...SandboxTools.all(context.sandbox!),
    }.toList();

    state.messages.addAll([
      if (systemMessage.isNotEmpty)
        ai.Message(
          role: ai.Role.system,
          content: [ai.TextPart(systemMessage)],
        ),
      ai.Message(
        role: ai.Role.user,
        content: [ai.TextPart(input)],
      ),
    ]);

    var scores = <String, Score>{};
    String? failedPhase;

    try {
      EvalLog.evalPhase('  setUp');
      failedPhase = 'setUp';
      state = await setUp(state);

      EvalLog.evalPhase('  run');
      failedPhase = 'run';
      state = await run(state);

      EvalLog.evalPhase('  score');
      failedPhase = 'score';
      // Store input/target so evaluators (e.g. ModelGradedEvaluator) can
      // access them without needing a reference back to the Eval.
      state.store['input'] = input;
      state.store['target'] = target;
      scores = await score(state);
      failedPhase = null; // Success — clear the marker.
    } catch (e, st) {
      EvalLog.error('Eval "$name" failed during $failedPhase', e, st);
      scores['_lifecycle'] = Score.error(
        explanation: 'Failed during $failedPhase: $e',
      );
    } finally {
      try {
        EvalLog.evalPhase('cleanUp');
        state = await cleanUp(state);
      } catch (e, st) {
        EvalLog.error('cleanUp failed for "$name"', e, st);
      }
    }

    // Auto-capture the agent trajectory (if an agent was used).
    final trajectory = state.output?.messages;

    return EvalResult(
      id: '${name}_${context.agent.model}_${context.scenario.name}',
      evalName: name,
      model: context.agent.model,
      scenario: context.scenario.name,
      input: input,
      target: target,
      output: state.outputText ?? '',
      scores: scores,
      store: {
        ...state.store,
        if (state.output != null) ...{
          'agent_status': state.output!.status.name,
          if (state.output!.error != null) 'agent_error': state.output!.error,
        },
      },
      startedAt: state.startedAt,
      completedAt: DateTime.now(),
      error: failedPhase != null ? 'Failed during $failedPhase' : null,
      trajectory: trajectory,
    );
  }

  // ---------------------------------------------------------------------------
  // Execution lifecycle — override these.
  // ---------------------------------------------------------------------------

  /// Called first. Optional — use to set up environment state.
  Future<EvalState> setUp(EvalState state) async => state;

  /// The core eval logic.
  ///
  /// The default implementation calls [Agent.run] with [input],
  /// [systemMessage], and all resolved [EvalState.tools]. Override this
  /// only if you need custom logic (e.g. storing extra metadata).
  Future<EvalState> run(EvalState state) async {
    state.output = await state.agent.run(
      task: input,
      systemMessage: systemMessage,
      additionalTools: state.tools,
    );
    return state;
  }

  /// Runs all evaluators — both eval-level and scenario-level — against
  /// the post-run state.
  ///
  /// Throws [ArgumentError] if two evaluators share the same [Evaluator.name],
  /// which would cause one score to silently overwrite the other.
  Future<Map<String, Score>> score(EvalState state) async {
    final allEvaluators = [
      ...evaluators,
      ...state.context.scenario.evaluators,
    ];

    // Detect duplicate evaluator names before running any of them.
    final seen = <String>{};
    for (final evaluator in allEvaluators) {
      if (!seen.add(evaluator.name)) {
        throw ArgumentError(
          'Duplicate evaluator name "${evaluator.name}" in eval "$name". '
          'Both eval-level and scenario-level evaluators define this name. '
          'Override Evaluator.name on one instance to disambiguate.',
        );
      }
    }

    final scores = <String, Score>{};
    for (final evaluator in allEvaluators) {
      try {
        scores[evaluator.name] = await evaluator.evaluate(state);
      } catch (e, st) {
        EvalLog.error('Evaluator ${evaluator.name} failed', e, st);
        scores[evaluator.name] = Score.error(
          explanation: 'Evaluator threw: $e',
        );
      }
    }
    return scores;
  }

  /// Called last. Optional — use to tear down sandbox sessions, etc.
  Future<EvalState> cleanUp(EvalState state) async => state;

  @override
  String toString() => 'Eval($name)';
}
