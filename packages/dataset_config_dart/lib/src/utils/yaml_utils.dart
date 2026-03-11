import 'dart:io';

import '../runner_config_exception.dart';
import 'package:yaml/yaml.dart';

/// Converts a YamlMap or YamlList to standard Dart Map/List.
dynamic convertYamlToObject(dynamic yaml) {
  if (yaml is YamlMap) {
    return Map<String, dynamic>.fromEntries(
      yaml.entries.map(
        (e) => MapEntry(e.key.toString(), convertYamlToObject(e.value)),
      ),
    );
  }
  if (yaml is YamlList) {
    return yaml.map(convertYamlToObject).toList();
  }
  return yaml;
}

/// Reads a YAML file and returns the parsed content.
/// Returns the raw YamlMap/YamlList for flexibility.
YamlNode readYamlFile(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    throw ConfigException('YAML file not found: $filePath');
  }
  final content = file.readAsStringSync();
  return loadYamlNode(content);
}

/// Reads a YAML file and converts it to a standard Dart Map.
Map<String, dynamic> readYamlFileAsMap(String filePath) {
  final yaml = readYamlFile(filePath);
  if (yaml is YamlMap) {
    return convertYamlToObject(yaml) as Map<String, dynamic>;
  }
  return {};
}
