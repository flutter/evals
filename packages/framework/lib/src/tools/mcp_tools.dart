import 'package:genkit/genkit.dart' as g;
import 'package:genkit_mcp/genkit_mcp.dart';

/// Utilities for connecting to MCP servers and obtaining [Tool]s
/// for use in evals.
///
/// Returns a tuple of `(client, tools)` so the caller can close the client
/// in [Eval.cleanUp].
///
/// ```dart
/// @override
/// Future<EvalState> setUp(EvalState state) async {
///   final (client, tools) = await McpTools.dartMcpServer(state.agent.genkit);
///   state.store['_mcp_client'] = client;
///   state.store['_mcp_tools'] = tools;
///   return state;
/// }
/// ```
abstract final class McpTools {
  /// Connects to the Dart MCP server via stdio and returns all
  /// discovered tools.
  ///
  /// The Dart MCP server is launched as a subprocess using
  /// `dart mcp-server` (a built-in SDK command). The caller must close the returned
  /// [GenkitMcpClient] when done (typically in [Eval.cleanUp]).
  ///
  /// A [timeout] guards against the subprocess dying silently (e.g. package
  /// not found). Without it, the pending JSON-RPC completer inside the MCP
  /// client is never resolved, and since an uncompleted [Completer] does not
  /// register with the Dart event loop the VM exits cleanly — which looks
  /// like the process just vanished.
  static Future<(GenkitMcpClient, List<g.Tool>)> dartMcpServer(
    g.Genkit genkit, {
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final client = GenkitMcpClient(
      McpClientOptions(
        name: 'dart-mcp-server',
        mcpServer: McpServerConfig(
          command: 'dart',
          args: ['mcp-server'],
        ),
      ),
    );

    await client.ready().timeout(
      timeout,
      onTimeout: () => throw StateError(
        'MCP server failed to start within ${timeout.inSeconds}s. '
        'Ensure "dart mcp-server" is available in your Dart SDK.',
      ),
    );

    try {
      final tools = await client.getActiveTools(genkit).timeout(
        timeout,
        onTimeout: () => throw StateError(
          'MCP server did not return tools within ${timeout.inSeconds}s.',
        ),
      );

      return (client, tools);
    } catch (e) {
      await client.close();
      rethrow;
    }
  }
}
