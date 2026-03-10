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

    test('includes variants when provided', () {
      final result = taskTemplate(
        taskFunc: 'flutter_code_gen',
        variants: ['baseline', 'mcp_only'],
      );
      expect(result, contains('variants: [baseline, mcp_only]'));
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

    group('workspace section', () {
      test('generates git workspace', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.git,
          workspaceValue: 'https://github.com/example/repo',
        );
        expect(result, contains('workspace:'));
        expect(result, contains('git: https://github.com/example/repo'));
      });

      test('generates path workspace', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.path,
          workspaceValue: './my_project',
        );
        expect(result, contains('workspace:'));
        expect(result, contains('path: ./my_project'));
      });

      test('generates template workspace', () {
        final result = taskTemplate(
          taskFunc: 'flutter_code_gen',
          workspaceType: WorkspaceType.template,
          templatePackage: TemplatePackage.flutterApp,
        );
        expect(result, contains('workspace:'));
        expect(result, contains('template: flutter_app'));
      });

      test('generates create workspace as path', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.create,
        );
        expect(result, contains('workspace:'));
        expect(result, contains('path: ./project'));
      });

      test('generates commented workspace section when type is null', () {
        final result = taskTemplate(taskFunc: 'question_answer');
        expect(result, contains('# Workspace configuration'));
        expect(result, contains('#   template: flutter_app'));
      });

      test('generates git with default URL when workspaceValue is null', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.git,
        );
        expect(result, contains('git: <GIT_REPOSITORY_URL>'));
      });

      test('generates path with default when workspaceValue is null', () {
        final result = taskTemplate(
          taskFunc: 'flutter_bug_fix',
          workspaceType: WorkspaceType.path,
        );
        expect(result, contains('path: ./project'));
      });

      test(
        'generates template with placeholder when templatePackage is null',
        () {
          final result = taskTemplate(
            taskFunc: 'flutter_code_gen',
            workspaceType: WorkspaceType.template,
          );
          expect(
            result,
            contains(
              'template: <flutter_app OR jaspr_app OR dart_package>',
            ),
          );
        },
      );
    });
  });
}
