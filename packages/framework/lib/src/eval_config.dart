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

  /// When `true`, the framework copies the sandbox working directory
  /// to the run output directory after each eval cell completes.
  ///
  /// The project is saved to `<runDir>/<evalId>/` where `evalId` is
  /// the cell identifier (e.g. `flutter_bug_fix_gemini-2.5-flash_baseline`).
  ///
  /// Has no effect when the eval doesn't use a sandbox.
  final bool saveCode;

  /// The path inside the sandbox to extract when [saveCode] is `true`.
  ///
  /// Defaults to `/workspace/app` — the conventional sandbox workspace.
  final String sandboxWorkDir;

  const EvalConfig({
    this.cacheDir,
    this.saveCode = false,
    this.sandboxWorkDir = '/workspace/app',
  });
}
