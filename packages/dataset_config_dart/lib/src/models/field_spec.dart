import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_spec.freezed.dart';
part 'field_spec.g.dart';

/// Dart representation of Inspect AI's `FieldSpec` dataclass.
///
/// Specification for mapping data source fields to sample fields.
///
/// See [`FieldSpec`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#fieldspec).
@freezed
sealed class FieldSpec with _$FieldSpec {
  const factory FieldSpec({
    /// Name of the field containing the sample input.
    String? input,

    /// Name of the field containing the sample target.
    String? target,

    /// Name of the field containing the list of answer choices.
    String? choices,

    /// Name of the field containing the unique sample identifier.
    String? id,

    /// List of additional field names that should be read as metadata.
    List<String>? metadata,

    /// Sandbox type along with optional config file.
    String? sandbox,

    /// Name of the field containing files that go with the sample.
    String? files,

    /// Name of the field containing the setup script.
    String? setup,
  }) = _FieldSpec;

  factory FieldSpec.fromJson(Map<String, dynamic> json) =>
      _$FieldSpecFromJson(json);
}
