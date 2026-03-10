import 'dart:io';

import 'package:devals/src/dataset/file_templates/pubspec_template.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../cli_exception.dart';
import 'workspace.dart';

export 'dataset_reader.dart';
export 'variant_defaults.dart';
export 'workspace.dart';

/// Finds or creates the tasks directory.
String findTasksDir(String datasetDirPath) {
  final tasksDirPath = p.join(datasetDirPath, 'tasks');
  final dir = Directory(tasksDirPath);

  if (!dir.existsSync()) {
    stderr.writeln(
      'Tasks directory not found. Creating: $tasksDirPath',
    );
    dir.createSync(recursive: true);
  }
  return tasksDirPath;
}

/// Creates the task directory structure at tasks/{taskName}/.
///
/// If a workspace type is provided, creates the project/ subdirectory
/// with appropriate scaffolding.
///
/// Returns the path to the new dir at tasks/{taskName}
Future<String> createTaskResources(
  String taskName, {
  required String tasksDirPath,
  WorkspaceType? workspaceKey,
  TemplatePackage? templatePackage,
  String? workspaceValue,
}) async {
  final dir = p.join(tasksDirPath, taskName);

  try {
    // Create task directory
    Directory(dir).createSync(recursive: true);

    // For any workspace type, create the project/ directory
    if (workspaceKey != null) {
      final projectDir = p.join(dir, 'project');

      if (workspaceKey == WorkspaceType.create) {
        // Run the creation command from the task dir.
        final parts = workspaceValue?.split(' ') ?? [];
        if (parts.isEmpty) {
          throw CliException('No creation command provided.');
        }
        final result = Process.runSync(
          parts.first,
          parts.skip(1).toList(),
          workingDirectory: dir,
        );
        if (result.exitCode != 0) {
          throw CliException(
            'Creation command failed (exit ${result.exitCode}):\n${result.stderr}',
          );
        }
      } else if (workspaceKey == WorkspaceType.template) {
        // Template workspaces don't need a local project directory
        // — the solver creates them at runtime.
      } else {
        // For path/git: create project/ and generate a pubspec
        Directory(projectDir).createSync();
        final pubspecContent = pubspecTemplate(
          sampleId: taskName,
          workspaceKey: workspaceKey,
          templatePackage: templatePackage,
          workspaceValue: workspaceValue,
        );
        File(
          p.join(projectDir, 'pubspec.yaml'),
        ).writeAsStringSync(pubspecContent);
      }
    }
  } on FileSystemException {
    rethrow;
  }

  return dir;
}

/// Finds or creates the jobs directory within the dataset directory.
String findJobsDir(String datasetDirPath) {
  final jobsDirPath = p.join(datasetDirPath, 'jobs');
  ensureDirectoryExists(jobsDirPath);
  return jobsDirPath;
}

/// Finds the logs directory within the dataset directory.
/// Returns null if it doesn't exist.
String? findLogsDir(String datasetDirPath) {
  final logsPath = p.join(datasetDirPath, 'logs');
  if (Directory(logsPath).existsSync()) {
    return logsPath;
  }
  return null;
}

/// Ensures a directory exists, creating it if necessary.
void ensureDirectoryExists(String dirPath) {
  final dir = Directory(dirPath);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
}

/// Writes content to a file with error handling.
/// Creates parent directories if they don't exist.
void writeFile(String filePath, String content) {
  try {
    final file = File(filePath);
    final parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }
    file.writeAsStringSync(content);
  } on FileSystemException catch (e) {
    throw CliException(
      'Failed to write file: $filePath\n${e.message}',
    );
  }
}

/// Reads file content as a string. Throws CliException if file doesn't exist.
String readFile(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    throw CliException('File not found: $filePath');
  }
  return file.readAsStringSync();
}

/// Appends content to an existing file. Throws CliException if file doesn't exist.
void appendToFile(String filePath, String content) {
  final file = File(filePath);
  if (!file.existsSync()) {
    throw CliException('File not found: $filePath');
  }
  try {
    file.writeAsStringSync(content, mode: FileMode.append);
  } on FileSystemException catch (e) {
    throw CliException(
      'Failed to append to file: $filePath\n${e.message}',
    );
  }
}

// ------------------------------------------------------------------
// Dataset discovery (moved from dataset_config)
// ------------------------------------------------------------------

/// The marker file that identifies a devals project root.
const devalsYamlFilename = 'devals.yaml';
const maxSearchDepth = 10;

/// Finds the dataset directory by walking up from the current directory
/// looking for a `devals.yaml` marker file.
///
/// The `devals.yaml` file must contain a `dataset` field pointing to the
/// directory containing `tasks/` and `jobs/`, relative to the yaml file.
///
/// This works like `flutter` finding `pubspec.yaml` — you can run `devals`
/// from any subdirectory of your project.
///
/// Throws [CliException] if no `devals.yaml` is found.
String findDatasetDirectory() {
  var dir = Directory.current.absolute;

  for (var i = 0; i < maxSearchDepth; i++) {
    final yamlFile = File(p.join(dir.path, devalsYamlFilename));
    if (yamlFile.existsSync()) {
      return _resolveDatasetPath(yamlFile);
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break; // filesystem root
    dir = parent;
  }

  throw CliException(
    'Could not find $devalsYamlFilename in this directory or any parent.\n'
    '\n'
    'Run "devals init" to initialize a new devals project.',
  );
}

/// Reads the `dataset` field from a `devals.yaml` file and resolves
/// it to an absolute path.
String _resolveDatasetPath(File yamlFile) {
  final content = yamlFile.readAsStringSync();
  final yaml = loadYaml(content);

  if (yaml is! Map || !yaml.containsKey('dataset')) {
    throw CliException(
      '${yamlFile.path} is missing the required "dataset" field.\n'
      'Expected format:\n'
      '  dataset: ./evals',
    );
  }

  final datasetRelative = yaml['dataset'] as String;
  final projectRoot = p.dirname(yamlFile.path);
  final datasetPath = p.normalize(p.join(projectRoot, datasetRelative));

  // Verify the dataset directory contains tasks/
  if (!Directory(p.join(datasetPath, 'tasks')).existsSync()) {
    throw CliException(
      'Dataset directory does not contain a tasks/ subdirectory: '
      '$datasetPath\n'
      'Check the "dataset" field in ${yamlFile.path}.',
    );
  }

  return datasetPath;
}

/// Tries to find the dataset directory, returning null instead of throwing.
/// Useful when the dataset directory is optional.
String? tryFindDatasetDirectory() {
  try {
    return findDatasetDirectory();
  } on CliException {
    return null;
  }
}
