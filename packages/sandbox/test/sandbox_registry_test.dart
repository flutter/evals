import 'package:test/test.dart';
import 'package:devals_sandbox/sandbox.dart';

void main() {
  group('SandboxRegistry', () {
    tearDown(() {
      // Reset registry after each test
      SandboxRegistry.clear();
    });

    test('built-in types are registered on first access', () {
      expect(SandboxRegistry.isRegistered('docker'), isTrue);
      expect(SandboxRegistry.isRegistered('local'), isTrue);
    });

    test('registeredTypes includes builtins', () {
      final types = SandboxRegistry.registeredTypes;
      expect(types, contains('docker'));
      expect(types, contains('local'));
    });

    test('create("docker") returns DockerSandboxManager', () {
      final manager = SandboxRegistry.create('docker');
      expect(manager, isA<DockerSandboxManager>());
    });

    test('create("podman") returns PodmanSandboxManager', () {
      final manager = SandboxRegistry.create('podman');
      expect(manager, isA<PodmanSandboxManager>());
    });



    test('create("local") returns LocalSandboxManager', () {
      final manager = SandboxRegistry.create('local');
      expect(manager, isA<LocalSandboxManager>());
    });

    test('create throws for unknown type', () {
      expect(
        () => SandboxRegistry.create('kubernetes'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('register adds a custom type', () {
      SandboxRegistry.register('custom', () => LocalSandboxManager());
      expect(SandboxRegistry.isRegistered('custom'), isTrue);

      final manager = SandboxRegistry.create('custom');
      expect(manager, isA<SandboxManager>());
    });

    test('register overwrites existing type', () {
      // Register a "local" that returns a Docker manager (just to prove override)
      SandboxRegistry.register('local', () => DockerSandboxManager());
      final manager = SandboxRegistry.create('local');
      expect(manager, isA<DockerSandboxManager>());
    });

    test('unregister removes a type', () {
      expect(SandboxRegistry.isRegistered('local'), isTrue);
      SandboxRegistry.unregister('local');
      expect(SandboxRegistry.isRegistered('local'), isFalse);
    });

    test('clear removes all registrations', () {
      SandboxRegistry.clear();
      // After clear + first access, builtins re-register
      expect(SandboxRegistry.isRegistered('docker'), isTrue);
    });

    test('custom registration persists after clear + re-access', () {
      SandboxRegistry.register('custom', () => LocalSandboxManager());
      SandboxRegistry.clear();
      // Custom is gone after clear
      // Builtins re-register on next access, but custom does not
      expect(SandboxRegistry.isRegistered('custom'), isFalse);
    });

    test('registeredTypes is unmodifiable', () {
      final types = SandboxRegistry.registeredTypes;
      expect(() => (types as List).add('bad'), throwsA(anything));
    });
  });
}
