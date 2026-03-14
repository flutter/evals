import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_filter.freezed.dart';
part 'tag_filter.g.dart';

/// Tag-based filter for including/excluding items by their tags.
@freezed
sealed class TagFilter with _$TagFilter {
  const factory TagFilter({
    @JsonKey(name: 'include_tags') List<String>? includeTags,
    @JsonKey(name: 'exclude_tags') List<String>? excludeTags,
  }) = _TagFilter;

  factory TagFilter.fromJson(Map<String, dynamic> json) =>
      _$TagFilterFromJson(json);
}

/// Check whether a set of [itemTags] matches the given [filter].
///
/// Returns `true` if:
/// - All include_tags (if any) are present in [itemTags]
/// - No exclude_tags (if any) are present in [itemTags]
bool matchesTagFilter(List<String> itemTags, TagFilter filter) {
  if (filter.includeTags != null &&
      filter.includeTags!.isNotEmpty &&
      !filter.includeTags!.every((t) => itemTags.contains(t))) {
    return false;
  }
  if (filter.excludeTags != null &&
      filter.excludeTags!.isNotEmpty &&
      filter.excludeTags!.any((t) => itemTags.contains(t))) {
    return false;
  }
  return true;
}
