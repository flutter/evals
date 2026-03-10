import 'package:args/command_runner.dart';
import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/dataset_reader.dart';
import 'package:devals/src/dataset/eval_writer.dart';
import 'package:devals/src/dataset/file_templates/sample_template.dart';
import 'package:howdy/howdy.dart';

/// Interactive command to add a new sample to an existing task file.
class CreateSampleCommand extends Command<int> {
  @override
  String get name => 'sample';

  @override
  String get description => 'Add a new sample to an existing task file.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();
    terminal.maxWidth = 60;

    final existingTasks = datasetReader.getTasks();
    if (existingTasks.isEmpty) {
      Text.error(
        'No tasks found. Run "devals create task" first to create a task.',
      );
      return 1;
    }

    final results = Form.send(
      children: [
        Note(
          children: [
            Text(
              'This command will insert a new sample into a task with a placeholder input and output. '
              "You'll still need to ${'write'.italic} that sample within the task file.",
            ),
          ],
        ),
        Page(
          children: [
            Select<String>(
              'Select a task',
              help: 'The sample will be appended to this task file.',
              options: existingTasks
                  .map((t) => Option(label: t, value: t))
                  .toList(),
              key: 'task',
            ),
            Prompt(
              'Sample ID',
              help: 'A unique ID for this sample (snake_case).',
              key: 'id',
              validator: (value) =>
                  value.isEmpty ? 'Sample ID cannot be empty.' : null,
            ),
            Select<String>(
              'Difficulty',
              help: 'Used for filtering and reporting.',
              options: [
                Option(label: 'easy', value: 'easy'),
                Option(label: 'medium', value: 'medium'),
                Option(label: 'hard', value: 'hard'),
              ],
              defaultValue: 'medium',
              key: 'difficulty',
            ),
          ],
        ),
      ],
      title: 'Add a sample to a task',
    );

    final taskName = results['task'] as String;
    final sampleId = results['id'] as String;
    final difficulty = results['difficulty'] as String;

    final success = await SpinnerTask.send<bool>(
      'Adding sample to $taskName',
      task: () async {
        try {
          final sampleContent = sampleTemplate(
            id: sampleId,
            difficulty: difficulty,
          );
          generator.appendToTaskFile(taskName, content: sampleContent);
          return true;
        } catch (e) {
          throw CliException('Failed to add sample: $e');
        }
      },
    );

    if (success) {
      Text.success('Added "$sampleId" to task "$taskName"');
      Text.body(
        'Open ${generator.taskYamlFilePath(taskName)} and edit the INPUT and TARGET.',
      );
      return 0;
    } else {
      Text.error('Failed to add sample.');
      return 1;
    }
  }
}
