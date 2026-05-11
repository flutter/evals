import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';

import 'package:genkit/genkit.dart' show ModelRequest, ModelResponse;

final _log = Logger('FileCache');

/// A simple file-backed cache for model request/response pairs.
///
/// Each entry is stored as a JSON file named `<sha256>.json` inside [cacheDir].
/// The file contains both the original request (for debugging / manual
/// invalidation) and the response.
class FileCache {
  /// Directory where cache files are written.
  final String cacheDir;

  FileCache({required this.cacheDir});

  /// Computes a deterministic cache key from a [ModelRequest].
  ///
  /// The key is the hex SHA-256 of the request's canonical JSON. Tool
  /// definitions, messages, config, and output constraints are all included
  /// so that any change in inputs produces a new key.
  String keyFor(ModelRequest request) {
    final json = canonicalJson(request.toJson());
    return sha256.convert(utf8.encode(json)).toString();
  }

  /// Returns the cached [ModelResponse] for [key], or `null` on miss.
  Future<ModelResponse?> read(String key) async {
    final file = File(_pathFor(key));
    if (!file.existsSync()) return null;

    try {
      final raw = await file.readAsString();
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final responseJson = map['response'] as Map<String, dynamic>;
      return ModelResponse.fromJson(responseJson);
    } catch (e) {
      // Corrupted cache entry — treat as miss, but log for visibility.
      _log.fine('Corrupt cache entry $key, treating as miss: $e');
      return null;
    }
  }

  /// Writes a request/response pair to disk.
  Future<void> write(
    String key,
    ModelRequest request,
    ModelResponse response,
  ) async {
    final dir = Directory(cacheDir);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final payload = jsonEncode({
      'request': request.toJson(),
      'response': response.toJson(),
    });

    await File(_pathFor(key)).writeAsString(payload);
  }

  /// Deletes all cache entries.
  Future<int> clear() async {
    final dir = Directory(cacheDir);
    if (!dir.existsSync()) return 0;

    var count = 0;
    await for (final entity in dir.list()) {
      if (entity is File && entity.path.endsWith('.json')) {
        await entity.delete();
        count++;
      }
    }
    return count;
  }

  String _pathFor(String key) => '$cacheDir/$key.json';

  /// Produces a canonical (deterministic) JSON string by recursively sorting
  /// map keys.
  static String canonicalJson(Object? value) {
    return jsonEncode(_sortKeys(value));
  }

  static Object? _sortKeys(Object? value) => switch (value) {
    Map<String, dynamic>() => Map.fromEntries(
      (value.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
          .map((e) => MapEntry(e.key, _sortKeys(e.value))),
    ),
    List() => value.map(_sortKeys).toList(),
    _ => value,
  };
}
