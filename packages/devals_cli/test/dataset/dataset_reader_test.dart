import 'dart:io';
import 'package:devals/src/dataset/dataset_reader.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory tempDir;
  late Directory originalDir;

  /// The dataset root — contains tasks/ directly.
  late String datasetPath;

  /// Creates a devals.yaml + dataset directory with a tasks/ subdirectory
  /// so findDatasetDirectory() can discover it.
  void createDatasetDir() {
    Directory('$datasetPath/tasks').createSync(recursive: true);
    // Create devals.yaml in tempDir pointing to the dataset
    File(
      p.join(tempDir.path, 'devals.yaml'),
    ).writeAsStringSync('dataset: ./evals\n');
  }

  setUp(() {
    originalDir = Directory.current;
    tempDir = Directory.systemTemp.createTempSync('dataset_reader_test_');
    datasetPath = p.join(tempDir.path, 'evals');
    // Clear singleton cache between tests
    DatasetReader().clearCache();
  });

  tearDown(() {
    Directory.current = originalDir;
    DatasetReader().clearCache();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('getVariants()', () {
    test('returns common variant names for scaffolding', () {
      createDatasetDir();

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final variants = reader.getVariants();
        expect(
          variants,
          containsAll(['baseline', 'flutter_rules', 'with_skills', 'with_mcp']),
        );
      } finally {
        Directory.current = originalDir;
      }
    });
  });

  group('getTasks()', () {
    test('discovers task directories containing task.yaml', () {
      createDatasetDir();
      final tasksDir = Directory('$datasetPath/tasks');
      for (final name in ['task_one', 'task_two']) {
        final dir = Directory('${tasksDir.path}/$name');
        dir.createSync(recursive: true);
        File('${dir.path}/task.yaml').writeAsStringSync('func: solve');
      }

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final tasks = reader.getTasks();
        expect(tasks, containsAll(['task_one', 'task_two']));
      } finally {
        Directory.current = originalDir;
      }
    });

    test('returns empty list when tasks dir is empty', () {
      createDatasetDir();
      Directory('$datasetPath/tasks').createSync(recursive: true);

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final tasks = reader.getTasks();
        expect(tasks, isEmpty);
      } finally {
        Directory.current = originalDir;
      }
    });

    test('returns empty list when tasks dir missing', () {
      createDatasetDir();

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final tasks = reader.getTasks();
        expect(tasks, isEmpty);
      } finally {
        Directory.current = originalDir;
      }
    });

    test('ignores directories without task.yaml', () {
      createDatasetDir();
      final tasksDir = Directory('$datasetPath/tasks');
      final validDir = Directory('${tasksDir.path}/valid_task');
      validDir.createSync(recursive: true);
      File('${validDir.path}/task.yaml').writeAsStringSync('func: solve');

      final invalidDir = Directory('${tasksDir.path}/no_yaml');
      invalidDir.createSync(recursive: true);

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final tasks = reader.getTasks();
        expect(tasks, equals(['valid_task']));
      } finally {
        Directory.current = originalDir;
      }
    });
  });

  group('getExistingTaskNames()', () {
    test('returns Set of task names from filesystem', () {
      createDatasetDir();
      final tasksDir = Directory('$datasetPath/tasks');
      for (final name in ['task_a', 'task_b']) {
        final dir = Directory('${tasksDir.path}/$name');
        dir.createSync(recursive: true);
        File('${dir.path}/task.yaml').writeAsStringSync('func: solve');
      }

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final names = reader.getExistingTaskNames();
        expect(names, isA<Set<String>>());
        expect(names, containsAll(['task_a', 'task_b']));
      } finally {
        Directory.current = originalDir;
      }
    });
  });

  group('getTaskFuncs()', () {
    test('returns list of task func records from filesystem', () {
      createDatasetDir();
      final tasksDir = Directory('$datasetPath/tasks');
      for (final name in ['task_a', 'task_b']) {
        final dir = Directory('${tasksDir.path}/$name');
        dir.createSync(recursive: true);
        File('${dir.path}/task.yaml').writeAsStringSync('func: solve');
      }

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();
        final funcs = reader.getTaskFuncs();
        expect(funcs, hasLength(2));

        // Verify discovered task names are present
        final funcNames = funcs.map((f) => f.name).toSet();
        expect(funcNames, containsAll(['task_a', 'task_b']));
      } finally {
        Directory.current = originalDir;
      }
    });
  });

  group('clearCache()', () {
    test('clears cached dataset path', () {
      createDatasetDir();

      try {
        Directory.current = tempDir;
        final reader = DatasetReader();

        // Access to prime the cache
        reader.datasetDirPath;

        // Clear and verify it re-discovers
        reader.clearCache();
        expect(() => reader.datasetDirPath, returnsNormally);
      } finally {
        Directory.current = originalDir;
      }
    });
  });
}
