import 'package:devals_sandbox/sandbox.dart'
    show SandboxException, SandboxTimeoutException;
import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';

/// A graduated scorer that combines multiple code-quality checks into
/// a single [Score.partial] value.
///
/// Runs three checks and weights them:
/// 1. **Static analysis** (weight 0.4): `dart analyze --fatal-warnings`
/// 2. **Tests** (weight 0.4): `dart test` or `flutter test`
/// 3. **Efficiency** (weight 0.2): step count from `EvalState.store['steps']`
///
/// Returns `Score.partial(weighted_sum)` with a detailed breakdown.
///
/// ```dart
/// CodeQualityEvaluator(
///   testCmd: ['flutter', 'test', '--reporter', 'compact'],
///   maxExpectedSteps: 10,
/// )
/// ```
class CodeQualityEvaluator extends Evaluator {
  /// Command to run tests. Defaults to `flutter test`.
  final List<String> testCmd;

  /// Command to run static analysis.
  final List<String> analyzeCmd;

  /// Directory within the sandbox where the app is located.
  final String workingDir;

  /// Maximum steps before the efficiency score drops.
  final int maxExpectedSteps;

  /// Time limit for each command.
  final Duration timeout;

  const CodeQualityEvaluator({
    this.testCmd = const ['flutter', 'test', '--reporter', 'compact'],
    this.analyzeCmd = const ['dart', 'analyze', '--fatal-warnings'],
    this.workingDir = '/workspace/app',
    this.maxExpectedSteps = 15,
    this.timeout = const Duration(minutes: 3),
  });

  /// Convenience constructor for Dart-only projects.
  const CodeQualityEvaluator.dart({
    this.testCmd = const ['dart', 'test', '--reporter', 'compact'],
    this.analyzeCmd = const ['dart', 'analyze', '--fatal-warnings'],
    this.workingDir = '/workspace/app',
    this.maxExpectedSteps = 15,
    this.timeout = const Duration(minutes: 3),
  });

  @override
  Future<Score> evaluate(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      return Score.error(
        explanation: 'No sandbox — cannot run code quality checks.',
      );
    }

    final breakdown = <String>[];
    var weightedSum = 0.0;

    // ── 1. Static analysis (weight: 0.4) ──
    try {
      final analyzeResult = await sandbox.exec(
        analyzeCmd,
        cwd: workingDir,
        timeout: timeout,
      );
      final analyzePassed = analyzeResult.success;
      final analyzeScore = analyzePassed ? 1.0 : 0.0;
      weightedSum += analyzeScore * 0.4;
      breakdown.add(
        'analyze=${analyzePassed ? "pass" : "fail"} '
        '(${(analyzeScore * 0.4).toStringAsFixed(2)})',
      );
    } on SandboxTimeoutException {
      breakdown.add('analyze=timeout (0.00)');
    } on SandboxException catch (e) {
      breakdown.add('analyze=error:$e (0.00)');
    }

    // ── 2. Tests (weight: 0.4) ──
    try {
      final testResult = await sandbox.exec(
        testCmd,
        cwd: workingDir,
        timeout: timeout,
      );
      final testsPassed = testResult.success;
      final testScore = testsPassed ? 1.0 : 0.0;
      weightedSum += testScore * 0.4;
      breakdown.add(
        'tests=${testsPassed ? "pass" : "fail"} '
        '(${(testScore * 0.4).toStringAsFixed(2)})',
      );
    } on SandboxTimeoutException {
      breakdown.add('tests=timeout (0.00)');
    } on SandboxException catch (e) {
      breakdown.add('tests=error:$e (0.00)');
    }

    // ── 3. Efficiency (weight: 0.2) ──
    final steps = (state.store['steps'] as num?)?.toInt() ?? 0;
    final efficiencyScore = steps <= maxExpectedSteps ? 1.0 : 0.5;
    weightedSum += efficiencyScore * 0.2;
    breakdown.add(
      'efficiency=$steps/${maxExpectedSteps}steps '
      '(${(efficiencyScore * 0.2).toStringAsFixed(2)})',
    );

    return Score.partial(
      weightedSum,
      answer: weightedSum >= 0.8 ? 'high quality' : 'needs improvement',
      explanation: breakdown.join(', '),
    );
  }
}
