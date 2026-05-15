/// Status of an eval run.
enum RunStatus {
  /// The run completed successfully.
  success,

  /// The run completed with errors.
  error;

  /// Serialises this status to a JSON-compatible string.
  String toJson() => name;

  /// Deserialises a [RunStatus] from a JSON string.
  static RunStatus fromJson(String json) => switch (json) {
    'success' => success,
    'error' => error,
    _ => throw FormatException('Unknown RunStatus: $json'),
  };
}
