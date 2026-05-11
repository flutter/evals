// =============================================================================
// Entry point
// =============================================================================

import 'package:devals_sandbox/sandbox.dart';
import 'package:framework/framework.dart';
import 'package:example/src/evals/fix_remote_bug_eval.dart';
import 'package:example/src/evals/flutter_bug_fix_eval.dart';
import 'package:example/src/evals/mcp_pub_dev_search_eval.dart';

/// Runs the full stress-test suite.
///
/// The matrix is: N models × N scenarios × N evals.
///
/// **Models**
/// - `gemini-2.5-flash-lite`
///
/// **Scenarios**
/// - `baseline`          — no extra tools; model answers from training data
/// - `with_mcp`          — Dart MCP server provides `pub_dev_search` tool
///
/// **Evals**
/// - [PubDevSearchEval]  — single-turn, tool-agnostic package search
/// - [FlutterBugFixEval] — agentic sandbox eval
/// - [FixRemoteBugEval]  — agentic remote-clone eval
void main() async {
  // ---------------------------------------------------------------------------
  // Scenarios
  // ---------------------------------------------------------------------------

  final scenarios = [
    const Scenario(name: 'baseline', tags: ['dart']),
    Scenario(
      name: 'with_mcp',
      tags: ['dart', 'mcp'],
      mcpServers: [
        McpServerConfig(command: 'dart', args: ['mcp-server']),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Evals
  // ---------------------------------------------------------------------------

  final pubSearchEval = PubDevSearchEval(
    input: 'What is the best package to display line charts in Flutter?',
    target: 'fl_chart',
  );

  final fixBug = FlutterBugFixEval();

  // ---------------------------------------------------------------------------
  // EvalSet — backend is auto-resolved from Model.provider
  // ---------------------------------------------------------------------------

  final evalSet = EvalSet(
    models: [
      Model('googleai', 'gemini-2.5-flash-lite'),
    ],
    scenarios: scenarios,
    evals: [pubSearchEval, fixBug],
    config: EvalConfig(cacheDir: '.devals-cache'),
    sandbox: PodmanSandboxManager(
      dockerfilePath: 'example/docker/Dockerfile',
      buildContext: 'example',
    ),
  );

  await runEvals(evalSet);
}
