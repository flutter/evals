import 'package:ai/agents.dart';
import 'package:ai/ai.dart';
import 'package:test/test.dart';

void main() {
  group('AgentConfig', () {
    test('has sensible defaults', () {
      const config = AgentConfig();
      expect(config.maxSteps, 30);
      expect(config.commandTimeout, const Duration(seconds: 60));
      expect(config.maxOutputChars, 50000);
    });

    test('accepts custom values', () {
      const config = AgentConfig(
        maxSteps: 10,
        commandTimeout: Duration(seconds: 120),
        maxOutputChars: 20000,
      );
      expect(config.maxSteps, 10);
      expect(config.commandTimeout, const Duration(seconds: 120));
      expect(config.maxOutputChars, 20000);
    });
  });

  group('Result', () {
    test('toJson serializes correctly', () {
      final result = Result(
        messages: [],
        status: AgentStatus.completed,
        steps: 5,
        usage: const Usage(
          inputTokens: 100,
          outputTokens: 50,
          totalTokens: 150,
        ),
      );
      final json = result.toJson();
      expect(json['status'], 'completed');
      expect(json['steps'], 5);
      expect(json['usage']['inputTokens'], 100);
      expect(json['usage']['totalTokens'], 150);
      expect(json.containsKey('error'), isFalse);
    });

    test('toJson includes error when present', () {
      final result = Result(
        messages: [],
        status: AgentStatus.error,
        steps: 1,
        usage: const Usage.zero(),
        error: 'something went wrong',
      );
      final json = result.toJson();
      expect(json['error'], 'something went wrong');
    });

    test('toJson omits usage when null', () {
      final result = Result(
        messages: [],
        status: AgentStatus.completed,
        steps: 1,
      );
      final json = result.toJson();
      expect(json.containsKey('usage'), isFalse);
    });

    test('round-trips through fromJson', () {
      final original = Result(
        messages: [
          Message.text(Role.user, 'hello'),
          Message.text(Role.model, 'world'),
        ],
        status: AgentStatus.completed,
        steps: 2,
        usage: const Usage(
          inputTokens: 10,
          outputTokens: 20,
          totalTokens: 30,
        ),
      );
      final roundTripped = Result.fromJson(original.toJson());
      expect(roundTripped, equals(original));
    });
  });

  group('Usage', () {
    test('starts at zero', () {
      const usage = Usage.zero();
      expect(usage.inputTokens, 0);
      expect(usage.outputTokens, 0);
      expect(usage.totalTokens, 0);
    });

    test('accumulates correctly', () {
      const u1 = Usage(inputTokens: 10, outputTokens: 5, totalTokens: 15);
      const u2 = Usage(inputTokens: 20, outputTokens: 10, totalTokens: 30);
      final sum = u1 + u2;
      expect(sum.inputTokens, 30);
      expect(sum.outputTokens, 15);
      expect(sum.totalTokens, 45);
    });
  });
}
