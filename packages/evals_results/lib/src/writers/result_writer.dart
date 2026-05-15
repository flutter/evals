import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../eval_set_result.dart';
import '../utils/string_util.dart';

/// Writes [log] to a timestamped run directory under [baseOutputDir].
///
/// The run directory is named `YYYY-MM-DD_HH-MM_<evalNames>` and is created
/// under [baseOutputDir] (default: `eval_logs`). All output files for the run
/// (log JSON, generated code, etc.) should be written into this directory so
/// each run is self-contained.
///
/// The log file inside the run directory is named `eval.json` and contains
/// the [EvalSetResult] serialised as JSON.
///
/// Returns the absolute path of the **run directory**.
///
/// ```dart
/// final log = await EvalSet(evals: [MyEval()], ...).run();
/// final runDir = await writeEvalLog(log);
/// print('Outputs written to $runDir');
/// ```
Future<String> writeEvalLog(
  EvalSetResult log, {
  String baseOutputDir = 'eval_logs',
}) async {
  final runDir = await _createRunDir(log, baseOutputDir);

  final file = File(p.join(runDir.path, 'eval.json'));
  final encoded = const JsonEncoder.withIndent('  ').convert(log.toJson());
  await file.writeAsString(encoded);

  return runDir.path;
}

/// Writes [log] directly into [runDir] as `eval.json`.
///
/// Unlike [writeEvalLog], this does not create a timestamped subdirectory —
/// the caller is responsible for creating [runDir] beforehand. This is used
/// by [runEvals] which creates the run directory early for log file output.
Future<String> writeEvalLogToDir(
  EvalSetResult log, {
  required String runDir,
}) async {
  final dir = Directory(runDir);
  await dir.create(recursive: true);

  final file = File(p.join(dir.path, 'eval.json'));
  final encoded = const JsonEncoder.withIndent('  ').convert(log.toJson());
  await file.writeAsString(encoded);

  return dir.path;
}

/// Creates and returns the run output directory under [baseOutputDir].
///
/// Directory name format: `YYYY-MM-DD_HH-MM_<evalNames>`
Future<Directory> _createRunDir(
  EvalSetResult log,
  String baseOutputDir,
) async {
  final timestamp = formatDirTimestamp(log.startedAt);
  final safeName = toSafeId(log.name, allowHyphens: false);
  final dirName = '${timestamp}_$safeName';

  final base = Directory(p.absolute(baseOutputDir));
  final runDir = Directory(p.join(base.path, dirName));
  await runDir.create(recursive: true);
  return runDir;
}
