import 'package:args/command_runner.dart';
import 'package:devals/src/dataset/dataset_reader.dart';
import 'package:devals/src/dataset/eval_writer.dart';
import 'package:devals/src/dataset/file_templates/job_template.dart';
import 'package:eval_config/eval_config.dart';
import 'package:howdy/howdy.dart';

/// Interactive command to create a new job file.
class CreateJobCommand extends Command<int> {
  @override
  String get name => 'job';

  @override
  String get description => 'Create a new job file interactively.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();

    // Get available options from the generated registries and filesystem
    final models = List.of(kDefaultModels);
    final variants = datasetReader.getVariants();
    final tasks = datasetReader.getTasks();

    final results = Form.send(
      title: 'Create a new job',
      children: [
        Note(
          next: true,
          nextLabel: 'Get started',
          children: [
            Text(
              'A ${"job".bold} is a runtime definition for dash-evals. It defines which tasks to run, which models to run against, and more. This flow generates a new job.yaml file, which is run with `devals run <job name>.'
                  .wordWrap(60),
            ),
          ],
        ),
        Page(
          children: [
            Prompt(
              'Job name',
              help: 'devals run <job name>',
              key: 'job',
              validator: (value) =>
                  value.isEmpty ? 'Job name cannot be empty' : null,
            ),
            Multiselect<String>(
              'Select tasks',
              help: 'Choose which tasks to run',
              options: tasks.map((t) => Option(label: t, value: t)).toList(),
              validator: (List<String>? selection) {
                if (selection == null || selection.isEmpty) {
                  return 'You must select at least one Task.';
                }
                return null;
              },
              key: 'tasks',
            ),
          ],
        ),
        Page(
          children: [
            Multiselect(
              'Select models',
              help: 'Tasks will run against each of these',
              options: models.map((m) => Option(label: m, value: m)).toList(),
              key: 'models',
              defaultValue: models
                  .where((String name) => name.contains('gemini'))
                  .toList(),
            ),
            Multiselect(
              'Select variants',
              help: 'Tasks will run once for each variant',
              options: variants.map((m) => Option(label: m, value: m)).toList(),
              defaultValue: ['baseline'],
              key: 'variants',
            ),
          ],
        ),
      ],
    );

    final jobName = results['job'] as String;
    final selectedModels = results['models'] as List<String>;
    final selectedVariants = results['variants'] as List<String>;
    final selectedTasks = results['tasks'] as List<String>;

    final success = await SpinnerTask.send<bool>(
      'Creating $jobName.yaml file',
      task: () async {
        // Build job YAML
        final jobContent = jobTemplate(
          name: jobName,
          models: selectedModels,
          variants: selectedVariants,
          tasks: selectedTasks,
        );

        // Write job file using the writer utility
        generator.writeJobFile(jobName, jobContent);
        return true;
      },
    );

    if (success) {
      Text.success('Created: jobs/$jobName.yaml');
      Text.body('Run with: devals run $jobName');
      return 0;
    } else {
      // Not sure if this is useful.
      // If not success, the Spinner task threw an error,
      // and this already exited.
      Text.error('Create job failed');
      return 1;
    }
  }
}
