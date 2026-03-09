/// Loads environment configuration from `.env` files.
///
/// Searches for `.env` at the project root (walking up from cwd to find
/// a directory containing a `pubspec.yaml` with `workspace:`, or
/// any `.env` file along the way).
library;

import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:path/path.dart' as p;

/// Well-known environment variable keys used by the CLI.
abstract final class EnvKeys {
  static const gcsBucket = 'GCS_BUCKET';
  static const gcpProjectId = 'GCP_PROJECT_ID';
  static const googleApplicationCredentials = 'GOOGLE_APPLICATION_CREDENTIALS';
  static const geminiApiKey = 'GEMINI_API_KEY';
  static const anthropicApiKey = 'ANTHROPIC_API_KEY';
  static const openaiApiKey = 'OPENAI_API_KEY';

  /// All keys that `loadEnv` will look for.
  static const all = [
    gcsBucket,
    gcpProjectId,
    googleApplicationCredentials,
    geminiApiKey,
    anthropicApiKey,
    openaiApiKey,
  ];
}

/// Loads environment configuration, merging `.env` file values with
/// system environment variables. System env vars take precedence.
///
/// Returns a map of resolved environment key-value pairs.
Map<String, String> loadEnv() {
  final envFile = _findEnvFile();
  final env = <String, String>{};

  // Load from .env file if found
  dotenv.DotEnv? dotEnv;
  if (envFile != null) {
    dotEnv = dotenv.DotEnv(includePlatformEnvironment: false)..load([envFile]);
  }

  // For each known key, check .env first, then system env overrides
  for (final key in EnvKeys.all) {
    // .env file value (using public [] operator)
    if (dotEnv != null && dotEnv.isDefined(key)) {
      final value = dotEnv[key];
      if (value != null && value.isNotEmpty) {
        env[key] = value;
      }
    }

    // System environment variables override .env file values
    final systemValue = Platform.environment[key];
    if (systemValue != null && systemValue.isNotEmpty) {
      env[key] = systemValue;
    }
  }

  return env;
}

/// Resolves a value with the following precedence:
/// 1. Explicit CLI flag value
/// 2. Environment variable (from .env or system)
/// 3. Default value (if provided)
///
/// Throws [StateError] if no value is found and no default is given.
String resolveEnvValue({
  String? flagValue,
  required String envKey,
  required Map<String, String> env,
  String? defaultValue,
}) {
  if (flagValue != null && flagValue.isNotEmpty) return flagValue;
  final envValue = env[envKey];
  if (envValue != null && envValue.isNotEmpty) return envValue;
  if (defaultValue != null) return defaultValue;
  throw StateError(
    'Missing required configuration: $envKey. '
    'Set it in .env, as an environment variable, or pass it as a CLI flag.',
  );
}

/// Walks up from the current directory to find a `.env` file
/// at or below the repo root.
String? _findEnvFile() {
  var dir = Directory.current.absolute;
  // Walk up at most 10 levels
  for (var i = 0; i < 10; i++) {
    final envPath = p.join(dir.path, '.env');
    if (File(envPath).existsSync()) {
      return envPath;
    }
    // Check if this looks like the repo root
    final pubspecPath = p.join(dir.path, 'pubspec.yaml');
    if (File(pubspecPath).existsSync()) {
      final contents = File(pubspecPath).readAsStringSync();
      if (contents.contains('workspace:')) {
        // This is the repo root — no .env file here
        return null;
      }
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break; // reached filesystem root
    dir = parent;
  }
  return null;
}
