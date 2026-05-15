/// Roles in a conversation.
enum Role {
  user,
  system,
  model,
  tool;

  /// Serialises this role to a JSON-compatible string.
  String toJson() => name;

  /// Deserialises a [Role] from a JSON string.
  static Role fromJson(String json) => switch (json) {
    'user' => user,
    'system' => system,
    'model' => model,
    'tool' => tool,
    _ => throw FormatException('Unknown Role: $json'),
  };

  @override
  String toString() => name;
}
