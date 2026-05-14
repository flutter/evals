import 'dart:async';
import 'dart:io';

import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';
import 'package:evals_results/evals_results.dart';
import 'package:genkit/genkit.dart' as g;
import 'package:genkit/plugin.dart' show GenkitPlugin;
import 'package:genkit_anthropic/genkit_anthropic.dart' as anthropic;
import 'package:genkit_google_genai/genkit_google_genai.dart' as genai;

import 'backend/backend.dart';
import 'backend/genkit_backend/genkit_backend.dart';
import 'eval.dart';
import 'eval_config.dart';
import 'eval_context.dart';
import 'logging/eval_log.dart';
import 'output/sandbox_code_saver.dart';
import 'scenario.dart';
import 'util/string_util.dart';

// Re-export so callers can use `baselineScenario` from a single import.
export 'scenario.dart' show baselineScenario;

/// The eval matrix runner.
///
/// [EvalSet] runs every combination of `models × scenarios × evals`,
/// building a fresh agent per cell (stamped with the correct model, cache
/// middleware injected, etc.), creating a sandbox session when [sandbox] is
/// provided, and collecting [EvalResult]s into a flat list.
///
/// ## Simple usage (recommended)
///
/// ```dart
/// final results = await EvalSet(
///   models: [Model('googleai', 'gemini-2.5-flash')],
///   evals: [MyEval()],
///   config: EvalConfig(cacheDir: '.devals-cache'),
/// ).run();
/// ```
///
/// The backend is auto-resolved from `Model.provider`:
/// - `googleai` → Google AI (reads `GEMINI_API_KEY` from env)
/// - `anthropic` → Anthropic (reads `ANTHROPIC_API_KEY` from env)
///
/// Mixed providers are supported — the framework creates a Genkit instance
/// with all needed plugins.
///
/// ## Advanced usage (explicit backend)
///
/// For custom backends or non-standard configurations, pass a [Backend]
/// directly:
///
/// ```dart
/// final results = await EvalSet(
///   backend: GeminiCliBackend(genkit: genkit),
///   models: [Model('googleai', 'gemini-2.5-flash')],
///   evals: [MyEval()],
/// ).run();
/// ```
class EvalSet {
  /// The evals to run.
  final List<Eval> evals;

  /// Model identifiers to evaluate against.
  final List<ai.Model> models;

  /// Scenario variations to test.
  final List<Scenario> scenarios;

  /// Optional sandbox manager.
  final SandboxManager? sandbox;

  /// Run configuration — controls caching, agent type, etc.
  final EvalConfig config;

  /// The resolved backend. When `null`, auto-resolved from [models] on first
  /// call to [run].
  Backend? _backend;

  /// Creates an [EvalSet].
  ///
  /// When [backend] is omitted, the framework auto-resolves the correct
  /// backend from `Model.provider`. All models must share the same provider.
  ///
  /// Throws [ArgumentError] if:
  /// - [models] is empty
  /// - Models have mixed providers and no explicit [backend] is given
  /// - The provider is unknown and no explicit [backend] is given
  /// - A required env var (e.g. `GEMINI_API_KEY`) is missing
  EvalSet({
    required this.evals,
    required this.models,
    this.scenarios = const [baselineScenario],
    this.sandbox,
    this.config = const EvalConfig(),
    Backend? backend,
  }) : _backend = backend {
    if (models.isEmpty) {
      throw ArgumentError('EvalSet requires at least one model.');
    }

    // Fail fast: if no explicit backend, validate we can auto-resolve.
    if (_backend == null) {
      _validateModelsForAutoResolution();
    }
  }

  /// The active backend — auto-resolved lazily if not set explicitly.
  Backend get backend => _backend ??= _resolveBackend();

  /// Run the full `models × scenarios × evals` matrix.
  ///
  /// When [runDir] is provided and [EvalConfig.saveCode] is `true`,
  /// the sandbox workspace is copied to `<runDir>/<cellId>/` after
  /// each cell completes.
  ///
  /// When [onResult] is provided, it is called after each cell completes
  /// with the [EvalResult] and the list of all results so far. This
  /// enables incremental output writing (e.g. trajectory files, partial
  /// eval.json).
  Future<List<EvalResult>> run({
    String? runDir,
    Future<void> Function(EvalResult result, List<EvalResult> allResults)?
        onResult,
  }) async {
    final results = <EvalResult>[];
    final totalCells = models.length * scenarios.length * evals.length;
    var completed = 0;

    for (final model in models) {
      for (final scenario in scenarios) {
        for (final eval in evals) {
          EvalLog.setProgress(completed, totalCells);
          EvalLog.evalStart(
            eval.name,
            model.toString(),
            scenario.name,
          );

          final result = await _runCell(eval, model, scenario, runDir: runDir);
          results.add(result);

          // Fire the incremental callback.
          if (onResult != null) {
            try {
              await onResult(result, results);
            } catch (e, st) {
              EvalLog.error('onResult callback failed', e, st);
            }
          }

          completed++;
        }
      }
    }

    // Log aggregate cache statistics.
    final (:hits, :misses) = backend.cacheStats;
    if (hits > 0 || misses > 0) {
      EvalLog.debug('[Cache] $hits hits, $misses misses');
    }

    return results;
  }

