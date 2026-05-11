import 'dart:io';

import 'package:test/test.dart';
import 'package:devals_sandbox/sandbox.dart';

void main() {
  group('LocalSandboxEnvironment', () {
    late LocalSandboxEnvironment sandbox;

    setUp(() async {
      sandbox = await LocalSandboxEnvironment.create();
    });

    tearDown(() async {
      await sandbox.cleanup();
    });

    test('creates a temp directory', () {
      expect(sandbox.directory.existsSync(), isTrue);
    });

    test('exec: echo command', () async {
      final result = await sandbox.exec(['echo', 'hello world']);
      expect(result.success, isTrue);
      expect(result.stdout.trim(), equals('hello world'));
    });

    test('exec: non-zero exit code', () async {
      final result = await sandbox.exec(['sh', '-c', 'exit 42']);
      expect(result.success, isFalse);
      expect(result.exitCode, equals(42));
    });

    test('exec: captures stderr', () async {
      final result = await sandbox.exec([
        'sh',
        '-c',
        'echo "err msg" >&2; exit 1',
      ]);
      expect(result.success, isFalse);
      expect(result.stderr.trim(), equals('err msg'));
    });

    test('exec: stdin input', () async {
      final result = await sandbox.exec(['cat'], input: 'hello from stdin');
      expect(result.success, isTrue);
      expect(result.stdout, equals('hello from stdin'));
    });

    test('exec: cwd relative to sandbox dir', () async {
      // Create a subdirectory
      final subdir = Directory('${sandbox.directory.path}/subdir');
      await subdir.create();
      await File('${subdir.path}/marker.txt').writeAsString('found');

      final result = await sandbox.exec(['cat', 'marker.txt'], cwd: 'subdir');
      expect(result.success, isTrue);
      expect(result.stdout, equals('found'));
    });

    test('exec: env variables', () async {
      final result = await sandbox.exec(
        ['sh', '-c', 'echo \$MY_VAR'],
        env: {'MY_VAR': 'test_value'},
      );
      expect(result.success, isTrue);
      expect(result.stdout.trim(), equals('test_value'));
    });

    test('exec: user parameter logs warning but works', () async {
      // Should not throw, just warn
      final result = await sandbox.exec(['echo', 'ok'], user: 'root');
      expect(result.success, isTrue);
    });

    test('writeFile + readFile: text', () async {
      await sandbox.writeFile('test.txt', 'Hello, World!');
      final content = await sandbox.readFile('test.txt');
      expect(content, equals('Hello, World!'));
    });

    test('writeFile + readFile: nested directory', () async {
      await sandbox.writeFile('a/b/c/deep.txt', 'deep content');
      final content = await sandbox.readFile('a/b/c/deep.txt');
      expect(content, equals('deep content'));
    });

    test('writeFileBytes + readFileBytes: binary', () async {
      final bytes = [0, 1, 2, 128, 255];
      await sandbox.writeFileBytes('binary.bin', bytes);
      final readBytes = await sandbox.readFileBytes('binary.bin');
      expect(readBytes, equals(bytes));
    });

    test('fileExists: returns true for existing file', () async {
      await sandbox.writeFile('exists.txt', 'data');
      expect(await sandbox.fileExists('exists.txt'), isTrue);
    });

    test('fileExists: returns false for missing file', () async {
      expect(await sandbox.fileExists('missing.txt'), isFalse);
    });

    test('listDirectory: lists entries', () async {
      await sandbox.writeFile('a.txt', 'a');
      await sandbox.writeFile('b.txt', 'b');
      await sandbox.writeFile('sub/c.txt', 'c');
      final entries = await sandbox.listDirectory('.');
      expect(entries, containsAll(['a.txt', 'b.txt', 'sub']));
    });

    test('listDirectory: throws for missing directory', () async {
      expect(
        () => sandbox.listDirectory('nonexistent'),
        throwsA(isA<SandboxException>()),
      );
    });

    test('deleteFile: deletes a file', () async {
      await sandbox.writeFile('to_delete.txt', 'data');
      expect(await sandbox.fileExists('to_delete.txt'), isTrue);
      await sandbox.deleteFile('to_delete.txt');
      expect(await sandbox.fileExists('to_delete.txt'), isFalse);
    });

    test('deleteFile: throws for missing file', () async {
      expect(
        () => sandbox.deleteFile('nonexistent.txt'),
        throwsA(isA<FileNotFoundException>()),
      );
    });

    test('deleteFile: recursive deletes directory', () async {
      await sandbox.writeFile('dir/a.txt', 'a');
      await sandbox.writeFile('dir/b.txt', 'b');
      await sandbox.deleteFile('dir', recursive: true);
      expect(await sandbox.fileExists('dir'), isFalse);
    });

    test('writeFile: absolute path', () async {
      final absPath = '${sandbox.directory.path}/abs_test.txt';
      await sandbox.writeFile(absPath, 'absolute');
      final content = await sandbox.readFile(absPath);
      expect(content, equals('absolute'));
    });

    test('readFile: missing file throws FileNotFoundException', () async {
      expect(
        () => sandbox.readFile('nonexistent.txt'),
        throwsA(isA<FileNotFoundException>()),
      );
    });

    test('readFileBytes: missing file throws FileNotFoundException', () async {
      expect(
        () => sandbox.readFileBytes('nonexistent.txt'),
        throwsA(isA<FileNotFoundException>()),
      );
    });

    test('cleanup deletes the directory', () async {
      final path = sandbox.directory.path;
      expect(Directory(path).existsSync(), isTrue);
      await sandbox.cleanup();
      expect(Directory(path).existsSync(), isFalse);
    });

    test('dispose delegates to cleanup', () async {
      final path = sandbox.directory.path;
      expect(Directory(path).existsSync(), isTrue);
      await sandbox.dispose();
      expect(Directory(path).existsSync(), isFalse);
    });
  });

  group('LocalSandboxManager', () {
    late LocalSandboxManager manager;

    setUp(() {
      manager = LocalSandboxManager();
    });

    test('warmUp is a no-op', () async {
      // Should not throw
      await manager.warmUp('test_eval');
    });

    test('createSession creates a session with an environment', () async {
      final session = await manager.createSession('test_eval', evalId: 'e1');
      expect(session.sandbox, isA<LocalSandboxEnvironment>());
      expect(session.environments, hasLength(1));
      expect(session.environments.containsKey('default'), isTrue);
      expect(session.isDisposed, isFalse);

      await session.dispose();
      expect(session.isDisposed, isTrue);
    });

    test('createSession provisions files', () async {
      final session = await manager.createSession(
        'test_eval',
        evalId: 'file-test',
        files: {'hello.txt': 'Hello!', 'data/config.json': '{"a": 1}'},
      );

      expect(await session.sandbox.readFile('hello.txt'), equals('Hello!'));
      expect(
        await session.sandbox.readFile('data/config.json'),
        equals('{"a": 1}'),
      );

      await session.dispose();
    });

    test('createSession runs setup script', () async {
      final session = await manager.createSession(
        'test_eval',
        evalId: 'setup-test',
        setupScript: 'echo "setup ran" > marker.txt',
      );

      final content = await session.sandbox.readFile('marker.txt');
      expect(content.trim(), equals('setup ran'));

      await session.dispose();
    });

    test('dispose removes temp directory', () async {
      final session = await manager.createSession(
        'test_eval',
        evalId: 'cleanup',
      );
      final sandbox = session.sandbox as LocalSandboxEnvironment;
      final dirPath = sandbox.directory.path;

      expect(Directory(dirPath).existsSync(), isTrue);
      await session.dispose();
      expect(Directory(dirPath).existsSync(), isFalse);
    });

    test('multiple sessions are independent', () async {
      final session1 = await manager.createSession('test', evalId: 'a');
      final session2 = await manager.createSession('test', evalId: 'b');
      final dir1 =
          (session1.sandbox as LocalSandboxEnvironment).directory.path;
      final dir2 =
          (session2.sandbox as LocalSandboxEnvironment).directory.path;

      // Disposing one doesn't affect the other
      await session1.dispose();
      expect(Directory(dir1).existsSync(), isFalse);
      expect(Directory(dir2).existsSync(), isTrue);

      await session2.dispose();
      expect(Directory(dir2).existsSync(), isFalse);
    });

    test('file key with service prefix strips prefix', () async {
      final session = await manager.createSession(
        'test_eval',
        evalId: 'prefix-test',
        files: {'myservice:data.txt': 'prefixed content'},
      );

      expect(
        await session.sandbox.readFile('data.txt'),
        equals('prefixed content'),
      );

      await session.dispose();
    });

    test('dispose is idempotent', () async {
      final session = await manager.createSession('test_eval', evalId: 'idem');
      await session.dispose();
      // Second dispose should not throw
      await session.dispose();
      expect(session.isDisposed, isTrue);
    });
  });

  group('SandboxManager interface', () {
    test('LocalSandboxManager implements SandboxManager', () {
      final manager = LocalSandboxManager();
      expect(manager, isA<SandboxManager>());
    });

    test('DockerSandboxManager implements SandboxManager', () {
      final manager = DockerSandboxManager();
      expect(manager, isA<SandboxManager>());
    });
  });
}
