/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dataset.dart' as _i2;
import 'evaluation.dart' as _i3;
import 'greetings/greeting.dart' as _i4;
import 'model.dart' as _i5;
import 'run.dart' as _i6;
import 'run_summary.dart' as _i7;
import 'sample.dart' as _i8;
import 'sample_tag_xref.dart' as _i9;
import 'scorer.dart' as _i10;
import 'scorer_result.dart' as _i11;
import 'status_enum.dart' as _i12;
import 'tag.dart' as _i13;
import 'task.dart' as _i14;
import 'task_summary.dart' as _i15;
import 'tool_call_data.dart' as _i16;
import 'variant.dart' as _i17;
import 'package:eval_explorer_shared/eval_explorer_shared.dart' as _i18;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i19;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i20;
export 'dataset.dart';
export 'evaluation.dart';
export 'greetings/greeting.dart';
export 'model.dart';
export 'run.dart';
export 'run_summary.dart';
export 'sample.dart';
export 'sample_tag_xref.dart';
export 'scorer.dart';
export 'scorer_result.dart';
export 'status_enum.dart';
export 'tag.dart';
export 'task.dart';
export 'task_summary.dart';
export 'tool_call_data.dart';
export 'variant.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Dataset) {
      return _i2.Dataset.fromJson(data) as T;
    }
    if (t == _i3.Evaluation) {
      return _i3.Evaluation.fromJson(data) as T;
    }
    if (t == _i4.Greeting) {
      return _i4.Greeting.fromJson(data) as T;
    }
    if (t == _i5.Model) {
      return _i5.Model.fromJson(data) as T;
    }
    if (t == _i6.Run) {
      return _i6.Run.fromJson(data) as T;
    }
    if (t == _i7.RunSummary) {
      return _i7.RunSummary.fromJson(data) as T;
    }
    if (t == _i8.Sample) {
      return _i8.Sample.fromJson(data) as T;
    }
    if (t == _i9.SampleTagXref) {
      return _i9.SampleTagXref.fromJson(data) as T;
    }
    if (t == _i10.Scorer) {
      return _i10.Scorer.fromJson(data) as T;
    }
    if (t == _i11.ScorerResult) {
      return _i11.ScorerResult.fromJson(data) as T;
    }
    if (t == _i12.Status) {
      return _i12.Status.fromJson(data) as T;
    }
    if (t == _i13.Tag) {
      return _i13.Tag.fromJson(data) as T;
    }
    if (t == _i14.Task) {
      return _i14.Task.fromJson(data) as T;
    }
    if (t == _i15.TaskSummary) {
      return _i15.TaskSummary.fromJson(data) as T;
    }
    if (t == _i16.ToolCallData) {
      return _i16.ToolCallData.fromJson(data) as T;
    }
    if (t == _i17.Variant) {
      return _i17.Variant.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Dataset?>()) {
      return (data != null ? _i2.Dataset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Evaluation?>()) {
      return (data != null ? _i3.Evaluation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Greeting?>()) {
      return (data != null ? _i4.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Model?>()) {
      return (data != null ? _i5.Model.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Run?>()) {
      return (data != null ? _i6.Run.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.RunSummary?>()) {
      return (data != null ? _i7.RunSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Sample?>()) {
      return (data != null ? _i8.Sample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SampleTagXref?>()) {
      return (data != null ? _i9.SampleTagXref.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Scorer?>()) {
      return (data != null ? _i10.Scorer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ScorerResult?>()) {
      return (data != null ? _i11.ScorerResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Status?>()) {
      return (data != null ? _i12.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Tag?>()) {
      return (data != null ? _i13.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Task?>()) {
      return (data != null ? _i14.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.TaskSummary?>()) {
      return (data != null ? _i15.TaskSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ToolCallData?>()) {
      return (data != null ? _i16.ToolCallData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Variant?>()) {
      return (data != null ? _i17.Variant.fromJson(data) : null) as T;
    }
    if (t == List<_i17.Variant>) {
      return (data as List).map((e) => deserialize<_i17.Variant>(e)).toList()
          as T;
    }
    if (t == List<_i16.ToolCallData>) {
      return (data as List)
              .map((e) => deserialize<_i16.ToolCallData>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i5.Model>) {
      return (data as List).map((e) => deserialize<_i5.Model>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i5.Model>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i5.Model>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i2.Dataset>) {
      return (data as List).map((e) => deserialize<_i2.Dataset>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i2.Dataset>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i2.Dataset>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i14.Task>) {
      return (data as List).map((e) => deserialize<_i14.Task>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i14.Task>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i14.Task>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i9.SampleTagXref>) {
      return (data as List)
              .map((e) => deserialize<_i9.SampleTagXref>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.SampleTagXref>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i9.SampleTagXref>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i18.ScorerResultData) {
      return _i18.ScorerResultData.fromJson(data) as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<_i18.ScorerResultData?>()) {
      return (data != null ? _i18.ScorerResultData.fromJson(data) : null) as T;
    }
    try {
      return _i19.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i20.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i18.ScorerResultData => 'ScorerResultData',
      _i2.Dataset => 'Dataset',
      _i3.Evaluation => 'Evaluation',
      _i4.Greeting => 'Greeting',
      _i5.Model => 'Model',
      _i6.Run => 'Run',
      _i7.RunSummary => 'RunSummary',
      _i8.Sample => 'Sample',
      _i9.SampleTagXref => 'SampleTagXref',
      _i10.Scorer => 'Scorer',
      _i11.ScorerResult => 'ScorerResult',
      _i12.Status => 'Status',
      _i13.Tag => 'Tag',
      _i14.Task => 'Task',
      _i15.TaskSummary => 'TaskSummary',
      _i16.ToolCallData => 'ToolCallData',
      _i17.Variant => 'Variant',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'eval_explorer.',
        '',
      );
    }

    switch (data) {
      case _i18.ScorerResultData():
        return 'ScorerResultData';
      case _i2.Dataset():
        return 'Dataset';
      case _i3.Evaluation():
        return 'Evaluation';
      case _i4.Greeting():
        return 'Greeting';
      case _i5.Model():
        return 'Model';
      case _i6.Run():
        return 'Run';
      case _i7.RunSummary():
        return 'RunSummary';
      case _i8.Sample():
        return 'Sample';
      case _i9.SampleTagXref():
        return 'SampleTagXref';
      case _i10.Scorer():
        return 'Scorer';
      case _i11.ScorerResult():
        return 'ScorerResult';
      case _i12.Status():
        return 'Status';
      case _i13.Tag():
        return 'Tag';
      case _i14.Task():
        return 'Task';
      case _i15.TaskSummary():
        return 'TaskSummary';
      case _i16.ToolCallData():
        return 'ToolCallData';
      case _i17.Variant():
        return 'Variant';
    }
    className = _i19.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i20.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ScorerResultData') {
      return deserialize<_i18.ScorerResultData>(data['data']);
    }
    if (dataClassName == 'Dataset') {
      return deserialize<_i2.Dataset>(data['data']);
    }
    if (dataClassName == 'Evaluation') {
      return deserialize<_i3.Evaluation>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i4.Greeting>(data['data']);
    }
    if (dataClassName == 'Model') {
      return deserialize<_i5.Model>(data['data']);
    }
    if (dataClassName == 'Run') {
      return deserialize<_i6.Run>(data['data']);
    }
    if (dataClassName == 'RunSummary') {
      return deserialize<_i7.RunSummary>(data['data']);
    }
    if (dataClassName == 'Sample') {
      return deserialize<_i8.Sample>(data['data']);
    }
    if (dataClassName == 'SampleTagXref') {
      return deserialize<_i9.SampleTagXref>(data['data']);
    }
    if (dataClassName == 'Scorer') {
      return deserialize<_i10.Scorer>(data['data']);
    }
    if (dataClassName == 'ScorerResult') {
      return deserialize<_i11.ScorerResult>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i12.Status>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i13.Tag>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i14.Task>(data['data']);
    }
    if (dataClassName == 'TaskSummary') {
      return deserialize<_i15.TaskSummary>(data['data']);
    }
    if (dataClassName == 'ToolCallData') {
      return deserialize<_i16.ToolCallData>(data['data']);
    }
    if (dataClassName == 'Variant') {
      return deserialize<_i17.Variant>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i19.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i20.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i19.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i20.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
