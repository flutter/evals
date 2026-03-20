import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import '../models/models.dart';
import 'package:path/path.dart' as p;

import '../parsed_task.dart';



/// Default sandbox configurations for Flutter evaluations.
///
/// Consumers can pass these to [EvalSetResolver] or provide their own.
const Map<String, Map<String, String>> kDefaultSandboxRegistry = {
  'podman': {'name': 'podman', 'path': './sandboxes/podman/compose.yaml'},
  'podman-beta': {
    'name': 'podman',
    'path': './sandboxes/podman/compose-beta.yaml',
  },
  'podman-main': {
    'name': 'podman',
    'path': './sandboxes/podman/compose-main.yaml',
  },
};



/// Resolves parsed task configs and job into fully-resolved
/// [EvalSet] objects ready for JSON serialization.
///
/// This is the resolution engine. It:
/// 1. Resolves models, sandboxes, and variants
/// 2. Expands task × variant combinations into [Task] entries
/// 3. Propagates job-level and task-level settings to the output
class EvalSetResolver {
  /// Creates a resolver with optional sandbox configuration.
  ///
  /// If [sandboxRegistry] is not provided, it defaults to an empty map
  /// (no sandbox resolution). Pass [kDefaultSandboxRegistry] for the
  /// Flutter-specific sandbox setup.
  const EvalSetResolver({
    this.sandboxRegistry = const {},
  });

  /// Named sandbox configurations (e.g. `'podman'` → compose file path).
  final Map<String, Map<String, String>> sandboxRegistry;

  /// Resolve task configs and job into [EvalSet] objects.
  List<EvalSet> resolve(
    List<ParsedTask> datasetTasks,
    Job job,
    String datasetRoot,
  ) {
    if (job.models.isEmpty) {
      throw ArgumentError(
        'job.models is required and must contain at least one model. '
        'Specify models in your job YAML, e.g.:\n'
        '  models:\n    - google/gemini-2.5-flash',
      );
    }
    final models = job.models;
    final sandboxCfg = job.sandbox ?? <String, dynamic>{};
    final sandboxTypeStr = (sandboxCfg['environment'] as String?) ?? 'local';
    final expandedTasks = _expandTaskConfigs(
      datasetTasks,
      job,
      sandboxTypeStr,
      datasetRoot,
    );

    final sandbox = _resolveSandbox(datasetRoot, job);

    return [
      _buildEvalSet(
        taskConfigs: expandedTasks,
        logDir: job.logDir,
        models: models,
        sandbox: sandbox,
        job: job,
      ),
    ];
  }

  // ------------------------------------------------------------------
  // EvalSet building
  // ------------------------------------------------------------------

