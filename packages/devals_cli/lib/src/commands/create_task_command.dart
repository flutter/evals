import 'package:args/command_runner.dart';
import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/eval_writer.dart';
import 'package:devals/src/dataset/file_templates/task_template.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:howdy/howdy.dart';

/// Interactive command to create a new task file in tasks/{name}/task.yaml.
class CreateTaskCommand extends Command<int> {
  @override
  String get name => 'task';

  @override
  String get description => 'Create a new task file in tasks/.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();

    final existingTasks = datasetReader.getExistingTaskNames();
    final availableFuncs = datasetReader.getTaskFuncs();
    final availableVariants = datasetReader.getVariants();

    // Form 1: core task info
    final results = Form.send(
      children: [
        Note(
          next: true,
          nextLabel: 'Get started',
          children: [
            Text(
              'A task defines a group of samples that share a scoring '
              'function and run configuration.',
            ),
          ],
        ),
        Page(
          children: [
            Prompt(
              'Task name',
              help: 'Unique name (snake_case). Creates tasks/<name>/task.yaml.',
              key: 'name',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Task name cannot be empty.';
                }
                if (existingTasks.contains(value)) {
                  return 'Task "$value" already exists.';
                }
                return null;
              },
            ),
            Select<String>(
              'Task function',
              help: 'Defines how the sample is run and scored.',
              options: availableFuncs
                  .map(
                    (f) => Option(
                      label: f.name,
                      value: f.name,
                    ),
                  )
                  .toList(),
              key: 'func',
            ),
          ],
        ),
        Page(
          children: [
            if (availableVariants.isNotEmpty)
              Multiselect<String>(
                'Variants',
                help: 'Which variants to run for this task. Optional.',
                options: availableVariants
                    .map((v) => Option(label: v, value: v))
                    .toList(),
                key: 'variants',
              ),
            Select<WorkspaceType>(
              'Workspace type',
              help: 'How the task\'s sandbox workspace is provided.',
              options: [
                Option(
                  label: 'path',
                  value: WorkspaceType.path,
                  textStyle: const TextStyle(),
                ),
                Option(
                  label: 'git',
                  value: WorkspaceType.git,
                  textStyle: const TextStyle(),
                ),
                Option(
                  label: 'create',
                  value: WorkspaceType.create,
                  textStyle: const TextStyle(),
                ),
              ],
              key: 'workspaceType',
            ),
          ],
        ),
      ],
      title: 'Create a new task',
    );

    final taskName = results['name'] as String;
    final taskFunc = results['func'] as String;
    final selectedVariants = availableVariants.isNotEmpty
        ? results['variants'] as List<String>
        : <String>[];
    final workspaceType = results['workspaceType'] as WorkspaceType;

    // Workspace value depends on type — prompt standalone after the form
    final String? workspaceValue = switch (workspaceType) {
      WorkspaceType.path => Prompt.send(
        'Relative path',
        help:
            'Relative path to the project directory from the sample.yaml.\n'
            'Example: ../../my_app',
      ),
      WorkspaceType.git => Prompt.send(
        'Git URL',
        help:
            'Public repository URL.\n'
            'Example: https://github.com/user/repo',
      ),
      WorkspaceType.create => Prompt.send(
        'Creation command',
        help:
            'Command to run from the sample directory.\n'
            'Use "project" as the output name.\n'
            'Example: flutter create project --empty',
        defaultValue: 'flutter create project --empty',
      ),
      _ => null,
    };

    // Optional system message
    final systemMessage = Prompt.send(
      'System message (optional)',
      help:
          'Custom system prompt. Leave blank to skip.\n'
          'Example: "You are an expert Flutter developer."',
      defaultValue: '',
    );

    final tasksDir = findTasksDir(datasetReader.datasetDirPath);

    final success = await SpinnerTask.send<bool>(
      'Creating task "$taskName"',
      task: () async {
        try {
          await createTaskResources(
            taskName,
            tasksDirPath: tasksDir,
            workspaceKey: workspaceType,
            templatePackage: null,
            workspaceValue: workspaceValue,
          );

          final yaml = taskTemplate(
            taskFunc: taskFunc,
            workspaceType: workspaceType,
            templatePackage: null,
            workspaceValue: workspaceValue,
            variants: selectedVariants,
            systemMessage: systemMessage.isNotEmpty ? systemMessage : null,
          );

          generator.writeTaskFile(taskName, yaml: yaml);
          return true;
        } catch (e) {
          throw CliException('Failed to create task: $e');
        }
      },
    );

    if (success) {
      Text.success('Created: ${generator.taskYamlFilePath(taskName)}');
      Text.body(
        'Edit the task file to set your sample INPUT and TARGET.',
      );
      return 0;
    } else {
      Text.error('Create task failed.');
      return 1;
    }
  }
}
