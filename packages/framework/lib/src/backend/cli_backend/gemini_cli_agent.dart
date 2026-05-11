import 'dart:io';

import 'package:ai/agents.dart' as ai show Agent, Result, AgentStatus;
import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';

import '../../logging/eval_log.dart';
import '../model_provider.dart';
import 'gemini_api_proxy.dart';

/// An agent that runs the Gemini CLI inside a sandbox.
///
/// Spawns the `gemini` CLI binary in the sandbox environment, passing the
/// task as a `--prompt` argument. The model is passed via `--model`.
///
/// The sandbox and model provider are injected at construction time by
/// [GeminiCliBackend], keeping the [run] method simple.
///
/// ## Proxy mode
///
/// When a [modelProvider] is set, the agent starts a [GeminiApiProxy] and
/// points the CLI at it via `GEMINI_API_BASE_URL`. The proxy intercepts all
/// generate calls, routes them through the framework's [ModelProvider], and
/// captures a full message-level trajectory. This enables model-matrix
/// evaluation and caching for CLI agents.
///
/// When [modelProvider] is `null`, the CLI talks directly to the Gemini API
/// (no trajectory capture beyond stdout).
class GeminiCliAgent extends ai.Agent {
  /// The model name passed to the CLI via `--model`.
  @override
  final String model;

  /// The sandbox environment to run the CLI in.
  final SandboxEnvironment sandbox;

  /// Optional model provider for proxy-backed execution.
  final ModelProvider? modelProvider;

  /// Additional CLI arguments to append to each invocation.
  final List<String> extraArgs;

  /// Timeout for the CLI process.
  final Duration timeout;

  const GeminiCliAgent({
    required this.model,
    required this.sandbox,
    this.modelProvider,
    this.extraArgs = const [],
    this.timeout = const Duration(minutes: 10),
  });

  @override
  GeminiCliAgent copyWith({String? model}) => GeminiCliAgent(
    model: model ?? this.model,
    sandbox: sandbox,
    modelProvider: modelProvider,
    extraArgs: extraArgs,
    timeout: timeout,
  );

  @override
  Future<ai.Result> run({
    required String task,
    String systemMessage = '',
    List<ai.Tool> additionalTools = const [],
  }) async {
    if (modelProvider != null) {
      return _runWithProxy(task: task);
    } else {
      return _runDirect(task: task);
    }
  }

  // ---------------------------------------------------------------------------
  // Proxy-backed execution
  // ---------------------------------------------------------------------------

  Future<ai.Result> _runWithProxy({required String task}) async {
    final proxy = GeminiApiProxy(provider: modelProvider!);
    await proxy.start();

    try {
      final apiKey = Platform.environment['GEMINI_API_KEY'] ?? '';
      // host.docker.internal resolves to the host machine from inside Docker.
      final baseUrl = 'http://host.docker.internal:${proxy.port}';

      final result = await sandbox.exec(
        [
          'gemini',
          '--prompt',
          task,
          '--model',
          model,
          '--no-interactive',
          ...extraArgs,
        ],
        env: {
          'GEMINI_API_KEY': apiKey,
          'GEMINI_API_BASE_URL': baseUrl,
        },
        timeout: timeout,
      );

      // The proxy transcript has the full message history.
      final messages = proxy.transcript.isNotEmpty
          ? List<ai.Message>.from(proxy.transcript)
          : _syntheticMessages(task, result);

      return ai.Result(
        messages: messages,
        status: result.exitCode == 0
            ? ai.AgentStatus.completed
            : ai.AgentStatus.error,
        steps: proxy.transcript
            .where((m) => m.role == ai.Role.model)
            .length
            .clamp(1, double.maxFinite.toInt()),
        error: result.exitCode != 0
            ? 'Exit ${result.exitCode}: ${result.stderr}'
            : null,
      );
    } finally {
      await proxy.stop();
    }
  }

  // ---------------------------------------------------------------------------
  // Direct execution (no proxy)
  // ---------------------------------------------------------------------------

  Future<ai.Result> _runDirect({required String task}) async {
    EvalLog.debug('[GeminiCliAgent] Running in direct (no proxy) mode');

    final apiKey = Platform.environment['GEMINI_API_KEY'] ?? '';

    final result = await sandbox.exec(
      [
        'gemini',
        '--prompt',
        task,
        '--model',
        model,
        '--no-interactive',
        ...extraArgs,
      ],
      env: {'GEMINI_API_KEY': apiKey},
      timeout: timeout,
    );

    return ai.Result(
      messages: _syntheticMessages(task, result),
      status: result.exitCode == 0
          ? ai.AgentStatus.completed
          : ai.AgentStatus.error,
      steps: 1,
      error: result.exitCode != 0
          ? 'Exit ${result.exitCode}: ${result.stderr}'
          : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Builds a minimal two-message transcript from raw stdout when no proxy
  /// transcript is available.
  List<ai.Message> _syntheticMessages(
    String task,
    ExecResult result,
  ) {
    final output = result.stdout.trim();
    return [
      ai.Message(role: ai.Role.user, content: [ai.TextPart(task)]),
      if (output.isNotEmpty)
        ai.Message(role: ai.Role.model, content: [ai.TextPart(output)]),
    ];
  }
}
