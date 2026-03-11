import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dataset_config_dart/dataset_config_dart.dart';
import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/eval_writer.dart';
import 'package:devals/src/dataset/file_templates/job_template.dart';
import 'package:devals/src/dataset/file_templates/task_template.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:howdy/howdy.dart';

/// Interactive guide to create a task and job in one go.
class CreatePipelineCommand extends Command<int> {
  @override
  String get name => 'pipeline';

  @override
  String get description => 'Interactive guide to set up an end-to-end eval.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();

    final datasetDirPath = findDatasetDirectory();
    final tasksDirPath = findTasksDir(datasetDirPath);

    final availableFuncs = datasetReader.getTaskFuncs();
    if (availableFuncs.isEmpty) {
      throw CliException(
        'No task functions registered.\n'
        'Run sync_registries.py to regenerate the task registry.',
      );
    }

    final availableVariants = datasetReader.getVariants();
    final models = List.of(kDefaultModels);
    if (models.isEmpty) {
      throw CliException(
        'No models configured.',
      );
    }

    // =========================================================================
    // Form 1: Task setup
    // =========================================================================
    final taskResults = Form.send(
      title: 'Create an eval pipeline',
      children: [
        Note(
          next: true,
          nextLabel: 'Get started',
          children: [
            Text(
              'This command walks you through setting up an end-to-end eval.',
            ),
            Text('Running evals requires two components:', newline: false),
            Text(
              '  • A Task — input prompts paired with expected outputs.',
              newline: false,
            ),
            Text('  • A Job — which models, tasks, and variants to evaluate.'),
          ],
        ),
        Page(
          children: [
            Prompt(
              'Task ID',
              help:
                  'Unique identifier (snake_case, e.g., fix_shopping_cart_bug)',
              key: 'taskId',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Task ID cannot be empty.';
                }
                if (Directory('$tasksDirPath/$value').existsSync()) {
                  return 'Task "$value" already exists. Try another name.';
                }
                return null;
              },
            ),
            Select<String>(
              'Task function',
              help: 'Defines how the sample is run and scored.',
              options: availableFuncs
                  .map((f) => Option(label: f.name, value: f.name))
                  .toList(),
              key: 'taskFunc',
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
              help:
                  'Does your eval run against code? How is the code provided?',
              options: [
                Option(
                  label: 'path',
                  value: WorkspaceType.path,
                  help: 'Enter a path ref to the codebase.',
                ),
                Option(
                  label: 'git',
                  value: WorkspaceType.git,
                  help: 'Enter a public git url with the codebase.',
                ),
                Option(
                  label: 'create',
                  value: WorkspaceType.create,
                  help: 'Run a command to generate a new codebase.',
                ),
              ],
              key: 'workspaceType',
            ),
          ],
        ),
      ],
    );
    final taskId = taskResults['taskId'] as String;
    final taskFunc = taskResults['taskFunc'] as String;
    final selectedVariants = availableVariants.isNotEmpty
        ? taskResults['variants'] as List<String>
        : <String>[];
    final workspaceType = taskResults['workspaceType'] as WorkspaceType;

    // Workspace value depends on the selected type — collected standalone
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

    await SpinnerTask.send<void>(
      'Creating task "$taskId"',
      task: () async {
        try {
          await createTaskResources(
            taskId,
            tasksDirPath: tasksDirPath,
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
          );

          generator.writeTaskFile(taskId, yaml: yaml);
        } catch (e) {
          throw CliException('Failed to create task: $e');
        }
      },
    );

    Text.success('Created task: ${generator.taskYamlFilePath(taskId)}');

    // =========================================================================
    // Form 2: Job setup
    // =========================================================================
    final defaultModel = models.contains('google/gemini-2.5-flash')
        ? 'google/gemini-2.5-flash'
        : models.first;

    final jobResults = Form.send(
      title: 'Step 2: Create a Job',
      children: [
        Page(
          children: [
            Prompt(
              'Job name',
              help: 'Used to run evals via: devals run <job name>',
              defaultValue: '${taskId}_job',
              key: 'jobName',
              validator: (value) =>
                  value.isEmpty ? 'Job name cannot be empty.' : null,
            ),
            Multiselect<String>(
              'Models',
              help:
                  'Choose which models to evaluate. You need API keys for each provider.',
              options: models.map((m) => Option(label: m, value: m)).toList(),
              defaultValue: [defaultModel],
              key: 'models',
            ),
          ],
        ),
      ],
    );

    final jobName = jobResults['jobName'] as String;
    final selectedModels = jobResults['models'] as List<String>;

    await SpinnerTask.send<void>(
      'Creating job "$jobName"',
      task: () async {
        final jobContent = jobTemplate(
          name: jobName,
          models: selectedModels,
          variants: selectedVariants,
          tasks: [taskId],
        );
        generator.writeJobFile(jobName, jobContent);
      },
    );

    Text.success('Created job: jobs/$jobName.yaml');

    // =========================================================================
    // Done!
    // =========================================================================
    terminal.writeln();
    Text.body('🎉 You\'re all set!');
    Text.body('');
    Text.body('Next steps:');
    Text.body('  1. Edit the task at: ${generator.taskYamlFilePath(taskId)}');
    Text.body('     - Add your input prompt and expected target');
    Text.body('  2. Run your evaluation:');
    Text.body('     dart run bin/devals.dart run $jobName');

    return 0;
  }
}
