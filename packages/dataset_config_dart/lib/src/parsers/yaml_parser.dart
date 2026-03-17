import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import '../models/models.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../parsed_task.dart';
import '../utils/yaml_utils.dart';
import 'parser.dart';

/// Default log directory (relative to dataset root).
const _kDefaultLogsDir = '../logs';

/// Parses YAML config files from the filesystem into domain objects.
///
/// Reads `tasks/*/task.yaml` files for task configs and job YAML files
/// for job configs.
class YamlParser extends Parser {
  // ------------------------------------------------------------------
  // Task parsing
  // ------------------------------------------------------------------

  @override
  List<ParsedTask> parseTasks(String datasetRoot) {
    final tasksDir = Directory(p.join(datasetRoot, 'tasks'));
    if (!tasksDir.existsSync()) return [];

    final taskConfigs = <ParsedTask>[];

    final taskDirs = tasksDir.listSync().whereType<Directory>().toList()
      ..sort((a, b) => a.path.compareTo(b.path));

    for (final taskDir in taskDirs) {
      final taskFile = File(p.join(taskDir.path, 'task.yaml'));
      if (taskFile.existsSync()) {
        taskConfigs.addAll(_loadTaskFile(taskFile.path, datasetRoot));
      }
    }

    return taskConfigs;
  }

  /// Load a single task.yaml file into a [ParsedTask].
  ///
  /// Returns a single-element list (variant expansion happens later).
  List<ParsedTask> _loadTaskFile(String taskPath, String datasetRoot) {
    final data = readYamlFileAsMap(taskPath);
    final taskDir = p.dirname(taskPath);

    final taskId = (data['id'] as String?) ?? p.basename(taskDir);
    final func = (data['func'] as String?) ?? taskId;

    final taskWorkspaceRaw = data['workspace'];
    final taskTestsRaw = data['tests'];
    final systemMessage = data['system_message'] as String?;

    // Pre-resolve task-level paths to absolute
    final taskWorkspace = _preResolveToAbs(taskWorkspaceRaw, taskDir);
    final taskTests = _preResolveToAbs(taskTestsRaw, taskDir);

    // Optional whitelist of variant names
    final allowedVariants = (data['allowed_variants'] as List?)?.cast<String>();

    // Parse samples section
    final samplesRaw = data['samples'];
    if (samplesRaw is! Map) {
      throw FormatException(
        "Task '$taskId': 'samples' must be a dict with 'inline' and/or "
        "'paths' keys, got ${samplesRaw.runtimeType}",
      );
    }
    final samplesMap = Map<String, dynamic>.from(samplesRaw);
    final samples = _loadSamplesSection(
      samplesMap,
      datasetRoot,
      taskWorkspace,
      taskTests,
      taskDir,
    );

    // Task-level Inspect AI args are nested under inspect_task_args
    final taskArgs = _asMap(data['inspect_task_args']) ?? <String, dynamic>{};
    final model = taskArgs['model'] as String?;
    final config = _asMap(taskArgs['config']);
    final modelRoles = _asStringMap(taskArgs['model_roles']);
    final sandbox = taskArgs['sandbox'];
    final approval = taskArgs['approval'];
    final epochs = taskArgs['epochs'];
    final failOnError = taskArgs['fail_on_error'];
    final continueOnFail = taskArgs['continue_on_fail'] as bool?;
    final messageLimit = taskArgs['message_limit'] as int?;
    final tokenLimit = taskArgs['token_limit'] as int?;
    final timeLimit = taskArgs['time_limit'] as int?;
    final workingLimit = taskArgs['working_limit'] as int?;
    final costLimit = (taskArgs['cost_limit'] as num?)?.toDouble();
    final earlyStopping = taskArgs['early_stopping'];
    final displayName = data['display_name'] as String?;
    final version = data['version'];
    final taskMetadata = _asMap(data['metadata']);
    final sandboxParameters = _asMap(data['sandbox_parameters']);

    // Parse variant_filters (tag-based variant restriction)
    final variantFiltersRaw = _asMap(data['variant_filters']);
    final variantFilters = variantFiltersRaw != null
        ? TagFilter.fromJson(variantFiltersRaw)
        : null;

    return [
      ParsedTask(
        id: taskId,
        func: func,
        variant: const Variant(), // placeholder baseline
        samples: samples,
        systemMessage: systemMessage,
        allowedVariants: allowedVariants,
        // Task-level settings
        model: model,
        config: config,
        modelRoles: modelRoles,
        sandbox: sandbox,
        approval: approval,
        epochs: epochs,
        failOnError: failOnError,
        continueOnFail: continueOnFail,
        messageLimit: messageLimit,
        tokenLimit: tokenLimit,
        timeLimit: timeLimit,
        workingLimit: workingLimit,
        costLimit: costLimit,
        earlyStopping: earlyStopping,
        displayName: displayName,
        version: version,
        metadata: taskMetadata,
        sandboxParameters: sandboxParameters,
        variantFilters: variantFilters,
      ),
    ];
  }

