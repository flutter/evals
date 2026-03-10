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
import 'package:eval_explorer_client/src/protocol/protocol.dart' as _i2;

/// Result of a tool call made during evaluation. Not a database table.
abstract class ToolCallData implements _i1.SerializableModel {
  ToolCallData._({
    required this.name,
    required this.arguments,
  });

  factory ToolCallData({
    required String name,
    required Map<String, String> arguments,
  }) = _ToolCallDataImpl;

  factory ToolCallData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ToolCallData(
      name: jsonSerialization['name'] as String,
      arguments: _i2.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['arguments'],
      ),
    );
  }

  /// Name of the tool.
  String name;

  /// Arguments passed to the tool.
  Map<String, String> arguments;

  /// Returns a shallow copy of this [ToolCallData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ToolCallData copyWith({
    String? name,
    Map<String, String>? arguments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ToolCallData',
      'name': name,
      'arguments': arguments.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ToolCallDataImpl extends ToolCallData {
  _ToolCallDataImpl({
    required String name,
    required Map<String, String> arguments,
  }) : super._(
         name: name,
         arguments: arguments,
       );

  /// Returns a shallow copy of this [ToolCallData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ToolCallData copyWith({
    String? name,
    Map<String, String>? arguments,
  }) {
    return ToolCallData(
      name: name ?? this.name,
      arguments:
          arguments ??
          this.arguments.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
    );
  }
}
