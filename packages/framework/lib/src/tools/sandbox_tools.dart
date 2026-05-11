import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';

import '../logging/eval_log.dart';
import 'sandbox_tools_models.dart';

/// Factory for creating [ai.Tool]s that execute against a [SandboxEnvironment].
///
/// These tools give the model direct access to the sandbox — it can run
/// shell commands, read files, and write files without needing structured
/// output schemas or post-processing steps.
///
/// Pass the returned tools as [additionalTools] in [Agent.run], so each
/// eval cell gets tools bound to its own fresh sandbox session:
///
/// ```dart
/// final result = await state.agent.run(
///   task: input,
///   additionalTools: SandboxTools.all(state.context.sandbox!),
/// );
/// ```
abstract final class SandboxTools {
  /// Maximum characters to return from tool output before truncation.
  static const int _maxOutputChars = 50000;

  /// Returns all sandbox tools: [bash], [readFile], and [writeFile].
  static List<ai.Tool> all(SandboxEnvironment sandbox) => [
    bash(sandbox),
    readFile(sandbox),
    writeFile(sandbox),
  ];

  /// A tool that executes a bash command inside the sandbox.
  static ai.Tool bash(SandboxEnvironment sandbox) => ai.Tool(
    name: 'bash',
    description:
        'Execute a bash command in the sandbox. '
        'Returns the exit code, stdout, and stderr. '
        'Use for running commands, exploring the filesystem, '
        'editing files, running tests, etc.',
    inputSchema: _schemaFor(BashInput.$schema),
    run: (input) async {
      final parsed = BashInput.fromJson(input);
      final result = await sandbox.exec(
        ['bash', '-c', parsed.command],
        cwd: parsed.workingDir,
        timeout: Duration(seconds: parsed.timeout ?? 60),
      );

      EvalLog.sandboxExec(
        ['bash', '-c', parsed.command],
        result,
      );

      final output = StringBuffer()
        ..writeln('exit_code: ${result.exitCode}')
        ..writeln('stdout:')
        ..writeln(result.stdout)
        ..writeln('stderr:')
        ..write(result.stderr);

      return _truncate(output.toString());
    },
  );

  /// A tool that reads a file from the sandbox as UTF-8 text.
  static ai.Tool readFile(SandboxEnvironment sandbox) => ai.Tool(
    name: 'read_file',
    description:
        'Read a file from the sandbox as UTF-8 text. '
        'Returns the file content. Provide the absolute path.',
    inputSchema: _schemaFor(ReadFileInput.$schema),
    run: (input) async {
      final parsed = ReadFileInput.fromJson(input);
      final content = await sandbox.readFile(parsed.path);
      return _truncate(content);
    },
  );

  /// A tool that writes content to a file in the sandbox.
  static ai.Tool writeFile(SandboxEnvironment sandbox) => ai.Tool(
    name: 'write_file',
    description:
        'Write content to a file in the sandbox. '
        'Creates parent directories automatically. '
        'Provide the absolute path and the complete file content.',
    inputSchema: _schemaFor(WriteFileInput.$schema),
    run: (input) async {
      final parsed = WriteFileInput.fromJson(input);
      await sandbox.writeFile(parsed.path, parsed.content);
      return 'File written successfully: ${parsed.path}';
    },
  );

  /// Truncates [text] to [_maxOutputChars] with a warning suffix.
  static String _truncate(String text) {
    if (text.length <= _maxOutputChars) return text;
    return '${text.substring(0, _maxOutputChars)}\n'
        '... [OUTPUT TRUNCATED — ${text.length - _maxOutputChars} '
        'characters omitted]';
  }

  /// Extracts a JSON Schema map from a SchemanticType, or returns empty.
  static Map<String, dynamic> _schemaFor(dynamic schema) {
    try {
      final meta = (schema as dynamic).schemaMetadata;
      if (meta != null) {
        return Map<String, dynamic>.from(meta.definition as Map);
      }
    } catch (_) {}
    return {};
  }
}
