/// Framework abstraction over a model generation call.
///
/// Used by [GeminiApiProxy] to route CLI agent requests through the
/// framework's configured model backend, enabling model-matrix evaluation,
/// caching, and trajectory capture for process-based agents.
///
/// The interface operates at the Gemini API JSON level — request and response
/// bodies are raw Maps matching the Gemini REST API format. This keeps the
/// proxy implementation straightforward and avoids introducing new
/// framework-specific message types in Tier 2.
abstract class ModelProvider {
  /// Generate content for the given request.
  ///
  /// [model] is the model identifier extracted from the Gemini API request
  /// path (e.g. `'gemini-2.5-flash'`).
  ///
  /// [requestBody] is the parsed Gemini REST API request body (the `contents`,
  /// `systemInstruction`, `generationConfig`, and `tools` fields).
  ///
  /// Returns a Gemini REST API response body suitable for JSON serialization.
  Future<Map<String, dynamic>> generateContent({
    required String model,
    required Map<String, dynamic> requestBody,
  });
}
