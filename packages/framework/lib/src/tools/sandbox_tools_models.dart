import 'package:schemantic/schemantic.dart';

part 'sandbox_tools_models.g.dart';

/// Input schema for the `bash` sandbox tool.
///
/// The model sends a command string and optional working directory / timeout.
@Schema()
abstract class $BashInput {
  /// The bash command to execute.
  @StringField(description: 'The bash command to execute.')
  String get command;

  /// Optional working directory (absolute path inside the sandbox).
  @StringField(
    description:
        'Optional working directory (absolute path inside the sandbox).',
  )
  String? get workingDir;

  /// Optional timeout in seconds. Defaults to 60 if not specified.
  @IntegerField(
    description: 'Optional timeout in seconds. Defaults to 60.',
    minimum: 1,
    maximum: 300,
  )
  int? get timeout;
}

/// Input schema for the `read_file` sandbox tool.
@Schema()
abstract class $ReadFileInput {
  /// Absolute path to the file inside the sandbox.
  @StringField(description: 'Absolute path to the file inside the sandbox.')
  String get path;
}

/// Input schema for the `write_file` sandbox tool.
@Schema()
abstract class $WriteFileInput {
  /// Absolute path to the file inside the sandbox.
  @StringField(description: 'Absolute path to the file inside the sandbox.')
  String get path;

  /// The file content to write.
  @StringField(description: 'The complete file content to write.')
  String get content;
}
