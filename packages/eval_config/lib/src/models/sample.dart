import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample.freezed.dart';
part 'sample.g.dart';

/// Dart representation of Inspect AI's `Sample` class.
///
/// A sample for an evaluation task.
///
/// See [`Sample`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#sample).
@freezed
sealed class Sample with _$Sample {
  const factory Sample({
    /// The input to be submitted to the model.
    ///
    /// Can be a simple string or a list of `ChatMessage` objects.
    required Object input,

    /// List of available answer choices (used only for multiple-choice evals).
    List<String>? choices,

    /// Ideal target output.
    ///
    /// May be a literal value or narrative text to be used by a model grader.
    /// Can be a single string or a list of strings.
    @Default('') Object target,

    /// Unique identifier for the sample.
    Object? id,

    /// Arbitrary metadata associated with the sample.
    Map<String, dynamic>? metadata,

    /// Sandbox environment type and optional config file.
    Object? sandbox,

    /// Files that go along with the sample (copied to `SandboxEnvironment`).
    ///
    /// Keys are destination paths, values are source paths, inline text,
    /// or inline binary (base64-encoded data URLs).
    Map<String, String>? files,

    /// Setup script to run for sample (run within default
    /// `SandboxEnvironment`).
    String? setup,
  }) = _Sample;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}
