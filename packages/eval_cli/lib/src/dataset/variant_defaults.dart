// TODO(ewindmill): The whole variants flow should be re-considered now that we don't have default variants.
// I think the default variants should just be something helpful i.e.: baseline and skills

/// Returns the list of common variant names for scaffolding.
List<String> variants = const ['baseline', 'context_only', 'mcp_only', 'full'];

String variantDefaults() {
  // Build named variant map YAML
  final variantsMap = StringBuffer();
  for (final v in variants) {
    switch (v) {
      case 'baseline':
        variantsMap.writeln('  baseline: {}');
      case 'context_only':
        variantsMap.writeln(
          '  context_only: { context_files: [./context_files/flutter.md] }',
        );
      case 'mcp_only':
        variantsMap.writeln('  mcp_only: { mcp_servers: [dart] }');
      case 'full':
        variantsMap.writeln(
          '  full: { context_files: [./context_files/flutter.md], mcp_servers: [dart] }',
        );
      default:
        variantsMap.writeln('  $v: {}');
    }
  }

  return variantsMap.toString();
}
