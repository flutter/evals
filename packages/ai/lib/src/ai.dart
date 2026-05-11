import 'message.dart';
import 'response.dart';
import 'tool.dart';

/// Interface for an AI provider.
abstract class AI {
  /// Generate a response for the given [messages].
  ///
  /// [model] is the identifier of the model to use.
  /// [tools] are the tools available to the model.
  /// [returnToolRequests] if true, the provider should return tool requests
  /// rather than executing them automatically (if supported).
  Future<Response> generate({
    required String model,
    required List<Message> messages,
    List<Tool> tools = const [],
    bool returnToolRequests = false,
  });
}
