import 'package:genkit/genkit.dart';

import '../../logging/eval_log.dart';
import 'file_cache.dart';

/// A Genkit [GenerateMiddleware] that caches model responses to disk.
///
/// Intercepts at the `model()` level so each individual `genkit.generate()`
/// call is cached independently. This works transparently with both
/// single-turn ([BasicAgent]) and multi-turn ([MiniSweAgent]) agents.
///
/// ## Usage
///
/// Pass as a middleware ref when creating an [EvalSet]:
///
/// ```dart
/// final result = await runEvals(
///   evalSet,
///   cacheDir: '.devals-cache',
/// );
/// ```
///
/// Or use directly with Genkit:
///
/// ```dart
/// final cache = CacheMiddleware(cacheDir: '.devals-cache');
/// // Register with Genkit or use via Agent's `use` parameter.
/// ```
class CacheMiddleware extends GenerateMiddleware {
  /// The file cache backing this middleware.
  final FileCache _cache;

  /// Number of cache hits during this session.
  int _hits = 0;

  /// Number of cache misses (API calls made) during this session.
  int _misses = 0;

  /// Creates a [CacheMiddleware] writing to [cacheDir].
  CacheMiddleware({String cacheDir = '.devals-cache'})
    : _cache = FileCache(cacheDir: cacheDir);

  /// Session statistics for logging.
  ({int hits, int misses}) get stats => (hits: _hits, misses: _misses);

  @override
  Future<ModelResponse> model(
    ModelRequest request,
    ActionFnArg<ModelResponseChunk, ModelRequest, void> ctx,
    Future<ModelResponse> Function(
      ModelRequest request,
      ActionFnArg<ModelResponseChunk, ModelRequest, void> ctx,
    )
    next,
  ) async {
    final key = _cache.keyFor(request);
    final cached = await _cache.read(key);

    if (cached != null) {
      _hits++;
      EvalLog.cacheEvent(hit: true, key: key);
      return cached;
    }

    final response = await next(request, ctx);
    await _cache.write(key, request, response);
    _misses++;
    EvalLog.cacheEvent(hit: false, key: key);
    return response;
  }
}
