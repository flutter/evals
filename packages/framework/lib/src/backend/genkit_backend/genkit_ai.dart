import 'package:genkit/genkit.dart' as g;

import 'package:ai/ai.dart';

/// An [AI] implementation that routes generation through a [g.Genkit] instance.
class GenkitAI implements AI {
  /// The underlying Genkit instance.
  final g.Genkit genkit;

  /// Optional middleware (e.g. caching) applied to every generate call.
  final List<g.GenerateMiddlewareRef>? use;

  const GenkitAI(this.genkit, {this.use});

  /// Returns a copy of this [GenkitAI] with additional [middleware] appended.
  GenkitAI withMiddleware(List<g.GenerateMiddlewareRef> middleware) =>
      GenkitAI(genkit, use: [...?use, ...middleware]);

  @override
  Future<Response> generate({
    required String model,
    required List<Message> messages,
    List<Tool> tools = const [],
    bool returnToolRequests = false,
  }) async {
    final response = await genkit.generate(
      model: g.modelRef(model),
      messages: messages.map(_toGenkitMessage).toList(),
      tools: tools.map(_toGenkitTool).toList(),
      returnToolRequests: returnToolRequests,
      use: use,
    );

    return _toAiResponse(response);
  }

  // ---------------------------------------------------------------------------
  // ai → Genkit conversion
  // ---------------------------------------------------------------------------

  g.Message _toGenkitMessage(Message msg) => g.Message(
    role: _toGenkitRole(msg.role),
    content: msg.content.map(_toGenkitPart).toList(),
  );

  g.Part _toGenkitPart(Part part) => switch (part) {
    TextPart(:final text) => g.TextPart(text: text),
    ToolRequestPart(:final name, :final ref, :final input) => g.ToolRequestPart(
      toolRequest: g.ToolRequest(name: name, ref: ref, input: input),
    ),
    ToolResponsePart(:final name, :final ref, :final output) =>
      g.ToolResponsePart(
        toolResponse: g.ToolResponse(
          name: name,
          ref: ref,
          output: output is Map<String, dynamic> ? output : {'result': output},
        ),
      ),
    _ => g.TextPart(text: part.toString()),
  };

  g.Role _toGenkitRole(Role role) => switch (role) {
    Role.user => g.Role.user,
    Role.system => g.Role.system,
    Role.model => g.Role.model,
    Role.tool => g.Role.tool,
  };

  /// Wraps an [ai.Tool] as a [g.Tool] so Genkit can include its schema in
  /// the API request and route tool-call responses back through it.
  ///
  /// The [g.Tool] constructor expects a `SchemanticType` for `inputSchema`,
  /// but our [ai.Tool] exposes a plain `Map<String, dynamic>` JSON Schema.
  /// We pass `null` for `inputSchema` and let Genkit accept the raw map input
  /// directly — Genkit will still include the tool definition in the request
  /// via name/description.
  g.Tool<Map<String, dynamic>, dynamic> _toGenkitTool(Tool tool) =>
      g.Tool<Map<String, dynamic>, dynamic>(
        name: tool.name,
        description: tool.description,
        fn: (input, _) => tool.run(input),
      );

  // ---------------------------------------------------------------------------
  // Genkit → ai conversion
  // ---------------------------------------------------------------------------

  Response _toAiResponse(g.GenerateResponseHelper response) {
    final gMessage = response.message;

    final content =
        gMessage?.content.map(_toAiPart).whereType<Part>().toList() ?? [];

    final message = gMessage != null
        ? Message(role: _toAiRole(gMessage.role), content: content)
        : null;

    final toolRequests = response.toolRequests
        .map(
          (tr) => ToolRequestPart(
            name: tr.name,
            ref: tr.ref ?? tr.name,
            input: tr.input ?? {},
          ),
        )
        .toList();

    final usage = response.usage;
    return Response(
      message: message,
      toolRequests: toolRequests,
      usage: Usage(
        inputTokens: (usage?.inputTokens ?? 0).round(),
        outputTokens: (usage?.outputTokens ?? 0).round(),
        totalTokens: (usage?.totalTokens ?? 0).round(),
      ),
    );
  }

  Part? _toAiPart(g.Part part) {
    final json = part.toJson();
    if (json['text'] != null) return TextPart(json['text'] as String);
    if (json['toolRequest'] != null) {
      final tr = json['toolRequest'] as Map<String, dynamic>;
      return ToolRequestPart(
        name: tr['name'] as String,
        ref: (tr['ref'] as String?) ?? (tr['name'] as String),
        input: (tr['input'] as Map<String, dynamic>?) ?? {},
      );
    }
    if (json['toolResponse'] != null) {
      final tr = json['toolResponse'] as Map<String, dynamic>;
      return ToolResponsePart(
        name: tr['name'] as String,
        ref: (tr['ref'] as String?) ?? (tr['name'] as String),
        output: tr['output'],
      );
    }
    return TextPart(part.toString());
  }

  Role _toAiRole(g.Role role) {
    final value = role.value;
    if (value == 'system') return Role.system;
    if (value == 'model') return Role.model;
    if (value == 'tool') return Role.tool;
    return Role.user;
  }
}
