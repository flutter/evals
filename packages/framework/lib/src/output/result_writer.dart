import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:evals_results/evals_results.dart';

import '../util/filesystem_util.dart';
import '../util/string_util.dart';

/// Writes the generated code from each eval result to [runDir].
///
/// ### Writing a full app copy (preferred)
///
/// When a result's `store` contains both `generated_app_base_path` and
/// `generated_files`, a complete copy of the base app is made:
///
/// 1. The directory at `generated_app_base_path` is copied to
///    `<runDir>/<prefix>/` where `prefix` = `<evalName>_<id>`.
/// 2. Each entry in `generated_files` (a `Map<String, String>` of relative
///    path → Dart source) is written into the copied directory, overwriting
///    the originals.
/// 3. `flutter pub get` is run in the copied directory.
/// 4. `dart format .` is run in the copied directory.
///
/// ### Writing individual files (legacy / fallback)
///
/// If `generated_app_base_path` is absent but `generated_files` (or the older
/// `generated_*_dart` keys) are present, each file is written as a flat
/// `.dart` file in [runDir] and formatted with `dart format`.
///
/// ### Raw completion fallback
///
/// If none of the above keys are present, the raw model completion is saved as
/// `<prefix>.dart` (with any markdown fences stripped).
///
/// [runDir] should be the directory returned by [writeEvalLog]. It is created
/// if it does not exist.
Future<void> writeGeneratedCode(
  EvalSetResult log, {
  required String runDir,
}) async {
  final dir = Directory(p.absolute(runDir));
  await dir.create(recursive: true);

  for (final evalResult in log.results) {
    final prefix = toSafeId(evalResult.id, allowHyphens: false);

    final store = evalResult.store;
    final rawFiles = store['generated_files'];
    final basePath = store['generated_app_base_path'] as String?;

    // Coerce generated_files to Map<String, String> regardless of how
    // the JSON deserializer represented the nested map.
    final Map<String, String>? generatedFiles;
    if (rawFiles is Map) {
      generatedFiles = {
        for (final e in rawFiles.entries) e.key.toString(): e.value.toString(),
      };
    } else {
      generatedFiles = null;
    }

    // ------------------------------------------------------------------
    // Path 1: full app copy
    // ------------------------------------------------------------------
    if (basePath != null && generatedFiles != null) {
      final sampleAppDir = Directory(p.join(dir.path, prefix));
      await copyDirectory(Directory(p.absolute(basePath)), sampleAppDir);

      for (final entry in generatedFiles.entries) {
        final dest = File(p.join(sampleAppDir.path, entry.key));
        await dest.parent.create(recursive: true);
        await dest.writeAsString(entry.value);
      }

      await runCommand('flutter', [
        'pub',
        'get',
      ], workingDir: sampleAppDir.path);
      await runCommand('dart', [
        'format',
        '.',
      ], workingDir: sampleAppDir.path);
      continue;
    }

    // ------------------------------------------------------------------
    // Path 2: individual flat .dart files (generated_files without a base)
    // ------------------------------------------------------------------
    if (generatedFiles != null && generatedFiles.isNotEmpty) {
      for (final entry in generatedFiles.entries) {
        // Use the relative path's filename as the suffix.
        final suffix = p
            .basenameWithoutExtension(entry.key)
            .replaceAll('/', '_');
        final file = File(p.join(dir.path, '${prefix}_$suffix.dart'));
        await file.writeAsString(entry.value);
        await formatDartFile(file.path);
      }
      continue;
    }

    // ------------------------------------------------------------------
    // Path 3: legacy generated_*_dart store keys
    // ------------------------------------------------------------------
    final legacyFiles = <String, String>{};
    for (final entry in store.entries) {
      if (entry.key.startsWith('generated_') &&
          entry.key.endsWith('_dart') &&
          entry.value is String) {
        final suffix = entry.key
            .replaceFirst('generated_', '')
            .replaceFirst(RegExp(r'_dart$'), '');
        legacyFiles[suffix] = entry.value as String;
      }
    }
    if (legacyFiles.isNotEmpty) {
      for (final entry in legacyFiles.entries) {
        final file = File(p.join(dir.path, '${prefix}_${entry.key}.dart'));
        await file.writeAsString(entry.value);
        await formatDartFile(file.path);
      }
      continue;
    }

    // ------------------------------------------------------------------
    // Path 4: raw completion text fallback
    // ------------------------------------------------------------------
    final raw = evalResult.output;
    final content = extractDartCode(raw);
    final file = File(p.join(dir.path, '$prefix.dart'));
    await file.writeAsString(content);
    await formatDartFile(file.path);
  }
}
