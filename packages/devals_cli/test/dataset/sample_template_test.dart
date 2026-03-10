import 'package:devals/src/dataset/file_templates/sample_template.dart';
import 'package:devals/src/dataset/workspace.dart';
import 'package:test/test.dart';

void main() {
  group('sampleTemplate()', () {
    test('generates sample block with required params only', () {
      final result = sampleTemplate(
        id: 'test_sample',
        difficulty: 'easy',
      );

      expect(result, contains('id: test_sample'));
      expect(result, contains('difficulty: easy'));
      expect(result, contains('input:'));
      expect(result, contains('target:'));
    });

    test('includes tags field', () {
      final result = sampleTemplate(id: 'test', difficulty: 'easy');
      expect(result, contains('tags: []'));
    });

    test('with git workspace includes git section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.git,
        workspaceValue: 'https://github.com/example/repo.git',
      );
      expect(result, contains('git:'));
      expect(result, contains('https://github.com/example/repo.git'));
    });

    test('with path workspace includes path section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.path,
        workspaceValue: './project',
      );
      expect(result, contains('path:'));
      expect(result, contains('./project'));
    });

    test('with template workspace includes template section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.template,
        templatePackage: TemplatePackage.flutterApp,
      );
      expect(result, contains('flutter_app'));
    });

    test('without workspace type has no workspace section', () {
      final result = sampleTemplate(id: 'test', difficulty: 'easy');
      expect(result, isNot(contains('workspace:')));
    });

    test('generates indented block for appending to task file', () {
      final result = sampleTemplate(id: 'test', difficulty: 'medium');
      // Should start with indented list marker for inline sample
      expect(result, contains('  - id: test'));
    });

    test('git type with null value uses placeholder', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.git,
      );
      expect(result, contains('<GIT_REPOSITORY_URL>'));
    });

    test('path type with null value uses placeholder', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.path,
      );
      expect(result, contains('<RELATIVE_PATH>'));
    });
  });
}
