import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// Cross-language config parity verification.
///
/// For each fixture in `tool/fixtures/`, runs both the Dart and Python config
/// resolvers with the same YAML input and verifies they produce identical
/// JSON output.
///
/// Usage:
///   dart run tool/verify_config_parity.dart
///
/// Exit codes:
///   0  — all fixtures match
///   1  — one or more fixtures diverge (diff printed to stderr)
void main() async {
  final repoRoot = _findRepoRoot();
  final fixturesDir = Directory(p.join(repoRoot, 'tool', 'fixtures'));

  if (!fixturesDir.existsSync()) {
    stderr.writeln('ERROR: fixtures directory not found: ${fixturesDir.path}');
    exit(1);
  }

  final fixtureDirs = fixturesDir.listSync().whereType<Directory>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  if (fixtureDirs.isEmpty) {
    stderr.writeln(
      'ERROR: no fixture directories found in ${fixturesDir.path}',
    );
    exit(1);
  }

  stdout.writeln('Config Parity Verification');
  stdout.writeln('=' * 60);
  stdout.writeln('');

  var allPassed = true;

  for (final fixtureDir in fixtureDirs) {
    final fixtureName = p.basename(fixtureDir.path);
    final jobsDir = Directory(p.join(fixtureDir.path, 'jobs'));

    if (!jobsDir.existsSync()) {
      stderr.writeln('  SKIP $fixtureName — no jobs/ directory');
      continue;
    }

    final jobFiles = jobsDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.yaml') || f.path.endsWith('.yml'))
        .toList();

    for (final jobFile in jobFiles) {
      final jobName = p.basenameWithoutExtension(jobFile.path);
      final label = '$fixtureName / $jobName';

      stdout.write('  $label ... ');

      try {
        final passed = await _verifyFixture(
          repoRoot: repoRoot,
          datasetPath: fixtureDir.path,
          jobName: jobName,
          label: label,
        );
        if (passed) {
          stdout.writeln('✅ PASS');
        } else {
          stdout.writeln('❌ FAIL');
          allPassed = false;
        }
      } catch (e) {
        stdout.writeln('💥 ERROR');
        stderr.writeln('    $e');
        allPassed = false;
      }
    }
  }

  stdout.writeln('');
  if (allPassed) {
    stdout.writeln('All fixtures passed! 🎉');
  } else {
    stdout.writeln('Some fixtures FAILED. See errors above.');
    exit(1);
  }
}

/// Run both resolvers on the given fixture and compare JSON output.
Future<bool> _verifyFixture({
  required String repoRoot,
  required String datasetPath,
  required String jobName,
  required String label,
}) async {
  // Run Dart resolver
  final dartResult = await Process.run(
    'dart',
    [
      'run',
      p.join(repoRoot, 'tool', 'bin', 'resolve_dart.dart'),
      datasetPath,
      jobName,
    ],
    workingDirectory: repoRoot,
  );

  if (dartResult.exitCode != 0) {
    stderr.writeln('    Dart resolver failed (exit ${dartResult.exitCode}):');
    stderr.writeln(_indent(dartResult.stderr.toString()));
    return false;
  }

  // Run Python resolver
  // Use the venv Python if available, otherwise fall back to system python3.
  final pythonBin = _findPython(repoRoot);
  final pythonResult = await Process.run(
    pythonBin,
    [
      p.join(repoRoot, 'tool', 'bin', 'resolve_python.py'),
      datasetPath,
      jobName,
    ],
    workingDirectory: repoRoot,
    environment: {
      'PYTHONPATH': p.join(
        repoRoot,
        'packages',
        'dataset_config_python',
        'src',
      ),
    },
  );

  if (pythonResult.exitCode != 0) {
    stderr.writeln(
      '    Python resolver failed (exit ${pythonResult.exitCode}):',
    );
    stderr.writeln(_indent(pythonResult.stderr.toString()));
    return false;
  }

  // Parse JSON outputs
  final dartJson = _parseAndNormalize(dartResult.stdout.toString().trim());
  final pythonJson = _parseAndNormalize(pythonResult.stdout.toString().trim());

  // Deep compare
  if (_deepEquals(dartJson, pythonJson)) {
    return true;
  }

  // Print diff on failure
  final dartPretty = const JsonEncoder.withIndent('  ').convert(dartJson);
  final pythonPretty = const JsonEncoder.withIndent('  ').convert(pythonJson);

  stderr.writeln('    JSON output differs for $label:');
  stderr.writeln('');
  _printDiff(dartPretty, pythonPretty);

  return false;
}

