import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_info.freezed.dart';
part 'task_info.g.dart';

/// Dart representation of Inspect AI's `TaskInfo` class.
///
/// Task information including file path, name, and attributes.
///
/// See [`TaskInfo`](https://inspect.aisi.org.uk/reference/inspect_ai.html#taskinfo).
@freezed
sealed class TaskInfo with _$TaskInfo {
  const factory TaskInfo({
    /// File path where the task was loaded from.
    required String file,

    /// Task name (defaults to the function name).
    required String name,

    /// Task attributes (arguments passed to `@task`).
    @Default({}) Map<String, dynamic> attribs,
  }) = _TaskInfo;

  factory TaskInfo.fromJson(Map<String, dynamic> json) =>
      _$TaskInfoFromJson(json);
}
