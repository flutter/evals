import 'dart:io';

import 'package:devals/src/cli_exception.dart';
import 'package:devals/src/dataset/filesystem_utils.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory tempDir;
  late Directory originalDir;

  setUp(() {
    originalDir = Directory.current;
    tempDir = Directory.systemTemp.createTempSync('fs_utils_test_');
    DatasetReader().clearCache();
  });

  tearDown(() {
    Directory.current = originalDir;
    DatasetReader().clearCache();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('findDatasetDirectory()', () {
    test(
      'finds devals.yaml in current directory and resolves dataset path',
      () {
        // Create: tempDir/devals.yaml pointing to ./evals
        final evalsDir = Directory(p.join(tempDir.path, 'evals', 'tasks'));
        evalsDir.createSync(recursive: true);
        File(
          p.join(tempDir.path, 'devals.yaml'),
        ).writeAsStringSync('dataset: ./evals\n');

        try {
          Directory.current = tempDir;
          final result = findDatasetDirectory();
          expect(
            result,
            equals(
              p.normalize(
                p.join(tempDir.resolveSymbolicLinksSync(), 'evals'),
              ),
            ),
          );
        } finally {
          Directory.current = originalDir;
        }
      },
    );

    test('walks up to find devals.yaml in ancestor directory', () {
      // Create: tempDir/devals.yaml
      // Cwd:    tempDir/some/deep/subdir
      final evalsDir = Directory(p.join(tempDir.path, 'evals', 'tasks'));
      evalsDir.createSync(recursive: true);
      File(
        p.join(tempDir.path, 'devals.yaml'),
      ).writeAsStringSync('dataset: ./evals\n');

      final subDir = Directory(p.join(tempDir.path, 'some', 'deep', 'subdir'));
      subDir.createSync(recursive: true);

      try {
        Directory.current = subDir;
        final result = findDatasetDirectory();
        expect(
          result,
          equals(
            p.normalize(
              p.join(tempDir.resolveSymbolicLinksSync(), 'evals'),
            ),
          ),
        );
      } finally {
        Directory.current = originalDir;
      }
    });

    test('throws CliException when no devals.yaml found', () {
      try {
        Directory.current = tempDir;
        expect(
          () => findDatasetDirectory(),
          throwsA(isA<CliException>()),
        );
      } finally {
        Directory.current = originalDir;
      }
    });

    test('throws when devals.yaml is missing dataset field', () {
      File(
        p.join(tempDir.path, 'devals.yaml'),
      ).writeAsStringSync('name: test\n');

      try {
        Directory.current = tempDir;
        expect(
          () => findDatasetDirectory(),
          throwsA(isA<CliException>()),
        );
      } finally {
        Directory.current = originalDir;
      }
    });

    test('throws when dataset path has no tasks/ subdirectory', () {
      Directory(p.join(tempDir.path, 'evals')).createSync();
      File(
        p.join(tempDir.path, 'devals.yaml'),
      ).writeAsStringSync('dataset: ./evals\n');

      try {
        Directory.current = tempDir;
        expect(
          () => findDatasetDirectory(),
          throwsA(isA<CliException>()),
        );
      } finally {
        Directory.current = originalDir;
      }
    });
  });

  group('ensureDirectoryExists()', () {
    test('creates directory when it does not exist', () {
      final newPath = '${tempDir.path}/new_dir';
      expect(Directory(newPath).existsSync(), isFalse);

      ensureDirectoryExists(newPath);

      expect(Directory(newPath).existsSync(), isTrue);
    });

    test('does not error when directory already exists', () {
      final existingPath = '${tempDir.path}/existing';
      Directory(existingPath).createSync();

      expect(() => ensureDirectoryExists(existingPath), returnsNormally);
      expect(Directory(existingPath).existsSync(), isTrue);
    });

    test('creates nested directories', () {
      final nestedPath = '${tempDir.path}/a/b/c';

      ensureDirectoryExists(nestedPath);

      expect(Directory(nestedPath).existsSync(), isTrue);
    });
  });

  group('writeFile()', () {
    test('writes content to new file', () {
      final filePath = '${tempDir.path}/test.txt';

      writeFile(filePath, 'Hello, World!');

      expect(File(filePath).existsSync(), isTrue);
      expect(File(filePath).readAsStringSync(), equals('Hello, World!'));
    });

    test('creates parent directories if missing', () {
      final filePath = '${tempDir.path}/nested/dir/file.txt';

      writeFile(filePath, 'content');

      expect(File(filePath).existsSync(), isTrue);
    });

    test('overwrites existing file', () {
      final filePath = '${tempDir.path}/overwrite.txt';
      File(filePath).writeAsStringSync('original');

      writeFile(filePath, 'updated');

      expect(File(filePath).readAsStringSync(), equals('updated'));
    });

    test('handles empty content', () {
      final filePath = '${tempDir.path}/empty.txt';

      writeFile(filePath, '');

      expect(File(filePath).existsSync(), isTrue);
      expect(File(filePath).readAsStringSync(), equals(''));
    });

    test('handles multiline content', () {
      final filePath = '${tempDir.path}/multiline.txt';
      final content = 'Line 1\nLine 2\nLine 3';

      writeFile(filePath, content);

      expect(File(filePath).readAsStringSync(), equals(content));
    });
  });

  group('readFile()', () {
    test('reads content from existing file', () {
      final filePath = '${tempDir.path}/readable.txt';
      File(filePath).writeAsStringSync('test content');

      final result = readFile(filePath);

      expect(result, equals('test content'));
    });

    test('throws CliException for non-existent file', () {
      expect(
        () => readFile('${tempDir.path}/nonexistent.txt'),
        throwsA(isA<CliException>()),
      );
    });

    test('reads empty file', () {
      final filePath = '${tempDir.path}/empty.txt';
      File(filePath).writeAsStringSync('');

      final result = readFile(filePath);

      expect(result, equals(''));
    });

    test('preserves newlines', () {
      final filePath = '${tempDir.path}/lines.txt';
      File(filePath).writeAsStringSync('a\nb\nc');

      final result = readFile(filePath);

      expect(result, equals('a\nb\nc'));
    });
  });

  group('findJobsDir()', () {
    test('returns path when jobs directory exists', () {
      final datasetPath = '${tempDir.path}/dataset';
      final jobsPath = '$datasetPath/jobs';
      Directory(datasetPath).createSync();
      Directory(jobsPath).createSync();

      final result = findJobsDir(datasetPath);

      expect(result, equals(jobsPath));
    });

    test('creates jobs directory if missing', () {
      final datasetPath = '${tempDir.path}/dataset';
      Directory(datasetPath).createSync();

      final result = findJobsDir(datasetPath);

      expect(Directory(result).existsSync(), isTrue);
    });
  });

  group('findLogsDir()', () {
    test('returns path when logs directory exists inside dataset dir', () {
      final datasetPath = '${tempDir.path}/dataset';
      final logsPath = '$datasetPath/logs';
      Directory(datasetPath).createSync();
      Directory(logsPath).createSync();

      final result = findLogsDir(datasetPath);

      expect(result, equals(logsPath));
    });

    test('returns null when logs directory missing', () {
      final datasetPath = '${tempDir.path}/dataset';
      Directory(datasetPath).createSync();

      final result = findLogsDir(datasetPath);

      expect(result, isNull);
    });
  });

  group('tryFindDatasetDirectory()', () {
    test('returns null when devals.yaml not found', () {
      try {
        Directory.current = tempDir;
        final result = tryFindDatasetDirectory();
        expect(result, isNull);
      } finally {
        Directory.current = originalDir;
      }
    });
  });
}
