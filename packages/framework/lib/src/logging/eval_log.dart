import 'dart:convert';
import 'dart:io';

import 'package:ai/ai.dart' as ai;
import 'package:devals_sandbox/sandbox.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:evals_results/evals_results.dart';

import 'ansi.dart';

// ---------------------------------------------------------------------------
// EvalLog — structured, real-time eval logging
// ---------------------------------------------------------------------------

/// Provides structured, real-time logging for eval runs.
///
/// Output is written to a configurable [IOSink] (default: [stdout]) and
/// simultaneously to a plaintext log file (ANSI codes stripped).
///
/// All methods are static and gate output on the globally configured
/// [LogLevel]. Initialise once at the start of a run with [init].
///
/// ```dart
/// EvalLog.init(LogLevel.normal, logDir: 'eval_logs/2026-04-28_run');
/// EvalLog.header('run-42', models: ['flash'], evals: ['my_eval']);
/// // ... run evals ...
/// EvalLog.footer(evalSetResult);
/// ```
class EvalLog {
  EvalLog._();

  static Level _level = Level.FINER;
  static DateTime _runStart = DateTime.now();
  static IOSink _sink = stdout;
  static IOSink? _logFile;

  // -------------------------------------------------------------------------
  // Initialisation & teardown
  // -------------------------------------------------------------------------

  /// Initialise the logging system.
  ///
  /// Must be called once before any other `EvalLog` method. Sets the
  /// output [level], configures `package:logging`, and optionally opens a
  /// parallel log file in [logDir].
  ///
  /// [sink] defaults to [stdout] and can be overridden for testing.
  static void init(
    Level level, {
    IOSink? sink,
    String? logDir,
  }) {
    _level = level;
    _runStart = DateTime.now();
    _sink = sink ?? stdout;

    // Open parallel log file. Logs to terminal and file.
    if (logDir != null) {
      final logFile = File(p.join(logDir, 'run.log'));
      logFile.parent.createSync(recursive: true);
      _logFile = logFile.openWrite();
    }

    Logger.root.onRecord.listen((record) {
      final elapsed = record.time.difference(_runStart);
      final prefix = _logLevelPrefix(record.level);
      _writeLine(
        '$prefix $dim+${_fmtDuration(elapsed)} '
        '[${record.loggerName}]$reset ${record.message}',
        minLevel: Level.INFO,
      );
    });
  }

  /// Flush and close the log file (if open). Call after the run completes.
  static Future<void> close() async {
    await _logFile?.flush();
    await _logFile?.close();
    _logFile = null;
  }

  // -------------------------------------------------------------------------
  // Run-level messages
  // -------------------------------------------------------------------------

  /// Print the run header banner.
  static void header(
    String runId, {
    List<String> models = const [],
    List<String> evals = const [],
    List<String> scenarios = const [],
  }) {
    final totalCells = models.length * scenarios.length * evals.length;
    final sep = '═' * 72;
    _writeLine('', minLevel: Level.INFO);
    _writeLine('$bold$cyan$sep$reset', minLevel: Level.INFO);
    _writeLine(
      '$bold$cyan  dart-evals$reset  run=$runId',
      minLevel: Level.INFO,
    );
    _writeLine(
      '  Models    : ${models.join(', ')}',
      minLevel: Level.INFO,
    );
    _writeLine(
      '  Evals     : ${evals.join(', ')}',
      minLevel: Level.INFO,
    );
    _writeLine(
      '  Scenarios : ${scenarios.join(', ')}',
      minLevel: Level.INFO,
    );
    _writeLine(
      '  Matrix    : $totalCells cells '
      '(${models.length}m × ${scenarios.length}s × ${evals.length}e)',
      minLevel: Level.INFO,
    );
    _writeLine('$bold$cyan$sep$reset', minLevel: Level.INFO);
    _writeLine('', minLevel: Level.INFO);
  }

