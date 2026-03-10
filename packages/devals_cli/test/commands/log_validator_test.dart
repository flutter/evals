import 'dart:io';

import 'package:devals/src/gcs/log_validator.dart';
import 'package:test/test.dart';

void main() {
  late Directory tmpDir;

  setUp(() {
    tmpDir = Directory.systemTemp.createTempSync('log_validator_test_');
  });

  tearDown(() {
    tmpDir.deleteSync(recursive: true);
  });

  File writeFile(String name, String content) {
    final file = File('${tmpDir.path}/$name');
    file.writeAsStringSync(content);
    return file;
  }

  // A minimal valid Inspect log header.
  const validHead = '''
{
  "version": 2,
  "status": "success",
  "eval": {
    "task": "my_task:baseline",
    "task_id": "abc123"
  },
  "plan": {},
  "results": {},
  "stats": {},
  "samples": []
}''';

  group('validateInspectLog (file-based)', () {
    test('accepts a valid Inspect log file', () async {
      final file = writeFile('valid.json', validHead);
      final result = await validateInspectLog(file);
      expect(result.isValid, isTrue);
      expect(result.reason, isNull);
    });

    test('rejects a non-.json file', () async {
      final file = writeFile('data.csv', validHead);
      final result = await validateInspectLog(file);
      expect(result.isValid, isFalse);
      expect(result.reason, contains('.json'));
    });

    test('rejects an empty file', () async {
      final file = writeFile('empty.json', '');
      final result = await validateInspectLog(file);
      expect(result.isValid, isFalse);
      expect(result.reason, contains('empty'));
    });
  });

  group('validateHead (string-based)', () {
    test('accepts a valid Inspect log head', () {
      final result = validateHead(validHead);
      expect(result.isValid, isTrue);
    });

    test('rejects non-JSON content', () {
      final result = validateHead('this is not json');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('not a JSON object'));
    });

    test('rejects a JSON array', () {
      final result = validateHead('[1, 2, 3]');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('not a JSON object'));
    });

    test('rejects JSON missing "version"', () {
      final result = validateHead('''
{
  "status": "success",
  "eval": { "task": "my_task" }
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('version'));
    });

    test('rejects JSON where "version" is a string', () {
      final result = validateHead('''
{
  "version": "2",
  "status": "success",
  "eval": { "task": "my_task" }
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('version'));
    });

    test('rejects JSON missing "status"', () {
      final result = validateHead('''
{
  "version": 2,
  "eval": { "task": "my_task" }
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('status'));
    });

    test('rejects JSON missing "eval" object', () {
      final result = validateHead('''
{
  "version": 2,
  "status": "success"
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('eval'));
    });

    test('rejects JSON where "eval" is not an object', () {
      final result = validateHead('''
{
  "version": 2,
  "status": "success",
  "eval": "not_an_object"
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('eval'));
    });

    test('rejects JSON missing "eval.task"', () {
      final result = validateHead('''
{
  "version": 2,
  "status": "success",
  "eval": { "run_id": "abc" }
}''');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('eval.task'));
    });

    test('rejects a random JSON object', () {
      final result = validateHead('{"name": "foo", "count": 42}');
      expect(result.isValid, isFalse);
      expect(result.reason, contains('version'));
    });

    test('accepts version 1 format', () {
      final result = validateHead('''
{
  "version": 1,
  "status": "error",
  "eval": { "task": "some_eval:variant" }
}''');
      expect(result.isValid, isTrue);
    });

    test('accepts with leading whitespace', () {
      final result = validateHead('''
  {
    "version": 2,
    "status": "success",
    "eval": { "task": "my_task:baseline" }
  }''');
      expect(result.isValid, isTrue);
    });
  });
}
