import 'dart:convert';
import 'dart:io';

import '../models/models.dart';
import 'package:path/path.dart' as p;

/// Writes resolved [EvalSet] configs as a single JSON file.
///
/// The output JSON maps ~1:1 to `eval_set()` kwargs. Datasets are inlined
/// in each task — no separate JSONL files needed.
class EvalSetWriter {
  /// Write [EvalSet] JSON for the given resolved configs.
  ///
  /// Files are written to [outputDir]. Returns the path to the JSON file.
  String write(List<EvalSet> configs, String outputDir) {
    Directory(outputDir).createSync(recursive: true);

    final jsonPath = p.join(outputDir, 'eval_set.json');

    // Single config → single object; multiple → array
    final jsonContent = configs.length == 1
        ? configs.first.toJson()
        : configs.map((c) => c.toJson()).toList();

    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonContent);
    File(jsonPath).writeAsStringSync(jsonString);

    return jsonPath;
  }
}
