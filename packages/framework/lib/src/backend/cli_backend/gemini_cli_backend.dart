import 'package:genkit/genkit.dart' as g;
import 'package:ai/ai.dart' as ai;
import 'package:ai/agents.dart' show Agent;
import 'package:devals_sandbox/sandbox.dart';

import 'gemini_cli_agent.dart';
import '../../logging/eval_log.dart';
import '../genkit_backend/genkit_ai.dart';
import '../genkit_backend/genkit_model_provider.dart';
import '../backend.dart';
import '../cacheable_backend.dart';

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
class GeminiCliBackend with CacheableBackend implements Backend {
  /// The Genkit instance used for model generation (via the proxy).
  final g.Genkit genkit;

  /// When set, caches model responses in this directory.
  final String? cacheDir;

  /// Additional CLI arguments to append to each invocation.
  final List<String> extraCliArgs;

  /// Timeout for each CLI process invocation.
  final Duration timeout;

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
      middlewareRefs = [middlewareRefFor(cacheDir!, model, genkitAi)];
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

}
