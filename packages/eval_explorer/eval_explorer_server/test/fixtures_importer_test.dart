import 'package:eval_explorer_server/src/business/fixtures/fixtures_importer.dart';
import 'package:eval_explorer_server/src/business/fixtures/fixtures_parser.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  late InMemoryFixturesImporter importer;

  setUp(() {
    importer = InMemoryFixturesImporter();
  });

  group('InMemoryFixturesImporter', () {
    test('initially empty', () {
      expect(importer.datasets, isEmpty);
      expect(importer.samples, isEmpty);
    });

    test('import creates new dataset and samples', () async {
      final dataset = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1',
            target: 'target1',
            metadata: SampleMetadata(),
          ),
          FixtureSample(
            id: 'sample2',
            input: 'input2',
            target: 'target2',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset]);

      expect(importer.datasets, hasLength(1));
      expect(importer.datasets.values.first.name, 'test_dataset');
      expect(importer.datasets.values.first.isActive, isTrue);

      expect(importer.samples, hasLength(2));
      expect(importer.samples.values.any((s) => s.name == 'sample1'), isTrue);
      expect(importer.samples.values.any((s) => s.name == 'sample2'), isTrue);
      expect(importer.samples.values.first.isActive, isTrue);
    });

    test('import updates existing samples', () async {
      final dataset1 = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1',
            target: 'target1',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset1]);

      final dataset2 = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1_modified',
            target: 'target1_modified',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset2]);

      expect(importer.samples, hasLength(1));

      final sample = importer.samples.values.first;
      expect(sample.input, 'input1_modified');
      expect(sample.target, 'target1_modified');
    });

    test('import deactivates missing samples in existing dataset', () async {
      // First import: 2 samples
      final dataset1 = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1',
            target: 'target1',
            metadata: SampleMetadata(),
          ),
          FixtureSample(
            id: 'sample2',
            input: 'input2',
            target: 'target2',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset1]);
      expect(importer.samples.values.where((s) => s.isActive), hasLength(2));

      // Second import: only sample1
      final dataset2 = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1',
            target: 'target1',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset2]);

      expect(importer.samples, hasLength(2)); // Total still 2
      final activeSamples = importer.samples.values
          .where((s) => s.isActive)
          .toList();
      final inactiveSamples = importer.samples.values
          .where((s) => !s.isActive)
          .toList();

      expect(activeSamples, hasLength(1));
      expect(activeSamples.first.name, 'sample1');

      expect(inactiveSamples, hasLength(1));
      expect(inactiveSamples.first.name, 'sample2');
    });

    test('import deactivates missing datasets', () async {
      // First import: 2 datasets
      final dataset1 = FixtureDataset(
        name: 'dataset1',
        samples: [],
      );
      final dataset2 = FixtureDataset(
        name: 'dataset2',
        samples: [],
      );

      await importer.import([dataset1, dataset2]);
      expect(importer.datasets.values.where((d) => d.isActive), hasLength(2));

      // Second import: only dataset1
      await importer.import([dataset1]);

      expect(importer.datasets, hasLength(2));
      final activeDatasets = importer.datasets.values
          .where((d) => d.isActive)
          .toList();
      final inactiveDatasets = importer.datasets.values
          .where((d) => !d.isActive)
          .toList();

      expect(activeDatasets, hasLength(1));
      expect(activeDatasets.first.name, 'dataset1');

      expect(inactiveDatasets, hasLength(1));
      expect(inactiveDatasets.first.name, 'dataset2');
    });

    test('generates valid uuids', () async {
      final dataset = FixtureDataset(
        name: 'test_dataset',
        samples: [
          FixtureSample(
            id: 'sample1',
            input: 'input1',
            target: 'target1',
            metadata: SampleMetadata(),
          ),
        ],
      );

      await importer.import([dataset]);

      expect(importer.datasets.values.first.id, isNotNull);
      expect(importer.samples.values.first.id, isNotNull);
      expect(importer.datasets.values.first.id, isA<UuidValue>());
      expect(importer.samples.values.first.id, isA<UuidValue>());
    });
  });
}