  // ------------------------------------------------------------------
  // Sample loading
  // ------------------------------------------------------------------

  /// Load samples from the `paths` and `inline` subsections.
  List<Sample> _loadSamplesSection(
    Map<String, dynamic> samplesMap,
    String datasetRoot,
    Object? taskWorkspace,
    Object? taskTests,
    String taskDir,
  ) {
    final pathPatterns =
        (samplesMap['paths'] as List?)?.cast<String>() ?? const [];
    final inlineDefs =
        (samplesMap['inline'] as List?)?.cast<Map<String, dynamic>>() ??
        const [];

    final samples = <Sample>[];

    // Load from path patterns (glob-expanded)
    for (final pattern in pathPatterns) {
      List<String> matchedFiles;
      if (_isGlob(pattern)) {
        matchedFiles = _expandGlobFiles(taskDir, pattern);
      } else {
        final candidate = p.normalize(p.join(taskDir, pattern));
        matchedFiles = File(candidate).existsSync() ? [candidate] : [];
      }

      if (matchedFiles.isEmpty) {
        throw FileSystemException(
          'No sample files matched pattern: $pattern',
        );
      }

      samples.addAll(
        _loadSamplesFromFiles(
          matchedFiles,
          datasetRoot,
          taskWorkspace,
          taskTests,
        ),
      );
    }

    // Load inline definitions
    for (final def in inlineDefs) {
      if (def.isEmpty) continue;
      samples.add(
        _resolveSample(def, taskDir, datasetRoot, taskWorkspace, taskTests),
      );
    }

    return samples;
  }

  /// Load samples from external YAML files.
  List<Sample> _loadSamplesFromFiles(
    List<String> sampleFiles,
    String datasetRoot,
    Object? taskWorkspace,
    Object? taskTests,
  ) {
    final samples = <Sample>[];

    for (final filePath in sampleFiles) {
      final fullPath = p.isAbsolute(filePath)
          ? filePath
          : p.join(datasetRoot, filePath);
      if (!File(fullPath).existsSync()) {
        throw FileSystemException('Sample file not found', fullPath);
      }

      final sampleDir = p.dirname(fullPath);
      final content = File(fullPath).readAsStringSync();

      // Support multi-document YAML (--- separated)
      final docs = content.split(RegExp(r'^---\s*$', multiLine: true));
      for (final doc in docs) {
        if (doc.trim().isEmpty) continue;
        final data = convertYamlToObject(loadYaml(doc)) as Map<String, dynamic>;
        samples.add(
          _resolveSample(
            data,
            sampleDir,
            datasetRoot,
            taskWorkspace,
            taskTests,
          ),
        );
      }
    }

    return samples;
  }

  // ------------------------------------------------------------------
  // Sample resolution
  // ------------------------------------------------------------------

  /// Resolve a single sample dict into a [Sample].
  ///
  /// Validates required fields and normalises tags (formerly done by
  /// `SampleConfig.fromYaml`).
  Sample _resolveSample(
    Map<String, dynamic> doc,
    String baseDir,
    String datasetRoot,
    Object? taskWorkspace,
    Object? taskTests,
  ) {
    // --- Validate required fields ---
    for (final field in ['id', 'input', 'target']) {
      if (!doc.containsKey(field)) {
        throw FormatException(
          "Sample '${doc['id'] ?? 'unknown'}' missing required field: $field",
        );
      }
    }

    // Read metadata fields from the metadata dict
    final metaRaw = Map<String, dynamic>.from(doc['metadata'] as Map? ?? {});

    final sampleWorkspace = metaRaw['workspace'];
    final sampleTests = metaRaw['tests'];

    // Sample-level overrides task-level
    final effectiveWorkspace = sampleWorkspace ?? taskWorkspace;

    String? workspace;
    String? workspaceGit;
    String? workspaceGitRef;

    if (effectiveWorkspace != null) {
      if (effectiveWorkspace is Map && effectiveWorkspace.containsKey('git')) {
        workspaceGit = effectiveWorkspace['git'] as String?;
        workspaceGitRef = effectiveWorkspace['ref'] as String?;
      } else {
        final resolveDir = sampleWorkspace != null ? baseDir : datasetRoot;
        workspace = _resolveResourcePath(effectiveWorkspace, resolveDir);
      }
    }

    String? tests;
    if (sampleTests != null) {
      tests = _resolveResourcePath(sampleTests, baseDir);
    } else if (taskTests != null) {
      tests = _resolveResourcePath(taskTests, datasetRoot);
    }

    // --- Normalize tags from metadata ---
    final rawTags = metaRaw['tags'];
    final List<String> tags;
    if (rawTags is String) {
      tags = rawTags.split(',').map((t) => t.trim()).toList();
    } else if (rawTags is List) {
      tags = rawTags.cast<String>();
    } else {
      tags = [];
    }

    // Build metadata with domain-specific fields
    final metadata = <String, dynamic>{
      ...metaRaw,
      'difficulty': metaRaw['difficulty'] as String? ?? 'medium',
      'tags': tags,
      'workspace': ?workspace,
      'tests': ?tests,
      'workspace_git': ?workspaceGit,
      'workspace_git_ref': ?workspaceGitRef,
    };

    // Parse sample-level fields
    final choices = (doc['choices'] as List?)?.cast<String>();
    final sampleSandbox = doc['sandbox'];
    final setup = doc['setup'] as String?;
    final files = _asStringMap(doc['files']);

    return Sample(
      id: doc['id'] as String,
      input: doc['input'] as String,
      target: doc['target'] as String,
      metadata: metadata,
      choices: choices,
      sandbox: sampleSandbox,
      files: files,
      setup: setup,
    );
  }

