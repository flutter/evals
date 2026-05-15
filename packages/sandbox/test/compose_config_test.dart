import 'package:test/test.dart';
import 'package:devals_sandbox/sandbox.dart';

void main() {
  group('ComposeService', () {
    test('toMap includes only set fields', () {
      final service = ComposeService(
        image: 'python:3.12',
        init: true,
        command: 'tail -f /dev/null',
      );
      final map = service.toMap();
      expect(map['image'], equals('python:3.12'));
      expect(map['command'], equals('tail -f /dev/null'));
      expect(map['init'], isTrue);
      expect(map.containsKey('build'), isFalse);
      expect(map.containsKey('volumes'), isFalse);
      expect(map.containsKey('mem_limit'), isFalse);
    });

    test('toMap includes resource limits', () {
      final service = ComposeService(
        image: 'ubuntu:latest',
        cpus: 2.0,
        memLimit: '1gb',
        networkMode: 'none',
      );
      final map = service.toMap();
      expect(map['cpus'], equals(2.0));
      expect(map['mem_limit'], equals('1gb'));
      expect(map['network_mode'], equals('none'));
    });

    test('toMap includes extension fields', () {
      final service = ComposeService(
        image: 'my-image',
        extensions: {'x-local': true, 'x-default': true},
      );
      final map = service.toMap();
      expect(map['x-local'], isTrue);
      expect(map['x-default'], isTrue);
    });
  });

  group('ComposeConfig', () {
    test('defaultConfig has expected structure', () {
      final config = ComposeConfig.defaultConfig();
      expect(config.services, hasLength(1));
      expect(config.services.containsKey('default'), isTrue);

      final defaultService = config.services['default']!;
      expect(defaultService.image, equals('ghcr.io/cirruslabs/flutter:stable'));
      expect(defaultService.init, isTrue);
      expect(defaultService.command, equals('tail -f /dev/null'));
    });

    test('toYaml produces valid structure', () {
      final config = ComposeConfig(
        services: {
          'default': ComposeService(
            image: 'python:3.12',
            init: true,
            command: 'tail -f /dev/null',
          ),
        },
      );
      final yaml = config.toYaml();
      expect(yaml, contains('services:'));
      expect(yaml, contains('default:'));
      expect(yaml, contains('image:'));
      expect(yaml, contains('python:3.12'));
      expect(yaml, contains('init: true'));
    });

    test('toYaml with multiple services', () {
      final config = ComposeConfig(
        services: {
          'default': ComposeService(image: 'python:3.12', init: true),
          'worker': ComposeService(image: 'node:20', init: true),
        },
      );
      final yaml = config.toYaml();
      expect(yaml, contains('default:'));
      expect(yaml, contains('worker:'));
      expect(yaml, contains('python:3.12'));
      expect(yaml, contains('node:20'));
    });

    test('toMap includes volumes', () {
      final config = ComposeConfig(
        services: {'default': ComposeService(image: 'python:3.12')},
        volumes: {'data-vol': <String, Object>{}},
      );
      final map = config.toMap();
      expect(map.containsKey('volumes'), isTrue);
    });
  });
}
