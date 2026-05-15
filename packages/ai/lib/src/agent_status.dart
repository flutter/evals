/// The terminal state of an agent run.
enum AgentStatus {
  /// The agent is still running (internal only — not a terminal state).
  running,

  /// The model stopped calling tools and returned a text response.
  completed,

  /// The step limit was reached before the model finished.
  maxStepsReached,

  /// An unrecoverable error occurred during the agent loop.
  error;

  /// Serialises this status to a JSON-compatible string.
  String toJson() => name;

  /// Deserialises an [AgentStatus] from a JSON string.
  static AgentStatus fromJson(String json) => switch (json) {
    'running' => running,
    'completed' => completed,
    'maxStepsReached' => maxStepsReached,
    'error' => error,
    _ => throw FormatException('Unknown AgentStatus: $json'),
  };
}