  /// Execute a single matrix cell, catching both synchronous and async errors.
  ///
  /// Wraps the cell in [runZonedGuarded] so that unhandled async errors
  /// (e.g. MCP transport failures) are captured instead of crashing the
  /// isolate.
  Future<EvalResult> _runCell(
    Eval eval,
    ai.Model model,
    Scenario scenario, {
    String? runDir,
  }) async {
    final completer = Completer<EvalResult>();

    runZonedGuarded(
      () async {
        EvalLog.evalPhase('sandbox');
        final session = await sandbox?.createSession(
          eval.name,
          evalId: '${model}_${scenario.name}',
        );

        // Let the backend build the agent for this cell.
        EvalLog.evalPhase('agent');
        final cellAgent = backend.buildCellAgent(
          model: model,
          sandbox: session?.sandbox,
        );

        // Delegate MCP lifecycle to the backend.
        McpSession? mcpSession;

        try {
          if (scenario.mcpServers.isNotEmpty) {
            EvalLog.evalPhase('mcp');
            mcpSession = await backend.startMcpSession(
              scenario.mcpServers,
            );
          }

          final mcpTools = mcpSession?.tools ?? const <ai.Tool>[];

          final context = EvalContext(
            agent: cellAgent,
            scenario: scenario,
            sandbox: session?.sandbox,
            mcpTools: mcpTools,
          );

          EvalLog.evalPhase('execute');
          final result = await eval.execute(context);
          EvalLog.evalComplete(result);

          // Save the sandbox project if configured.
          if (config.saveCode && runDir != null && session?.sandbox != null) {
            try {
              EvalLog.evalPhase('saveCode');
              final cellId = toSafeId(result.id, allowHyphens: false);
              await saveCodeFromSandbox(
                session!.sandbox,
                sandboxPath: config.sandboxWorkDir,
                destDir: '$runDir/$cellId',
              );
            } catch (e, st) {
              EvalLog.error('saveCode failed for "${eval.name}"', e, st);
            }
          }

          if (!completer.isCompleted) completer.complete(result);
        } catch (e, st) {
          EvalLog.error('Eval "${eval.name}" failed', e, st);
          if (!completer.isCompleted) {
            completer.complete(_errorResult(eval, model, scenario, e, st));
          }
        } finally {
          await mcpSession?.dispose();
          await session?.dispose();
        }
      },
      (error, stackTrace) {
        // Catches async errors thrown outside the try/catch scope
        // (e.g. MCP client transport errors).
        EvalLog.error(
          'Eval "${eval.name}" async error',
          error,
          stackTrace,
        );
        if (!completer.isCompleted) {
          completer.complete(
            _errorResult(eval, model, scenario, error, stackTrace),
          );
        }
      },
    );

    return completer.future;
  }

  // ---------------------------------------------------------------------------
  // Auto-resolution
  // ---------------------------------------------------------------------------

  /// Validates that models can be auto-resolved (known provider, required env
  /// vars present). Called from the constructor for fail-fast.
  void _validateModelsForAutoResolution() {
    final providers = models.map((m) => m.provider).toSet();

    for (final provider in providers) {
      switch (provider) {
        case 'googleai':
          final apiKey = Platform.environment['GEMINI_API_KEY'];
          if (apiKey == null || apiKey.isEmpty) {
            throw ArgumentError(
              'Model provider "googleai" requires the GEMINI_API_KEY '
              'environment variable to be set.',
            );
          }
        case 'anthropic':
          final apiKey = Platform.environment['ANTHROPIC_API_KEY'];
          if (apiKey == null || apiKey.isEmpty) {
            throw ArgumentError(
              'Model provider "anthropic" requires the ANTHROPIC_API_KEY '
              'environment variable to be set.',
            );
          }
        default:
          throw ArgumentError(
            'Unknown model provider "$provider". '
            'Supported auto-resolved providers: googleai, anthropic. '
            'For other providers, pass a Backend explicitly.',
          );
      }
    }
  }

  /// Builds the correct [Backend] from the model providers.
  ///
  /// Creates a Genkit instance with all needed plugins for the providers
  /// present in [models].
  Backend _resolveBackend() {
    final providers = models.map((m) => m.provider).toSet();
    final plugins = <GenkitPlugin>[];

    for (final provider in providers) {
      switch (provider) {
        case 'googleai':
          plugins.add(genai.googleAI(
            apiKey: Platform.environment['GEMINI_API_KEY'],
          ));
        case 'anthropic':
          plugins.add(anthropic.anthropic(
            apiKey: Platform.environment['ANTHROPIC_API_KEY'],
          ));
        default:
          throw StateError('Unreachable — validated in constructor');
      }
    }

    final genkit = g.Genkit(plugins: plugins);

    return GenkitBackend(
      genkit: genkit,
      cacheDir: config.cacheDir,
    );
  }

  // ---------------------------------------------------------------------------
  // Error handling
  // ---------------------------------------------------------------------------

  /// Build a failed [EvalResult] to record an error without aborting the run.
  static EvalResult _errorResult(
    Eval eval,
    ai.Model model,
    Scenario scenario,
    Object error,
    StackTrace stackTrace,
  ) {
    return EvalResult(
      id: '${eval.name}_${model}_${scenario.name}',
      evalName: eval.name,
      model: model.toString(),
      scenario: scenario.name,
      input: eval.input,
      output: 'ERROR: $error',
      scores: {'err': Score.error()},
      store: {'error': error.toString(), 'stackTrace': stackTrace.toString()},
      startedAt: DateTime.now(),
      completedAt: DateTime.now(),
    );
  }
}
