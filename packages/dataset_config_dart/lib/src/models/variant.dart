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
/// - [files] populated → context injection enabled
/// - [mcpServers] populated → MCP tools enabled
/// - [skills] populated → agent skills enabled
/// - [taskParameters] populated → extra parameters passed to the task
/// - all empty → baseline variant
///
/// Example YAML:
/// ```yaml
/// variants:
///   baseline: {}
///   context_only:
///     files: [./context_files/flutter.md]
///   full:
///     files: [./context_files/flutter.md]
///     mcp_servers:
///       - name: dart
///         command: dart
///         args: [mcp-server]
///     skills: [./skills/flutter_docs_ui]
/// ```
@freezed
sealed class Variant with _$Variant {
  const factory Variant({
    /// User-defined variant name from the job file.
    @Default('baseline') String name,

    /// Loaded context files (paths resolved by config resolver).
    @JsonKey(name: 'files') @Default([]) List<ContextFile> files,

    /// MCP server configurations (list of config maps or ref strings).
    @JsonKey(name: 'mcp_servers')
    @Default([])
    List<Map<String, dynamic>> mcpServers,

    /// Resolved paths to agent skill directories.
    /// Each directory must contain a `SKILL.md` file.
    @JsonKey(name: 'skills') @Default([]) List<String> skills,

    /// Optional parameters merged into the task config dict at runtime.
    @JsonKey(name: 'task_parameters')
    @Default({})
    Map<String, dynamic> taskParameters,
  }) = _Variant;

  const Variant._();

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);

  /// Human-readable label for this variant.
  ///
  /// Alias for [name], preserved for backward compatibility.
  String get label => name;
}
