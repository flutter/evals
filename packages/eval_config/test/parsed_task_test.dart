import 'package:eval_config/eval_config.dart';
import 'package:test/test.dart';

void main() {
  group('ParsedTask', () {
    test('has correct defaults', () {
      const task = ParsedTask(
        id: 'test',
        taskFunc: 'question_answer',
        samples: [],
        variant: Variant(),
      );

      expect(task.sandboxType, 'local');
      expect(task.saveExamples, false);
      expect(task.systemMessage, isNull);
      expect(task.allowedVariants, isNull);
      expect(task.examplesDir, isNull);
      expect(task.model, isNull);
      expect(task.config, isNull);
      expect(task.timeLimit, isNull);
      expect(task.messageLimit, isNull);
      expect(task.tokenLimit, isNull);
      expect(task.costLimit, isNull);
    });

    test('stores all constructor fields', () {
      const task = ParsedTask(
        id: 'my_task',
        taskFunc: 'flutter_code_gen',
        samples: [Sample(id: 's1', input: 'q', target: 'a')],
        variant: Variant(name: 'full'),
        sandboxType: 'podman',
        systemMessage: 'Be helpful',
        allowedVariants: ['baseline', 'full'],
        saveExamples: true,
        examplesDir: '/tmp/examples',
        model: 'gemini-pro',
        config: {'temperature': 0.5},
        modelRoles: {'grader': 'gpt-4o'},
        timeLimit: 600,
        messageLimit: 50,
        tokenLimit: 4096,
        workingLimit: 300,
        costLimit: 1.5,
        displayName: 'My Task',
        version: 2,
        metadata: {'author': 'test'},
      );

      expect(task.id, 'my_task');
      expect(task.taskFunc, 'flutter_code_gen');
      expect(task.samples, hasLength(1));
      expect(task.variant.name, 'full');
      expect(task.sandboxType, 'podman');
      expect(task.systemMessage, 'Be helpful');
      expect(task.allowedVariants, ['baseline', 'full']);
      expect(task.saveExamples, true);
      expect(task.examplesDir, '/tmp/examples');
      expect(task.model, 'gemini-pro');
      expect(task.config, {'temperature': 0.5});
      expect(task.modelRoles, {'grader': 'gpt-4o'});
      expect(task.timeLimit, 600);
      expect(task.messageLimit, 50);
      expect(task.tokenLimit, 4096);
      expect(task.workingLimit, 300);
      expect(task.costLimit, 1.5);
      expect(task.displayName, 'My Task');
      expect(task.version, 2);
      expect(task.metadata, {'author': 'test'});
    });
  });

  group('copyWith()', () {
    test('overrides specified fields', () {
      const original = ParsedTask(
        id: 'original',
        taskFunc: 'func_a',
        samples: [],
        variant: Variant(name: 'baseline'),
        timeLimit: 100,
      );

      final copy = original.copyWith(
        id: 'copied',
        timeLimit: 999,
      );

      expect(copy.id, 'copied');
      expect(copy.timeLimit, 999);
    });

    test('preserves fields not overridden', () {
      const original = ParsedTask(
        id: 'task',
        taskFunc: 'func',
        samples: [],
        variant: Variant(name: 'full'),
        sandboxType: 'podman',
        systemMessage: 'Be helpful',
        model: 'gemini-pro',
      );

      final copy = original.copyWith(id: 'new_id');

      expect(copy.taskFunc, 'func');
      expect(copy.variant.name, 'full');
      expect(copy.sandboxType, 'podman');
      expect(copy.systemMessage, 'Be helpful');
      expect(copy.model, 'gemini-pro');
    });

    test('returns a new instance (not the same object)', () {
      const original = ParsedTask(
        id: 'a',
        taskFunc: 'f',
        samples: [],
        variant: Variant(),
      );

      final copy = original.copyWith(id: 'b');

      expect(identical(original, copy), isFalse);
      expect(original.id, 'a');
      expect(copy.id, 'b');
    });

    test('can override samples list', () {
      const original = ParsedTask(
        id: 'task',
        taskFunc: 'func',
        samples: [Sample(id: 's1', input: 'q', target: 'a')],
        variant: Variant(),
      );

      final copy = original.copyWith(
        samples: [
          const Sample(id: 's2', input: 'q2', target: 'a2'),
          const Sample(id: 's3', input: 'q3', target: 'a3'),
        ],
      );

      expect(copy.samples, hasLength(2));
      expect(copy.samples.first.id, 's2');
    });
  });
}
