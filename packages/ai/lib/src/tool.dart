/// A tool that can be called by an AI model.
///
/// Tools are the framework-agnostic representation of callable functions.
/// Provider-specific adapters (e.g. [GenkitAI]) convert these to their
/// native tool format for model requests.
///
/// ```dart
/// final bashTool = Tool(
///   name: 'bash',
///   description: 'Execute a bash command.',
///   inputSchema: {'type': 'object', 'properties': {'command': {'type': 'string'}}},
///   run: (input) async => execSync(input['command'] as String),
/// );
/// ```
class Tool {
  /// The tool's identifier (e.g. `'bash'`, `'read_file'`).
  final String name;

  /// Human-readable description of what the tool does.
  final String description;

  /// JSON Schema describing the expected input shape.
  ///
  /// This schema is sent to the model so it knows how to construct
  /// well-formed tool calls. The actual parsing of the input is done
  /// by the [run] callback.
  final Map<String, dynamic> inputSchema;

  /// The callback that executes the tool with the given [input].
  final Future<dynamic> Function(Map<String, dynamic> input) _run;

  const Tool({
    required this.name,
    required this.description,
    this.inputSchema = const {},
    required Future<dynamic> Function(Map<String, dynamic> input) run,
  }) : _run = run;

  /// Execute the tool with the given [input].
  Future<dynamic> run(Map<String, dynamic> input) => _run(input);
}
