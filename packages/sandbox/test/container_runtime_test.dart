import 'package:devals_sandbox/sandbox.dart';
import 'package:test/test.dart';

void main() {
  group('ComposeRunner', () {
    test('can be constructed with const', () {
      const runner = ComposeRunner();
      expect(runner, isA<ComposeRunner>());
    });
  });

  group('DockerSandboxManager', () {
    test('default construction succeeds', () {
      final manager = DockerSandboxManager();
      expect(manager, isA<SandboxManager>());
    });
  });

  group('PodmanSandboxManager', () {
    test('construction with required params succeeds', () {
      final manager = PodmanSandboxManager(
        dockerfilePath: 'docker/Dockerfile',
        buildContext: '.',
      );
      expect(manager, isA<SandboxManager>());
    });

    test('accepts optional parameters', () {
      final manager = PodmanSandboxManager(
        dockerfilePath: 'docker/Dockerfile',
        buildContext: '.',
        imageName: 'custom-image',
        workingDir: '/app',
        memLimit: '2g',
        cpuLimit: '1.0',
        defaultSetupScript: 'echo hello',
      );
      expect(manager, isA<SandboxManager>());
    });
  });
}
