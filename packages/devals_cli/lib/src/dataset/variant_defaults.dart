/// Default variant configurations for eval jobs.
///
/// Each variant defines a YAML snippet that configures what tools/context
/// the agent has access to during an evaluation run.
enum DefaultVariants {
  baseline(
    'baseline',
    'Run without any additional AI tools.',
    'baseline: {}',
  ),
  flutterRules(
    'flutter_rules',
    'Run with Flutter rules context files.',
    'flutter_rules: { context_files: [./context_files/flutter.md] }',
  ),
  withSkills(
    'with_skills',
    'Run with skills files.',
    'with_skills: { skill_paths: [./skills/*] }',
  ),
  withMCP(
    'with_mcp',
    'Run with Dart MCP server available.',
    'with_mcp: { mcp_servers: [dart] }',
  )
  ;

  const DefaultVariants(this.variantName, this.help, this.yaml);

  /// The variant name as it appears in YAML (e.g. `'baseline'`).
  final String variantName;

  /// Human-readable description shown in CLI prompts.
  final String help;

  /// The YAML snippet for this variant (e.g. `'baseline: {}'`).
  final String yaml;

  /// Look up a [DefaultVariants] by its [variantName], or `null` if not found.
  static DefaultVariants? tryByName(String name) {
    for (final v in values) {
      if (v.variantName == name) return v;
    }
    return null;
  }
}

/// Builds a YAML string for the `variants:` section of a job file.
///
/// For each variant name in [selectedVariants], uses the matching
/// [DefaultVariants] YAML snippet if one exists, otherwise falls back to
/// an empty config (`variant_name: {}`).
String variantDefaults(List<String> selectedVariants) {
  final buffer = StringBuffer();
  for (final name in selectedVariants) {
    final defaultVariant = DefaultVariants.tryByName(name);
    if (defaultVariant != null) {
      buffer.writeln('  ${defaultVariant.yaml}');
    } else {
      buffer.writeln('  $name: {}');
    }
  }
  return buffer.toString();
}
