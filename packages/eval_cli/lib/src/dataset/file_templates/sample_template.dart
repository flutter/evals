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
  final workspaceSection = _buildSampleWorkspaceSection(
    workspaceType,
    templatePackage: templatePackage,
    workspaceValue: workspaceValue,
  );

  return '''
    - id: $id
      difficulty: $difficulty
      tags: []$workspaceSection
      input: |
        # Write prompt here
      target: |
        # Write target here
''';
}

/// Builds workspace/tests lines for an inline sample block.
///
/// Only needed if the sample overrides the task-level workspace.
String _buildSampleWorkspaceSection(
  WorkspaceType? workspaceType, {
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  return switch (workspaceType) {
    WorkspaceType.git =>
      '''

      workspace:
        git: ${workspaceValue ?? '<GIT_REPOSITORY_URL>'}''',
    WorkspaceType.path =>
      '''

      workspace:
        path: ${workspaceValue ?? '<RELATIVE_PATH>'}''',
    WorkspaceType.template =>
      '''

      workspace:
        template: ${templatePackage?.yamlValue ?? '<flutter_app OR jaspr_app OR dart_package>'}''',
    WorkspaceType.create =>
      '''

      workspace:
        path: ./project''',
    _ => '',
  };
}
