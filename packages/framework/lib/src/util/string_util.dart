import 'dart:math';

final _rng = Random.secure();

/// Generates a random 16-character hex ID.
String randomId() {
  final bytes = List<int>.generate(8, (_) => _rng.nextInt(256));
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

/// Formats a [DateTime] as `YYYY-MM-DD_HH-MM` for use in directory names.
String formatDirTimestamp(DateTime dt) {
  final y = dt.year.toString().padLeft(4, '0');
  final mo = dt.month.toString().padLeft(2, '0');
  final d = dt.day.toString().padLeft(2, '0');
  final h = dt.hour.toString().padLeft(2, '0');
  final mi = dt.minute.toString().padLeft(2, '0');
  final sec = dt.second.toString().padLeft(2, '0');
  return '$y-$mo-${d}__$h-$mi-$sec';
}

/// Extracts the first Dart code block from [text], or returns the raw text.
///
/// If [text] contains a fenced `` ```dart ... ``` `` block, its contents are
/// returned. Otherwise the full [text] is returned as-is. This handles the
/// common case where the model wraps its output in a markdown code fence.
String extractDartCode(String text) {
  final fencePattern = RegExp(r'```(?:dart)?\n([\s\S]*?)```', multiLine: true);
  final match = fencePattern.firstMatch(text);
  if (match != null) return match.group(1) ?? text;
  return text;
}

/// Replaces non-alphanumeric characters (except `_` and `-`) with `_`.
///
/// Useful for converting sample IDs, task names, etc. into filesystem- and
/// log-safe identifiers.
String toSafeId(String value, {bool allowHyphens = true}) {
  final pattern = allowHyphens
      ? RegExp(r'[^a-zA-Z0-9_\-]')
      : RegExp(r'[^a-zA-Z0-9_]');
  return value.replaceAll(pattern, '_');
}
