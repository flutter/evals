import 'dart:io';

import 'package:dataset_config/dataset_config.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('convertYamlToObject()', () {
    test('converts YamlMap to Map', () {
      final yaml = loadYaml('key: value');
      final result = convertYamlToObject(yaml);
      expect(result, isA<Map<String, dynamic>>());
      expect(result['key'], equals('value'));
    });

    test('converts YamlList to List', () {
      final yaml = loadYaml('- item1\n- item2\n- item3');
      final result = convertYamlToObject(yaml);
      expect(result, isA<List>());
      expect(result, equals(['item1', 'item2', 'item3']));
    });

    test('converts nested YamlMap', () {
      final yaml = loadYaml('''
outer:
  inner:
    deep: value
''');
      final result = convertYamlToObject(yaml);
      expect(result['outer']['inner']['deep'], equals('value'));
    });

    test('preserves String primitive', () {
      final yaml = loadYaml('key: hello');
      final result = convertYamlToObject(yaml);
      expect(result['key'], isA<String>());
      expect(result['key'], equals('hello'));
    });

    test('preserves int primitive', () {
      final yaml = loadYaml('key: 42');
      final result = convertYamlToObject(yaml);
      expect(result['key'], equals(42));
    });

    test('preserves bool primitive', () {
      final yaml = loadYaml('key: true');
      final result = convertYamlToObject(yaml);
      expect(result['key'], equals(true));
    });

    test('handles null value', () {
      final yaml = loadYaml('key: null');
      final result = convertYamlToObject(yaml);
      expect(result['key'], isNull);
    });

    test('handles mixed nested structures', () {
      final yaml = loadYaml('''
map:
  list:
    - item1
    - nested:
        key: value
''');
      final result = convertYamlToObject(yaml);
      expect(result['map']['list'][0], equals('item1'));
      expect(result['map']['list'][1]['nested']['key'], equals('value'));
    });
  });

  group('readYamlFile()', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('yaml_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    // test('reads valid YAML file', () {
    //   final file = File('${tempDir.path}/test.yaml');
    //   file.writeAsStringSync('key: value');

    //   final result = readYamlFile(file.path);
    //   expect(result, isNotNull);
    //   expect(result['key'], equals('value'));
    // });

    test('throws RunnerConfigException for non-existent file', () {
      expect(
        () => readYamlFile('${tempDir.path}/nonexistent.yaml'),
        throwsA(isA<ConfigException>()),
      );
    });

    //     test('reads complex YAML structure', () {
    //       final file = File('${tempDir.path}/complex.yaml');
    //       file.writeAsStringSync('''
    // name: test
    // items:
    //   - one
    //   - two
    // config:
    //   enabled: true
    // ''');

    //       final result = readYamlFile(file.path);
    //       expect(result['name'], equals('test'));
    //       expect(result['items'], hasLength(2));
    //       expect(result['config']['enabled'], isTrue);
    //     });
  });

  group('readYamlFileAsMap()', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('yaml_map_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('returns standard Dart Map from YAML', () {
      final file = File('${tempDir.path}/test.yaml');
      file.writeAsStringSync('key: value');

      final result = readYamlFileAsMap(file.path);
      expect(result, isA<Map<String, dynamic>>());
      expect(result['key'], equals('value'));
    });

    test('returns empty map for YAML with list root', () {
      final file = File('${tempDir.path}/list.yaml');
      file.writeAsStringSync('- item1\n- item2');

      final result = readYamlFileAsMap(file.path);
      expect(result, equals(<String, dynamic>{}));
    });

    test('converts nested YamlMaps to Maps', () {
      final file = File('${tempDir.path}/nested.yaml');
      file.writeAsStringSync('''
outer:
  inner: value
''');

      final result = readYamlFileAsMap(file.path);
      expect(result['outer'], isA<Map<String, dynamic>>());
    });
  });
}
