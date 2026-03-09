/// Command to publish InspectAI log files to Google Cloud Storage.
library;

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:devals/src/config/expand_home_dir.dart';
import 'package:howdy/howdy.dart';
import 'package:path/path.dart' as p;

import '../cli_exception.dart';
import '../config/env.dart';
import '../gcs/gcs_client.dart';
import '../gcs/log_validator.dart';

/// Publishes InspectAI JSON log files to a GCS bucket.
///
/// Usage:
///   devals publish {path}           Upload a file or directory of logs
///   devals publish --dry-run {path} Preview what would be uploaded
///
/// The target bucket and credentials are configured via `.env` file,
/// environment variables, or CLI flags. Precedence: flag > env var > .env.
class PublishCommand extends Command<int> {
  PublishCommand() {
    argParser
      ..addFlag(
        'dry-run',
        help: 'Preview what would be uploaded without uploading.',
        negatable: false,
      )
      ..addOption(
        'bucket',
        abbr: 'b',
        help: 'GCS bucket name (or set GCS_BUCKET in .env).',
      )
      ..addOption(
        'project',
        abbr: 'p',
        help: 'GCP project ID (or set GCP_PROJECT_ID in .env).',
      )
      ..addOption(
        'credentials',
        abbr: 'c',
        help:
            'Path to service account JSON key file '
            '(default: from .env or GOOGLE_APPLICATION_CREDENTIALS).',
      )
      ..addOption(
        'prefix',
        help:
            'GCS object prefix (default: directory name for dirs, empty for files).',
      );
  }

  @override
  String get name => 'publish';

  @override
  String get description =>
      'Publish InspectAI log files to Google Cloud Storage.';

  @override
  String get invocation => '${runner?.executableName} publish <path>';

  @override
  Future<int> run() async {
    if (argResults?.rest.isEmpty ?? true) {
      Text.error(
        'Missing required argument: <path>\n'
        'Usage: devals publish <path>\n'
        'Example: devals publish logs/2026-01-07_17-11-47/\n',
      );
      return 1;
    }

    final targetPath = argResults!.rest.first;
    final dryRun = argResults!['dry-run'] as bool;

    // Discover log files
    final discoveredFiles = _discoverLogFiles(targetPath);
    if (discoveredFiles.isEmpty) {
      Text.error('No .json log files found at: $targetPath\n');
      return 1;
    }

    // Validate that each file looks like an Inspect AI log.
    final files = <File>[];
    for (final file in discoveredFiles) {
      final result = await validateInspectLog(file);
      if (result.isValid) {
        files.add(file);
      } else {
        Text.warning(
          '⚠️  Skipping ${p.basename(file.path)} — ${result.reason}\n',
        );
      }
    }

    if (files.isEmpty) {
      Text.error(
        'No valid Inspect AI log files found at: $targetPath\n'
        'All discovered .json files failed validation.\n',
      );
      return 1;
    }

    // Load environment config
    final env = loadEnv();

    String bucket;
    try {
      bucket = resolveEnvValue(
        flagValue: argResults!['bucket'] as String?,
        envKey: EnvKeys.gcsBucket,
        env: env,
      );
    } on StateError {
      Text.error(
        'No GCS bucket configured.\n'
        'Set GCS_BUCKET in your .env file or pass --bucket <name>.\n\n'
        'See .env.example for a template.\n',
      );
      return 1;
    }

    // Determine GCS prefix
    final prefix = _resolvePrefix(
      flagPrefix: argResults!['prefix'] as String?,
      targetPath: targetPath,
    );

    final prefixDisplay = prefix.isNotEmpty ? '$prefix/' : '';

    Text.body(
      '🚀 Publishing ${files.length} log file(s) to '
      'gs://$bucket/$prefixDisplay...\n',
    );

    if (dryRun) {
      Text.body('DRY RUN — no files will be uploaded.\n');
      for (final file in files) {
        final objectName = _objectName(prefix, file);
        Text.body('  • $objectName');
      }
      terminal.writeln('');
      Text.success('${files.length} file(s) would be published.\n');
      return 0;
    }

    // Resolve credentials for real upload
    String projectId;
    try {
      projectId = resolveEnvValue(
        flagValue: argResults!['project'] as String?,
        envKey: EnvKeys.gcpProjectId,
        env: env,
      );
    } on StateError {
      Text.error(
        'No GCP project ID configured.\n'
        'Set GCP_PROJECT_ID in your .env file or pass --project <id>.\n\n'
        'See .env.example for a template.\n',
      );
      return 1;
    }

    String credentialsPath;
    try {
      credentialsPath = resolveEnvValue(
        flagValue: argResults!['credentials'] as String?,
        envKey: EnvKeys.googleApplicationCredentials,
        env: env,
      );
    } on StateError {
      Text.error(
        'No credentials configured.\n'
        'Set GOOGLE_APPLICATION_CREDENTIALS in your .env file or environment,\n'
        'or pass --credentials <path-to-key.json>.\n\n'
        'See .env.example for a template.\n',
      );
      return 1;
    }

    credentialsPath = expandHomeDir(credentialsPath);

    // Create GCS client and upload
    GcsClient? client;
    try {
      client = await GcsClient.create(
        projectId: projectId,
        credentialsPath: credentialsPath,
      );

      var successCount = 0;
      var failCount = 0;

      for (final file in files) {
        final objectName = _objectName(prefix, file);
        try {
          await client.uploadFile(bucket, objectName, file);
          Text.success('  $objectName');
          successCount++;
        } catch (e) {
          Text.error('  $objectName — $e\n');
          failCount++;
        }
      }

      terminal.writeln('');
      if (failCount == 0) {
        Text.success('Published $successCount file(s).\n');
      } else {
        Text.warning('Published $successCount file(s), $failCount failed.\n');
      }

      return failCount > 0 ? 1 : 0;
    } on FileSystemException catch (e) {
      throw CliException(
        'Credentials error: ${e.message}\n'
        'Path: ${e.path ?? credentialsPath}\n',
      );
    } catch (e) {
      throw CliException('Upload failed: $e\n');
    } finally {
      client?.close();
    }
  }

  /// Discovers JSON log files from a path (file or directory).
  List<File> _discoverLogFiles(String path) {
    final entity = FileSystemEntity.typeSync(path);

    if (entity == FileSystemEntityType.file) {
      if (path.endsWith('.json')) {
        return [File(path)];
      }
      return [];
    }

    if (entity == FileSystemEntityType.directory) {
      return Directory(path)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .where((f) => !p.basename(f.path).startsWith('runner'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
    }

    return [];
  }

  /// Resolves the GCS object prefix.
  ///
  /// If an explicit prefix is given, use that.
  /// If the target is a directory, use its name as a prefix.
  /// If the target is a single file, no prefix.
  String _resolvePrefix({String? flagPrefix, required String targetPath}) {
    if (flagPrefix != null) return flagPrefix;

    final entity = FileSystemEntity.typeSync(targetPath);
    if (entity == FileSystemEntityType.directory) {
      return p.basename(p.normalize(targetPath));
    }
    return '';
  }

  /// Computes the GCS object name for a file.
  String _objectName(String prefix, File file) {
    final fileName = p.basename(file.path);
    if (prefix.isEmpty) return fileName;
    return '$prefix/$fileName';
  }
}