/// Regex to match timestamped log_dir suffixes (e.g. /2026-03-11_19-52-13).
final _timestampSuffix = RegExp(r'/\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}$');

/// Parse JSON string and normalize for comparison:
/// - Sort all map keys recursively
/// - Remove null values (Dart includes them, Python excludes with exclude_none)
/// - Remove empty maps/lists that one side might include but the other omits
/// - Normalize timestamped log_dir paths
dynamic _parseAndNormalize(String jsonStr) {
  final parsed = json.decode(jsonStr);
  return _normalize(parsed);
}

/// Recursively normalize a JSON value for comparison.
dynamic _normalize(dynamic value) {
  if (value is Map) {
    final sorted = Map<String, dynamic>.fromEntries(
      (value.entries.toList()
            ..sort((a, b) => a.key.toString().compareTo(b.key.toString())))
          .map((e) => MapEntry(e.key.toString(), _normalize(e.value))),
    );
    // Remove null values (Dart freezed includes them, Python excludes them)
    sorted.removeWhere((k, v) => v == null);
    // Remove empty map/list values that might be omitted on the other side
    sorted.removeWhere((k, v) {
      if (v is Map && v.isEmpty) return true;
      if (v is List && v.isEmpty) return true;
      return false;
    });
    // Strip Dart-only fields that have false/zero defaults and are absent
    // from Python models (e.g. Dataset.shuffled, Dataset.location).
    const dartOnlyDefaults = <String, dynamic>{
      'shuffled': false,
    };
    for (final entry in dartOnlyDefaults.entries) {
      if (sorted[entry.key] == entry.value) {
        sorted.remove(entry.key);
      }
    }
    // Normalize timestamped log_dir paths — both sides append timestamps
    // but at slightly different times; strip the timestamp for comparison
    if (sorted.containsKey('log_dir') && sorted['log_dir'] is String) {
      sorted['log_dir'] = (sorted['log_dir'] as String).replaceAll(
        _timestampSuffix,
        '/<TIMESTAMP>',
      );
    }
    return sorted;
  }
  if (value is List) {
    return value.map(_normalize).toList();
  }
  // Normalize numeric types: int 0 == double 0.0
  if (value is num) {
    if (value == value.toInt()) return value.toInt();
    return value.toDouble();
  }
  return value;
}

/// Deep equality check for JSON-like structures.
bool _deepEquals(dynamic a, dynamic b) {
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!_deepEquals(a[key], b[key])) return false;
    }
    return true;
  }
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_deepEquals(a[i], b[i])) return false;
    }
    return true;
  }
  return a == b;
}

/// Print a line-by-line diff between two strings.
void _printDiff(String a, String b) {
  final aLines = a.split('\n');
  final bLines = b.split('\n');
  final maxLines = aLines.length > bLines.length
      ? aLines.length
      : bLines.length;

  for (var i = 0; i < maxLines; i++) {
    final aLine = i < aLines.length ? aLines[i] : '';
    final bLine = i < bLines.length ? bLines[i] : '';
    if (aLine != bLine) {
      stderr.writeln('      dart:   $aLine');
      stderr.writeln('      python: $bLine');
      stderr.writeln('');
    }
  }
}

/// Find the repo root by looking for pubspec.yaml.
String _findRepoRoot() {
  var dir = Directory.current;
  while (true) {
    if (File(p.join(dir.path, 'pubspec.yaml')).existsSync() &&
        Directory(p.join(dir.path, 'packages')).existsSync()) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      // Fallback to current directory
      return Directory.current.path;
    }
    dir = parent;
  }
}

/// Find the best Python executable. Prefers the repo's venv if it exists.
String _findPython(String repoRoot) {
  final venvPython = p.join(repoRoot, '.venv', 'bin', 'python');
  if (File(venvPython).existsSync()) return venvPython;

  final venvPython3 = p.join(repoRoot, '.venv', 'bin', 'python3');
  if (File(venvPython3).existsSync()) return venvPython3;

  return 'python3';
}

/// Indent every line for nested error output.
String _indent(String text, {String prefix = '      '}) {
  return text.split('\n').map((line) => '$prefix$line').join('\n');
}
