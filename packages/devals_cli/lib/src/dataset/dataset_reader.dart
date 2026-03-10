import 'dart:io';

import 'package:path/path.dart' as p;
import 'filesystem_utils.dart';

/// Global accessor for the dataset reader singleton.
DatasetReader get datasetReader => DatasetReader();

/// Reads dataset YAML files for configuration.
class DatasetReader {
  DatasetReader._();
  static final DatasetReader _instance = DatasetReader._();
  factory DatasetReader() => _instance;

  String? _cachedDatasetPath;

  /// Clears the cached dataset path. Useful for testing.
  void clearCache() {
    _cachedDatasetPath = null;
  }

  /// Gets the path to the dataset directory.
  String get datasetDirPath {
    _cachedDatasetPath ??= findDatasetDirectory();
    return _cachedDatasetPath!;
  }

  /// Gets the path to the tasks directory.
  String get tasksDirPath => p.join(datasetDirPath, 'tasks');

  /// Returns the list of task names discovered from tasks/ directory.
  ///
  /// Each subdirectory in tasks/ that contains a task.yaml file is a task.
  /// The task name is derived from the directory name.
  List<String> getTasks() {
    final tasksDir = Directory(tasksDirPath);
    if (!tasksDir.existsSync()) {
      return [];
    }

    final taskNames = <String>[];
    for (final entity in tasksDir.listSync()) {
      if (entity is Directory) {
        final taskFile = File(p.join(entity.path, 'task.yaml'));
        if (taskFile.existsSync()) {
          taskNames.add(p.basename(entity.path));
        }
      }
    }
    taskNames.sort();
    return taskNames;
  }

  /// Returns the set of existing task names for duplicate checking.
  Set<String> getExistingTaskNames() => getTasks().toSet();

  /// Returns the list of available variant names.
  ///
  /// These come from the [DefaultVariants] enum, which defines the
  /// built-in variant configurations (baseline, flutter_rules, etc.).
  List<String> getVariants() {
    return DefaultVariants.values.map((v) => v.variantName).toList();
  }

  /// Returns task function info discovered from task.yaml files.
  ///
  /// Reads the `func` and optional `description` field from each task.yaml.
  List<({String name, String? help})> getTaskFuncs() {
    return getTasks().map((name) {
      return (name: name, help: null as String?);
    }).toList();
  }
}