  // ------------------------------------------------------------------
  // Job parsing
  // ------------------------------------------------------------------

  @override
  Job parseJob(String jobPath, String datasetRoot) {
    if (!File(jobPath).existsSync()) {
      throw FileSystemException('Job file not found', jobPath);
    }

    final data = readYamlFileAsMap(jobPath);

    final logsDir = (data['logs_dir'] as String?) ?? _kDefaultLogsDir;
    final maxConnections = (data['max_connections'] as int?) ?? 10;

    // Resolve log directory with timestamp
    final logDir = _resolveLogDir(logsDir, datasetRoot);

    // Parse task filters
    List<String>? taskPaths;
    Map<String, JobTask>? tasks;
    final tasksRaw = data['tasks'] as Map<String, dynamic>?;
    if (tasksRaw != null) {
      taskPaths = (tasksRaw['paths'] as List?)?.cast<String>();
      final inlineTasks = tasksRaw['inline'] as Map<String, dynamic>?;
      if (inlineTasks != null) {
        tasks = {};
        for (final entry in inlineTasks.entries) {
          tasks[entry.key] = JobTask.fromYaml(
            entry.key,
            entry.value as Map<String, dynamic>?,
          );
        }
      }
    }

    // Parse variants
    Map<String, Map<String, dynamic>>? variants;
    final variantsRaw = data['variants'];
    if (variantsRaw is Map) {
      variants = {};
      for (final entry in variantsRaw.entries) {
        final key = entry.key.toString();
        final value = entry.value;
        if (value is Map) {
          variants[key] = Map<String, dynamic>.from(value);
        } else {
          variants[key] = <String, dynamic>{};
        }
      }
    }

    // Parse tag filters
    final taskFiltersRaw = data['task_filters'];
    final sampleFiltersRaw = data['sample_filters'];
    final TagFilter? taskFilters = taskFiltersRaw is Map
        ? TagFilter.fromJson(Map<String, dynamic>.from(taskFiltersRaw))
        : null;
    final TagFilter? sampleFilters = sampleFiltersRaw is Map
        ? TagFilter.fromJson(Map<String, dynamic>.from(sampleFiltersRaw))
        : null;

    return Job(
      logDir: logDir,
      maxConnections: maxConnections,
      description: data['description'] as String?,
      models: (data['models'] as List?)?.cast<String>(),
      variants: variants,
      taskPaths: taskPaths,
      tasks: tasks,
      taskFilters: taskFilters,
      sampleFilters: sampleFilters,
      saveExamples: data['save_examples'] == true,
      // Sandbox configuration
      sandbox: _parseSandbox(data['sandbox']),
      // All inspect eval arguments
      inspectEvalArguments: _asMap(data['inspect_eval_arguments']),
    );
  }