  /// Build an [EvalSet] from resolved [ParsedTask]s.
  ///
  /// This is where [ParsedTask]s (internal) get converted to
  /// [Task]s (output format).
  EvalSet _buildEvalSet({
    required List<ParsedTask> taskConfigs,
    required String logDir,
    required List<String> models,
    required Object sandbox,
    required Job job,
  }) {
    final inspectTasks = <Task>[];
    final sandboxCfg = job.sandbox ?? <String, dynamic>{};
    final sandboxTypeStr = (sandboxCfg['environment'] as String?) ?? 'local';

    // Parse task_defaults from inspect_eval_arguments
    final evalArgs = job.inspectEvalArguments ?? <String, dynamic>{};
    final taskDefaults = (evalArgs['task_defaults'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    for (final tc in taskConfigs) {
      // Enrich each sample with task-level metadata
      final inspectSamples = <Sample>[];
      for (final sample in tc.samples) {
        final enriched = <String, dynamic>{...?sample.metadata};

        if (tc.saveExamples) {
          enriched['save_examples'] = true;
          if (tc.examplesDir != null) {
            enriched['examples_dir'] = tc.examplesDir;
            enriched['task_variant'] = '${tc.id}:${tc.variant.name}';
          }
        }

        // Stack files: task-level + sample-level (sample wins on conflict)
        Map<String, String>? files;
        if (tc.taskFiles != null || sample.files != null) {
          files = {...?tc.taskFiles, ...?sample.files};
        }

        // Setup: sample overrides task
        final setup = sample.setup ?? tc.taskSetup;

        inspectSamples.add(
          Sample(
            id: sample.id,
            input: sample.input,
            target: sample.target,
            metadata: enriched,
            choices: sample.choices,
            sandbox: sample.sandbox,
            files: files,
            setup: setup,
          ),
        );
      }

      final dataset = Dataset(
        samples: inspectSamples,
        name: '${tc.id}:${tc.variant.name}',
        format: tc.datasetFormat,
        source: tc.datasetSource,
        args: tc.datasetArgs,
      );

      // Build task metadata (variant config, system message, etc.)
      final metadata = <String, dynamic>{
        'variant': tc.variant.name,
        if (tc.variant.files.isNotEmpty ||
            tc.variant.mcpServers.isNotEmpty ||
            tc.variant.skills.isNotEmpty ||
            tc.variant.taskParameters.isNotEmpty)
          'variant_config': {
            if (tc.variant.files.isNotEmpty)
              'files': tc.variant.files
                  .map(
                    (cf) => {
                      'title': cf.metadata.title,
                      'version': cf.metadata.version,
                      'content': cf.content,
                    },
                  )
                  .toList(),
            if (tc.variant.mcpServers.isNotEmpty)
              'mcp_servers': tc.variant.mcpServers,
            if (tc.variant.skills.isNotEmpty)
              'skills': tc.variant.skills,
            if (tc.variant.taskParameters.isNotEmpty)
              'task_parameters': tc.variant.taskParameters,
          },
        if (tc.systemMessage != null) 'system_message': tc.systemMessage,
        if (tc.saveExamples) 'save_examples': true,
        if (tc.examplesDir != null) 'examples_dir': tc.examplesDir,
        // Propagate image_prefix from sandbox for container image resolution
        if (sandboxCfg['image_prefix'] != null)
          'image_prefix': sandboxCfg['image_prefix'],
        // Merge any task-level metadata from YAML
        ...?tc.metadata,
      };

      // Determine sandbox for this task
      Object? taskSandbox;
      if (tc.sandbox != null) {
        // Task-level sandbox override
        taskSandbox = tc.sandbox;
      } else if (sandboxTypeStr != 'local') {
        taskSandbox = _serializeSandbox(sandbox);
      }

      // Resolve task-level settings with precedence:
      // task.yaml > task_defaults > hardcoded defaults
      final resolvedTimeLimit =
          tc.timeLimit ??
          taskDefaults['time_limit'] as int? ??
          (sandboxTypeStr != 'local' ? 300 : null);
      final resolvedMessageLimit =
          tc.messageLimit ?? taskDefaults['message_limit'] as int?;
      final resolvedTokenLimit =
          tc.tokenLimit ?? taskDefaults['token_limit'] as int?;
      final resolvedWorkingLimit =
          tc.workingLimit ?? taskDefaults['working_limit'] as int?;
      final resolvedCostLimit =
          tc.costLimit ?? (taskDefaults['cost_limit'] as num?)?.toDouble();
      final resolvedEpochs = tc.epochs ?? taskDefaults['epochs'];
      final resolvedFailOnError =
          tc.failOnError ?? taskDefaults['fail_on_error'];
      final resolvedContinueOnFail =
          tc.continueOnFail ?? taskDefaults['continue_on_fail'] as bool?;
      final resolvedModel = tc.model ?? taskDefaults['model'] as String?;
      final resolvedConfig = tc.config ?? taskDefaults['config'];
      final resolvedApproval = tc.approval ?? taskDefaults['approval'];
      final resolvedEarlyStopping =
          tc.earlyStopping ?? taskDefaults['early_stopping'];
      final resolvedDisplayName =
          tc.displayName ?? taskDefaults['display_name'] as String?;
      final resolvedVersion = tc.version ?? taskDefaults['version'];
      final resolvedModelRoles =
          tc.modelRoles ??
          (taskDefaults['model_roles'] as Map<String, String>?);

      inspectTasks.add(
        Task(
          name: '${tc.id}:${tc.variant.name}',
          func: tc.func,
          dataset: dataset,
          sandbox: taskSandbox,
          metadata: metadata,
          systemMessage: tc.systemMessage,
          sandboxParameters: tc.sandboxParameters,
          model: resolvedModel,
          config: resolvedConfig,
          modelRoles: resolvedModelRoles,
          approval: resolvedApproval,
          epochs: resolvedEpochs,
          failOnError: resolvedFailOnError,
          continueOnFail: resolvedContinueOnFail,
          messageLimit: resolvedMessageLimit,
          tokenLimit: resolvedTokenLimit,
          timeLimit: resolvedTimeLimit,
          workingLimit: resolvedWorkingLimit,
          costLimit: resolvedCostLimit,
          earlyStopping: resolvedEarlyStopping,
          displayName: resolvedDisplayName,
          version: resolvedVersion ?? 0,
        ),
      );
    }

    // Build the EvalSet with all job-level parameters from inspect_eval_arguments.
    final evalSetOverrides = (evalArgs['eval_set_overrides'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    // Helper to get a value from evalArgs then overrides
    T? getArg<T>(String key, [T? defaultVal]) {
      final v = evalArgs[key] as T?;
      if (v != null) return v;
      final o = evalSetOverrides[key] as T?;
      if (o != null) return o;
      return defaultVal;
    }

    return EvalSet(
      tasks: inspectTasks,
      logDir: logDir,
      model: models,
      sandbox: _serializeSandbox(sandbox),
      // Retry settings
      retryAttempts: getArg<int>('retry_attempts', 10),
      retryWait: (getArg<num>('retry_wait', 60))?.toDouble() ?? 60,
      retryConnections:
          (getArg<num>('retry_connections', 0.5))?.toDouble() ?? 0.5,
      retryCleanup: getArg<bool>('retry_cleanup'),
      retryOnError:
          getArg<int>('retry_on_error') ?? getArg<int>('max_retries'),
      // Error handling
      failOnError: (getArg<num>('fail_on_error', 0.05))?.toDouble() ?? 0.05,
      continueOnFail: getArg<bool>('continue_on_fail'),
      debugErrors: getArg<bool>('debug_errors'),
      // Concurrency
      maxSamples: getArg<int>('max_samples'),
      maxTasks: getArg<int>('max_tasks'),
      maxSubprocesses: getArg<int>('max_subprocesses'),
      maxSandboxes: getArg<int>('max_sandboxes'),
      // Logging
      logLevel: getArg<String>('log_level', 'info'),
      logLevelTranscript: getArg<String>('log_level_transcript'),
      logFormat: getArg<String>('log_format', 'json'),
      logSamples: getArg<bool>('log_samples'),
      logRealtime: getArg<bool>('log_realtime'),
      logImages: getArg<bool>('log_images'),
      logBuffer: getArg<int>('log_buffer'),
      logShared: getArg<int>('log_shared'),
      logDirAllowDirty: getArg<bool>('log_dir_allow_dirty'),
      // Model config
      modelBaseUrl: getArg<String>('model_base_url'),
      modelArgs:
          (evalArgs['model_args'] as Map<String, Object?>?) ??
          (evalSetOverrides['model_args'] as Map<String, Object?>?) ??
          const {},
      modelRoles:
          (evalArgs['model_roles'] as Map<String, String>?) ??
          evalSetOverrides['model_roles'] as Map<String, String>?,
      taskArgs:
          (evalArgs['task_args'] as Map<String, Object?>?) ??
          (evalSetOverrides['task_args'] as Map<String, Object?>?) ??
          const {},
      modelCostConfig:
          (evalArgs['model_cost_config'] as Map<String, Object?>?) ??
          evalSetOverrides['model_cost_config'] as Map<String, Object?>?,
      // Sandbox
      sandboxCleanup: getArg<bool>('sandbox_cleanup'),
      // Sample control
      limit: evalArgs['limit'] ?? evalSetOverrides['limit'],
      sampleId: evalArgs['sample_id'] ?? evalSetOverrides['sample_id'],
      sampleShuffle: evalArgs['sample_shuffle'] ?? evalSetOverrides['sample_shuffle'],
      epochs: evalArgs['epochs'] ?? evalSetOverrides['epochs'],
      // Misc
      tags: (evalArgs['tags'] as List?)?.cast<String>() ?? (evalSetOverrides['tags'] as List?)?.cast<String>(),
      metadata: (evalArgs['metadata'] as Map<String, dynamic>?) ?? evalSetOverrides['metadata'] as Map<String, dynamic>?,
      trace: getArg<bool>('trace'),
      display: getArg<String>('display'),
      approval: evalArgs['approval'] ?? evalSetOverrides['approval'],
      solver: evalArgs['solver'] ?? evalSetOverrides['solver'],
      score: getArg<bool>('score', true) ?? true,
      // Limits
      messageLimit: getArg<int>('message_limit'),
      tokenLimit: getArg<int>('token_limit'),
      timeLimit: getArg<int>('time_limit'),
      workingLimit: getArg<int>('working_limit'),
      costLimit: (getArg<num>('cost_limit'))?.toDouble(),
      // Bundling
      bundleDir: getArg<String>('bundle_dir'),
      bundleOverwrite: getArg<bool>('bundle_overwrite', false) ?? false,
      evalSetId: getArg<String>('eval_set_id'),
    );
  }



  // ------------------------------------------------------------------
  // Sandbox resolution
  // ------------------------------------------------------------------

  /// Resolve sandbox spec for a given config.
  ///
  /// Returns either `"local"` or a `Map` with `type` and `path` keys.
  Object _resolveSandbox(
    String datasetRoot,
    Job job,
  ) {
    final sandboxCfg = job.sandbox ?? <String, dynamic>{};
    final sandboxType = (sandboxCfg['environment'] as String?) ?? 'local';
    if (sandboxType.isEmpty || sandboxType == 'local') return 'local';

    // Named sandbox from registry
    if (sandboxRegistry.containsKey(sandboxType)) {
      final def = sandboxRegistry[sandboxType]!;
      var sandboxPath = def['path']!;
      if (!p.isAbsolute(sandboxPath)) {
        sandboxPath = p.normalize(p.join(datasetRoot, sandboxPath));
      }
      return {'type': def['name']!, 'path': sandboxPath};
    }

    return 'local';
  }

  // ------------------------------------------------------------------
  // Task × variant expansion
  // ------------------------------------------------------------------

  /// Expand task × variant combinations.
  List<ParsedTask> _expandTaskConfigs(
    List<ParsedTask> datasetTasks,
    Job job,
    String sandboxType,
    String datasetRoot,
  ) {
    final jobVariants = job.variants ?? {'baseline': <String, dynamic>{}};
    final expanded = <ParsedTask>[];

    for (final taskConfig in datasetTasks) {
      final taskId = taskConfig.id;

      // Filter by job.tasks (ID-based)
      if (job.tasks != null && !job.tasks!.containsKey(taskId)) continue;

      // Filter by job.taskFilters (tag-based)
      if (job.taskFilters != null) {
        final taskTags = (taskConfig.metadata?['tags'] as List?)?.cast<String>() ?? [];
        if (!matchesTagFilter(taskTags, job.taskFilters!)) continue;
      }

      // Get job-level task overrides
      final jobTask = (job.tasks != null && job.tasks!.containsKey(taskId))
          ? job.tasks![taskId]
          : null;

      // Determine effective variants using job-level include/exclude
      final effectiveVariants = <String, Map<String, dynamic>>{};
      for (final entry in jobVariants.entries) {
        final vName = entry.key;

        // Job-task level include_variants filter
        if (jobTask?.includeVariants != null &&
            !jobTask!.includeVariants!.contains(vName)) {
          continue;
        }
        // Job-task level exclude_variants filter
        if (jobTask?.excludeVariants != null &&
            jobTask!.excludeVariants!.contains(vName)) {
          continue;
        }

        effectiveVariants[vName] = entry.value;
      }

      // Apply sample filtering
      var samples = taskConfig.samples;
      if (jobTask != null) {
        if (jobTask.includeSamples != null) {
          samples = samples
              .where((s) => jobTask.includeSamples!.contains(s.id))
              .toList();
        }
        if (jobTask.excludeSamples != null) {
          samples = samples
              .where((s) => !jobTask.excludeSamples!.contains(s.id))
              .toList();
        }
      }

      // Apply sample tag filtering (job-level)
      if (job.sampleFilters != null) {
        samples = samples.where((s) {
          final sampleTags = (s.metadata?['tags'] as List?)?.cast<String>() ?? [];
          return matchesTagFilter(sampleTags, job.sampleFilters!);
        }).toList();
      }

      // Apply system_message from task (no longer overridden by job task)
      var systemMessage = taskConfig.systemMessage;

      // Merge job-task args into metadata
      Map<String, dynamic>? mergedMetadata = taskConfig.metadata;
      if (jobTask?.args != null && jobTask!.args!.isNotEmpty) {
        mergedMetadata = {...?mergedMetadata, 'args': jobTask.args};
      }

      // Create one ParsedTask per effective variant
      for (final entry in effectiveVariants.entries) {
        final variant = _resolveVariant(entry.key, entry.value, datasetRoot);

        // Compute examples_dir from job log_dir
        String? examplesDir;
        if (job.saveExamples) {
          examplesDir = p.join(job.logDir, 'examples');
        }

        expanded.add(
          taskConfig.copyWith(
            samples: samples,
            variant: variant,
            sandboxType: sandboxType,
            systemMessage: systemMessage,
            saveExamples: job.saveExamples,
            examplesDir: examplesDir,
            metadata: mergedMetadata,
          ),
        );
      }
    }

    return expanded;
  }

  // ------------------------------------------------------------------
  // Variant resolution
  // ------------------------------------------------------------------

  /// Resolve a variant dict into a fully-resolved [Variant].
  Variant _resolveVariant(
    String name,
    Map<String, dynamic> vDef,
    String datasetRoot,
  ) {
    if (vDef.isEmpty) return Variant(name: name);

    // Load context files (with glob support)
    final files = <ContextFile>[];
    final cfPaths =
        (vDef['files'] as List?)?.cast<String>() ?? const [];
    for (final cfPath in cfPaths) {
      if (_isGlob(cfPath)) {
        final matched = _expandGlobFiles(datasetRoot, cfPath);
        if (matched.isEmpty) {
          throw FileSystemException(
            'No context files matched pattern: $cfPath',
          );
        }
        for (final f in matched) {
          files.add(ContextFile.load(f));
        }
      } else {
        final fullPath = p.normalize(p.join(datasetRoot, cfPath));
        files.add(ContextFile.load(fullPath));
      }
    }

    // Resolve skill paths (with glob support)
    final skills = <String>[];
    final rawSkills =
        (vDef['skills'] as List?)?.cast<String>() ?? const [];
    for (final skillPathStr in rawSkills) {
      if (_isGlob(skillPathStr)) {
        final matched = _expandGlobDirs(datasetRoot, skillPathStr);
        final validDirs = matched
            .where((d) => File(p.join(d, 'SKILL.md')).existsSync())
            .toList();
        if (validDirs.isEmpty) {
          throw FileSystemException(
            'No skill directories matched pattern: $skillPathStr',
          );
        }
        skills.addAll(validDirs);
      } else {
        final skillDir = p.normalize(p.join(datasetRoot, skillPathStr));
        if (!Directory(skillDir).existsSync()) {
          throw FileSystemException('Skill directory not found', skillDir);
        }
        if (!File(p.join(skillDir, 'SKILL.md')).existsSync()) {
          throw FileSystemException(
            'SKILL.md not found in $skillDir. '
            'Each skill directory must contain a SKILL.md file.',
          );
        }
        skills.add(skillDir);
      }
    }

    // Parse MCP servers as config objects
    final mcpServers = <Map<String, dynamic>>[];
    final rawMcpServers = vDef['mcp_servers'] as List? ?? [];
    for (final srv in rawMcpServers) {
      if (srv is Map) {
        mcpServers.add(Map<String, dynamic>.from(srv));
      } else if (srv is String) {
        // String shorthand: treat as a ref (Python import path)
        mcpServers.add(<String, dynamic>{'ref': srv});
      }
    }

    // Parse task_parameters
    final taskParameters = (vDef['task_parameters'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};

    return Variant(
      name: name,
      files: files,
      mcpServers: mcpServers,
      skills: skills,
      taskParameters: taskParameters,
    );
  }

  // ------------------------------------------------------------------
  // Serialization helpers
  // ------------------------------------------------------------------

  /// Serialize sandbox to eval_set()-compatible format.
  ///
  /// eval_set() accepts sandbox as:
  /// - `null` for no sandbox
  /// - `"type"` for simple types
  /// - `("type", "path")` which maps to a JSON list `["type", "path"]`
  dynamic _serializeSandbox(Object sandbox) {
    if (sandbox is String) return sandbox == 'local' ? null : sandbox;
    if (sandbox is Map) {
      final type = sandbox['type'] as String;
      final path = sandbox['path'] as String;
      return [type, path];
    }
    return null;
  }

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

  /// Expand a glob pattern relative to [baseDir], returning matching dirs.
  static List<String> _expandGlobDirs(String baseDir, String pattern) {
    final glob = Glob(pattern);
    return glob
        .listSync(root: baseDir)
        .whereType<Directory>()
        .map((d) => p.normalize(d.path))
        .toList()
      ..sort();
  }
}
