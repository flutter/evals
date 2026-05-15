/// Example evaluation suite demonstrating every major framework feature.
///
/// This entrypoint runs a matrix of:
/// - **2 models**: Google AI (Gemini) + Anthropic (Claude)
/// - **2 scenarios**: baseline (no tools) + with_mcp (Dart MCP server)
/// - **5 evals**: PubDevSearch, FlutterBugFix, DartBugFix, FlutterFeature, DartDocumentation
///
/// ## Features exercised:
/// - Multi-model matrix (Google AI + Anthropic)
/// - Scenario-level evaluators (McpToolUsageEvaluator on with_mcp)
/// - Sandbox tools (bash, read_file, write_file)
/// - MCP tools via Scenario.mcpServers
/// - Both sandbox and non-sandbox evals in the same set
/// - saveCode: full project persistence
/// - Response caching
/// - ExecEvaluator.dartTest(), .flutterTest(), .dartAnalyze()
/// - IncludesEvaluator, McpToolUsageEvaluator, OutputContainsEvaluator
/// - TrajectoryEvaluator, FileChangedEvaluator, CodeQualityEvaluator
/// - Score.partial graduated scoring
/// - Custom setUp / run / cleanUp lifecycle
/// - EvalState.store metadata
///
/// **Evals**
/// - [PubDevSearchEval]      — single-turn, tool-agnostic
/// - [FlutterBugFixEval]     — agentic, BLoC state-mutation bug
/// - [DartBugFixEval]        — agentic, Dart CLI sort bug
/// - [FlutterFeatureEval]    — agentic, add a reset button
/// - [DartDocumentationEval] — single-turn, no-sandbox
library;

import 'package:devals_sandbox/sandbox.dart';
import 'package:example/src/evals/dart_bug_fix_eval.dart';
import 'package:example/src/evals/dart_documentation_eval.dart';
import 'package:example/src/evals/flutter_bug_fix_eval.dart';
import 'package:example/src/evals/flutter_feature_eval.dart';
import 'package:example/src/evals/mcp_pub_dev_search_eval.dart';
import 'package:framework/framework.dart';

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
      // Scenario-level evaluator — only scores when MCP is available.
      evaluators: [
        const McpToolUsageEvaluator(
          requiredTools: ['dart/pub_dev_search'],
        ),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Evals
  // ---------------------------------------------------------------------------

  // Single-turn eval: search pub.dev.
  final pubSearchEval = PubDevSearchEval(
    input: 'What is the best package to display line charts in Flutter?',
    target: 'fl_chart',
  );

  // Agentic eval: fix a BLoC bug in a Flutter app.
  final flutterBugFix = FlutterBugFixEval();

  // Agentic eval: fix a duplicate-dropping bug in a Dart CLI app.
  final dartBugFix = DartBugFixEval();

  // Agentic eval: add a reset button to a Flutter counter app.
  final flutterFeature = FlutterFeatureEval();

  // Single-turn eval: explain Dart null safety (no sandbox needed).
  final dartDocs = DartDocumentationEval();

  // ---------------------------------------------------------------------------
  // EvalSet — backend is auto-resolved from Model.provider
  // ---------------------------------------------------------------------------

  final evalSet = EvalSet(
    models: [
      Model('googleai', 'gemini-2.5-flash-lite'),
      Model('anthropic', 'claude-sonnet-4-20250514'),
    ],
    scenarios: scenarios,
    evals: [pubSearchEval, flutterBugFix, dartBugFix, flutterFeature, dartDocs],
    config: EvalConfig(
      cacheDir: '.devals-cache',
      saveCode: true,
    ),
    sandbox: PodmanSandboxManager(
      dockerfilePath: 'docker/Dockerfile',
      buildContext: '.',
    ),
  );

  await runEvals(evalSet);
}
