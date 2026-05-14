import 'dart:io';

import 'package:devals_sandbox/sandbox.dart';
import 'package:path/path.dart' as p;

import '../logging/eval_log.dart';

/// Directories to skip when extracting code from a sandbox.
///
/// These are build artifacts, caches, and dependency directories that are
/// large and not meaningful to save alongside eval output.
const _skipDirs = {
  '.dart_tool',
  '.dart_tool_internal',
  'build',
  '.packages',
  '.pub-cache',
  '.gradle',
  '.idea',
};

/// Recursively copies a directory tree from [sandbox] at [sandboxPath]
/// to the local filesystem at [destDir].
///
/// Uses [SandboxEnvironment.listDirectory] and [SandboxEnvironment.readFile]
/// to walk the tree, so it works identically for Docker, Podman, and Local
/// sandbox backends.
///
/// Directories listed in [_skipDirs] are excluded to keep output small.
///
/// Example:
/// ```dart
/// await saveCodeFromSandbox(
///   sandbox,
///   sandboxPath: '/workspace/app',
///   destDir: 'eval_logs/2026-05-13__10-30-00_evals/flutter_bug_fix_flash_baseline',
/// );
/// ```
Future<void> saveCodeFromSandbox(
  SandboxEnvironment sandbox, {
  required String sandboxPath,
  required String destDir,
}) async {
  final destDirectory = Directory(destDir);
  await destDirectory.create(recursive: true);

  await _copyRecursive(sandbox, sandboxPath, destDirectory.path);

  EvalLog.codeSaved(destDir);
}

/// Recursively copies files from [currentSandboxPath] to [currentDestPath].
Future<void> _copyRecursive(
  SandboxEnvironment sandbox,
  String currentSandboxPath,
  String currentDestPath,
) async {
  List<String> entries;
  try {
    entries = await sandbox.listDirectory(currentSandboxPath);
  } catch (e) {
    // If we can't list, skip this directory.
    EvalLog.debug('[saveCode] Could not list $currentSandboxPath: $e');
    return;
  }

  for (final entry in entries) {
    if (_skipDirs.contains(entry)) continue;

    final sandboxEntryPath = '$currentSandboxPath/$entry';
    final localEntryPath = p.join(currentDestPath, entry);

    // Determine if the entry is a directory by attempting to list it.
    // If listing succeeds, it's a directory; otherwise, treat as a file.
    final isDir = await _isDirectory(sandbox, sandboxEntryPath);

    if (isDir) {
      await Directory(localEntryPath).create(recursive: true);
      await _copyRecursive(sandbox, sandboxEntryPath, localEntryPath);
    } else {
      await _copyFile(sandbox, sandboxEntryPath, localEntryPath);
    }
  }
}

/// Determines if [path] is a directory in the sandbox.
///
/// Uses `test -d` for an accurate check. The previous heuristic
/// (attempting `listDirectory`) incorrectly identified files as
/// directories because `ls -1 <file>` succeeds on regular files.
Future<bool> _isDirectory(
  SandboxEnvironment sandbox,
  String path,
) async {
  try {
    final result = await sandbox.exec(['test', '-d', path]);
    return result.success;
  } catch (_) {
    return false;
  }
}

/// Copies a single file from the sandbox to the local filesystem.
///
/// Uses [readFileBytes] to handle both text and binary files.
Future<void> _copyFile(
  SandboxEnvironment sandbox,
  String sandboxPath,
  String localPath,
) async {
  try {
    final bytes = await sandbox.readFileBytes(sandboxPath);
    final file = File(localPath);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
  } catch (e) {
    // Best-effort: log and skip files that can't be read.
    EvalLog.debug('[saveCode] Could not copy $sandboxPath: $e');
  }
}
