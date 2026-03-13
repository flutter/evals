import 'dart:convert';
import 'dart:io';

import 'package:dataset_config_dart/dataset_config_dart.dart';
import 'package:test/test.dart';

void main() {
  late EvalSetWriter writer;
  late Directory tmpDir;

  setUp(() {
    writer = EvalSetWriter();
    tmpDir = Directory.systemTemp.createTempSync('eval_set_writer_test_');
  });

  tearDown(() {
    if (tmpDir.existsSync()) {
      tmpDir.deleteSync(recursive: true);
    }
  });

  EvalSet makeEvalSet({String logDir = '/tmp/logs', int taskCount = 1}) {
    return EvalSet(
      tasks: List.generate(
        taskCount,
        (i) => Task(
          name: 'task_$i:baseline',
          func: 'func_$i',
          dataset: Dataset(
            samples: [
              Sample(id: 's$i', input: 'input $i', target: 'target $i'),
            ],
            name: 'task_$i:baseline',
          ),
        ),
      ),
      logDir: logDir,
    );
  }

  group('write()', () {
    test('single config writes valid JSON object to eval_set.json', () {
      final config = makeEvalSet();
      final path = writer.write([config], tmpDir.path);

      expect(path, endsWith('eval_set.json'));
      expect(File(path).existsSync(), isTrue);

      final content = File(path).readAsStringSync();
      final json = jsonDecode(content);
      expect(json, isA<Map<String, dynamic>>());
      expect(json['tasks'], isA<List>());
      expect(json['log_dir'], '/tmp/logs');
    });

    test('multiple configs writes JSON array', () {
      final configs = [
        makeEvalSet(logDir: '/logs/a'),
        makeEvalSet(logDir: '/logs/b'),
      ];
      final path = writer.write(configs, tmpDir.path);

      final content = File(path).readAsStringSync();
      final json = jsonDecode(content);
      expect(json, isA<List>());
      expect((json as List), hasLength(2));
    });

    test('creates output directory if missing', () {
      final nestedDir = '${tmpDir.path}/a/b/c';
      expect(Directory(nestedDir).existsSync(), isFalse);

      writer.write([makeEvalSet()], nestedDir);

      expect(Directory(nestedDir).existsSync(), isTrue);
    });

    test('output is pretty-printed', () {
      final path = writer.write([makeEvalSet()], tmpDir.path);
      final content = File(path).readAsStringSync();

      // Pretty-printed JSON has newlines and indentation
      expect(content, contains('\n'));
      expect(content, contains('  '));
    });

    test('overwrites existing file', () {
      writer.write([makeEvalSet(logDir: '/first')], tmpDir.path);
      final path = writer.write([makeEvalSet(logDir: '/second')], tmpDir.path);

      final content = File(path).readAsStringSync();
      expect(content, contains('/second'));
      expect(content, isNot(contains('/first')));
    });
  });
}
