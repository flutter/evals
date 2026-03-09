String getTestFile() {
  return '''
/// Tests added here will be copied into your workspace and run against
/// the workspace after code is generated.
///
/// These tests run IN ADDITION to any tests already present in the
/// workspace project (e.g., tests in the git repo or local path project).
///
/// Write your test cases below.
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests', () {
    test('run', () {
      // Write tests
    });
  });
''';
}
