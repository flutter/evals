import 'package:ai/ai.dart' as ai;
import 'package:evals_results/evals_results.dart';
import 'package:framework/framework.dart';
import 'package:test/test.dart';

// ---------------------------------------------------------------------------
// Fake Agent
// ---------------------------------------------------------------------------

class _FakeAgent extends Agent {
  @override
  final String model;

  const _FakeAgent({this.model = 'test/model'});

  @override
  Agent copyWith({String? model}) => _FakeAgent(model: model ?? this.model);

  @override
  Future<Result> run({
    required String task,
    String systemMessage = '',
    List<Tool> additionalTools = const [],
    List<Message> history = const [],
  }) async {
    final newMessages = [
      ...history,
      if (systemMessage.isNotEmpty) Message.text(Role.system, systemMessage),
      Message.text(Role.user, task),
      Message.text(Role.model, 'Response to: $task'),
    ];

    return Result(
      messages: newMessages,
      status: AgentStatus.completed,
      steps: 1,
    );
  }
}

// ---------------------------------------------------------------------------
// Fake Evaluator
// ---------------------------------------------------------------------------

class _TestEvaluator extends Evaluator {
  @override
  final String name;
  final double returnScore;
  final bool isError;

  _TestEvaluator({
    required this.name,
    required this.returnScore,
    this.isError = false,
  });

  @override
  Future<Score> evaluate(EvalState state) async {
    if (isError) return Score.error(explanation: 'Test error');
    return Score(value: returnScore, explanation: 'Test score');
  }
}

// ---------------------------------------------------------------------------
// Test MultiStepEval
// ---------------------------------------------------------------------------

class _TestMultiStepEval extends MultiStepEval {
  @override
  final String name = 'test_multi_step';
  
  @override
  final String target = 'target_value';

  @override
  final List<EvalStep> steps;

  const _TestMultiStepEval(this.steps);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('MultiStepEval', () {
    test('executes all steps and aggregates scores', () async {
      final eval = _TestMultiStepEval([
        EvalStep(
          name: 'step1',
          input: 'input 1',
          evaluators: [_TestEvaluator(name: 'evalA', returnScore: 1.0)],
        ),
        EvalStep(
          name: 'step2',
          input: 'input 2',
          evaluators: [_TestEvaluator(name: 'evalA', returnScore: 0.5)],
        ),
      ]);

      final context = EvalContext(
        agent: const _FakeAgent(),
        scenario: Scenario(name: 'test_scenario', evaluators: []),
      );

      final result = await eval.execute(context);

      expect(result.error, isNull);
      expect(result.stepsCompleted, equals(2));
      expect(result.scores.length, equals(2));
      expect(result.scores['step1_evalA']?.value, equals(1.0));
      expect(result.scores['step2_evalA']?.value, equals(0.5));
      expect(result.output, equals('Response to: input 2'));
    });

    test('preserves cumulative message history', () async {
      final eval = _TestMultiStepEval([
        EvalStep(name: 'step1', input: 'first input'),
        EvalStep(name: 'step2', input: 'second input'),
      ]);

      final context = EvalContext(
        agent: const _FakeAgent(),
        scenario: Scenario(name: 'default', evaluators: []),
      );

      final result = await eval.execute(context);

      final trajectory = result.trajectory;
      expect(trajectory, isNotNull);
      
      // Expected trajectory: user(first), model, user(second), model
      final texts = trajectory!.map((m) => m.text).toList();
      expect(texts[0], equals('first input'));
      expect(texts[1], equals('Response to: first input'));
      expect(texts[2], equals('second input'));
      expect(texts[3], equals('Response to: second input'));
    });

    test('stops early if step falls below minScore', () async {
      final eval = _TestMultiStepEval([
        EvalStep(
          name: 'step1',
          input: 'input 1',
          evaluators: [_TestEvaluator(name: 'eval', returnScore: 0.0)],
          minScore: 0.5, // Should fail here
        ),
        EvalStep(
          name: 'step2',
          input: 'input 2',
          evaluators: [_TestEvaluator(name: 'eval', returnScore: 1.0)],
        ),
      ]);

      final context = EvalContext(
        agent: const _FakeAgent(),
        scenario: Scenario(name: 'default', evaluators: []),
      );

      final result = await eval.execute(context);

      // Only completed 1 step
      expect(result.stepsCompleted, equals(1));
      
      // Should have score for step1, but not step2
      expect(result.scores.containsKey('step1_eval'), isTrue);
      expect(result.scores.containsKey('step2_eval'), isFalse);
    });

    test('applies scenario evaluators to every step', () async {
      final eval = _TestMultiStepEval([
        EvalStep(name: 's1', input: 'i1'),
        EvalStep(name: 's2', input: 'i2'),
      ]);

      final context = EvalContext(
        agent: const _FakeAgent(),
        scenario: Scenario(
          name: 'test_scenario',
          evaluators: [_TestEvaluator(name: 'scenario_eval', returnScore: 1.0)],
        ),
      );

      final result = await eval.execute(context);

      expect(result.scores.containsKey('s1_scenario_eval'), isTrue);
      expect(result.scores.containsKey('s2_scenario_eval'), isTrue);
    });
  });
}
