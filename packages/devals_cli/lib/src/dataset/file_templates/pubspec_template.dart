import '../workspace.dart';

/// Builds a pubspec.yaml string for a sample's project directory.
///
/// The pubspec imports the workspace so that Dart tooling (analyzer, etc.)
/// can resolve the code.
///
/// When [workspaceKey] is [WorkspaceType.template], [templatePackage] must be
/// provided. For other workspace types, [workspaceValue] carries the
/// user-provided string (path, git URL, etc.).
String pubspecTemplate({
  required String sampleId,
  required WorkspaceType workspaceKey,
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  final isFlutter = templatePackage?.isFlutter ?? false;
  final dependencySection = _buildDependencySection(
    workspaceKey: workspaceKey,
    templatePackage: templatePackage,
    workspaceValue: workspaceValue,
    sampleId: sampleId,
  );

  final header =
      '''
name: ${sampleId}_tests
description: 'Test workspace for $sampleId'
publish_to: 'none'
version: 1.0.0
''';

  final flutterBase =
      '''
environment:
  sdk: ^3.5.0
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  $dependencySection

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
''';

  final dartBase =
      '''
environment:
  sdk: ^3.5.0

dependencies:
  $dependencySection

dev_dependencies:
''';

  return isFlutter ? '$header\n$flutterBase' : '$header\n$dartBase';
}

String _buildDependencySection({
  required WorkspaceType workspaceKey,
  required String sampleId,
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) {
  return switch (workspaceKey) {
    WorkspaceType.template =>
      '''
  ${templatePackage!.packageName}:
    path: ../../../workspaces/${templatePackage.yamlValue}''',
    WorkspaceType.path =>
      '''
  # Workspace path dependency
  # $sampleId:
  #   path: ${workspaceValue ?? '<WORKSPACE_PATH>'}''',
    WorkspaceType.git =>
      '''
  # Workspace git dependency
  # $sampleId:
  #   git: ${workspaceValue ?? '<GIT_URL>'}''',
    _ => '  # No workspace dependency',
  };
}
