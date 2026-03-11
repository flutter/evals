import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:devals/src/utils/env.dart';
import 'package:devals/src/utils/expand_home_dir.dart';
import 'package:howdy/howdy.dart';

/// The result status of a single doctor check.
enum CheckStatus { ok, warning, error }

/// The result of a single prerequisite check.
class CheckResult {
  const CheckResult({
    required this.status,
    this.version,
    this.message,
    this.fix,
  });

  final CheckStatus status;
  final String? version;
  final String? message;
  final String? fix;
}

/// A single prerequisite check to run.
class DoctorCheck {
  const DoctorCheck({
    required this.name,
    required this.component,
    required this.check,
    this.isRequired = false,
  });

  final String name;
  final String component;
  final Future<CheckResult> Function() check;
  final bool isRequired;
}

/// Typedef for a function that runs a process, enabling test injection.
typedef ProcessRunner =
    Future<ProcessResult> Function(
      String executable,
      List<String> arguments,
    );

/// Command that checks whether prerequisites are installed.
///
/// Similar to `flutter doctor`, this verifies the tools needed
/// for the CLI, dash_evals, and eval_explorer.
class DoctorCommand extends Command<int> {
  DoctorCommand({ProcessRunner? processRunner})
    : _runProcess = processRunner ?? Process.run;

  final ProcessRunner _runProcess;

  @override
  String get name => 'doctor';

  @override
  String get description =>
      'Check that all prerequisites are installed for '
      'the CLI, dash_evals, and eval_explorer.';

  @override
  Future<int> run() async {
    terminal.scrollClear();
    terminal.writeln();

    final checks = buildChecks(processRunner: _runProcess);

    Text.body('devals doctor');
    Text.body('Checking prerequisites...\n');

    final results = <(DoctorCheck, CheckResult)>[];
    for (final check in checks) {
      final result = await check.check();
      results.add((check, result));
      _printResult(check, result);
    }

    terminal.writeln();

    // Collect issues.
    final issues = results.where((r) => r.$2.status != CheckStatus.ok).toList();

    if (issues.isEmpty) {
      Text.success('No issues found!\n');
      return 0;
    }

    Text.warning('Issues found:\n');
    for (final (check, result) in issues) {
      final (icon, style) = switch (result.status) {
        CheckStatus.error => (
          '${Icon.error} ',
          Theme.current.focused.errorMessage,
        ),
        CheckStatus.warning => (
          '${Icon.warning} ',
          Theme.current.focused.warningMessage,
        ),
        _ => ('', const TextStyle()),
      };
      terminal.writeln('  ${'$icon${check.name}'.style(style)}');
      if (result.message != null) {
        terminal.writeln('    ${result.message}');
      }
      if (result.fix != null) {
        terminal.writeln('    Fix: ${result.fix}');
      }
    }

    final hasErrors = issues.any((r) => r.$2.status == CheckStatus.error);
    return hasErrors ? 1 : 0;
  }

  void _printResult(DoctorCheck check, CheckResult result) {
    final (icon, style) = switch (result.status) {
      CheckStatus.ok => (Icon.check, Theme.current.focused.successMessage),
      CheckStatus.warning => (
        Icon.warning,
        Theme.current.focused.warningMessage,
      ),
      CheckStatus.error => (Icon.error, Theme.current.focused.errorMessage),
    };
    final versionSuffix = result.version != null ? ' (${result.version})' : '';
    final messageSuffix = result.message != null ? ' — ${result.message}' : '';
    terminal.writeln(
      '  ${'$icon ${check.name}$versionSuffix$messageSuffix'.style(style)}',
    );
  }
}

// ---------------------------------------------------------------------------
// Check definitions
// ---------------------------------------------------------------------------

/// Builds the list of all doctor checks.
///
/// [processRunner] is injectable for testing.
List<DoctorCheck> buildChecks({ProcessRunner? processRunner}) {
  final run = processRunner ?? Process.run;
  return [
    DoctorCheck(
      name: 'Dart SDK',
      component: 'CLI, eval_explorer',
      isRequired: true,
      check: () => _checkDart(run),
    ),
    DoctorCheck(
      name: 'Python',
      component: 'dash_evals',
      isRequired: true,
      check: () => _checkPython(run),
    ),
    DoctorCheck(
      name: 'dash_evals installed',
      component: 'dash_evals',
      isRequired: true,
      check: () => _checkDashEvals(run),
    ),
    DoctorCheck(
      name: 'Podman',
      component: 'dash_evals',
      check: () => _checkPodman(run),
    ),
    DoctorCheck(
      name: 'Flutter SDK',
      component: 'eval_explorer',
      isRequired: true,
      check: () => _checkFlutter(run),
    ),
    DoctorCheck(
      name: 'Serverpod CLI',
      component: 'eval_explorer',
      check: () => _checkServerpod(run),
    ),
    DoctorCheck(
      name: 'API keys',
      component: 'dash_evals',
      isRequired: true,
      check: () => _checkApiKeys(),
    ),
    DoctorCheck(
      name: 'Publish config',
      component: 'CLI (devals publish)',
      check: () => _checkPublishConfig(),
    ),
  ];
}

