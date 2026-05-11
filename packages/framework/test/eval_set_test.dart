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
///
/// Model stamping works via [_MockAgent.copyWith].
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

/// An eval that records which scenario it ran under as its output.
class _EchoEval extends Eval {
  final String _input;

  _EchoEval(this._input);

  @override
  String get name => 'echo_eval';
  @override
  String get input => _input;
  @override
  List<Evaluator> get evaluators => const [_AlwaysCorrectEvaluator()];

  @override
  Future<EvalState> run(EvalState state) async {
    state.messages.add(
      ai.Message(
        role: ai.Role.model,
        content: [ai.TextPart(state.context.scenario.name)],
      ),
    );
    return state;
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  final model = Model('test', 'model');
  final agent = _MockAgent();
  final backend = _MockBackend(agent);

  // -------------------------------------------------------------------------
  // runEval — single-eval primitive
  // -------------------------------------------------------------------------

  group('runEval', () {
    test('returns a single EvalResult', () async {
      final result = await runEval(_EchoEval('hello'), agent: agent);

      expect(result.evalName, equals('echo_eval'));
      expect(result.model, equals('mock/model'));
      expect(result.scenario, equals('baseline'));
    });

    test('uses baselineScenario by default', () async {
      final result = await runEval(_EchoEval('hello'), agent: agent);
      expect(result.scenario, equals('baseline'));
    });

    test('uses provided scenario', () async {
      const scenario = Scenario(name: 'custom');
      final result = await runEval(
        _EchoEval('hello'),
        agent: agent,
        scenario: scenario,
      );
      expect(result.scenario, equals('custom'));
    });

    test('scores are recorded', () async {
      final result = await runEval(_EchoEval('hello'), agent: agent);
      expect(result.scores.values.first.value, equals(1.0));
    });

    test('input is reflected in result', () async {
      final result = await runEval(_EchoEval('my question'), agent: agent);
      expect(result.input, equals('my question'));
    });
  });

  // -------------------------------------------------------------------------
  // EvalSet — matrix runner
  // -------------------------------------------------------------------------

  group('EvalSet', () {
    test('runs all evals and aggregates scores', () async {
      final results = await EvalSet(
        backend: backend,
        models: [model],
        evals: [_EchoEval('q1'), _EchoEval('q2')],
      ).run();

      expect(results, hasLength(2));
      expect(results.every((r) => r.scores.values.first.value == 1.0), isTrue);
    });

    test('runs multiple evals independently', () async {
      final results = await EvalSet(
        backend: backend,
        models: [model],
        evals: [_EchoEval('q1'), _EchoEval('q2')],
      ).run();

      expect(results, hasLength(2));
    });

    test('returns empty result for empty evals list', () async {
      final results = await EvalSet(
        backend: backend,
        models: [model],
        evals: [],
      ).run();

      expect(results, isEmpty);
    });

    test('runs matrix: 2 models × 2 scenarios × 1 eval = 4 results', () async {
      final results = await EvalSet(
        backend: backend,
        models: [model, Model('test', 'model-b')],
        scenarios: [
          const Scenario(name: 'baseline'),
          const Scenario(name: 'other'),
        ],
        evals: [_EchoEval('q')],
      ).run();

      expect(results, hasLength(4));
    });

    test('scenario name is captured in result', () async {
      const scenario = Scenario(name: 'my_scenario');
      final results = await EvalSet(
        backend: backend,
        models: [model],
        scenarios: [scenario],
        evals: [_EchoEval('q')],
      ).run();

      expect(results.single.scenario, equals('my_scenario'));
    });

    test('EvalSet stamps model into agent per cell', () async {
      final modelA = Model('test', 'alpha');
      final modelB = Model('test', 'beta');

      final capturedModels = <String>[];

      final captureEval = _CaptureModelEval(capturedModels);

      await EvalSet(
        backend: backend,
        models: [modelA, modelB],
        evals: [captureEval],
      ).run();

      expect(capturedModels, containsAll(['test/alpha', 'test/beta']));
    });

    test('throws ArgumentError when models is empty', () {
      expect(
        () => EvalSet(backend: backend, models: [], evals: [_EchoEval('q')]),
        throwsArgumentError,
      );
    });
  });
}

/// Records the model string stamped into the agent for each cell.
class _CaptureModelEval extends Eval {
  final List<String> captured;
  _CaptureModelEval(this.captured);

  @override
  String get name => 'capture_model';
  @override
  String get input => '';

  @override
  Future<EvalState> run(EvalState state) async {
    captured.add(state.agent.model);
    return state;
  }
}
