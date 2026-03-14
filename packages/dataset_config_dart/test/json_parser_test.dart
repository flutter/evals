import 'package:dataset_config_dart/dataset_config_dart.dart';
import 'package:test/test.dart';

void main() {
  late JsonParser parser;

  setUp(() {
    parser = JsonParser();
  });

  group('parseTasksFromMaps()', () {
    test('parses a minimal task map', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'my_task',
          'func': 'question_answer',
          'samples': {
            'inline': [
              {'id': 's1', 'input': 'What is Dart?', 'target': 'A language'},
            ],
          },
        },
      ]);

      expect(tasks, hasLength(1));
      expect(tasks.first.id, 'my_task');
      expect(tasks.first.func, 'question_answer');
      expect(tasks.first.samples, hasLength(1));
      expect(tasks.first.samples.first.id, 's1');
      expect(tasks.first.samples.first.input, 'What is Dart?');
      expect(tasks.first.samples.first.target, 'A language');
    });

    test('defaults func to id when func is absent', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'dart_qa',
          'samples': {'inline': <Map<String, dynamic>>[]},
        },
      ]);

      expect(tasks.first.func, 'dart_qa');
    });

    test('throws FormatException when sample missing required field', () {
      expect(
        () => parser.parseTasksFromMaps([
          {
            'id': 'bad_task',
            'samples': {
              'inline': [
                {'id': 's1', 'input': 'hello'}, // missing 'target'
              ],
            },
          },
        ]),
        throwsA(isA<FormatException>()),
      );
    });

    test('normalises tags from comma-separated string', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'tagged_task',
          'samples': {
            'inline': [
              {
                'id': 's1',
                'input': 'q',
                'target': 'a',
                'tags': 'flutter, dart, widgets',
              },
            ],
          },
        },
      ]);

      final metadata = tasks.first.samples.first.metadata!;
      expect(metadata['tags'], equals(['flutter', 'dart', 'widgets']));
    });

    test('normalises tags from list', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'tagged_task',
          'samples': {
            'inline': [
              {
                'id': 's1',
                'input': 'q',
                'target': 'a',
                'tags': ['tag1', 'tag2'],
              },
            ],
          },
        },
      ]);

      final metadata = tasks.first.samples.first.metadata!;
      expect(metadata['tags'], equals(['tag1', 'tag2']));
    });

    test('defaults tags to empty list when absent', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'no_tags',
          'samples': {
            'inline': [
              {'id': 's1', 'input': 'q', 'target': 'a'},
            ],
          },
        },
      ]);

      final metadata = tasks.first.samples.first.metadata!;
      expect(metadata['tags'], isEmpty);
    });

    test('defaults difficulty to medium', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'task',
          'samples': {
            'inline': [
              {'id': 's1', 'input': 'q', 'target': 'a'},
            ],
          },
        },
      ]);

      final metadata = tasks.first.samples.first.metadata!;
      expect(metadata['difficulty'], 'medium');
    });

    test('parses sample-level choices, setup, files', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'task',
          'samples': {
            'inline': [
              {
                'id': 's1',
                'input': 'q',
                'target': 'a',
                'choices': ['A', 'B', 'C'],
                'setup': 'echo hello',
                'files': {'main.dart': 'void main() {}'},
              },
            ],
          },
        },
      ]);

      final sample = tasks.first.samples.first;
      expect(sample.choices, ['A', 'B', 'C']);
      expect(sample.setup, 'echo hello');
      expect(sample.files, {'main.dart': 'void main() {}'});
    });

    test('parses all task-level settings', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'full_task',
          'func': 'my_func',
          'system_message': 'Be helpful',
          'allowed_variants': ['baseline', 'full'],
          'model': 'gemini-pro',
          'config': {'temperature': 0.5},
          'model_roles': {'grader': 'gpt-4o'},
          'message_limit': 50,
          'token_limit': 4096,
          'time_limit': 600,
          'working_limit': 300,
          'cost_limit': 1.5,
          'display_name': 'Full Task',
          'version': 2,
          'metadata': {'author': 'test'},
          'samples': {'inline': <Map<String, dynamic>>[]},
        },
      ]);

      final task = tasks.first;
      expect(task.systemMessage, 'Be helpful');
      expect(task.allowedVariants, ['baseline', 'full']);
      expect(task.model, 'gemini-pro');
      expect(task.config, {'temperature': 0.5});
      expect(task.modelRoles, {'grader': 'gpt-4o'});
      expect(task.messageLimit, 50);
      expect(task.tokenLimit, 4096);
      expect(task.timeLimit, 600);
      expect(task.workingLimit, 300);
      expect(task.costLimit, 1.5);
      expect(task.displayName, 'Full Task');
      expect(task.version, 2);
      expect(task.metadata, {'author': 'test'});
    });

    test('skips empty sample maps', () {
      final tasks = parser.parseTasksFromMaps([
        {
          'id': 'task',
          'samples': {
            'inline': [<String, dynamic>{}],
          },
        },
      ]);

      expect(tasks.first.samples, isEmpty);
    });
  });

  group('parseJobFromMap()', () {
    test('parses minimal job with defaults', () {
      final job = parser.parseJobFromMap(<String, dynamic>{});

      expect(job.logDir, '');
      expect(job.sandboxType, 'local');
      expect(job.maxConnections, 10);
      expect(job.models, isNull);
      expect(job.saveExamples, false);
    });

    test('parses all core fields', () {
      final job = parser.parseJobFromMap({
        'log_dir': './logs/run1',
        'sandbox_type': 'podman',
        'max_connections': 5,
        'models': ['gemini-pro', 'gpt-4o'],
        'save_examples': true,
      });

      expect(job.logDir, './logs/run1');
      expect(job.sandboxType, 'podman');
      expect(job.maxConnections, 5);
      expect(job.models, ['gemini-pro', 'gpt-4o']);
      expect(job.saveExamples, true);
    });

    test('parses promoted eval_set fields', () {
      final job = parser.parseJobFromMap({
        'retry_attempts': 20,
        'max_retries': 3,
        'retry_wait': 5.0,
        'fail_on_error': 0.5,
        'continue_on_fail': true,
        'max_samples': 100,
        'max_tasks': 4,
        'log_level': 'debug',
        'tags': ['ci', 'nightly'],
        'metadata': {'run_by': 'bot'},
      });

      expect(job.retryAttempts, 20);
      expect(job.maxRetries, 3);
      expect(job.retryWait, 5.0);
      expect(job.failOnError, 0.5);
      expect(job.continueOnFail, true);
      expect(job.maxSamples, 100);
      expect(job.maxTasks, 4);
      expect(job.logLevel, 'debug');
      expect(job.tags, ['ci', 'nightly']);
      expect(job.metadata, {'run_by': 'bot'});
    });

    test('parses pass-through overrides', () {
      final job = parser.parseJobFromMap({
        'eval_set_overrides': {'custom_key': 'custom_value'},
        'task_defaults': {'time_limit': 600},
      });

      expect(job.evalSetOverrides, {'custom_key': 'custom_value'});
      expect(job.taskDefaults, {'time_limit': 600});
    });
  });

  group('parseTasks()', () {
    test('returns empty list (filesystem not used)', () {
      final tasks = parser.parseTasks('/nonexistent');
      expect(tasks, isEmpty);
    });
  });

  group('parseJob()', () {
    test('throws UnsupportedError', () {
      expect(
        () => parser.parseJob('/path', '/root'),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}
