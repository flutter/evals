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
  final filesSection = _buildTaskFilesSection(
    workspaceType,
    templatePackage: templatePackage,
    workspaceValue: workspaceValue,
  );

  final variantsLine = '';


  final systemMessageBlock = systemMessage != null && systemMessage.isNotEmpty
      ? 'system_message: |\n  ${systemMessage.replaceAll('\n', '\n  ')}\n'
      : '';

  return '''
# Task configuration
# See docs/configuration_reference.md for full schema reference.
func: $taskFunc
$variantsLine$systemMessageBlock$filesSection
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

/// Builds the files/setup section for a task-level definition.
String _buildTaskFilesSection(
  WorkspaceType? workspaceType, {
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  return switch (workspaceType) {
    WorkspaceType.path =>
      '''
files:
  /workspace: ${workspaceValue ?? './project'}
setup: "cd /workspace && flutter pub get"
''',
    WorkspaceType.create =>
      '''
files:
  /workspace: ./project
setup: "cd /workspace && flutter pub get"
''',
    _ =>
      '''
# Files to copy into the sandbox (uncomment as needed):
# files:
#   /workspace: ./project
# setup: "cd /workspace && flutter pub get"
''',
  };
}
