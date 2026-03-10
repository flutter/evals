import 'package:dataset_config/dataset_config.dart';
import 'package:test/test.dart';

void main() {
  late EvalSetResolver resolver;

  /// Helper to create a minimal [ParsedTask] for testing.
  ParsedTask makeTask({
    String id = 'test_task',
    String taskFunc = 'question_answer',
    List<Sample>? samples,
    Variant? variant,
    List<String>? allowedVariants,
    String? systemMessage,
    String? model,
    int? timeLimit,
    int? messageLimit,
  }) {
    return ParsedTask(
      id: id,
      taskFunc: taskFunc,
      samples:
          samples ??
          [
            const Sample(
              id: 's1',
              input: 'What is Dart?',
              target: 'A language',
              metadata: {'difficulty': 'easy', 'tags': <String>[]},
            ),
          ],
      variant: variant ?? const Variant(),
      allowedVariants: allowedVariants,
      systemMessage: systemMessage,
      model: model,
      timeLimit: timeLimit,
      messageLimit: messageLimit,
    );
  }

  /// Helper to create a minimal [Job] for testing.
  Job makeJob({
    String logDir = '/tmp/logs',
    String sandboxType = 'local',
    List<String>? models,
    Map<String, Map<String, dynamic>>? variants,
    Map<String, JobTask>? tasks,
    bool saveExamples = false,
    Map<String, dynamic>? taskDefaults,
  }) {
    return Job(
      logDir: logDir,
      sandboxType: sandboxType,
      models: models,
      variants: variants,
      tasks: tasks,
      saveExamples: saveExamples,
      taskDefaults: taskDefaults,
    );
  }

  setUp(() {
    resolver = EvalSetResolver();
  });

  group('resolve()', () {
    test(
      'single task with baseline variant produces 1 EvalSet with 1 Task',
      () {
        final results = resolver.resolve(
          [makeTask()],
          makeJob(models: ['gemini-pro']),
          '/tmp/dataset',
        );

        expect(results, hasLength(1));
        final evalSet = results.first;
        expect(evalSet.tasks, hasLength(1));
        expect(evalSet.tasks.first.name, 'test_task:baseline');
      },
    );

    test('task name follows "id:variant" format', () {
      final results = resolver.resolve(
        [makeTask(id: 'dart_qa')],
        makeJob(
          models: ['gemini-pro'],
          variants: {'my_variant': {}},
        ),
        '/tmp/dataset',
      );

      expect(results.first.tasks.first.name, 'dart_qa:my_variant');
    });

    test('samples are set on the task dataset', () {
      final samples = [
        const Sample(
          id: 'sample_1',
          input: 'input1',
          target: 'target1',
          metadata: {'difficulty': 'easy', 'tags': <String>[]},
        ),
        const Sample(
          id: 'sample_2',
          input: 'input2',
          target: 'target2',
          metadata: {'difficulty': 'hard', 'tags': <String>[]},
        ),
      ];

      final results = resolver.resolve(
        [makeTask(samples: samples)],
        makeJob(models: ['gemini-pro']),
        '/tmp/dataset',
      );

      final dataset = results.first.tasks.first.dataset!;
      expect(dataset.samples, hasLength(2));
      expect(dataset.samples.first.id, 'sample_1');
      expect(dataset.samples.last.id, 'sample_2');
    });

    test('multiple variants produce one Task per variant', () {
      final results = resolver.resolve(
        [makeTask()],
        makeJob(
          models: ['gemini-pro'],
          variants: {'baseline': {}, 'full': {}},
        ),
        '/tmp/dataset',
      );

      final taskNames = results
          .expand((e) => e.tasks)
          .map((t) => t.name)
          .toSet();
      expect(taskNames, containsAll(['test_task:baseline', 'test_task:full']));
    });

    test('model list from job is passed to EvalSet', () {
      final results = resolver.resolve(
        [makeTask()],
        makeJob(models: ['model_a', 'model_b']),
        '/tmp/dataset',
      );

      expect(results.first.model, ['model_a', 'model_b']);
    });

    test('uses default models when job has none', () {
      final results = resolver.resolve(
        [makeTask()],
        makeJob(models: null),
        '/tmp/dataset',
      );

      expect(results.first.model, kDefaultModels);
    });

    test('job with include_samples filters to only matching samples', () {
      final samples = [
        const Sample(
          id: 'keep',
          input: 'i',
          target: 't',
          metadata: {'difficulty': 'easy', 'tags': <String>[]},
        ),
        const Sample(
          id: 'drop',
          input: 'i',
          target: 't',
          metadata: {'difficulty': 'easy', 'tags': <String>[]},
        ),
      ];

      final results = resolver.resolve(
        [makeTask(id: 'filtered', samples: samples)],
        makeJob(
          models: ['m'],
          tasks: {
            'filtered': const JobTask(
              id: 'filtered',
              includeSamples: ['keep'],
            ),
          },
        ),
        '/tmp/dataset',
      );

      final dataset = results.first.tasks.first.dataset!;
      expect(dataset.samples, hasLength(1));
      expect(dataset.samples.first.id, 'keep');
    });

    test('job with exclude_samples filters out excluded', () {
      final samples = [
        const Sample(
          id: 'keep',
          input: 'i',
          target: 't',
          metadata: {'difficulty': 'easy', 'tags': <String>[]},
        ),
        const Sample(
          id: 'drop',
          input: 'i',
          target: 't',
          metadata: {'difficulty': 'easy', 'tags': <String>[]},
        ),
      ];

      final results = resolver.resolve(
        [makeTask(id: 'filtered', samples: samples)],
        makeJob(
          models: ['m'],
          tasks: {
            'filtered': const JobTask(
              id: 'filtered',
              excludeSamples: ['drop'],
            ),
          },
        ),
        '/tmp/dataset',
      );

      final dataset = results.first.tasks.first.dataset!;
      expect(dataset.samples, hasLength(1));
      expect(dataset.samples.first.id, 'keep');
    });

    test('local sandbox resolves to null in output', () {
      final results = resolver.resolve(
        [makeTask()],
        makeJob(models: ['m'], sandboxType: 'local'),
        '/tmp/dataset',
      );

      expect(results.first.sandbox, isNull);
    });

    test('respects allowedVariants on tasks', () {
      final results = resolver.resolve(
        [
          makeTask(allowedVariants: ['baseline']),
        ],
        makeJob(
          models: ['m'],
          variants: {'baseline': {}, 'full': {}},
        ),
        '/tmp/dataset',
      );

      final taskNames = results
          .expand((e) => e.tasks)
          .map((t) => t.name)
          .toList();
      expect(taskNames, ['test_task:baseline']);
      expect(taskNames, isNot(contains('test_task:full')));
    });

    test('tasks not in job.tasks are excluded', () {
      final results = resolver.resolve(
        [makeTask(id: 'included'), makeTask(id: 'excluded')],
        makeJob(
          models: ['m'],
          tasks: {
            'included': const JobTask(id: 'included'),
          },
        ),
        '/tmp/dataset',
      );

      final taskNames = results
          .expand((e) => e.tasks)
          .map((t) => t.name)
          .toList();
      expect(taskNames, hasLength(1));
      expect(taskNames.first, contains('included'));
    });

    test('taskFunc is propagated to output Task', () {
      final results = resolver.resolve(
        [makeTask(taskFunc: 'flutter_code_gen')],
        makeJob(models: ['m']),
        '/tmp/dataset',
      );

      expect(results.first.tasks.first.taskFunc, 'flutter_code_gen');
    });

    test('system_message appears in task metadata', () {
      final results = resolver.resolve(
        [makeTask(systemMessage: 'Be concise.')],
        makeJob(models: ['m']),
        '/tmp/dataset',
      );

      final metadata = results.first.tasks.first.metadata!;
      expect(metadata['system_message'], 'Be concise.');
    });

    test('task-level settings propagate to output', () {
      final results = resolver.resolve(
        [makeTask(model: 'gpt-4o', timeLimit: 120, messageLimit: 25)],
        makeJob(models: ['m']),
        '/tmp/dataset',
      );

      final task = results.first.tasks.first;
      expect(task.model, 'gpt-4o');
      expect(task.timeLimit, 120);
      expect(task.messageLimit, 25);
    });

    test('task_defaults from job are used as fallbacks', () {
      final results = resolver.resolve(
        [makeTask()],
        makeJob(
          models: ['m'],
          taskDefaults: {'time_limit': 999, 'message_limit': 77},
        ),
        '/tmp/dataset',
      );

      final task = results.first.tasks.first;
      expect(task.timeLimit, 999);
      expect(task.messageLimit, 77);
    });

    test('task-level settings override task_defaults', () {
      final results = resolver.resolve(
        [makeTask(timeLimit: 100)],
        makeJob(
          models: ['m'],
          taskDefaults: {'time_limit': 999},
        ),
        '/tmp/dataset',
      );

      expect(results.first.tasks.first.timeLimit, 100);
    });

    test('job-level eval_set fields propagate', () {
      final results = resolver.resolve(
        [makeTask()],
        const Job(
          logDir: '/tmp/logs',
          models: ['m'],
          retryAttempts: 42,
          logLevel: 'debug',
        ),
        '/tmp/dataset',
      );

      expect(results.first.retryAttempts, 42);
      expect(results.first.logLevel, 'debug');
    });

    test('dataset name matches task name', () {
      final results = resolver.resolve(
        [makeTask(id: 'my_eval')],
        makeJob(models: ['m']),
        '/tmp/dataset',
      );

      final dataset = results.first.tasks.first.dataset!;
      expect(dataset.name, 'my_eval:baseline');
    });
  });
}
