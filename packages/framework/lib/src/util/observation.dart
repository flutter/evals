/// Formats a command execution result into a string for the model's context.
///
/// Combines exit code, stdout, and stderr into a structured text block.
/// Truncates the combined output to [maxChars] if needed to prevent
/// token budget exhaustion.
String formatObservation({
  required int exitCode,
  required String stdout,
  required String stderr,
  int maxChars = 50000,
}) {
  final buffer = StringBuffer()
    ..writeln('exit_code: $exitCode')
    ..writeln('stdout:')
    ..writeln(stdout);

  if (stderr.isNotEmpty) {
    buffer
      ..writeln('stderr:')
      ..write(stderr);
  }

  return truncateOutput(buffer.toString(), maxChars);
}

/// Truncates [text] to [maxChars] with a warning suffix.
///
/// Returns [text] unchanged if it's already within the limit.
String truncateOutput(String text, int maxChars) {
  if (text.length <= maxChars) return text;
  final omitted = text.length - maxChars;
  return '${text.substring(0, maxChars)}\n'
      '... [OUTPUT TRUNCATED — $omitted characters omitted]';
}