  /// Print the run footer with summary statistics.
  static void footer(EvalSetResult result, {String? outputDir}) {
    final sep = '═' * 72;
    _writeLine('', minLevel: Level.INFO);
    _writeLine('$bold$cyan$sep$reset', minLevel: Level.INFO);
    _writeLine(
      '$bold$green  ✓ Run complete$reset  '
      '${result.totalResults} results in ${result.duration.inSeconds}s',
      minLevel: Level.INFO,
    );

    // Evaluator summaries.
    if (result.summaries.isNotEmpty) {
      _writeLine('', minLevel: Level.INFO);
      _writeLine(
        '  $bold${_underline}Evaluator Summaries$reset',
        minLevel: Level.INFO,
      );
      for (final summary in result.summaries) {
        final mean = summary.metrics
            .where((m) => m.name == 'mean')
            .firstOrNull
            ?.value;
        final pass = summary.metrics
            .where((m) => m.name == 'pass_count')
            .firstOrNull
            ?.value
            .toInt();
        final total = summary.metrics
            .where((m) => m.name == 'total_count')
            .firstOrNull
            ?.value
            .toInt();
        final passInfo = (pass != null && total != null)
            ? '  ($pass/$total passed)'
            : '';
        _writeLine(
          '    ${summary.name.padRight(30)} '
          'mean=${mean?.toStringAsFixed(2) ?? 'n/a'}  '
          '(${summary.scored} scored)$passInfo',
          minLevel: Level.INFO,
        );
      }
    }

    // Individual results.
    if (result.results.isNotEmpty) {
      _writeLine('', minLevel: Level.INFO);
      _writeLine(
        '  $bold${_underline}Individual Results$reset',
        minLevel: Level.INFO,
      );
      for (final r in result.results) {
        final scoreStr = r.scores.entries
            .map(
              (e) =>
                  '${e.key.split('.').last}=${e.value.value.toStringAsFixed(2)}',
            )
            .join('  ');
        final icon = r.scores.values.every((s) => s.value >= 1.0)
            ? '$green✓$reset'
            : r.scores.values.any((s) => s.value <= 0.0)
            ? '$red✗$reset'
            : '$yellow~$reset';
        _writeLine(
          '    $icon [$bold${r.model}$reset] ${r.evalName} / ${r.scenario}',
          minLevel: Level.INFO,
        );
        _writeLine(
          '      scores: $scoreStr',
          minLevel: Level.INFO,
        );
        for (final e in r.scores.entries) {
          if (e.value.explanation != null) {
            _writeLine(
              '      $dim${e.key.split('.').last}: '
              '${_truncate(e.value.explanation!, 100)}$reset',
              minLevel: Level.FINE,
            );
          }
        }
      }
    }

    // Output path.
    if (outputDir != null) {
      _writeLine('', minLevel: Level.INFO);
      _writeLine(
        '  ${dim}Output: $outputDir$reset',
        minLevel: Level.INFO,
      );
    }

    _writeLine('$bold$cyan$sep$reset', minLevel: Level.INFO);
    _writeLine('', minLevel: Level.INFO);
  }

  // -------------------------------------------------------------------------
  // Eval-level messages
  // -------------------------------------------------------------------------

  /// Log the start of an eval cell.
  static void evalStart(String evalName, String model, String scenario) {
    _writeLine(
      '$bold$blue▶$reset '
      '[$bold$model$reset] $evalName / $scenario',
      minLevel: Level.INFO,
    );
  }

  /// Log the completion of an eval cell with its scores.
  static void evalComplete(EvalResult result) {
    final duration = result.duration.inSeconds;
    final scoreStr = result.scores.entries
        .map(
          (e) => '${e.key.split('.').last}=${e.value.value.toStringAsFixed(2)}',
        )
        .join('  ');

    final icon = result.scores.values.every((s) => s.value >= 1.0)
        ? '$green✓$reset'
        : result.scores.values.any((s) => s.value <= 0.0)
        ? '$red✗$reset'
        : '$yellow~$reset';

    _writeLine(
      '  $icon ${result.evalName}  ${duration}s  $scoreStr',
      minLevel: Level.INFO,
    );
  }

  /// Log a lifecycle phase transition (setUp, run, score, cleanUp).
  static void evalPhase(String phase) {
    _writeLine(
      '    $dim↳ $phase$reset',
      minLevel: Level.FINE,
    );
  }

  // -------------------------------------------------------------------------
  // Progress
  // -------------------------------------------------------------------------

  /// Print overall matrix progress.
  static void setProgress(int completed, int total) {
    if (total <= 0) return;
    final pct = (completed / total * 100).round();
    final barLen = 20;
    final filled = (completed / total * barLen).round();
    final bar = '█' * filled + '░' * (barLen - filled);
    _writeLine(
      '  $dim[$completed/$total] $bar $pct%$reset',
      minLevel: Level.INFO,
    );
  }

  // -------------------------------------------------------------------------
  // Sandbox output
  // -------------------------------------------------------------------------

