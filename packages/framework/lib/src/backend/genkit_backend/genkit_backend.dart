import 'package:genkit/genkit.dart' as g;
import 'package:genkit_mcp/genkit_mcp.dart' as gmcp;
import 'package:ai/ai.dart' as ai;
import 'package:ai/agents.dart' as agents;
import 'package:devals_sandbox/sandbox.dart';

import '../agent.dart';
import '../sdk_agent_adapter.dart';
import '../../logging/eval_log.dart';
import '../../middlewares/cache/cache_middleware.dart';
import '../../middlewares/cache/cache_middleware_def.dart';
import 'genkit_ai.dart';
import '../backend.dart';

/// Default agent builder — creates a [agents.MiniSweAgent].
agents.Agent _defaultAgentBuilder(ai.AI ai, String model) =>
    agents.MiniSweAgent(ai: ai, model: model, tools: []);

/// [Backend] implementation backed by a [g.Genkit] instance.
///
/// Owns all Genkit-specific logic:
/// - Building agents with [GenkitAI] as the [ai.AI] provider.
/// - Injecting [CacheMiddleware] when [cacheDir] is set.
/// - Starting [gmcp.GenkitMcpClient] servers and converting their tools to
///   framework-agnostic [ai.Tool] wrappers.
///
/// ## Usage
///
/// Most eval authors do not construct this directly — [EvalSet] auto-resolves
/// a [GenkitBackend] from `Model.provider`. For advanced use:
///
/// ```dart
/// final genkit = Genkit(plugins: [googleAI(...)]);
///
/// await runEvals(EvalSet(
///   backend: GenkitBackend(genkit: genkit, cacheDir: '.devals-cache'),
///   models: [Model('googleai', 'gemini-2.5-flash')],
///   evals: [...],
/// ));
/// ```
///
/// ## Custom agent type
///
/// By default, [GenkitBackend] builds a [agents.MiniSweAgent]. To use a
/// different agent implementation, pass an [agentBuilder]:
///
/// ```dart
/// GenkitBackend(
///   genkit: genkit,
///   agentBuilder: (ai, model) => BasicAgent(ai: ai, model: model, tools: []),
/// )
/// ```
class GenkitBackend implements Backend {
  /// The Genkit instance used for MCP client creation and model generation.
  final g.Genkit genkit;

  /// When set, caches model responses in this directory.
  ///
  /// On subsequent runs with the same inputs, cached responses are returned
  /// instantly — no API call.
  final String? cacheDir;

  /// Builder that creates an [agents.Agent] given an [ai.AI] provider and
  /// a model string. Defaults to [agents.MiniSweAgent].
  final agents.Agent Function(ai.AI ai, String model) _agentBuilder;

  /// Per-model cache middleware instances (created lazily when [cacheDir]
  /// is set).
  final Map<String, CacheMiddleware> _cacheMiddlewareByModel = {};

  GenkitBackend({
    required this.genkit,
    this.cacheDir,
    agents.Agent Function(ai.AI ai, String model)? agentBuilder,
  }) : _agentBuilder = agentBuilder ?? _defaultAgentBuilder;

  // ---------------------------------------------------------------------------
  // Backend — agent construction
  // ---------------------------------------------------------------------------

  @override
  Agent buildCellAgent({
    required ai.Model model,
    SandboxEnvironment? sandbox,
  }) {
    var genkitAi = GenkitAI(genkit);

    // Inject cache middleware if configured.
    if (cacheDir != null) {
      genkitAi = genkitAi.withMiddleware([
        _middlewareRefFor(cacheDir!, model, genkitAi),
      ]);
    }

    final inner = _agentBuilder(genkitAi, model.toString());
    return SdkAgentAdapter(inner);
  }

  // ---------------------------------------------------------------------------
  // Backend — MCP
  // ---------------------------------------------------------------------------

  @override
  Future<McpSession> startMcpSession(List<McpServerConfig> mcpConfigs) async {
    final clients = <gmcp.GenkitMcpClient>[];
    final tools = <ai.Tool>[];

    for (final config in mcpConfigs) {
      EvalLog.debug(
        '[MCP] Starting ${config.command} ${config.args.join(' ')}...',
      );
      try {
        final client = gmcp.GenkitMcpClient(
          gmcp.McpClientOptions(
            name: config.command ?? 'mcp-server',
            mcpServer: gmcp.McpServerConfig(
              command: config.command,
              args: config.args,
              environment: config.env.isEmpty ? null : config.env,
            ),
          ),
        );
        await client.ready().timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw StateError(
            'MCP server failed to start within 15s. '
            'Config: ${config.command} ${config.args}',
          ),
        );

        final genkitTools = await _getTools(client);
        clients.add(client);
        tools.addAll(genkitTools);
        EvalLog.debug(
          '[MCP] ${client.serverName}: '
          '${genkitTools.length} tool(s): ${genkitTools.map((t) => t.name).toList()}',
        );
      } catch (e) {
        EvalLog.error(
          '[MCP] Failed to start server '
          '"${config.command} ${config.args.join(' ')}": $e',
        );
        // Continue — run the eval without this server's tools.
      }
    }

    return McpSession(
      tools: tools,
      dispose: () async {
        for (final client in clients.reversed) {
          try {
            await client.close();
          } catch (e) {
            EvalLog.debug('[MCP] Error closing client: $e');
          }
        }
      },
    );
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

  /// Fetches tools from an MCP [client] and wraps them as [ai.Tool]s.
  ///
  /// Tools are registered in the Genkit registry so they are automatically
  /// available during `genkit.generate()`. We also create [ai.Tool] wrappers
  /// so the framework's tool-merging logic (name-based dispatch) works.
  ///
  /// Genkit strips the server prefix when presenting tools to the Google AI
  /// API (e.g. `'dart/pub_dev_search'` → `'pub_dev_search'`) because `/` is
  /// not a valid function-name character. The model therefore returns the
  /// un-prefixed name, so we register the [ai.Tool] with the same un-prefixed
  /// name for dispatch to succeed.
  Future<List<ai.Tool>> _getTools(gmcp.GenkitMcpClient client) async {
    final gTools = await client
        .getActiveTools(genkit)
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw StateError(
            'MCP server did not return tools within 15s.',
          ),
        );
    return gTools
        .map(
          (gt) => ai.Tool(
            name: gt.name.contains('/') ? gt.name.split('/').last : gt.name,
            description: gt.metadata['description'] as String? ?? '',
            run: (input) => gt.run(input),
          ),
        )
        .toList();
  }

  /// Lazily creates a per-model [g.GenerateMiddlewareRef] backed by a
  /// [CacheMiddleware] that writes to a model-specific subdirectory.
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
