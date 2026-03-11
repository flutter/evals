import 'package:dataset_config_dart/dataset_config_dart.dart';

/// Preview resolved config without running evaluations.
///
/// Validates the config and prints a formatted summary of what would be
/// passed to the Python eval runner.
///
/// Returns `true` if the config is valid, `false` if there are errors.
bool dryRun(List<EvalSet> configs) {
  var allValid = true;

  for (var i = 0; i < configs.length; i++) {
    if (configs.length > 1) {
      print('\n${'=' * 70}');
      print('📦 Job ${i + 1}/${configs.length}');
      print('=' * 70);
    }

    if (!_validateConfig(configs[i])) {
      allValid = false;
    }
  }

  return allValid;
}

bool _validateConfig(EvalSet config) {
  final errors = <String>[];
  final warnings = <String>[];

  // {taskName: sampleCount}
  final taskSummaries = <String, int>{};

  for (final task in config.tasks) {
    final name = task.name ?? task.taskFunc ?? '(unknown)';

    if (task.taskFunc == null) {
      warnings.add(
        'Task "$name" has no task_func — Mode 2 hydration required',
      );
    }

    final sampleCount = task.dataset?.samples.length ?? 0;
    taskSummaries[name] = sampleCount;
  }

  final models = config.model ?? [];
  if (models.isEmpty) {
    errors.add('No models specified in config');
  }

  _printSummary(config, taskSummaries, errors, warnings);
  return errors.isEmpty;
}

void _printSummary(
  EvalSet config,
  Map<String, int> taskSummaries,
  List<String> errors,
  List<String> warnings,
) {
  print('=' * 70);
  print('🔍 DRY RUN - Configuration Summary');
  print('=' * 70);
  print('');

  // Log directory
  print('📁 Log Directory: ${config.logDir}');
  print('');

  // Models
  final models = config.model ?? [];
  print('🤖 Models (${models.length}):');
  for (final model in models) {
    print('   • $model');
  }
  print('');

  // Sandbox
  final sandbox = config.sandbox;
  if (sandbox is List && sandbox.length == 2) {
    print('🏖️  Sandbox: ${sandbox[0]} (${sandbox[1]})');
  } else if (sandbox != null) {
    print('🏖️  Sandbox: $sandbox');
  } else {
    print('🏖️  Sandbox: local');
  }
  print('');

  // Rate limits
  print('⚡ Rate Limits:');
  if (config.retryAttempts != null) {
    print('   • Retry attempts: ${config.retryAttempts}');
  }
  if (config.retryOnError != null) {
    print('   • Retry on error: ${config.retryOnError}');
  }
  print('');

  // Tasks tree
  final numModels = models.length;
  final totalTasks = taskSummaries.length;
  final totalRuns = totalTasks * numModels;
  final totalSamples =
      taskSummaries.values.fold<int>(0, (s, c) => s + c) * numModels;

  print(
    '📋 Tasks ($totalTasks tasks, '
    'run $totalRuns total times, $totalSamples total samples):',
  );

  final taskNames = taskSummaries.keys.toList();
  for (var i = 0; i < taskNames.length; i++) {
    final taskName = taskNames[i];
    final sampleCount = taskSummaries[taskName]!;
    final isLast = i == taskNames.length - 1;
    final prefix = isLast ? '└─' : '├─';

    final taskRuns = numModels;
    final taskSamples = sampleCount * numModels;

    print('   $prefix $taskName ($taskRuns runs, $taskSamples samples)');

    for (var j = 0; j < models.length; j++) {
      final isLastModel = j == models.length - 1;
      final indent = isLast ? '      ' : '   │  ';
      final modelPrefix = isLastModel ? '└─' : '├─';
      final model = models[j];
      final shortModel = model.contains('/') ? model.split('/').last : model;
      print('$indent$modelPrefix $shortModel ($sampleCount samples)');
    }
  }
  print('');

  // Warnings
  if (warnings.isNotEmpty) {
    print('⚠️  Warnings:');
    for (final warning in warnings) {
      print('   • $warning');
    }
    print('');
  }

  // Errors
  if (errors.isNotEmpty) {
    print('❌ Errors:');
    for (final error in errors) {
      print('   • $error');
    }
    print('');
    print('=' * 70);
    print('❌ Configuration invalid - fix errors before running');
    print('=' * 70);
  } else {
    print('=' * 70);
    print('✅ Configuration valid - ready to run');
    print('=' * 70);
  }
}
