import 'package:equatable/equatable.dart';

import 'parts.dart';
import 'role.dart';

/// A single message in a conversation history.
class Message extends Equatable {
  final Role role;
  final List<Part> content;

  const Message({required this.role, required this.content});

  /// Convenience constructor for a simple text message.
  factory Message.text(Role role, String text) =>
      Message(role: role, content: [TextPart(text)]);

  /// Deserialises a [Message] from a JSON map.
  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: Role.fromJson(json['role'] as String),
    content: (json['content'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Part.fromJson)
        .toList(),
  );

  /// Convenience getter for the first text part.
  String? get text =>
      content.whereType<TextPart>().map((p) => p.text).firstOrNull;

  /// Serialises this message to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'role': role.toJson(),
    'content': content.map((p) => p.toJson()).toList(),
  };

  @override
  List<Object?> get props => [role, content];
}
