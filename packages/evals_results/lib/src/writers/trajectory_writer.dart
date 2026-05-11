import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../eval_result.dart';

/// Writes per-eval conversation trajectory files to disk.
///
/// Produces one JSONL file per [EvalResult] that has a non-null trajectory.
/// Each line is a single message serialised via `Message.toJson()`.
///
/// ## Output format
///
/// ```
/// {"role":"system","content":[{"text":"You are a coding agent..."}]}
/// {"role":"user","content":[{"text":"Fix the bug in counter_app..."}]}
/// {"role":"model","content":[{"toolRequest":{"name":"bash","input":{...}}}]}
/// {"role":"tool","content":[{"toolResponse":{"name":"bash","output":"..."}}]}
/// ```
///
/// Write per-eval trajectory files into [runDir].
///
/// Produces: `<runDir>/<evalId>_trajectory.jsonl`
Future<void> writeTrajectories(
  List<EvalResult> results, {
  required String runDir,
}) async {
  for (final result in results) {
    final trajectory = result.trajectory;
    if (trajectory == null || trajectory.isEmpty) continue;

    final safeId = result.id.replaceAll('/', '-');
    final file = File(p.join(runDir, '${safeId}_trajectory.jsonl'));
    final sink = file.openWrite();
    for (final message in trajectory) {
      sink.writeln(jsonEncode(message.toJson()));
    }
    await sink.flush();
    await sink.close();
  }
}
