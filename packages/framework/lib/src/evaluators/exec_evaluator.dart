import 'package:devals_sandbox/sandbox.dart'
    show SandboxException, SandboxTimeoutException;
import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';

/// Grades an eval by running a script in the sandbox, i.e. `dart test`
///
/// Returns [Score.correct] if the exit code is 0, else [Score.incorrect].
/// The explanation includes the test output for debugging.
class ExecEvaluator extends Evaluator {
  /// Directory within the sandbox where the app is located.
  final String workingDir;

  /// Time limit for running tests.
  final Duration timeout;

  final List<String> cmd;

  const ExecEvaluator(
    this.cmd, {
    this.workingDir = '/workspace/app',
    this.timeout = const Duration(minutes: 3),
  });

  static ExecEvaluator flutterTest() {
    return ExecEvaluator(['flutter', 'test', '--reporter', 'compact']);
  }

  static ExecEvaluator dartTest() {
    return ExecEvaluator(['dart', 'test', '--reporter', 'compact']);
  }

  static ExecEvaluator dartAnalyze() {
    return ExecEvaluator(['dart', 'analyze', '--fatal-warnings']);
  }

  @override
  Future<Score> evaluate(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      return Score.incorrect(explanation: 'No sandbox environment available.');
    }

    try {
      final result = await sandbox.exec(cmd, cwd: workingDir, timeout: timeout);

      final explanation = [
        if (result.stdout.isNotEmpty) result.stdout,
        if (result.stderr.isNotEmpty) result.stderr,
      ].join('\n').trim();

      return result.success
          ? Score.correct(
              answer: 'exit 0',
              explanation: explanation.isEmpty ? 'Exit code 0' : explanation,
            )
          : Score.incorrect(
              answer: 'exit ${result.exitCode}',
              explanation: explanation.isEmpty
                  ? 'Exit code ${result.exitCode}'
                  : explanation,
            );
    } on SandboxTimeoutException catch (e) {
      return Score.error(explanation: 'Evaluator timed out: $e');
    } on SandboxException catch (e) {
      return Score.error(explanation: 'Sandbox error during scoring: $e');
    }
  }
}
