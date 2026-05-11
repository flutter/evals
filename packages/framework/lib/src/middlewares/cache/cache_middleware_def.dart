import 'package:genkit/genkit.dart';
import 'package:schemantic/schemantic.dart';

import 'cache_middleware.dart';

/// The name used to register [CacheMiddleware] in Genkit's middleware registry.
const cacheMwName = 'devals/cache';

/// Creates a [GenerateMiddlewareDef] backed by the given [instance].
///
/// Genkit resolves middleware by name from its registry. This factory builds a
/// def that always returns the **same** [CacheMiddleware] instance so that
/// cache hit/miss stats accumulate across all generate calls in a run.
///
/// ### Registration
///
/// ```dart
/// final mw = CacheMiddleware(cacheDir: '.devals-cache');
/// genkit.registry.registerValue(
///   'middleware',
///   cacheMwName,
///   cacheMiddlewareDefFor(mw),
/// );
/// ```
GenerateMiddlewareDef cacheMiddlewareDefFor(CacheMiddleware instance) {
  return _SharedInstanceDef(instance);
}

/// A [GenerateMiddlewareDef] that always returns the same pre-built instance.
class _SharedInstanceDef implements GenerateMiddlewareDef<void> {
  final CacheMiddleware _instance;

  _SharedInstanceDef(this._instance);

  @override
  String get name => cacheMwName;

  @override
  SchemanticType<void>? get configSchema => null;

  @override
  Map<String, Object?>? get configJsonSchema => null;

  @override
  GenerateMiddleware create([void config]) => _instance;
}
