@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:devals_sandbox/sandbox.dart';

/// These tests require Docker to be running.
/// Run with: dart test test/docker_sandbox_integration_test.dart
void main() {
  late DockerSandboxManager manager;

  setUpAll(() async {
    // Skip if Docker isn't available
    try {
      final result = await Process.run('docker', ['version']);
      if (result.exitCode != 0) {
        markTestSkipped('Docker is not available');
      }
    } catch (_) {
      markTestSkipped('Docker is not installed');
    }

    manager = DockerSandboxManager();
  });

  group('DockerSandboxManager integration', () {
    test(
      'full lifecycle: createSession, exec, write/read file, dispose',
      () async {
        const evalName = 'integration_test';

        // Create session
        final session = await manager.createSession(
          evalName,
          evalId: 'test-eval-1',
          epoch: 1,
        );

        expect(session.environments, isNotEmpty);
        expect(session.isDisposed, isFalse);

        final sandbox = session.sandbox;

        // exec: run a simple command
        final echoResult = await sandbox.exec(['echo', 'hello world']);
        expect(echoResult.success, isTrue);
        expect(echoResult.stdout.trim(), equals('hello world'));

        // exec: command with non-zero exit
        final failResult = await sandbox.exec(['sh', '-c', 'exit 42']);
        expect(failResult.success, isFalse);
        expect(failResult.exitCode, equals(42));

        // writeFile + readFile (text)
        await sandbox.writeFile('/tmp/test.txt', 'Hello from Dart!');
        final content = await sandbox.readFile('/tmp/test.txt');
        expect(content, equals('Hello from Dart!'));

        // writeFile + readFile (nested directory)
        await sandbox.writeFile('/tmp/deep/nested/dir/data.txt', 'nested data');
        final nestedContent = await sandbox.readFile(
          '/tmp/deep/nested/dir/data.txt',
        );
        expect(nestedContent, equals('nested data'));

        // writeFileBytes + readFileBytes (binary)
        final bytes = [0, 1, 2, 255, 128, 64];
        await sandbox.writeFileBytes('/tmp/binary.bin', bytes);
        final readBytes = await sandbox.readFileBytes('/tmp/binary.bin');
        expect(readBytes, equals(bytes));

        // readFile: missing file throws FileNotFoundException
        expect(
          () => sandbox.readFile('/nonexistent/file.txt'),
          throwsA(isA<FileNotFoundException>()),
        );

        // Dispose session
        await session.dispose();
        expect(session.isDisposed, isTrue);
      },
      timeout: Timeout(Duration(minutes: 5)),
    );

    test('per-eval file provisioning', () async {
      const evalName = 'file_provision_test';

      final session = await manager.createSession(
        evalName,
        evalId: 'provision-test',
        files: {
          '/tmp/inline.txt': 'inline content',
          '/tmp/data/config.json': '{"key": "value"}',
        },
      );

      final sandbox = session.sandbox;

      final inlineContent = await sandbox.readFile('/tmp/inline.txt');
      expect(inlineContent, equals('inline content'));

      final jsonContent = await sandbox.readFile('/tmp/data/config.json');
      expect(jsonContent, equals('{"key": "value"}'));

      await session.dispose();
    }, timeout: Timeout(Duration(minutes: 5)));

    test('setup script execution', () async {
      const evalName = 'setup_script_test';

      final session = await manager.createSession(
        evalName,
        evalId: 'setup-test',
        setupScript: 'echo "setup done" > /tmp/setup_marker.txt',
      );

      final sandbox = session.sandbox;

      final markerContent = await sandbox.readFile('/tmp/setup_marker.txt');
      expect(markerContent.trim(), equals('setup done'));

      await session.dispose();
    }, timeout: Timeout(Duration(minutes: 5)));

    test('dispose is idempotent', () async {
      final session = await manager.createSession(
        'idem_test',
        evalId: 'idem',
      );

      await session.dispose();
      // Should not throw
      await session.dispose();
      expect(session.isDisposed, isTrue);
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}

void markTestSkipped(String reason) {
  // This is a workaround — dart test doesn't have a built-in skip mechanism
  // for setUp. Tests themselves will just fail with a clear message.
  print('SKIPPING: $reason');
}