  /// Parse sandbox config from YAML value.
  ///
  /// Supports both string shorthand ('podman') and map form.
  static Map<String, dynamic>? _parseSandbox(Object? value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    } else if (value is String) {
      return {'environment': value};
    }
    return null;
  }

  /// Create a [Job] with default settings (when no job file is provided).
  Job createDefaultJob(String baseDir) {
    return Job(
      logDir: _resolveLogDir(_kDefaultLogsDir, baseDir),
    );
  }

  // ------------------------------------------------------------------
  // Type conversion helpers
  // ------------------------------------------------------------------

  /// Safely cast a YAML value to `Map<String, dynamic>?`.
  static Map<String, dynamic>? _asMap(Object? value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  /// Safely cast a YAML value to `Map<String, String>?`.
  static Map<String, String>? _asStringMap(Object? value) {
    if (value is Map) return Map<String, String>.from(value);
    return null;
  }


  // ------------------------------------------------------------------
  // Path resolution helpers
  // ------------------------------------------------------------------

  /// Pre-resolve a task-level resource to an absolute path.
  Object? _preResolveToAbs(Object? resource, String taskDir) {
    if (resource == null) return null;

    if (resource is String) {
      if (resource.startsWith('./') ||
          resource.startsWith('../') ||
          resource.startsWith('/')) {
        return {'path': p.normalize(p.join(taskDir, resource))};
      }
      return resource;
    }

    if (resource is Map) {
      if (resource.containsKey('path')) {
        final pathVal = resource['path'] as String;
        return {
          ...resource,
          'path': p.normalize(p.join(taskDir, pathVal)),
        };
      }
      return resource;
    }

    return resource;
  }

  /// Resolve a workspace/tests resource reference to an absolute path string.
  String? _resolveResourcePath(Object? resource, String baseDir) {
    if (resource == null) return null;

    if (resource is String) {
      if (resource.startsWith('./') ||
          resource.startsWith('../') ||
          resource.startsWith('/')) {
        return p.normalize(p.join(baseDir, resource));
      }
      return null;
    }

    if (resource is Map) {
      if (resource.containsKey('path')) {
        return p.normalize(p.join(baseDir, resource['path'] as String));
      }
    }

    return null;
  }

  // ------------------------------------------------------------------
  // Log dir helpers
  // ------------------------------------------------------------------

  /// Resolve log directory with a timestamp subfolder.
  String _resolveLogDir(String logsDir, String baseDir) {
    final now = DateTime.now().toUtc();
    final timestamp =
        '${now.year}-${_pad(now.month)}-${_pad(now.day)}'
        '_${_pad(now.hour)}-${_pad(now.minute)}-${_pad(now.second)}';
    return p.normalize(p.join(baseDir, logsDir, timestamp));
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');

  // ------------------------------------------------------------------
  // Glob helpers
  // ------------------------------------------------------------------

  static bool _isGlob(String pattern) =>
      pattern.contains('*') || pattern.contains('?') || pattern.contains('[');

  /// Expand a glob pattern relative to [baseDir], returning matching files.
  static List<String> _expandGlobFiles(String baseDir, String pattern) {
    final glob = Glob(pattern);
    return glob
        .listSync(root: baseDir)
        .whereType<File>()
        .where(
          (f) =>
              f.path.endsWith('.yaml') ||
              f.path.endsWith('.yml') ||
              f.path.endsWith('.md'),
        )
        .map((f) => p.normalize(f.path))
        .toList()
      ..sort();
  }
}

/// Find a job file by name or path.
///
/// Looks in `jobs/` directory first, then treats [job] as a relative/absolute
/// path.
///
/// Throws [FileSystemException] if the job file is not found.
String findJobFile(String datasetRoot, String job) {
  // Check if it's a path (contains / or ends with .yaml)
  if (job.contains('/') || job.endsWith('.yaml')) {
    final jobPath = p.isAbsolute(job) ? job : p.join(datasetRoot, job);
    if (!File(jobPath).existsSync()) {
      throw FileSystemException('Job file not found', jobPath);
    }
    return p.normalize(jobPath);
  }

  // Look in jobs/ directory
  final jobsDir = Directory(p.join(datasetRoot, 'jobs'));
  if (!jobsDir.existsSync()) {
    throw FileSystemException(
      'Jobs directory not found. '
      'Create it or specify a full path to the job file.',
      jobsDir.path,
    );
  }

  // Try with .yaml extension
  final withExt = File(p.join(jobsDir.path, '$job.yaml'));
  if (withExt.existsSync()) return p.normalize(withExt.path);

  // Try without extension (maybe they included it)
  final withoutExt = File(p.join(jobsDir.path, job));
  if (withoutExt.existsSync()) return p.normalize(withoutExt.path);

  // List available jobs for helpful error message
  final available = jobsDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.yaml'))
      .map((f) => p.basenameWithoutExtension(f.path))
      .toList();
  throw FileSystemException(
    "Job '$job' not found in ${jobsDir.path}. "
    'Available jobs: ${available.isEmpty ? '(none)' : available}',
  );
}
