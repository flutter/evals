/// Entry point for the deval CLI.
library;

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:devals/devals.dart';
import 'package:howdy/howdy.dart';

Future<void> main(List<String> args) async {
  final runner = CommandRunner<int>('devals', 'Manage dash-evals projects')
    ..addCommand(InitCommand())
    ..addCommand(DoctorCommand())
    ..addCommand(CreateCommand())
    ..addCommand(PublishCommand())
    ..addCommand(RunCommand())
    ..addCommand(ViewCommand());

  try {
    final exitCode = await runner.run(args) ?? 0;
    exit(exitCode);
  } on CliException catch (e) {
    Text.error('${e.message}\n');
    exit(e.exitCode);
  } on Exception catch (e) {
    Text.error('Error: $e\n');
    exit(1);
  }
}
