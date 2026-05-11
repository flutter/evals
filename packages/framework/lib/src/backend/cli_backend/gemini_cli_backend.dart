import 'package:genkit/genkit.dart' as g;
import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';

import '../agent.dart';
import 'gemini_cli_agent.dart';
import '../../logging/eval_log.dart';
import '../../middlewares/cache/cache_middleware.dart';
import '../../middlewares/cache/cache_middleware_def.dart';
import '../genkit_backend/genkit_ai.dart';
import '../genkit_backend/genkit_model_provider.dart';
import '../backend.dart';

/// [Backend] for process-based agents that run the Gemini CLI.
///
/// Spawns the `gemini` CLI binary inside a sandbox environment, using a local
/// proxy to route model calls through Genkit for trajectory capture, caching,
/// and model-matrix evaluation.
///
/// ## Usage
///
/// ```dart
/// final genkit = Genkit(plugins: [googleAI(...)]);
///
/// await runEvals(EvalSet(
///   backend: GeminiCliBackend(genkit: genkit, cacheDir: '.devals-cache'),
///   models: [Model('gemini', '2.5-flash')],
///   evals: [...],
///   sandbox: PodmanSandboxManager(...),
/// ));
/// ```
///
/// ## Requirements
///
/// - The sandbox image must have `gemini` installed
///   (`npm install -g @google/gemini-cli`).
/// - A [SandboxManager] must be provided to [EvalSet].
class GeminiCliBackend implements Backend {
  /// The Genkit instance used for model generation (via the proxy).
  final g.Genkit genkit;

  /// When set, caches model responses in this directory.
  final String? cacheDir;

  /// Additional CLI arguments to append to each invocation.
  final List<String> extraCliArgs;

  /// Timeout for each CLI process invocation.
  final Duration timeout;

  /// Per-model cache middleware instances (created lazily).
  final Map<String, CacheMiddleware> _cacheMiddlewareByModel = {};

  GeminiCliBackend({
    required this.genkit,
    this.cacheDir,
    this.extraCliArgs = const [],
    this.timeout = const Duration(minutes: 10),
  });

  // ---------------------------------------------------------------------------
  // Backend — agent construction
  // ---------------------------------------------------------------------------

  @override
  Agent buildCellAgent({
    required ai.Model model,
    SandboxEnvironment? sandbox,
  }) {
    if (sandbox == null) {
      throw StateError(
        'GeminiCliBackend requires a sandbox. '
        'Set sandbox on EvalSet.',
      );
    }

    // Build the model provider with optional cache middleware.
    final genkitAi = GenkitAI(genkit);
    List<g.GenerateMiddlewareRef>? middlewareRefs;
    if (cacheDir != null) {
      middlewareRefs = [_middlewareRefFor(cacheDir!, model, genkitAi)];
    }

    final modelProvider = GenkitModelProvider(
      genkit: genkit,
      use: middlewareRefs,
    );

    return GeminiCliAgent(
      model: model.toString(),
      sandbox: sandbox,
      modelProvider: modelProvider,
      extraArgs: extraCliArgs,
      timeout: timeout,
    );
  }

  // ---------------------------------------------------------------------------
  // Backend — MCP (not yet supported for CLI agents)
  // ---------------------------------------------------------------------------

  @override
  Future<McpSession> startMcpSession(List<McpServerConfig> mcpConfigs) async {
    if (mcpConfigs.isNotEmpty) {
      EvalLog.debug(
        '[GeminiCliBackend] MCP servers not yet supported for CLI agents. '
        'Skipping ${mcpConfigs.length} server config(s).',
      );
    }
    return McpSession(tools: const [], dispose: () async {});
  }

  // ---------------------------------------------------------------------------
  // Backend — cache stats
  // ---------------------------------------------------------------------------

  @override
  ({int hits, int misses}) get cacheStats {
    var totalHits = 0;
    var totalMisses = 0;
    for (final mw in _cacheMiddlewareByModel.values) {
      final (:hits, :misses) = mw.stats;
      totalHits += hits;
      totalMisses += misses;
    }
    return (hits: totalHits, misses: totalMisses);
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  g.GenerateMiddlewareRef _middlewareRefFor(
    String dir,
    ai.Model model,
    GenkitAI genkitAi,
  ) {
    final modelKey = model.toString().replaceAll('/', '_');
    if (!_cacheMiddlewareByModel.containsKey(modelKey)) {
      final modelCacheDir = '$dir/$modelKey';
      final mw = CacheMiddleware(cacheDir: modelCacheDir);
      _cacheMiddlewareByModel[modelKey] = mw;
      final mwName = '${cacheMwName}_$modelKey';
      genkitAi.genkit.registry.registerValue(
        'middleware',
        mwName,
        cacheMiddlewareDefFor(mw),
      );
      return g.middlewareRef(name: mwName);
    }
    final mwName = '${cacheMwName}_$modelKey';
    return g.middlewareRef(name: mwName);
  }
}
