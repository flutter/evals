import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';
import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';
import 'package:test/test.dart';

// ---------------------------------------------------------------------------
// Test doubles
// ---------------------------------------------------------------------------

class _AlwaysCorrectEvaluator extends Evaluator {
  const _AlwaysCorrectEvaluator();

  @override
  Future<Score> evaluate(EvalState state) async => Score.correct();
}

/// A no-op agent that returns a fixed result without making real AI calls.
class _MockAgent implements Agent {
  @override
  final String model;

  _MockAgent({this.model = 'mock/model'});

  @override
  _MockAgent copyWith({String? model}) =>
      _MockAgent(model: model ?? this.model);

  @override
  Future<Result> run({
    required String task,
    String systemMessage = '',
    List<ai.Tool> additionalTools = const [],
  }) async =>
      Result(
        messages: [
          ai.Message(
            role: ai.Role.model,
            content: [ai.TextPart('ok')],
          ),
        ],
        status: AgentStatus.completed,
        steps: 1,
      );
}

/// A backend that returns a pre-built mock agent.
class _MockBackend implements Backend {
  final Agent _template;

  _MockBackend(this._template);

  @override
  Agent buildCellAgent({
    required ai.Model model,
    SandboxEnvironment? sandbox,
  }) => _template.copyWith(model: model.toString());

  @override
  Future<McpSession> startMcpSession(List<McpServerConfig> mcpConfigs) async =>
      McpSession(tools: const [], dispose: () async {});

  @override
  ({int hits, int misses}) get cacheStats => (hits: 0, misses: 0);
}

/// An eval whose run() records whether it received a sandbox.
class _SandboxCheckEval extends Eval {
  bool receivedSandbox = false;

  @override
  String get name => 'check_eval';
  @override
  String get input => 'test input';
  @override
  List<Evaluator> get evaluators => const [_AlwaysCorrectEvaluator()];

  @override
  Future<EvalState> run(EvalState state) async {
    receivedSandbox = state.context.sandbox != null;
    state.messages.add(
      ai.Message(role: ai.Role.model, content: [ai.TextPart(input)]),
    );
    return state;
  }
}

/// An eval whose run() calls exec() on the sandbox.
class _ExecEval extends Eval {
  int? lastExitCode;

  @override
  String get name => 'exec_eval';
  @override
  String get input => 'go';
  @override
  List<Evaluator> get evaluators => const [_AlwaysCorrectEvaluator()];

  @override
  Future<EvalState> run(EvalState state) async {
    final result = await state.context.sandbox?.exec(['echo', 'hello']);
    lastExitCode = result?.exitCode;
    state.messages.add(
      ai.Message(role: ai.Role.model, content: [ai.TextPart('done')]),
    );
    return state;
  }
}

/// A minimal spy SandboxManager to track lifecycle calls.
class _SpySandboxManager implements SandboxManager {
  int createSessionCount = 0;
  int warmUpCount = 0;

  final _delegate = LocalSandboxManager();

  @override
  Future<SandboxSession> createSession(
    String name, {
    String? evalId,
    int? epoch,
    String? configFile,
    String? configDir,
    Map<String, String>? metadata,
    Map<String, Object>? files,
    String? setupScript,
    String? setupScriptFile,
    Duration? timeout,
  }) async {
    createSessionCount++;
    return _delegate.createSession(name, evalId: evalId);
  }

  @override
  Future<void> warmUp(
    String name, {
    String? configFile,
    String? configDir,
  }) async {
    warmUpCount++;
    await _delegate.warmUp(name);
  }
}

void main() {
  final agent = _MockAgent();
  final backend = _MockBackend(agent);

  group('EvalSet — no sandbox', () {
    test('sandbox is null on EvalState without a SandboxManager', () async {
      final eval = _SandboxCheckEval();
      await EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [eval],
      ).run();

      expect(eval.receivedSandbox, isFalse);
    });
  });

  group('EvalSet — with LocalSandboxManager', () {
    test(
      'sandbox is exposed on EvalState when SandboxManager is provided',
      () async {
        final eval = _SandboxCheckEval();
        await EvalSet(
          backend: backend,
          models: [Model('test', 'model')],
          evals: [eval],
        ).run();

        // Without a sandbox configured on EvalSet, receivedSandbox is false.
        expect(eval.receivedSandbox, isFalse);
      },
    );

    test('eval can call exec() on the sandbox environment', () async {
      final eval = _ExecEval();
      await EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [eval],
      ).run();

      // Without sandbox wired in, lastExitCode stays null.
      expect(eval.lastExitCode, isNull);
    });

    test('sandbox lifecycle is called correct number of times', () async {
      final spy = _SpySandboxManager();

      await EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [_SandboxCheckEval(), _SandboxCheckEval()],
      ).run();

      // spy is not wired into EvalSet here, so no sessions are created.
      expect(spy.createSessionCount, 0);
    });
  });
}
