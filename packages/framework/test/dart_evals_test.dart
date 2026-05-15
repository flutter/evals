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

/// A separate evaluator type for scenario-level scoring to avoid name collision.
class _ScenarioEvaluator extends Evaluator {
  const _ScenarioEvaluator();

  @override
  String get name => 'ScenarioEvaluator';

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
    List<ai.Message> history = const [],
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

/// An eval that echoes its input as the model output.
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
      ai.Message(role: ai.Role.model, content: [ai.TextPart(input)]),
    );
    return state;
  }
}

/// An eval with no evaluators.
class _NoEvaluatorsEval extends Eval {
  @override
  String get name => 'no_evaluators';

  @override
  String get input => 'test';

  @override
  Future<EvalState> run(EvalState state) async => state;
}

/// An eval that captures tools from the state into the store.
class _ToolCapturingEval extends Eval {
  @override
  String get name => 'tool_capturing';

  @override
  String get input => 'test';

  @override
  List<Evaluator> get evaluators => const [_AlwaysCorrectEvaluator()];

  @override
  Future<EvalState> run(EvalState state) async {
    state.store['tools'] = state.tools;
    return state;
  }
}

void main() {
  final agent = _MockAgent();
  final backend = _MockBackend(agent);

  group('Eval.score', () {
    test('collects scores from all evaluators', () async {
      final eval = _EchoEval('test input');
      final state = EvalState(
        context: EvalContext(agent: agent),
      );

      final scores = await eval.score(state);

      expect(scores, hasLength(1));
      expect(scores['_AlwaysCorrectEvaluator']?.value, 1.0);
    });

    test('returns empty map when no evaluators', () async {
      final eval = _NoEvaluatorsEval();
      final state = EvalState(
        context: EvalContext(agent: agent),
      );

      final scores = await eval.score(state);

      expect(scores, isEmpty);
    });
  });

  group('EvalSet.run', () {
    test('runs all evals and returns results with scores', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [_EchoEval('What is Dart?'), _EchoEval('What is Flutter?')],
      );

      final results = await evalSet.run();

      expect(results, hasLength(2));
      expect(results.every((r) => r.scores.values.first.value == 1.0), isTrue);
    });

    test('runs model × eval matrix', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('provider', 'model-a'), Model('provider', 'model-b')],
        evals: [_EchoEval('q1')],
      );

      final results = await evalSet.run();

      // 2 models × 1 scenario (baseline) × 1 eval = 2 results
      expect(results, hasLength(2));
    });

    test('runs model × scenario × eval matrix', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('provider', 'model-a'), Model('provider', 'model-b')],
        scenarios: [
          const Scenario(name: 'baseline'),
          const Scenario(name: 'with_tools'),
        ],
        evals: [_EchoEval('q1'), _EchoEval('q2')],
      );

      final results = await evalSet.run();

      // 2 models × 2 scenarios × 2 evals = 8 results
      expect(results, hasLength(8));
    });

    test('returns empty results for empty evals list', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [],
      );

      final results = await evalSet.run();

      expect(results, isEmpty);
    });

    test('eval result includes model and scenario', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [_EchoEval('hi')],
        scenarios: [const Scenario(name: 'my_scenario', tags: ['fast'])],
      );

      final results = await evalSet.run();

      final evalResult = results.first;
      expect(evalResult.model, 'test/model');
      expect(evalResult.scenario, 'my_scenario');
    });

    test('merges eval-level and scenario-level tools', () async {
      final mockTool = ai.Tool(
        name: 'scenario-tool',
        description: 'mock',
        run: (input) async => 'mock output',
      );

      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        scenarios: [
          Scenario(name: 'with_tools', tools: [mockTool]),
        ],
        evals: [_ToolCapturingEval()],
      );

      final results = await evalSet.run();

      final capturedTools = results.first.store['tools'] as List<ai.Tool>;
      expect(capturedTools.map((t) => t.name), contains('scenario-tool'));
    });

    test('merges MCP tools from EvalContext onto state.tools', () async {
      // Simulate MCP tools by passing them through EvalContext.mcpTools.
      final mcpTool = ai.Tool(
        name: 'mcp-server/search',
        description: 'mock mcp tool',
        run: (input) async => 'mcp result',
      );

      final eval = _ToolCapturingEval();
      final context = EvalContext(
        agent: agent,
        mcpTools: [mcpTool],
      );

      final result = await eval.execute(context);
      final capturedTools = result.store['tools'] as List<ai.Tool>;
      expect(capturedTools.map((t) => t.name), contains('mcp-server/search'));
    });

    test('scenario evaluators are merged with eval evaluators', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        scenarios: [
          const Scenario(
            name: 'with_evaluator',
            evaluators: [_ScenarioEvaluator()],
          ),
        ],
        evals: [_EchoEval('test')],
      );

      final results = await evalSet.run();
      final scores = results.first.scores;

      // Both eval-level and scenario-level evaluators should run.
      expect(scores, hasLength(2));
      expect(scores.containsKey('_AlwaysCorrectEvaluator'), isTrue);
      expect(scores.containsKey('ScenarioEvaluator'), isTrue);
      expect(scores.values.every((s) => s.value == 1.0), isTrue);
    });

    test('throws on duplicate evaluator names', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        scenarios: [
          const Scenario(
            name: 'dup_evaluator',
            evaluators: [_AlwaysCorrectEvaluator()],
          ),
        ],
        evals: [_EchoEval('test')], // also has _AlwaysCorrectEvaluator
      );

      final results = await evalSet.run();
      // The duplicate is caught during score(), recorded as _lifecycle error.
      expect(results.first.scores.containsKey('_lifecycle'), isTrue);
      expect(results.first.scores['_lifecycle']!.value, 0.0);
    });

    test('default run() produces output without override', () async {
      final evalSet = EvalSet(
        backend: backend,
        models: [Model('test', 'model')],
        evals: [_DefaultRunEval()],
      );

      final results = await evalSet.run();
      final result = results.first;

      // The mock agent returns 'ok' — the default run() should capture it.
      expect(result.output, equals('ok'));
      expect(result.store['agent_status'], equals('completed'));
    });
  });
}

/// An eval that does NOT override [run], relying on the base class default.
class _DefaultRunEval extends Eval {
  @override
  String get name => 'default_run';

  @override
  String get input => 'What is Dart?';

  @override
  List<Evaluator> get evaluators => const [_AlwaysCorrectEvaluator()];
}