/// Runs a command and returns the stdout, or `null` if it fails.
Future<String?> _tryRun(
  ProcessRunner run,
  String executable,
  List<String> args,
) async {
  try {
    final result = await run(executable, args);
    if (result.exitCode == 0) {
      return (result.stdout as String).trim();
    }
    return null;
  } on ProcessException {
    return null;
  }
}

/// Extracts a version number pattern (e.g. "3.10.1") from [text].
String? _extractVersion(String text) {
  final match = RegExp(r'(\d+\.\d+[\.\d]*)').firstMatch(text);
  return match?.group(1);
}

// -- Individual check implementations ----------------------------------------

Future<CheckResult> _checkDart(ProcessRunner run) async {
  final output = await _tryRun(run, 'dart', ['--version']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'not found',
      fix: 'Install the Dart SDK: https://dart.dev/get-dart',
    );
  }
  return CheckResult(status: CheckStatus.ok, version: _extractVersion(output));
}

Future<CheckResult> _checkPython(ProcessRunner run) async {
  final output = await _tryRun(run, 'python3', ['--version']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'not found',
      fix: 'Install Python 3.13+: https://www.python.org/downloads/',
    );
  }
  final version = _extractVersion(output);
  if (version != null) {
    final parts = version.split('.');
    final major = int.tryParse(parts[0]) ?? 0;
    final minor = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
    if (major < 3 || (major == 3 && minor < 13)) {
      return CheckResult(
        status: CheckStatus.error,
        version: version,
        message: 'Python 3.13+ required, found $version',
        fix: 'Upgrade Python: https://www.python.org/downloads/',
      );
    }
  }
  return CheckResult(status: CheckStatus.ok, version: version);
}

Future<CheckResult> _checkDashEvals(ProcessRunner run) async {
  final output = await _tryRun(run, 'run-evals', ['--help']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'not found',
      fix: 'cd path/to/dash_evals && pip install -e .',
    );
  }
  return const CheckResult(status: CheckStatus.ok);
}

Future<CheckResult> _checkPodman(ProcessRunner run) async {
  final output = await _tryRun(run, 'podman', ['--version']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.warning,
      message: 'not found (optional, needed for sandbox tasks)',
      fix: 'Install Podman: https://podman.io/getting-started/installation',
    );
  }
  return CheckResult(status: CheckStatus.ok, version: _extractVersion(output));
}

Future<CheckResult> _checkFlutter(ProcessRunner run) async {
  final output = await _tryRun(run, 'flutter', ['--version']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'not found',
      fix: 'Install the Flutter SDK: https://flutter.dev/flow',
    );
  }
  return CheckResult(status: CheckStatus.ok, version: _extractVersion(output));
}

Future<CheckResult> _checkServerpod(ProcessRunner run) async {
  final output = await _tryRun(run, 'serverpod', ['version']);
  if (output == null) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'not found',
      fix: 'dart pub global activate serverpod_cli',
    );
  }
  return CheckResult(status: CheckStatus.ok, version: _extractVersion(output));
}

Future<CheckResult> _checkApiKeys() async {
  const keys = ['GEMINI_API_KEY', 'ANTHROPIC_API_KEY', 'OPENAI_API_KEY'];

  final env = loadEnv();

  final present = keys.where((k) => env.containsKey(k));
  final missing = keys.where((k) => !env.containsKey(k));

  if (present.isEmpty) {
    return const CheckResult(
      status: CheckStatus.error,
      message: 'no API keys found',
      fix:
          'Set at least one of: GEMINI_API_KEY, ANTHROPIC_API_KEY, OPENAI_API_KEY\n'
          '    Tip: add them to your .env file (see .env.example)',
    );
  }
  if (missing.isNotEmpty) {
    return CheckResult(
      status: CheckStatus.warning,
      message: '${present.join(', ')} set; ${missing.join(', ')} missing',
    );
  }
  return CheckResult(
    status: CheckStatus.ok,
    message: 'all keys set',
  );
}

Future<CheckResult> _checkPublishConfig() async {
  final env = loadEnv();

  final requiredKeys = [
    EnvKeys.gcsBucket,
    EnvKeys.gcpProjectId,
    EnvKeys.googleApplicationCredentials,
  ];

  final present = <String>[];
  final missing = <String>[];

  for (final key in requiredKeys) {
    final value = env[key];
    if (value != null && value.isNotEmpty) {
      present.add(key);
    } else {
      missing.add(key);
    }
  }

  if (present.isEmpty) {
    return const CheckResult(
      status: CheckStatus.warning,
      message: 'not configured',
      fix:
          'cp .env.example .env and fill in GCS_BUCKET, '
          'GCP_PROJECT_ID, GOOGLE_APPLICATION_CREDENTIALS',
    );
  }

  // Check that credentials file actually exists
  final credPath = env[EnvKeys.googleApplicationCredentials];
  if (credPath != null && credPath.isNotEmpty) {
    var resolvedPath = expandHomeDir(credPath);
    if (!File(resolvedPath).existsSync()) {
      return CheckResult(
        status: CheckStatus.error,
        message: 'credentials file not found: $credPath',
      );
    }
  }

  if (missing.isNotEmpty) {
    return CheckResult(
      status: CheckStatus.warning,
      message: '${present.join(', ')} set; ${missing.join(', ')} missing',
      fix: 'Set missing values in .env (see .env.example)',
    );
  }

  return const CheckResult(
    status: CheckStatus.ok,
    message: 'all configured',
  );
}
