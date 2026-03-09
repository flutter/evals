import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import '../models/models.dart';
import 'package:path/path.dart' as p;

import '../parsed_task.dart';

/// Default models used when a job doesn't specify its own.
const List<String> kDefaultModels = [
  'anthropic/claude-haiku-4-5',
  'anthropic/claude-sonnet-4-5',
  'anthropic/claude-opus-4-6',
  'google/gemini-2.5-flash',
  'google/gemini-3-pro-preview',
  'google/gemini-3-flash-preview',
  'openai/gpt-5-mini',
  'openai/gpt-5-nano',
  'openai/gpt-5',
  'openai/gpt-5-pro',
];

/// Available sandbox configurations.
const Map<String, Map<String, String>> kSandboxRegistry = {
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

/// Maps Flutter SDK channel names to sandbox registry keys.
const Map<String, String> kSdkChannels = {
  'stable': 'podman',
  'beta': 'podman-beta',
  'main': 'podman-main',
};

/// Resolves parsed task configs and job into fully-resolved
/// [EvalSet] objects ready for JSON serialization.
///
/// This is the resolution engine. It:
/// 1. Resolves models, sandboxes, and variants
/// 2. Expands task × variant combinations into [Task] entries
/// 3. Groups by flutter_channel (one [EvalSet] per group)
/// 4. Propagates job-level and task-level settings to the output
class EvalSetResolver {
  /// Resolve task configs and job into [EvalSet] objects.
  ///
  /// Groups by flutter_channel so each gets its own sandbox.
  List<EvalSet> resolve(
    List<ParsedTask> datasetTasks,
    Job job,
    String datasetRoot,
  ) {
    final models = _resolveModels(job);
    final sandboxTypeStr = job.sandboxType;
    final expandedTasks = _expandTaskConfigs(
      datasetTasks,
      job,
      sandboxTypeStr,
      datasetRoot,
    );

    // Group by flutter channel
    final groups = <String?, List<ParsedTask>>{};
    for (final tc in expandedTasks) {
      final key = tc.variant.flutterChannel;
      (groups[key] ??= []).add(tc);
    }

    return [
      for (final entry in groups.entries)
        _buildEvalSet(
          taskConfigs: entry.value,
          logDir: job.logDir,
          models: models,
          sandbox: _resolveSandbox(
            datasetRoot,
            job,
            flutterChannel: entry.key,
          ),
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
    final isContainer =
        job.sandboxType.isNotEmpty && job.sandboxType != 'local';

    // Parse task_defaults from the job
    final taskDefaults = job.taskDefaults ?? <String, dynamic>{};

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

        // Build files + setup for sandbox provisioning
        Map<String, String>? files = sample.files;
        String? setup = sample.setup;
        final workspace = sample.metadata?['workspace'] as String?;
        final workspaceGit = sample.metadata?['workspace_git'] as String?;
        final workspaceGitRef =
            sample.metadata?['workspace_git_ref'] as String?;

        if (workspace != null && isContainer) {
          files = {...?files, '/workspace': workspace};
          setup = setup ?? 'cd /workspace && flutter pub get';
          enriched['workspace'] = '/workspace';
        }
        if (workspaceGit != null) {
          enriched['workspace_git'] = workspaceGit;
          if (workspaceGitRef != null) {
            enriched['workspace_git_ref'] = workspaceGitRef;
          }
        }

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
      );

      // Build task metadata (variant config, system message, etc.)
      final metadata = <String, dynamic>{
        'variant': tc.variant.name,
        if (tc.variant.contextFiles.isNotEmpty)
          'variant_config': {
            'context_files': tc.variant.contextFiles
                .map(
                  (cf) => {
                    'title': cf.metadata.title,
                    'version': cf.metadata.version,
                    'content': cf.content,
                  },
                )
                .toList(),
            'mcp_servers': tc.variant.mcpServers,
            'skill_paths': tc.variant.skillPaths,
          },
        if (tc.variant.contextFiles.isEmpty &&
            (tc.variant.mcpServers.isNotEmpty ||
                tc.variant.skillPaths.isNotEmpty))
          'variant_config': {
            'mcp_servers': tc.variant.mcpServers,
            'skill_paths': tc.variant.skillPaths,
          },
        if (tc.systemMessage != null) 'system_message': tc.systemMessage,
        if (tc.saveExamples) 'save_examples': true,
        if (tc.examplesDir != null) 'examples_dir': tc.examplesDir,
        // Merge any task-level metadata from YAML
        ...?tc.metadata,
      };

      // Determine sandbox for this task
      Object? taskSandbox;
      if (tc.sandbox != null) {
        // Task-level sandbox override
        taskSandbox = tc.sandbox;
      } else if (tc.sandboxType.isNotEmpty && tc.sandboxType != 'local') {
        taskSandbox = _serializeSandbox(sandbox);
      }

      // Resolve task-level settings with precedence:
      // task.yaml > task_defaults > hardcoded defaults
      final resolvedTimeLimit =
          tc.timeLimit ??
          taskDefaults['time_limit'] as int? ??
          (job.sandboxType != 'local' ? 300 : null);
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
          taskFunc: tc.taskFunc,
          dataset: dataset,
          sandbox: taskSandbox,
          metadata: metadata,
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

    // Build the EvalSet with all job-level parameters.
    // Start with any eval_set_overrides, then apply explicit fields.
    final overrides = job.evalSetOverrides ?? <String, dynamic>{};

    return EvalSet(
      tasks: inspectTasks,
      logDir: logDir,
      model: models,
      sandbox: _serializeSandbox(sandbox),
      // Retry settings
      retryAttempts:
          job.retryAttempts ?? overrides['retry_attempts'] as int? ?? 10,
      retryWait:
          job.retryWait ?? (overrides['retry_wait'] as num?)?.toDouble() ?? 60,
      retryConnections:
          job.retryConnections ??
          (overrides['retry_connections'] as num?)?.toDouble() ??
          0.5,
      retryCleanup: job.retryCleanup ?? overrides['retry_cleanup'] as bool?,
      retryOnError:
          job.retryOnError ??
          job.maxRetries ??
          overrides['retry_on_error'] as int?,
      // Error handling
      failOnError:
          job.failOnError ??
          (overrides['fail_on_error'] as num?)?.toDouble() ??
          0.05,
      continueOnFail:
          job.continueOnFail ?? overrides['continue_on_fail'] as bool?,
      debugErrors: job.debugErrors ?? overrides['debug_errors'] as bool?,
      // Concurrency
      maxSamples: job.maxSamples ?? overrides['max_samples'] as int?,
      maxTasks: job.maxTasks ?? overrides['max_tasks'] as int?,
      maxSubprocesses:
          job.maxSubprocesses ?? overrides['max_subprocesses'] as int?,
      maxSandboxes: job.maxSandboxes ?? overrides['max_sandboxes'] as int?,
      // Logging
      logLevel: job.logLevel ?? overrides['log_level'] as String? ?? 'info',
      logLevelTranscript:
          job.logLevelTranscript ??
          overrides['log_level_transcript'] as String?,
      logFormat: job.logFormat ?? overrides['log_format'] as String? ?? 'json',
      logSamples: job.logSamples ?? overrides['log_samples'] as bool?,
      logRealtime: job.logRealtime ?? overrides['log_realtime'] as bool?,
      logImages: job.logImages ?? overrides['log_images'] as bool?,
      logBuffer: job.logBuffer ?? overrides['log_buffer'] as int?,
      logShared: job.logShared ?? overrides['log_shared'] as int?,
      logDirAllowDirty:
          job.logDirAllowDirty ?? overrides['log_dir_allow_dirty'] as bool?,
      // Model config
      modelBaseUrl: job.modelBaseUrl ?? overrides['model_base_url'] as String?,
      modelArgs:
          job.modelArgs ??
          (overrides['model_args'] as Map<String, Object?>?) ??
          const {},
      modelRoles:
          job.modelRoles ?? overrides['model_roles'] as Map<String, String>?,
      taskArgs:
          job.taskArgs ??
          (overrides['task_args'] as Map<String, Object?>?) ??
          const {},
      modelCostConfig:
          job.modelCostConfig ??
          overrides['model_cost_config'] as Map<String, Object?>?,
      // Sandbox
      sandboxCleanup:
          job.sandboxCleanup ?? overrides['sandbox_cleanup'] as bool?,
      // Sample control
      limit: job.limit ?? overrides['limit'],
      sampleId: job.sampleId ?? overrides['sample_id'],
      sampleShuffle: job.sampleShuffle ?? overrides['sample_shuffle'],
      epochs: job.epochs ?? overrides['epochs'],
      // Misc
      tags: job.tags ?? (overrides['tags'] as List?)?.cast<String>(),
      metadata: job.metadata ?? overrides['metadata'] as Map<String, dynamic>?,
      trace: job.trace ?? overrides['trace'] as bool?,
      display: job.display ?? overrides['display'] as String?,
      approval: job.approval ?? overrides['approval'],
      solver: job.solver ?? overrides['solver'],
      score: job.score ?? overrides['score'] as bool? ?? true,
      // Limits
      messageLimit: job.messageLimit ?? overrides['message_limit'] as int?,
      tokenLimit: job.tokenLimit ?? overrides['token_limit'] as int?,
      timeLimit: job.timeLimit ?? overrides['time_limit'] as int?,
      workingLimit: job.workingLimit ?? overrides['working_limit'] as int?,
      costLimit: job.costLimit ?? (overrides['cost_limit'] as num?)?.toDouble(),
      // Bundling
      bundleDir: job.bundleDir ?? overrides['bundle_dir'] as String?,
      bundleOverwrite:
          job.bundleOverwrite ??
          overrides['bundle_overwrite'] as bool? ??
          false,
      evalSetId: job.evalSetId ?? overrides['eval_set_id'] as String?,
    );
  }

  // ------------------------------------------------------------------
  // Model resolution
  // ------------------------------------------------------------------

  /// Resolve which models to run. Job overrides default.
  List<String> _resolveModels(Job job) {
    if (job.models != null && job.models!.isNotEmpty) return job.models!;
    return List.of(kDefaultModels);
  }

  // ------------------------------------------------------------------
  // Sandbox resolution
  // ------------------------------------------------------------------

  /// Resolve sandbox spec for a given config.
  ///
  /// Returns either `"local"` or a `Map` with `type` and `path` keys.
  Object _resolveSandbox(
    String datasetRoot,
    Job job, {
    String? flutterChannel,
  }) {
    final sandboxType = job.sandboxType;
    if (sandboxType.isEmpty || sandboxType == 'local') return 'local';

    // Channel override → look up channel-specific sandbox
    if (flutterChannel != null && kSdkChannels.containsKey(flutterChannel)) {
      final registryKey = kSdkChannels[flutterChannel]!;
      if (kSandboxRegistry.containsKey(registryKey)) {
        final def = kSandboxRegistry[registryKey]!;
        var sandboxPath = def['path']!;
        if (!p.isAbsolute(sandboxPath)) {
          sandboxPath = p.normalize(p.join(datasetRoot, sandboxPath));
        }
        return {'type': def['name']!, 'path': sandboxPath};
      }
    }

    // Named sandbox from registry
    if (kSandboxRegistry.containsKey(sandboxType)) {
      final def = kSandboxRegistry[sandboxType]!;
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

      // Filter by job.tasks
      if (job.tasks != null && !job.tasks!.containsKey(taskId)) continue;

      // Determine effective variants (intersection)
      final effectiveVariants = <String, Map<String, dynamic>>{};
      for (final entry in jobVariants.entries) {
        if (taskConfig.allowedVariants == null ||
            taskConfig.allowedVariants!.contains(entry.key)) {
          effectiveVariants[entry.key] = entry.value;
        }
      }

      // Get job-level task overrides
      final jobTask = (job.tasks != null && job.tasks!.containsKey(taskId))
          ? job.tasks![taskId]
          : null;

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

      // Apply system_message override
      var systemMessage = taskConfig.systemMessage;
      if (jobTask?.systemMessage != null) {
        systemMessage = jobTask!.systemMessage;
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
            allowedVariants: null,
            saveExamples: job.saveExamples,
            examplesDir: examplesDir,
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
    final contextFiles = <ContextFile>[];
    final cfPaths =
        (vDef['context_files'] as List?)?.cast<String>() ?? const [];
    for (final cfPath in cfPaths) {
      if (_isGlob(cfPath)) {
        final matched = _expandGlobFiles(datasetRoot, cfPath);
        if (matched.isEmpty) {
          throw FileSystemException(
            'No context files matched pattern: $cfPath',
          );
        }
        for (final f in matched) {
          contextFiles.add(ContextFile.load(f));
        }
      } else {
        final fullPath = p.normalize(p.join(datasetRoot, cfPath));
        contextFiles.add(ContextFile.load(fullPath));
      }
    }

    // Resolve skill paths (with glob support)
    final skillPaths = <String>[];
    final rawSkills =
        ((vDef['skills'] as List?) ?? (vDef['skill_paths'] as List?) ?? [])
            .cast<String>();
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
        skillPaths.addAll(validDirs);
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
        skillPaths.add(skillDir);
      }
    }

    return Variant(
      name: name,
      contextFiles: contextFiles,
      mcpServers: (vDef['mcp_servers'] as List?)?.cast<String>() ?? [],
      skillPaths: skillPaths,
      flutterChannel: vDef['flutter_channel'] as String?,
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
