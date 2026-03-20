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

    test('with path workspace includes files section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.path,
        workspaceValue: './project',
      );
      expect(result, contains('files:'));
      expect(result, contains('/workspace: ./project'));
    });

    test('with create workspace includes files section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.create,
      );
      expect(result, contains('files:'));
      expect(result, contains('/workspace: ./project'));
    });

    test('without workspace type has no files section', () {
      final result = sampleTemplate(id: 'test', difficulty: 'easy');
      expect(result, isNot(contains('files:')));
    });

    test('generates indented block for appending to task file', () {
      final result = sampleTemplate(id: 'test', difficulty: 'medium');
      // Should start with indented list marker for inline sample
      expect(result, contains('  - id: test'));
    });

    test('path type with null value uses placeholder', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.path,
      );
      expect(result, contains('<RELATIVE_PATH>'));
    });

    test('git type falls through to no files section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.git,
      );
      expect(result, isNot(contains('files:')));
    });

    test('template type falls through to no files section', () {
      final result = sampleTemplate(
        id: 'test',
        difficulty: 'easy',
        workspaceType: WorkspaceType.template,
        templatePackage: TemplatePackage.flutterApp,
      );
      expect(result, isNot(contains('files:')));
    });
  });
}
