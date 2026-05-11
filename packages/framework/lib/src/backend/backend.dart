import 'package:ai/ai.dart' as ai;
import 'package:ai/agents.dart' show Agent;
import 'package:devals_sandbox/sandbox.dart';

/// Backend-specific integration hook for [EvalSet].
///
/// Owns all framework-specific concerns that [EvalSet] must not know about:
/// - Building a ready-to-run [Agent] for each matrix cell.
/// - Starting / stopping MCP servers and resolving their tools.
///
/// Implement this interface to add a new AI-framework backend. The existing
/// backends are:
/// - [GenkitBackend] — SDK agents backed by Genkit.
/// - [GeminiCliBackend] — process-based agents using the Gemini CLI.
///
/// Most eval authors do **not** need to interact with this interface. When
/// [EvalSet] is constructed without an explicit `backend`, the framework
/// auto-resolves the correct backend from the `Model.provider` field.
///
/// For advanced use (e.g. custom backends), pass a [Backend] explicitly:
///
/// ```dart
/// EvalSet(
///   backend: GenkitBackend(genkit: genkit),
///   models: [Model('googleai', 'gemini-2.5-flash')],
///   evals: [myEval],
/// )
/// ```
abstract interface class Backend {
  /// Build a ready-to-run [Agent] for one matrix cell.
  ///
  /// The backend handles model stamping, cache injection, and any
  /// framework-specific setup (e.g. model provider for proxy-based agents).
  ///
  /// [model] is the model to stamp into the agent.
  /// [sandbox] is the sandbox for this cell, if any.
  Agent buildCellAgent({
    required ai.Model model,
    SandboxEnvironment? sandbox,
  });

  /// Start all MCP servers described by [mcpConfigs] and return the
  /// [McpSession] containing their tools.
  ///
  /// Called once per matrix cell before [Eval.execute]. The caller disposes
  /// the session in its `finally` block via [McpSession.dispose].
  Future<McpSession> startMcpSession(List<McpServerConfig> mcpConfigs);

  /// Aggregate cache hit/miss statistics for the run.
  ///
  /// Only meaningful when caching is active. Returns `(hits: 0, misses: 0)`
  /// if caching is not supported or not configured.
  ({int hits, int misses}) get cacheStats;
}

/// A framework-agnostic description of an MCP server to start.
///
/// Mirrors the fields used by `McpServerConfig` from `package:genkit_mcp`,
/// but lives in the framework core so non-Genkit backends can also
/// declare MCP servers without a Genkit dependency.
class McpServerConfig {
  /// The executable to run (e.g. `'dart'`, `'npx'`).
  final String? command;

  /// Arguments passed to [command].
  final List<String> args;

  /// Optional environment variables for the server process.
  final Map<String, String> env;

  const McpServerConfig({
    this.command,
    this.args = const [],
    this.env = const {},
  });

  @override
  String toString() => '${command ?? '<no-command>'} ${args.join(' ')}';
}

/// The result of [Backend.startMcpSession].
///
/// Provides the [tools] collected from all started MCP servers, and a
/// [dispose] callback that shuts them down cleanly.
class McpSession {
  /// Framework-agnostic tools collected from all started servers.
  final List<ai.Tool> tools;

  /// Shutdown callback — always called in the matrix cell's `finally` block.
  final Future<void> Function() dispose;

  const McpSession({required this.tools, required this.dispose});
}
