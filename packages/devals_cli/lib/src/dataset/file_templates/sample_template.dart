import '../workspace.dart';

/// Builds a String of valid YAML for an inline sample block.
///
/// This generates a sample entry that can be appended to an existing
/// task.yaml file under the `samples.inline:` key.
String sampleTemplate({
  required String id,
  required String difficulty,
  WorkspaceType? workspaceType,
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  final filesSection = _buildSampleFilesSection(
    workspaceType,
    templatePackage: templatePackage,
    workspaceValue: workspaceValue,
  );

  return '''
    - id: $id
      difficulty: $difficulty
      tags: []$filesSection
      input: |
        # Write prompt here
      target: |
        # Write target here
''';
}

/// Builds files lines for an inline sample block.
///
/// Only needed if the sample overrides the task-level files.
String _buildSampleFilesSection(
  WorkspaceType? workspaceType, {
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  return switch (workspaceType) {
    WorkspaceType.path =>
      '''

      files:
        /workspace: ${workspaceValue ?? '<RELATIVE_PATH>'}''',
    WorkspaceType.create =>
      '''

      files:
        /workspace: ./project''',
    _ => '',
  };
}
