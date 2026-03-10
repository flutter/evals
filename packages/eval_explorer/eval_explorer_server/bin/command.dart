import 'dart:async';
import 'package:args/command_runner.dart';
import 'package:eval_explorer_server/src/business/fixtures/fixtures.dart';
import 'package:eval_explorer_server/src/generated/endpoints.dart';
import 'package:eval_explorer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// This file should not be invoked directly. Instead, register commands in
/// the serverpod section of pubspec.yaml and run those via
/// `serverpod run <command>`.
///
/// Of course, you *can* invoke this file via the same command registered in
/// the serverpod section of pubspec.yaml, but it is not recommended.
void main(List<String> args) async {
  final runner = CommandRunner('evals', 'Serverpod server')
    // $ serverpod run fixtures
    // OR
    // $ dart bin/command.dart fixtures --path lib/datasets
    ..addCommand(FixturesCommand());

  await runner.run(args);
}

class FixturesCommand extends Command {
  FixturesCommand() {
    argParser.addOption(
      'path',
      abbr: 'p',
      help: 'Path to the datasets directory',
    );
    argParser.addFlag(
      'verbose',
      abbr: 'v',
      help: 'Verbose output',
    );
  }

  @override
  String get name => 'fixtures';

  @override
  String get description => 'Imports fixtures from the given directory';

  @override
  FutureOr<void> run() async {
    final path = argResults!.option('path');

    if (path == null || path.isEmpty) {
      throw UsageException(
        'Path to the datasets directory is required',
        '--path <path>',
      );
    }

    final pod = Serverpod(
      [],
      Protocol(),
      Endpoints(),
    );

    await pod.start();

    FixturesParser parser = FixturesParser(
      datasetsPath: path,
    );

    final datasets = await parser.parse();

    final session = await pod.server.serverpod.createSession();
    final importer = DatabaseFixturesImporter(session: session);
    await importer.import(datasets, verbose: argResults!.flag('verbose'));
    await session.close();

    await pod.shutdown();
  }
}
