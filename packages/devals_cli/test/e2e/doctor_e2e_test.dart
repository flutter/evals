@Tags(['e2e'])
library;

import 'package:test/test.dart';

import 'e2e_helpers.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = createTestDatasetDir();
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('devals doctor', () {
    test('runs and outputs check names', () async {
      final result = await runDevals(
        ['doctor'],
        workingDirectory: tempDir.path,
      );
      // Doctor may exit 0 or 1 depending on the host environment,
      // but it should always run and produce output.
      expect(result.exitCode, isIn([0, 1]));
      expect(result.stdout, contains('Dart SDK'));
      expect(result.stdout, contains('Python'));
    });
  });
}
