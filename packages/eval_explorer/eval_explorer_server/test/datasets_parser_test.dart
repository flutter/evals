import 'package:eval_explorer_server/src/business/fixtures/fixtures_parser.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Parses datasets correctly', () async {
    // Correctly locating the datasets folder relative to the test file
    // Assuming the test file is in eval_explorer_server/test/
    // and datasets are in datasets/ (relative to the repo root)
    final rootDir = Directory.current.parent.parent;
    final datasetsPath = p.join(rootDir.path, 'datasets');

    // Fallback: If running from within the server package directly
    final serverDir = Directory.current;
    final fallbackDatasetsPath = p.join(
      serverDir.parent.parent.path,
      'datasets',
    );

    String validPath = datasetsPath;
    if (!await Directory(datasetsPath).exists()) {
      if (await Directory(fallbackDatasetsPath).exists()) {
        validPath = fallbackDatasetsPath;
      } else {
        // Try one more common setup: workspace root
        // If we are in /.../eval_explorer_server
        validPath = p.join(serverDir.path, '../../../datasets');
      }
    }

    final parser = FixturesParser(datasetsPath: validPath);
    final datasets = (await parser.parse()).toList();

    expect(datasets, isNotEmpty);

    // Check for dart_qa_dataset
    final dartDataset = datasets.firstWhere((d) => d.name == 'dart_qa_dataset');
    expect(dartDataset.samples, isNotEmpty);

    final dartSample = dartDataset.samples.firstWhere(
      (s) => s.id == 'dart_futures_vs_streams',
    );
    expect(dartSample.input, contains('Futures and Streams'));
    expect(dartSample.metadata.tags, contains('dart'));
    expect(dartSample.metadata.added, isNotNull);

    // Check for dart_qa_dataset
    final dartQADataset = datasets.firstWhere((d) {
      return d.name == 'dart_qa_dataset';
    });
    expect(dartQADataset.samples, isNotEmpty);

    final dartQAConstConstructorSample = dartQADataset.samples.firstWhere(
      (s) => s.id == 'dart_const_constructor',
    );
    expect(
      dartQAConstConstructorSample.input,
      contains('trying to use const to create a constant'),
    );
    expect(dartSample.metadata.tags, contains('dart'));
  }, skip: true);
}
