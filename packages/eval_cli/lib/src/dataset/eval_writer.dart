import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:path/path.dart' as p;

EvalsWriter get generator => EvalsWriter();

/// Contains methods for writing and editing YAML files.
/// For reading operations, use [DatasetReader].
class EvalsWriter {
  EvalsWriter._();
  static final EvalsWriter _instance = EvalsWriter._();
  factory EvalsWriter() => _instance;

  String get datasetDirPath => findDatasetDirectory();
  String get tasksDirPath => p.join(datasetDirPath, 'tasks');

  /// Returns the path for a task directory: tasks/{taskName}/
  String taskDirPath(String taskName) => p.join(tasksDirPath, taskName);

  /// Returns the path for a task YAML file: tasks/{taskName}/task.yaml
  String taskYamlFilePath(String taskName) =>
      p.join(taskDirPath(taskName), 'task.yaml');

  /// Writes a new task file at tasks/{taskName}/task.yaml.
  void writeTaskFile(String taskName, {required String yaml}) {
    final filePath = taskYamlFilePath(taskName);
    writeFile(filePath, yaml);
  }

  /// Appends content to an existing task file.
  void appendToTaskFile(String taskName, {required String content}) {
    final filePath = taskYamlFilePath(taskName);
    try {
      appendToFile(filePath, content);
    } on CliException catch (e) {
      throw CliException(
        '${e.message}\n\n'
        'Could not append sample to task file.\n'
        'Please manually add the sample to: $filePath\n'
        '$content',
      );
    }
  }

  /// Writes a job file to the jobs directory.
  void writeJobFile(String jobName, String content) {
    final jobsDir = findJobsDir(datasetDirPath);
    final jobFilePath = p.join(jobsDir, '$jobName.yaml');
    writeFile(jobFilePath, content);
  }
}
