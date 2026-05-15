import 'package:genkit/genkit.dart' as g;
import 'package:ai/ai.dart' as ai;

import 'genkit_backend/genkit_ai.dart';
import '../middlewares/cache/cache_middleware.dart';
import '../middlewares/cache/cache_middleware_def.dart';

/// Shared caching logic for [Backend] implementations that support
/// per-model response caching via Genkit middleware.
///
/// Provides:
/// - [middlewareRefFor] — lazily creates per-model cache middleware.
/// - [cacheStats] — aggregates hit/miss counts across all models.
mixin CacheableBackend {
  /// Per-model cache middleware instances (created lazily).
  final Map<String, CacheMiddleware> cacheMiddlewareByModel = {};

  /// Lazily creates a per-model [g.GenerateMiddlewareRef] backed by a
  /// [CacheMiddleware] that writes to a model-specific subdirectory.
  g.GenerateMiddlewareRef middlewareRefFor(
    String dir,
    ai.Model model,
    GenkitAI genkitAi,
  ) {
    final modelKey = model.toString().replaceAll('/', '_');
    if (!cacheMiddlewareByModel.containsKey(modelKey)) {
      final modelCacheDir = '$dir/$modelKey';
      final mw = CacheMiddleware(cacheDir: modelCacheDir);
      cacheMiddlewareByModel[modelKey] = mw;
      final mwName = '${cacheMwName}_$modelKey';
      genkitAi.genkit.registry.registerValue(
        'middleware',
        mwName,
        cacheMiddlewareDefFor(mw),
      );
      return g.middlewareRef(name: mwName);
    }
    final mwName = '${cacheMwName}_$modelKey';
    return g.middlewareRef(name: mwName);
  }

  /// Aggregate cache hit/miss statistics across all per-model caches.
  ({int hits, int misses}) get cacheStats {
    var totalHits = 0;
    var totalMisses = 0;
    for (final mw in cacheMiddlewareByModel.values) {
      final (:hits, :misses) = mw.stats;
      totalHits += hits;
      totalMisses += misses;
    }
    return (hits: totalHits, misses: totalMisses);
  }
}
