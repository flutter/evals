import '../workspace.dart';

/// Builds a String of valid YAML for a standalone task.yaml file.
///
/// This generates a complete task file with inline samples,
/// to be written at tasks/{taskName}/task.yaml.
String taskTemplate({
  required String taskFunc,
  WorkspaceType? workspaceType,
  TemplatePackage? templatePackage,
  String? workspaceValue,
  List<String> variants = const [],
  String? systemMessage,
}) {
  final workspaceSection = _buildTaskWorkspaceSection(
    workspaceType,
    templatePackage: templatePackage,
    workspaceValue: workspaceValue,
  );

  final variantsLine = variants.isNotEmpty
      ? 'allowed_variants: [${variants.join(', ')}]\n'
      : '';

  final systemMessageBlock = systemMessage != null && systemMessage.isNotEmpty
      ? 'system_message: |\n  ${systemMessage.replaceAll('\n', '\n  ')}\n'
      : '';

  return '''
# Task configuration
# See docs/configuration_reference.md for full schema reference.
func: $taskFunc
$variantsLine$systemMessageBlock$workspaceSection
samples:
  inline:
    - id: sample_1
      difficulty: medium
      input: |
        # Write prompt here
      target: |
        # Write target here
''';
}

/// Builds the workspace section for a task-level definition.
String _buildTaskWorkspaceSection(
  WorkspaceType? workspaceType, {
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  return switch (workspaceType) {
    WorkspaceType.git =>
      '''
workspace:
  git: ${workspaceValue ?? '<GIT_REPOSITORY_URL>'}
  # ref: <BRANCH_TAG_OR_COMMIT>  # Optional
''',
    WorkspaceType.path =>
      '''
workspace:
  path: ${workspaceValue ?? './project'}
''',
    WorkspaceType.template =>
      '''
workspace:
  template: ${templatePackage?.yamlValue ?? '<flutter_app OR jaspr_app OR dart_package>'}
''',
    WorkspaceType.create =>
      '''
workspace:
  path: ./project
''',
    _ =>
      '''
# Workspace configuration (uncomment one):
# workspace:
#   template: flutter_app  # OR dart_package OR jaspr_app
# workspace:
#   path: ./project
# workspace:
#   git: <REPOSITORY_URL>
''',
  };
}
