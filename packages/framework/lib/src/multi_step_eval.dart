import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';

import 'eval.dart';
import 'eval_context.dart';
import 'eval_state.dart';
import 'evaluator.dart';
import 'logging/eval_log.dart';
import 'tools/sandbox_tools.dart';

/// Strategy for aggregating step scores in a [MultiStepEval].
enum ScoreAggregation {
  /// The mean (average) of all step scores.
  mean,

  /// The score from the last completed step.
  last,

  /// A custom weighted mean or other advanced strategy (placeholder for future).
  weightedMean,
}

/// A single step in a [MultiStepEval].
class EvalStep {
  /// The name of this step.
  ///
  /// This is used as a prefix for evaluator scores (e.g., `scaffold_exec_evaluator`).
  final String name;

  /// The input prompt for this step.
  final String input;

  /// An optional system message for this step.
  ///
  /// If provided, this is appended to the cumulative message history before
  /// the step's [input]. Note that the [MultiStepEval] may also have a
  /// base system message that applies globally.
  final String systemMessage;

  /// Evaluators to run against the state after this step completes.
  final List<Evaluator> evaluators;

  /// The minimum average score required to proceed to the next step.
  ///
  /// If the aggregated step score falls below this value, the evaluation
  /// stops early and skips remaining steps.
  final double? minScore;

  /// An optional setup callback run before this step begins.
  ///
  /// Use this to mutate the sandbox environment or prepare state.
  final Future<EvalState> Function(EvalState state)? setUp;

  const EvalStep({
    required this.name,
    required this.input,
    this.systemMessage = '',
    this.evaluators = const [],
    this.minScore,
    this.setUp,
  });
}

/// A multi-step evaluation where each step builds on the previous one.
///
/// Unlike a standard [Eval], a `MultiStepEval` preserves the environment
/// (sandbox) and conversation history across multiple [steps]. Each step
/// can be evaluated independently, and you can specify a `minScore` to stop
/// early if a critical step fails.
abstract class MultiStepEval extends Eval {
  const MultiStepEval();

  /// The sequential steps that make up this evaluation.
  List<EvalStep> get steps;

  /// How to aggregate per-step scores into the final evaluation score.
  ScoreAggregation get aggregation => ScoreAggregation.mean;

  /// The base system message applied at the very beginning of the evaluation.
  @override
  String get systemMessage => '';

  /// The input for the overall evaluation.
  ///
  /// In a `MultiStepEval`, the input is driven by the individual [steps]. This
  /// property is only used for logging/reporting the top-level task description.
  @override
  String get input => 'Multi-step evaluation: $name';

  @override
  Future<EvalResult> execute(EvalContext context) async {
    var state = EvalState(context: context);

    // Merge global tools: eval-level + scenario-level + MCP + sandbox
    state.tools = <ai.Tool>{
      ...tools,
      ...context.scenario.tools,
      ...context.mcpTools,
      if (context.sandbox != null) ...SandboxTools.all(context.sandbox!),
    }.toList();

    if (systemMessage.isNotEmpty) {
      state.messages.add(
        ai.Message(role: ai.Role.system, content: [ai.TextPart(systemMessage)]),
      );
    }

    var scores = <String, Score>{};
    String? failedPhase;
    int stepsCompleted = 0;

    try {
      EvalLog.evalPhase('  setUp');
      failedPhase = 'setUp';
      state = await setUp(state);

      for (final step in steps) {
        failedPhase = 'step: ${step.name}';
        EvalLog.evalPhase('  $failedPhase');

        if (step.setUp != null) {
          state = await step.setUp!(state);
        }

        // Run the agent.
        // The MultiStepEval relies on the agent implementation to accept the
        // cumulative `history` to maintain conversation state.
        state.output = await state.agent.run(
          task: step.input,
          systemMessage: step.systemMessage,
          additionalTools: state.tools,
          history: List.from(state.messages),
        );

        // Update the state history with what the agent actually saw/produced.
        // If the agent provides a trajectory (e.g. MiniSweAgent), we append it.
        // Otherwise, we manually reconstruct the interaction.
        if (state.output?.messages.isNotEmpty == true) {
          // Replace state.messages with the full trajectory since the agent
          // prepended the history internally.
          state.messages.clear();
          state.messages.addAll(state.output!.messages);
        } else {
          // Fallback if the agent doesn't return full trajectory.
          if (step.systemMessage.isNotEmpty) {
            state.messages.add(
              ai.Message(role: ai.Role.system, content: [ai.TextPart(step.systemMessage)]),
            );
          }
          state.messages.add(
            ai.Message(role: ai.Role.user, content: [ai.TextPart(step.input)]),
          );
        }

        // Store step input/target so evaluators can access them
        state.store['input'] = step.input;
        state.store['target'] = target; // Inherited target, or could be per-step.

        // Score the step using step-specific and scenario evaluators.
        final stepEvaluators = [...step.evaluators, ...context.scenario.evaluators];
        final stepScores = <Score>[];

        for (final evaluator in stepEvaluators) {
          final score = await evaluator.evaluate(state);
          final key = '${step.name}_${evaluator.name}';
          
          if (scores.containsKey(key)) {
            throw ArgumentError(
              'Duplicate evaluator name "${evaluator.name}" in step "${step.name}".',
            );
          }
          scores[key] = score;
          stepScores.add(score);
        }

        stepsCompleted++;

        // Check early stopping threshold
        if (step.minScore != null && stepScores.isNotEmpty) {
          final validScores = stepScores.where((s) => !s.isError);
          if (validScores.isNotEmpty) {
            final avg = validScores.map((s) => s.value).reduce((a, b) => a + b) / validScores.length;
            if (avg < step.minScore!) {
              EvalLog.debug(
                'WARNING: Step "${step.name}" score ($avg) below minimum (${step.minScore}). Stopping early.',
              );
              break;
            }
          }
        }
      }

      failedPhase = null; // Success!
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

    final trajectory = state.output?.messages ?? state.messages;

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
      stepsCompleted: stepsCompleted,
    );
  }
}
