/// Validates that a JSON file is an Inspect AI evaluation log.
///
/// Uses a streaming approach that reads only the first few KB of the file
/// to check the structural fingerprint (version, status, eval.task) without
/// ever loading the full file into memory. This is important because Inspect
/// logs can be tens of thousands of lines.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

/// The number of bytes to read from the head of a file for validation.
///
/// The Inspect log format places `version`, `status`, and `eval` (including
/// `eval.task`) as the first keys, well before the massive `samples` array.
/// 4 KB is more than enough to capture these fields.
const _headBytes = 4096;

/// Result of validating a file against the Inspect AI log format.
class LogValidationResult {
  /// Whether the file appears to be a valid Inspect AI log.
  final bool isValid;

  /// Human-readable reason for validation failure.
  /// `null` when [isValid] is `true`.
  final String? reason;

  const LogValidationResult.valid() : isValid = true, reason = null;

  const LogValidationResult.invalid(this.reason) : isValid = false;

  @override
  String toString() =>
      isValid ? 'LogValidationResult(valid)' : 'LogValidationResult($reason)';
}

/// Validates that [file] looks like an Inspect AI evaluation log.
///
/// Reads only the first [_headBytes] bytes of the file and checks:
/// 1. The content starts with `{` (is a JSON object).
/// 2. A `"version"` key exists with an integer value.
/// 3. A `"status"` key exists with a string value.
/// 4. An `"eval"` key exists containing a `"task"` string.
///
/// This is intentionally a shallow "envelope" check — it confirms the file
/// is an Inspect log without parsing the full (potentially huge) payload.
Future<LogValidationResult> validateInspectLog(File file) async {
  if (!file.path.endsWith('.json')) {
    return LogValidationResult.invalid('File does not have a .json extension');
  }

  final fileLength = await file.length();
  if (fileLength == 0) {
    return LogValidationResult.invalid('File is empty');
  }

  // Read only the first _headBytes bytes.
  final raf = await file.open(mode: FileMode.read);
  try {
    final bytesToRead = min(_headBytes, fileLength);
    final bytes = await raf.read(bytesToRead);
    final head = utf8.decode(bytes, allowMalformed: true);

    return _validateHead(head);
  } finally {
    await raf.close();
  }
}

/// Validates the head (first few KB) of a JSON string.
///
/// Exposed for testing so tests can pass raw strings without creating files.
LogValidationResult validateHead(String head) => _validateHead(head);

LogValidationResult _validateHead(String head) {
  final trimmed = head.trimLeft();
  if (!trimmed.startsWith('{')) {
    return LogValidationResult.invalid('Content is not a JSON object');
  }

  // Try to parse the head. Since we truncated the file, it won't be valid
  // JSON on its own. We parse top-level keys by scanning for known patterns.
  //
  // Strategy: extract key-value pairs from the head using a lightweight
  // approach that doesn't require the full JSON to be well-formed.

  // Check for "version" key with an integer value.
  final versionMatch = RegExp(r'"version"\s*:\s*(\d+)').firstMatch(trimmed);
  if (versionMatch == null) {
    return LogValidationResult.invalid(
      'Missing or invalid "version" field (expected an integer)',
    );
  }

  // Check for "status" key with a string value.
  final statusMatch = RegExp(r'"status"\s*:\s*"([^"]*)"').firstMatch(trimmed);
  if (statusMatch == null) {
    return LogValidationResult.invalid(
      'Missing or invalid "status" field (expected a string)',
    );
  }

  // Check for "eval" key containing a "task" field.
  // First confirm "eval" key exists and opens an object.
  final evalMatch = RegExp(r'"eval"\s*:\s*\{').firstMatch(trimmed);
  if (evalMatch == null) {
    return LogValidationResult.invalid(
      'Missing "eval" object',
    );
  }

  // Within the eval object region, look for "task" with a non-empty string.
  final afterEval = trimmed.substring(evalMatch.end);
  final taskMatch = RegExp(r'"task"\s*:\s*"([^"]+)"').firstMatch(afterEval);
  if (taskMatch == null) {
    return LogValidationResult.invalid(
      'Missing or empty "eval.task" field',
    );
  }

  return LogValidationResult.valid();
}
