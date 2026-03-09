import 'package:args/command_runner.dart';

import 'create_job_command.dart';
import 'create_pipeline_command.dart';
import 'create_sample_command.dart';
import 'create_task_command.dart';

/// Parent command for create subcommands.
class CreateCommand extends Command<int> {
  CreateCommand() {
    addSubcommand(CreateSampleCommand());
    addSubcommand(CreateJobCommand());
    addSubcommand(CreateTaskCommand());
    addSubcommand(CreatePipelineCommand());
  }

  @override
  String get name => 'create';

  @override
  String get description => 'Create samples, jobs, and tasks for the dataset.';
}
