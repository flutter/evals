import 'dart:convert';

import 'package:dataset_config_dart/dataset_config_dart.dart';

/// Thin CLI wrapper that resolves a dataset + job using dataset_config_dart
/// and prints the resulting EvalSet JSON to stdout.
///
/// Usage:
///   dart run tool/bin/resolve_dart.dart [datasetPath] [jobName]
void main(List<String> args) {
  if (args.length != 2) {
    throw ArgumentError(
      'Usage: dart run tool/bin/resolve_dart.dart <datasetPath> <jobName>',
    );
  }

  final datasetPath = args[0];
  final jobName = args[1];

  final resolver = ConfigResolver();
  final evalSets = resolver.resolve(datasetPath, [jobName]);

  // Match the writer's convention: single → object, multiple → array
  final jsonContent = evalSets.length == 1
      ? evalSets.first.toJson()
      : evalSets.map((c) => c.toJson()).toList();

  // Sort keys for stable comparison
  final jsonString = const JsonEncoder.withIndent('  ').convert(jsonContent);
  // ignore: avoid_print
  print(jsonString);
}
