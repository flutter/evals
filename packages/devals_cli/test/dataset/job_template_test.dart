import 'package:devals/src/dataset/file_templates/job_template.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('jobTemplate()', () {
    test('generates valid YAML', () {
      final result = jobTemplate(
        name: 'test_job',
        models: ['model1'],
        variants: ['variant1'],
        tasks: ['task1'],
      );

      // Should be valid YAML
      expect(() => loadYaml(result), returnsNormally);
    });

    test('includes job name', () {
      final result = jobTemplate(
        name: 'my_job',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      expect(result, contains('# Job Configuration: my_job'));
    });

    test('single model formatted correctly', () {
      final result = jobTemplate(
        name: 'test',
        models: ['gemini-pro'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      expect(result, contains('- gemini-pro'));
    });

    test('multiple models listed', () {
      final result = jobTemplate(
        name: 'test',
        models: ['model1', 'model2', 'model3'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      expect(result, contains('- model1'));
      expect(result, contains('- model2'));
      expect(result, contains('- model3'));
    });

    test('single variant formatted correctly', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['baseline'],
        tasks: ['t1'],
      );
      expect(result, contains('baseline: {}'));
    });

    test(
      'multiple variants listed',
      () {
        final result = jobTemplate(
          name: 'test',
          models: ['m1'],
          variants: ['v1', 'v2', 'v3'],
          tasks: ['t1'],
        );
        expect(result, contains('v1: {}'));
        expect(result, contains('v2: {}'));
        expect(result, contains('v3: {}'));
      },
      skip: 'The way CLI presents variants is being refactored.',
    );

    test('single task with empty config', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['my_task'],
      );
      expect(result, contains('my_task: {}'));
    });

    test('multiple tasks listed', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['task1', 'task2', 'task3'],
      );
      expect(result, contains('task1: {}'));
      expect(result, contains('task2: {}'));
      expect(result, contains('task3: {}'));
    });

    test('empty models list', () {
      final result = jobTemplate(
        name: 'test',
        models: [],
        variants: ['v1'],
        tasks: ['t1'],
      );
      // Should still generate valid YAML structure
      expect(result, contains('models:'));
    });

    test('empty variants list', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: [],
        tasks: ['t1'],
      );
      expect(result, contains('variants:'));
    });

    test('empty tasks list', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['v1'],
        tasks: [],
      );
      expect(result, contains('tasks:'));
    });

    test('special characters in name', () {
      final result = jobTemplate(
        name: 'test-job_v2',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      expect(result, contains('# Job Configuration: test-job_v2'));
    });

    test('includes header comment', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      expect(result, contains('# Job Configuration:'));
    });

    test('sections appear in correct order', () {
      final result = jobTemplate(
        name: 'test',
        models: ['m1'],
        variants: ['v1'],
        tasks: ['t1'],
      );
      final configIndex = result.indexOf('# Job Configuration:');
      final modelsIndex = result.indexOf('models:');
      final variantsIndex = result.indexOf('variants:');
      final tasksIndex = result.indexOf('tasks:');

      expect(configIndex, lessThan(modelsIndex));
      expect(modelsIndex, lessThan(variantsIndex));
      expect(variantsIndex, lessThan(tasksIndex));
    });
  });
}
