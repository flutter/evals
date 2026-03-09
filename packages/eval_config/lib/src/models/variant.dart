import 'package:freezed_annotation/freezed_annotation.dart';

import 'context_file.dart';

part 'variant.freezed.dart';
part 'variant.g.dart';

/// A configuration variant for running evaluations.
///
/// Variants define different testing configurations to compare model
/// performance with and without specific tooling or context.
///
/// Features are implied by field presence — no explicit feature list needed:
/// - [contextFiles] populated → context injection enabled
/// - [mcpServers] populated → MCP tools enabled
/// - [skillPaths] populated → agent skills enabled
/// - all empty → baseline variant
///
/// Example YAML:
/// ```yaml
/// variants:
///   baseline: {}
///   context_only:
///     context_files: [./context_files/flutter.md]
///   full:
///     context_files: [./context_files/flutter.md]
///     mcp_servers: [dart]
///     skills: [./skills/flutter_docs_ui]
/// ```
@freezed
sealed class Variant with _$Variant {
  const factory Variant({
    /// User-defined variant name from the job file.
    @Default('baseline') String name,

    /// Loaded context files (paths resolved by config resolver).
    @JsonKey(name: 'context_files') @Default([]) List<ContextFile> contextFiles,

    /// MCP server keys to enable (e.g., `['dart']`).
    @JsonKey(name: 'mcp_servers') @Default([]) List<String> mcpServers,

    /// Resolved paths to agent skill directories.
    /// Each directory must contain a `SKILL.md` file.
    @JsonKey(name: 'skill_paths') @Default([]) List<String> skillPaths,

    /// Flutter SDK channel to use (e.g., `'stable'`, `'beta'`, `'main'`).
    /// `null` means use the default (stable) image from the job's sandbox.
    @JsonKey(name: 'flutter_channel') String? flutterChannel,
  }) = _Variant;

  const Variant._();

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);

  /// Human-readable label for this variant.
  ///
  /// Alias for [name], preserved for backward compatibility.
  String get label => name;
}
