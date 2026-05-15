import 'package:framework/framework.dart';
import 'package:test/test.dart';

// ---------------------------------------------------------------------------
// Fake AI — returns a canned response for grading prompts
// ---------------------------------------------------------------------------

class _FakeGraderAI implements AI {
  final String gradeResponse;

  const _FakeGraderAI(this.gradeResponse);

  @override
  Future<Response> generate({
    required String model,
    required List<Message> messages,
    List<Tool> tools = const [],
    bool returnToolRequests = false,
  }) async {
    return Response(
      message: Message.text(Role.model, gradeResponse),
    );
  }
}

class _FailingGraderAI implements AI {
  const _FailingGraderAI();

  @override
  Future<Response> generate({
    required String model,
    required List<Message> messages,
    List<Tool> tools = const [],
    bool returnToolRequests = false,
  }) async {
    throw Exception('API connection failed');
  }
}

// ---------------------------------------------------------------------------
// Fake Agent — for building EvalState
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
    return Result(
      messages: [
        Message.text(Role.model, 'The answer is fl_chart.'),
      ],
      status: AgentStatus.completed,
      steps: 1,
    );
  }
}

// ---------------------------------------------------------------------------
// Helper — builds an EvalState pre-populated like Eval.execute() would
// ---------------------------------------------------------------------------

EvalState _buildState({
  String input = 'What package is best for charts?',
  String target = 'fl_chart',
  String output = 'I recommend fl_chart for Flutter charting.',
}) {
  final state = EvalState(
    context: EvalContext(agent: const _FakeAgent()),
  );
  state.messages.addAll([
    Message.text(Role.system, 'You are a helpful assistant.'),
    Message.text(Role.user, input),
    Message.text(Role.model, output),
  ]);
  state.output = Result(
    messages: state.messages,
    status: AgentStatus.completed,
    steps: 1,
  );
  // Simulate what Eval.execute() does before scoring.
  state.store['input'] = input;
  state.store['target'] = target;
  return state;
}

// ============================================================================
// Tests
// ============================================================================

