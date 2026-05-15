import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';

/// Grades an eval based on the agent trajectory stored in [EvalState.store].
///
/// Checks that:
/// - The agent completed (not maxStepsReached / error).
/// - Step count is within the expected ceiling.
///
/// Returns a [Score.partial] that reflects both conditions.
class TrajectoryEvaluator extends Evaluator {
  /// Maximum number of agent steps before a penalty is applied.
  final int maxExpectedSteps;

  const TrajectoryEvaluator({this.maxExpectedSteps = 15});

  @override
  Future<Score> evaluate(EvalState state) async {
    final status = state.store['agent_status'] as String?;
    final steps = state.store['steps'] as num? ?? 0;
    final totalTokens = (state.store['total_tokens'] as num?)?.toInt() ?? 0;

    if (status == null) {
      return Score.incorrect(
        explanation: 'No agent_status in store — was the eval run correctly?',
      );
    }

    if (status == 'error') {
      return Score.incorrect(
        explanation: 'Agent errored: ${state.store['agent_error']}',
      );
    }

    // Partial penalty for exceeding the expected step budget.
    final stepScore = steps <= maxExpectedSteps ? 1.0 : 0.5;
    final completedCorrectly = status == 'completed';

    final value = completedCorrectly ? stepScore : 0.5;

    return Score.partial(
      value,
      answer: status,
      explanation:
          'status=$status, steps=$steps, tokens=$totalTokens, '
          'stepScore=$stepScore',
    );
  }
}
