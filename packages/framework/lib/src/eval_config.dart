/// Configuration for an [EvalSet] run.
///
/// Controls caching, agent construction, and other run-time options without
/// requiring eval authors to interact with framework internals like [Backend]
/// or Genkit.
///
/// ```dart
/// final evalSet = EvalSet(
///   models: [Model('googleai', 'gemini-2.5-flash')],
///   evals: [MyEval()],
///   config: EvalConfig(cacheDir: '.devals-cache'),
/// );
/// ```
class EvalConfig {
  /// Cache directory for response caching. `null` disables caching.
  ///
  /// When set, model responses are persisted to disk keyed by input. On
  /// subsequent runs with the same inputs, cached responses are returned
  /// instantly — no API call.
  final String? cacheDir;

  const EvalConfig({
    this.cacheDir,
  });
}