void main() {
  group('ModelGradedEvaluator', () {
    test('parses GRADE: 1.0 as correct', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI(
          'GRADE: 1.0\nThe answer correctly identifies fl_chart.',
        ),
        model: 'test/grader',
        rubric: 'Does the answer mention fl_chart?',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(1.0));
      expect(score.isError, isFalse);
      expect(
        score.explanation,
        contains('The answer correctly identifies fl_chart'),
      );
    });

    test('parses GRADE: 0.0 as incorrect', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI(
          'GRADE: 0.0\nThe answer does not mention the expected package.',
        ),
        model: 'test/grader',
        rubric: 'Does the answer mention fl_chart?',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.0));
      expect(score.isError, isFalse);
    });

    test('parses GRADE: 0.5 as partial when allowPartialCredit is true', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI(
          'GRADE: 0.5\nMentions the package but lacks detail.',
        ),
        model: 'test/grader',
        rubric: 'Does the answer explain why fl_chart is good?',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.5));
      expect(score.isError, isFalse);
    });

    test('treats GRADE: 0.5 as incorrect when allowPartialCredit is false', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI('GRADE: 0.5\nPartially correct.'),
        model: 'test/grader',
        rubric: 'test',
        allowPartialCredit: false,
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.0));
      expect(score.isError, isFalse);
      expect(score.explanation, contains('partial credit is disabled'));
    });

    test('custom intermediate value is parsed and respected', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI('GRADE: 0.75\nPartial.'),
        model: 'test/grader',
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.75));
    });

    test('returns error when grader output cannot be parsed', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI(
          'This answer looks good!', // No GRADE: prefix
        ),
        model: 'test/grader',
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.isError, isTrue);
      expect(score.explanation, contains('Could not parse grade'));
    });

    test('returns error when grading model call fails', () async {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FailingGraderAI(),
        model: 'test/grader',
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.isError, isTrue);
      expect(score.explanation, contains('Grading model call failed'));
    });

    test('reads input and target from state.store', () async {
      // Track the prompt that was sent to the grader.
      String? capturedPrompt;
      final evaluator = ModelGradedEvaluator(
        graderAI: _PromptCapturingAI(
          response: 'GRADE: 1.0\nCorrect.',
          onCapture: (prompt) => capturedPrompt = prompt,
        ),
        model: 'test/grader',
        rubric: 'Check the answer.',
      );

      final state = _buildState(
        input: 'Recommend a state management package.',
        target: 'riverpod',
      );
      await evaluator.evaluate(state);

      expect(capturedPrompt, contains('Recommend a state management package'));
      expect(capturedPrompt, contains('riverpod'));
    });

    test('evaluatorName overrides default name', () {
      final evaluator = ModelGradedEvaluator(
        graderAI: const _FakeGraderAI('GRADE: 1.0'),
        model: 'test/grader',
        rubric: 'test',
        evaluatorName: 'code_correctness',
      );

      expect(evaluator.name, equals('code_correctness'));
    });

    test('uses custom template', () async {
      String? capturedPrompt;
      final evaluator = ModelGradedEvaluator(
        graderAI: _PromptCapturingAI(
          response: 'GRADE: 1.0\nGood code.',
          onCapture: (prompt) => capturedPrompt = prompt,
        ),
        model: 'test/grader',
        rubric: 'Check Dart idioms.',
        template: codeQualityTemplate,
      );

      final state = _buildState();
      await evaluator.evaluate(state);

      // The code quality template has Dart-specific instructions.
      expect(capturedPrompt, contains('senior Dart/Flutter developer'));
    });
  });

  group('MajorityVoteEvaluator', () {
    test('averages to 1.0 when all are correct', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'a'),
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'b'),
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'c'),
        ],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(1.0));
      expect(score.explanation, contains('Average: 1.00'));
    });

    test('averages to 0.0 when all are incorrect', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FakeGraderAI('GRADE: 0.0\nWrong.') as AI, model: 'a'),
          (ai: const _FakeGraderAI('GRADE: 0.0\nWrong.') as AI, model: 'b'),
          (ai: const _FakeGraderAI('GRADE: 0.0\nWrong.') as AI, model: 'c'),
        ],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.0));
      expect(score.explanation, contains('Average: 0.00'));
    });

    test('calculates accurate average of mixed grades', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'a'),
          (ai: const _FakeGraderAI('GRADE: 0.5\nPartial.') as AI, model: 'b'),
          (ai: const _FakeGraderAI('GRADE: 0.0\nWrong.') as AI, model: 'c'),
        ],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      // (1.0 + 0.5 + 0.0) / 3 = 0.5
      expect(score.value, equals(0.5));
      expect(score.explanation, contains('Average: 0.50'));
    });

    test('treats average < 1.0 as 0.0 when allowPartialCredit is false', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'a'),
          (ai: const _FakeGraderAI('GRADE: 0.5\nPartial.') as AI, model: 'b'),
          (ai: const _FakeGraderAI('GRADE: 0.0\nWrong.') as AI, model: 'c'),
        ],
        rubric: 'test',
        allowPartialCredit: false,
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.value, equals(0.0));
      expect(score.explanation, contains('partial credit is disabled'));
    });

    test('skips errored graders without failing', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FakeGraderAI('GRADE: 1.0\nCorrect.') as AI, model: 'a'),
          (ai: const _FailingGraderAI() as AI, model: 'b'),
          (ai: const _FakeGraderAI('GRADE: 0.5\nPartial.') as AI, model: 'c'),
        ],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      // (1.0 + 0.5) / 2 valid graders = 0.75
      expect(score.value, equals(0.75));
      expect(score.explanation, contains('Average: 0.75'));
    });

    test('returns error when all graders fail', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: [
          (ai: const _FailingGraderAI() as AI, model: 'a'),
          (ai: const _FailingGraderAI() as AI, model: 'b'),
        ],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.isError, isTrue);
      expect(score.explanation, contains('All 2 graders failed'));
    });

    test('returns error when no graders are configured', () async {
      final evaluator = MajorityVoteEvaluator(
        graders: const [],
        rubric: 'test',
      );

      final state = _buildState();
      final score = await evaluator.evaluate(state);

      expect(score.isError, isTrue);
      expect(score.explanation, contains('No graders configured'));
    });
  });

  group('fillTemplate', () {
    test('replaces all placeholders', () {
      final result = fillTemplate(
        'Hello {name}, you are {age} years old.',
        {'name': 'Alice', 'age': '30'},
      );
      expect(result, equals('Hello Alice, you are 30 years old.'));
    });

    test('leaves unknown placeholders intact', () {
      final result = fillTemplate(
        'Hello {name}, {unknown} here.',
        {'name': 'Bob'},
      );
      expect(result, equals('Hello Bob, {unknown} here.'));
    });
  });
}

// ---------------------------------------------------------------------------
// Helper: AI that captures the prompt for inspection
// ---------------------------------------------------------------------------

class _PromptCapturingAI implements AI {
  final String response;
  final void Function(String prompt) onCapture;

  const _PromptCapturingAI({
    required this.response,
    required this.onCapture,
  });

  @override
  Future<Response> generate({
    required String model,
    required List<Message> messages,
    List<Tool> tools = const [],
    bool returnToolRequests = false,
  }) async {
    // Capture the user message content (the grading prompt).
    final userMessage = messages.firstWhere((m) => m.role == Role.user);
    onCapture(userMessage.text ?? '');
    return Response(message: Message.text(Role.model, response));
  }
}
