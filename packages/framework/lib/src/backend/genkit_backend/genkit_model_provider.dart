import 'package:genkit/genkit.dart' as g;

import '../model_provider.dart';

/// A [ModelProvider] that routes generation through a [g.Genkit] instance.
///
/// Used by [GeminiApiProxy] when the eval suite is using the Genkit backend.
/// Converts between the Gemini REST API JSON format (used by the proxy) and
/// Genkit's typed [g.Message] / [g.Part] model.
///
/// ### Model name normalisation
///
/// The Gemini CLI sends model names without a provider prefix (e.g.
/// `gemini-2.5-flash`). Genkit requires a prefixed identifier (e.g.
/// `googleai/gemini-2.5-flash`). If no `/` is present, `googleai/` is
/// prepended automatically.
class GenkitModelProvider implements ModelProvider {
  /// The Genkit instance to use for generation.
  final g.Genkit genkit;

  /// Optional middleware (e.g. caching) to apply to every generate call.
  final List<g.GenerateMiddlewareRef>? use;

  const GenkitModelProvider({required this.genkit, this.use});

  @override
  Future<Map<String, dynamic>> generateContent({
    required String model,
    required Map<String, dynamic> requestBody,
  }) async {
    final messages = _parseContents(requestBody);

    // Prepend system instruction as a system-role message.
    final sysInstruction =
        requestBody['systemInstruction'] as Map<String, dynamic>?;
    if (sysInstruction != null) {
      final parts = _parseParts(sysInstruction['parts'] as List? ?? []);
      if (parts.isNotEmpty) {
        messages.insert(0, g.Message(role: g.Role.system, content: parts));
      }
    }

    // Normalise model name: "gemini-2.5-flash" → "googleai/gemini-2.5-flash".
    final modelId = model.contains('/') ? model : 'googleai/$model';

    final response = await genkit.generate(
      model: g.modelRef(modelId),
      messages: messages,
      returnToolRequests: true,
      use: use,
    );

    return _toGeminiResponse(response);
  }

  // ---------------------------------------------------------------------------
  // Gemini API → Genkit conversion
  // ---------------------------------------------------------------------------

  List<g.Message> _parseContents(Map<String, dynamic> body) {
    final contents = body['contents'] as List? ?? [];
    return contents.map<g.Message>((c) {
      final roleStr = c['role'] as String? ?? 'user';
      final role = switch (roleStr) {
        'model' => g.Role.model,
        'tool' => g.Role.tool,
        _ => g.Role.user,
      };
      return g.Message(
        role: role,
        content: _parseParts(c['parts'] as List? ?? []),
      );
    }).toList();
  }

  List<g.Part> _parseParts(List parts) {
    return parts.map<g.Part>((p) {
      if (p['text'] != null) return g.TextPart(text: p['text'] as String);
      if (p['functionResponse'] != null) {
        final fr = p['functionResponse'] as Map<String, dynamic>;
        return g.ToolResponsePart(
          toolResponse: g.ToolResponse(
            name: fr['name'] as String,
            ref: fr['name'] as String,
            output: fr['response'] as Map<String, dynamic>? ?? {},
          ),
        );
      }
      // Unknown part — fall back to text representation.
      return g.TextPart(text: p.toString());
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Genkit response → Gemini API conversion
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _toGeminiResponse(g.GenerateResponseHelper response) {
    final message = response.message;
    final parts = <Map<String, dynamic>>[];

    if (message != null) {
      for (final part in message.content) {
        final json = part.toJson();
        if (json.containsKey('text')) {
          parts.add({'text': json['text']});
        } else if (json.containsKey('toolRequest')) {
          final tr = json['toolRequest'] as Map<String, dynamic>;
          parts.add({
            'functionCall': {
              'name': tr['name'],
              'args': tr['input'] ?? <String, dynamic>{},
            },
          });
        }
      }
    }

    final hasToolCalls =
        response.toolRequests.isNotEmpty ||
        parts.any((p) => p.containsKey('functionCall'));

    return {
      'candidates': [
        {
          'content': {
            'role': 'model',
            'parts': parts.isEmpty
                ? [
                    <String, dynamic>{'text': ''},
                  ]
                : parts,
          },
          'finishReason': hasToolCalls ? 'TOOL_USE' : 'STOP',
          'index': 0,
        },
      ],
      'usageMetadata': {
        'promptTokenCount': (response.usage?.inputTokens ?? 0).round(),
        'candidatesTokenCount': (response.usage?.outputTokens ?? 0).round(),
        'totalTokenCount': (response.usage?.totalTokens ?? 0).round(),
      },
    };
  }
}
