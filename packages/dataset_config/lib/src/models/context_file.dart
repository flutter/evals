import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'context_file.freezed.dart';
part 'context_file.g.dart';

/// Metadata parsed from a context file's YAML frontmatter.
@freezed
sealed class ContextFileMetadata with _$ContextFileMetadata {
  const factory ContextFileMetadata({
    /// Title of the context file.
    required String title,

    /// Version string.
    required String version,

    /// Description of the context file.
    required String description,

    /// Dart SDK version this context targets.
    @JsonKey(name: 'dart_version') String? dartVersion,

    /// Flutter SDK version this context targets.
    @JsonKey(name: 'flutter_version') String? flutterVersion,

    /// Last updated date string.
    String? updated,
  }) = _ContextFileMetadata;

  factory ContextFileMetadata.fromJson(Map<String, dynamic> json) =>
      _$ContextFileMetadataFromJson(json);
}

/// A context file with parsed YAML frontmatter and markdown content.
///
/// Context files provide additional documentation or guidelines that are
/// injected into the model's conversation as part of a variant configuration.
///
/// File format:
/// ```markdown
/// ---
/// title: Flutter Widget Guide
/// version: "1.0"
/// description: Comprehensive guide to Flutter widgets
/// ---
/// # Content starts here...
///
/// ```
@freezed
sealed class ContextFile with _$ContextFile {
  const factory ContextFile({
    /// Parsed frontmatter metadata.
    required ContextFileMetadata metadata,

    /// File content after the frontmatter section.
    required String content,

    /// Absolute path to the context file on disk.
    @JsonKey(name: 'file_path') required String filePath,
  }) = _ContextFile;

  const ContextFile._();

  factory ContextFile.fromJson(Map<String, dynamic> json) =>
      _$ContextFileFromJson(json);

  /// Load a context file from disk, parsing its YAML frontmatter.
  ///
  /// The file must begin with `---` and contain valid YAML frontmatter
  /// followed by a closing `---` delimiter.
  ///
  /// Throws [FileSystemException] if the file doesn't exist.
  /// Throws [FormatException] if the file lacks valid YAML frontmatter.
  static ContextFile load(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('Context file not found', filePath);
    }

    final text = file.readAsStringSync();

    if (!text.startsWith('---')) {
      throw FormatException(
        'Context file must have YAML frontmatter: $filePath',
      );
    }

    final parts = text.split('---');
    if (parts.length < 3) {
      throw FormatException('Invalid frontmatter in $filePath');
    }

    // parts[0] is empty (before first ---), parts[1] is frontmatter,
    // parts[2..] is content (rejoin in case content contains ---)
    final yamlContent = loadYaml(parts[1]) as Map;
    final content = parts.sublist(2).join('---').trim();

    final metadata = ContextFileMetadata(
      title: yamlContent['title'] as String,
      version: yamlContent['version'].toString(),
      description: yamlContent['description'] as String,
      dartVersion: yamlContent['dart_version']?.toString(),
      flutterVersion: yamlContent['flutter_version']?.toString(),
      updated: yamlContent['updated']?.toString(),
    );

    return ContextFile(
      metadata: metadata,
      content: content,
      filePath: filePath,
    );
  }
}