  /// Log a sandbox command and its result.
  ///
  /// At [Level.FINE], prints the command and truncated output.
  /// At [Level.ALL], prints full stdout/stderr.
  static void sandboxExec(List<String> cmd, ExecResult result) {
    final cmdStr = cmd.join(' ');
    final exitIcon = result.success ? '$green✓$reset' : '$red✗$reset';
    final durationStr = result.duration != null
        ? ' ${result.duration!.inMilliseconds}ms'
        : '';

    _writeLine(
      '    $dim⚡ $cmdStr → '
      'exit=${result.exitCode}$durationStr$reset $exitIcon',
      minLevel: Level.FINE,
    );

    // In debug mode, print full stdout/stderr.
    if (_level == Level.ALL) {
      if (result.stdout.trim().isNotEmpty) {
        _writeLine(
          '      ${dim}stdout:$reset',
          minLevel: Level.ALL,
        );
        for (final line in result.stdout.trim().split('\n')) {
          _writeLine(
            '        $dim$line$reset',
            minLevel: Level.ALL,
          );
        }
      }
      if (result.stderr.trim().isNotEmpty) {
        _writeLine(
          '      ${yellow}stderr:$reset',
          minLevel: Level.ALL,
        );
        for (final line in result.stderr.trim().split('\n')) {
          _writeLine(
            '        $yellow$line$reset',
            minLevel: Level.ALL,
          );
        }
      }
    } else if (_level == Level.FINE) {
      // Truncated output at verbose level.
      if (result.stdout.trim().isNotEmpty) {
        final truncated = _truncate(result.stdout.trim(), 200);
        _writeLine(
          '      $dim$truncated$reset',
          minLevel: Level.FINE,
        );
      }
      if (!result.success && result.stderr.trim().isNotEmpty) {
        final truncated = _truncate(result.stderr.trim(), 200);
        _writeLine(
          '      $yellow$truncated$reset',
          minLevel: Level.FINE,
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // Agent loop
  // -------------------------------------------------------------------------

  /// Log an agent step in the generate→execute loop.
  static void agentStep(
    int step,
    int maxSteps, {
    List<String>? toolCalls,
    int? tokenUsage,
  }) {
    final tools = toolCalls != null ? toolCalls.join(', ') : '…';
    final tokens = tokenUsage != null ? '  tokens=$tokenUsage' : '';
    _writeLine(
      '    ${dim}step $step/$maxSteps$reset  '
      'tools=[$tools]$tokens',
      minLevel: Level.INFO,
    );
  }

  /// Log a conversation message (condensed for terminal readability).
  ///
  /// At [LogLevel.normal], prints role + truncated content.
  /// Uses pattern matching on [ai.Part] subtypes to format each part.
  static void agentMessage(ai.Message message) {
    final role = message.role.name;

    final content = message.content
        .map(
          (part) => switch (part) {
            ai.TextPart(:final text) => _truncate(text, 120),
            ai.ToolRequestPart(:final name, :final input) =>
              '→ $name(${_truncate(_encodeInput(input), 80)})',
            ai.ToolResponsePart(:final name, :final output) =>
              '← $name: ${_truncate((output ?? '?').toString(), 80)}',
            _ => part.runtimeType.toString(),
          },
        )
        .join(' | ');

    _writeLine(
      '    $dim[$role]$reset $content',
      minLevel: Level.INFO,
    );
  }

  // -------------------------------------------------------------------------
  // Errors
  // -------------------------------------------------------------------------

  /// Log a cache hit or miss for a single model call.
  ///
  /// HITs are highlighted to make it obvious that no API call was made.
  /// Shown at [LogLevel.normal] so operators can see cache behaviour
  /// alongside agent step output.
  static void cacheEvent({required bool hit, required String key}) {
    final shortKey = key.length > 12 ? key.substring(0, 12) : key;
    if (hit) {
      _writeLine(
        '    $cyan⚡ cached$reset  ${dim}tokens=0  key=$shortKey$reset',
        minLevel: Level.INFO,
      );
    } else {
      _writeLine(
        '    $dim⏳ cache miss  key=$shortKey$reset',
        minLevel: Level.INFO,
      );
    }
  }

  /// Log a debug-level message (visible only at [Level.ALL]).
  static void debug(String message) {
    _writeLine('$dim$message$reset', minLevel: Level.ALL);
  }

  static void error(String message, [Object? err, StackTrace? stackTrace]) {
    _writeLine(
      '$bold$red✗ ERROR:$reset $red$message$reset',
      minLevel: Level.OFF,
    );
    if (err != null) {
      _writeLine('  $red$err$reset', minLevel: Level.OFF);
    }
    if (stackTrace != null && _level == Level.ALL) {
      _writeLine('  $dim$stackTrace$reset', minLevel: Level.ALL);
    }
  }

  // -------------------------------------------------------------------------
  // Internal
  // -------------------------------------------------------------------------

  static const _underline = '\x1B[4m';

  /// Write a line to both the terminal sink and the log file.
  ///
  /// Skips output if the current [_level] is below [minLevel].
  static void _writeLine(String line, {required Level minLevel}) {
    if (_level.value > minLevel.value) return;
    _sink.writeln(line);
    _logFile?.writeln(stripAnsi(line));
  }

  /// Format a [Duration] as `M:SS` relative to run start.
  static String _fmtDuration(Duration d) {
    final mins = d.inMinutes;
    final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  /// Truncate [text] to [maxLen] characters.
  static String _truncate(String text, int maxLen) {
    if (text.length <= maxLen) return text;
    return '${text.substring(0, maxLen)}… [${text.length - maxLen} more]';
  }

  /// Map `package:logging` levels to coloured prefixes.
  static String _logLevelPrefix(Level level) {
    if (level >= Level.SEVERE) return '$bold$red[SEV]$reset';
    if (level >= Level.WARNING) return '$yellow[WRN]$reset';
    if (level >= Level.INFO) return '$blue[INF]$reset';
    if (level >= Level.FINE) return '$dim[FIN]$reset';
    return '$dim[DBG]$reset';
  }

  /// Safely encode tool request input as a JSON string.
  static String _encodeInput(Object? input) {
    if (input == null) return '';
    try {
      return jsonEncode(input);
    } catch (_) {
      return input.toString();
    }
  }
}
