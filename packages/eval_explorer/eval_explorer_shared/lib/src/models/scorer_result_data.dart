import 'package:freezed_annotation/freezed_annotation.dart';

part 'scorer_result_data.freezed.dart';
part 'scorer_result_data.g.dart';

@freezed
sealed class ScorerResultData with _$ScorerResultData {
  const factory ScorerResultData({
    required String name,
    required bool passed,
    @Default('') String explanation,
    @Default('') String answer,
  }) = _ScorerResultData;

  const ScorerResultData._();

  factory ScorerResultData.fromJson(Map<String, dynamic> json) =>
      _$ScorerResultDataFromJson(json);
}
