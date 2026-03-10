enum WorkspaceType { template, path, git, create }

/// Available project templates for workspace creation.
///
/// Each template maps to a directory under `workspaces/` in the
/// dataset and a corresponding package name used in pubspec dependencies.
enum TemplatePackage {
  flutterApp('flutter_app', 'flutter_eval_app'),
  dartPackage('dart_package', 'dart_eval_package'),
  jasprApp('jaspr_app', 'jaspr_eval_app')
  ;

  const TemplatePackage(this.yamlValue, this.packageName);

  /// The value written to sample.yaml (e.g., `flutter_app`).
  final String yamlValue;

  /// The package name used in pubspec dependencies (e.g., `flutter_eval_app`).
  final String packageName;

  /// Whether this template is Flutter-based (needs Flutter SDK deps).
  bool get isFlutter => this == TemplatePackage.flutterApp;
}
