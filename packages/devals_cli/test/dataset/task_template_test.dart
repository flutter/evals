import 'package:devals/src/dataset/file_templates/task_template.dart';
import 'package:devals/src/dataset/workspace.dart';
import 'package:test/test.dart';

void main() {
  group('taskTemplate', () {
    test('generates YAML with func field', () {
      final result = taskTemplate(taskFunc: 'question_answer');
      expect(result, contains('func: question_answer'));
    });

    test('includes samples section', () {
      final result = taskTemplate(taskFunc: 'flutter_bug_fix');
      expect(result, contains('samples:'));
      expect(result, contains('- id: sample_1'));
      expect(result, contains('input: |'));
      expect(result, contains('target: |'));
    });

    test('does not include variants (variants are job-level)', () {
      final result = taskTemplate(
        taskFunc: 'flutter_code_gen',
        variants: ['baseline', 'mcp_only'],
      );
      // Variants are now configured at the job level, not task level
      expect(result, isNot(contains('variants:')));
    });

    test('omits variants line when list is empty', () {
      final result = taskTemplate(taskFunc: 'question_answer');
      expect(result, isNot(contains('variants:')));
    });

    test('includes system_message when provided', () {
      final result = taskTemplate(
        taskFunc: 'flutter_bug_fix',
        systemMessage: 'You are a helpful assistant.',
      );
      expect(result, contains('system_message: |'));
      expect(result, contains('You are a helpful assistant.'));
    });

    test('omits system_message when null', () {
      final result = taskTemplate(taskFunc: 'flutter_bug_fix');
      expect(result, isNot(contains('system_message:')));
    });

    test('omits system_message when empty string', () {
      final result = taskTemplate(
        taskFunc: 'flutter_bug_fix',
        systemMessage: '',
      );
      expect(result, isNot(contains('system_message:')));
    });

    group('files section', () {
      test('generates path files with workspace value', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.path,
          workspaceValue: './my_project',
        );
        expect(result, contains('files:'));
        expect(result, contains('/workspace: ./my_project'));
        expect(result, contains('setup:'));
      });

      test('generates path files with default when value is null', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.path,
        );
        expect(result, contains('files:'));
        expect(result, contains('/workspace: ./project'));
      });

      test('generates create workspace as files', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.create,
        );
        expect(result, contains('files:'));
        expect(result, contains('/workspace: ./project'));
        expect(result, contains('setup:'));
      });

      test('generates commented files section when type is null', () {
        final result = taskTemplate(taskFunc: 'question_answer');
        expect(result, contains('# files:'));
        expect(result, contains('#   /workspace: ./project'));
      });

      test('git type falls through to commented section', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.git,
        );
        expect(result, contains('# files:'));
      });

      test('template type falls through to commented section', () {
        final result = taskTemplate(
          taskFunc: 'flutter_code_gen',
          workspaceType: WorkspaceType.template,
        );
        expect(result, contains('# files:'));
      });
    });
  });
}
