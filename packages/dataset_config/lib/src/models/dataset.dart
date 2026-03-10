import 'package:freezed_annotation/freezed_annotation.dart';

import 'sample.dart';

part 'dataset.freezed.dart';
part 'dataset.g.dart';

/// Dart representation of Inspect AI's `Dataset` / `MemoryDataset` class.
///
/// A sequence of [Sample] objects.
///
/// This models the `MemoryDataset` variant which holds samples in an
/// in-memory list.
///
/// See [`Dataset`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#dataset)
/// and [`MemoryDataset`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#memorydataset).
@freezed
sealed class Dataset with _$Dataset {
  const factory Dataset({
    /// The list of sample objects.
    @Default([]) List<Sample> samples,

    /// Dataset name.
    String? name,

    /// Dataset location (file path or remote URL).
    String? location,

    /// Whether the dataset was shuffled after reading.
    @Default(false) bool shuffled,
  }) = _Dataset;

  factory Dataset.fromJson(Map<String, dynamic> json) =>
      _$DatasetFromJson(json);
}
