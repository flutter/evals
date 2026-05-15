import 'package:equatable/equatable.dart';

import 'message.dart';
import 'parts.dart';
import 'usage.dart';

/// The result of a generation call.
class Response extends Equatable {
  /// The message returned by the model.
  final Message? message;

  /// Any tool requests made by the model in this turn.
  final List<ToolRequestPart> toolRequests;

  /// Token usage for this call.
  final Usage usage;

  /// Why the model stopped generating.
  final String? stopReason;

  const Response({
    this.message,
    this.toolRequests = const [],
    this.usage = const Usage.zero(),
    this.stopReason,
  });

  /// Convenience getter for the text content of the response.
  String? get text => message?.text;

  @override
  List<Object?> get props => [message, toolRequests, usage, stopReason];
}
