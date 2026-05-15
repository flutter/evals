import 'package:ai/agents.dart' show Agent;
import 'package:logging/logging.dart';
import 'package:evals_results/evals_results.dart';

import 'eval.dart';
import 'eval_context.dart';
import 'eval_set.dart';
import 'logging/eval_log.dart';
import 'scenario.dart';
import 'util/filesystem_util.dart';

// Re-export so callers can use `baselineScenario` from a single import.
export 'scenario.dart' show baselineScenario;

// ---------------------------------------------------------------------------
// runEvals — lifecycle + logging wrapper over EvalSet
// ---------------------------------------------------------------------------

/// Entrypoint for the eval framework.
///
/// Manages the full lifecycle:
/// 1. Initialises structured logging at [logLevel].
/// 2. Creates the run directory early so the log file starts immediately.
/// 3. Delegates the `models × scenarios × evals` matrix to [EvalSet.run].
/// 4. Builds and returns an [EvalSetResult] from the collected results.
/// 5. Writes the log JSON and run.log to disk.
Future<EvalSetResult> runEvals(
  EvalSet evalSet, {
  Level logLevel = Level.FINER,
  String baseOutputDir = 'eval_logs',
}) async {
  final startedAt = DateTime.now();

  // Create the run directory early so the log file starts immediately.
  final runDirPath = buildRunDirPath(evalSet, startedAt, baseOutputDir);
  EvalLog.init(logLevel, logDir: runDirPath);

  EvalLog.header(
    'pending',
    models: evalSet.models.map((m) => m.toString()).toList(),
    evals: evalSet.evals.map((e) => e.name).toList(),
    scenarios: evalSet.scenarios.map((s) => s.name).toList(),
  );

  try {
    final results = await evalSet.run(
      runDir: runDirPath,
      onResult: (result, allResults) async {
        // Write this cell's trajectory immediately.
        await writeTrajectory(result, runDir: runDirPath);

        // Update the eval.json with all results so far.
        final partialResult = buildEvalSetResult(
          allResults,
          startedAt,
          DateTime.now(),
        );
        await writeEvalLogToDir(partialResult, runDir: runDirPath);
      },
    );

    final completedAt = DateTime.now();

    final evalSetResult = buildEvalSetResult(
      results,
      startedAt,
      completedAt,
    );

    // Final write with the definitive completedAt timestamp.
    await writeEvalLogToDir(evalSetResult, runDir: runDirPath);

    EvalLog.footer(evalSetResult, outputDir: runDirPath);

    return evalSetResult;
  } catch (e, st) {
    EvalLog.error('runEvals failed', e, st);
    rethrow;
  } finally {
    await EvalLog.close();
  }
}

// ---------------------------------------------------------------------------
// runEval — the primitive
// ---------------------------------------------------------------------------

/// Runs a single [eval] against one [agent] / [scenario] combination.
///
/// This is the fundamental unit of the framework. [EvalSet] and [runEvals]
/// are both built on top of this function.
///
/// ```dart
/// final genkit = Genkit(plugins: [googleAI(...)]);
/// final agent = BasicAgent(genkit: genkit, model: 'googleai/gemini-2.5-flash', tools: []);
///
/// final result = await runEval(MyEval(), agent: agent);
/// print(result.scores);
/// ```
Future<EvalResult> runEval(
  Eval eval, {
  required Agent agent,
  Scenario? scenario,
}) async {
  final context = EvalContext(
    agent: agent,
    scenario: scenario ?? baselineScenario,
  );
  return eval.execute(context);
}
