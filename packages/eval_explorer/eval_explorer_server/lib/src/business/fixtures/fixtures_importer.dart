import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:eval_explorer_server/src/business/controllers/controllers.dart';
import 'package:eval_explorer_server/src/business/utils.dart';
import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import 'fixtures_parser.dart';

final greenText = AnsiPen()..green(bold: true);
final redText = AnsiPen()..red(bold: true);

abstract class FixturesImporter {
  Future<void> import(
    Iterable<FixtureDataset> datasets, {
    bool verbose = false,
  }) async {
    // All of the datasets defined in the fixture files, used to delete
    // deprecated / removed datasets.
    final fixtureDatasetNames = <String>{};
    List<Dataset> updatedDatasets = [];
    List<Dataset> createdDatasets = [];

    for (final fixtureDataset in datasets) {
      fixtureDatasetNames.add(fixtureDataset.name);

      // Look for the existing row
      Dataset? dataset = await getDatasetByName(fixtureDataset.name);

      if (dataset == null) {
        // If not found, create it
        dataset = await createDataset(
          Dataset(
            name: fixtureDataset.name,
          ),
        );
        createdDatasets.add(dataset);
      } else {
        final updateResult = await updateDataset(dataset, fixtureDataset);
        dataset = updateResult.$1;
        if (updateResult.$2) {
          updatedDatasets.add(updateResult.$1);
        }
      }

      // All of the samples defined in the fixture files, used to delete
      // deprecated / removed samples.
      final fixtureSampleNames = <String>{};
      List<Sample> updatedSamples = [];
      List<Sample> createdSamples = [];

      // Now that we have the dataset, we can import the evals
      for (final fixtureSample in fixtureDataset.samples) {
        final tagNames = fixtureSample.metadata.tags != null
            ? fixtureSample.metadata.tags!
                  .split(',')
                  .map((s) => s.trim())
                  .toList()
            : <String>[];

        // In the YAML files, "id" is a human readable slug
        fixtureSampleNames.add(fixtureSample.id);

        final existingSample = await getSampleByName(
          fixtureSample.id, // human readable slug
          dataset.id!.toString(), // actual database Uuid.v7
        );

        if (existingSample != null) {
          final updateResult = await updateSample(
            existingSample,
            fixtureSample,
            tagNames: tagNames,
          );
          if (updateResult.$2) {
            updatedSamples.add(updateResult.$1);
          }
        } else {
          final creationResult = await createSample(
            Sample(
              datasetId: dataset.id!,
              name: fixtureSample.id,
              input: fixtureSample.input,
              target: fixtureSample.target,
            ),
            tagNames: tagNames,
          );
          createdSamples.add(creationResult.$1);
        }
      }

      // Now remove any samples that are no longer in the fixture files
      final deactivatedSamples = await deactivateSamples(
        datasetId: dataset.id!.toString(),
        namesToSave: fixtureSampleNames,
      );

      if (verbose) {
        if (createdSamples.isNotEmpty) {
          stdout.writeln(
            greenText(
              'Created samples from dataset ${dataset.name}: '
              '{${createdSamples.map((s) => s.name).join(', ')}}',
            ),
          );
        }
        if (updatedSamples.isNotEmpty) {
          stdout.writeln(
            greenText(
              'Updated samples from dataset ${dataset.name}: '
              '{${updatedSamples.map((s) => s.name).join(', ')}}',
            ),
          );
        }
        if (deactivatedSamples.isNotEmpty) {
          stdout.writeln(
            redText(
              'Deactivated samples from dataset ${dataset.name}: '
              '{${deactivatedSamples.map((s) => s.name).join(', ')}}',
            ),
          );
        }
        if (updatedSamples.isEmpty && deactivatedSamples.isEmpty) {
          stdout.writeln('No changes to existing samples for ${dataset.name}');
        }
      }
    }

    final deactivatedDatasets = await deactivateDatasets(
      namesToSave: fixtureDatasetNames,
    );

    if (verbose) {
      if (createdDatasets.isNotEmpty) {
        stdout.writeln(
          greenText(
            'Created datasets: '
            '{${createdDatasets.map((s) => s.name).join(', ')}}',
          ),
        );
      }
      if (updatedDatasets.isNotEmpty) {
        stdout.writeln(
          greenText(
            'Updated datasets: '
            '{${updatedDatasets.map((s) => s.name).join(', ')}}',
          ),
        );
      }
      if (deactivatedDatasets.isNotEmpty) {
        stdout.writeln(
          redText(
            'Deactivated datasets: '
            '{${deactivatedDatasets.map((d) => d.name).join(', ')}}',
          ),
        );
      }
      if (updatedDatasets.isEmpty && deactivatedDatasets.isEmpty) {
        stdout.writeln('No changes to existing datasets');
      }
    }
  }

  /// Load a dataset by its `name` column.
  Future<Dataset?> getDatasetByName(String name);

  /// Create a new dataset.
  Future<Dataset> createDataset(Dataset dataset);

  /// Update an existing dataset against the latest fixture values. Returns
  /// a tuple of the updated dataset and a boolean indicating whether the
  /// dataset was modified by the update.
  Future<(Dataset, bool)> updateDataset(
    Dataset dataset,
    FixtureDataset fixtureDataset,
  );

  /// Load a sample by its `name` column.
  Future<Sample?> getSampleByName(String name, String datasetId);

  /// Create a new sample.
  Future<(Sample, XrefModification)> createSample(
    Sample sample, {
    required List<String> tagNames,
  });

  /// Update an existing sample against the latest fixture values. Returns
  /// a tuple of the updated sample and a boolean indicating whether the sample
  /// was modified by the update.
  Future<(Sample, bool, XrefModification)> updateSample(
    Sample sample,
    FixtureSample fixtureSample, {
    required List<String> tagNames,
  });

  /// Deactivate datasets satisfying the conditions.
  Future<List<Dataset>> deactivateDatasets({
    required Set<String> namesToSave,
  });

  /// Deactivate samples satisfying the conditions.
  Future<List<Sample>> deactivateSamples({
    required String datasetId,
    required Set<String> namesToSave,
  });
}

class DatabaseFixturesImporter extends FixturesImporter {
  DatabaseFixturesImporter({required this.session})
    : _samplesController = SamplesController(session),
      _tagsController = TagsController(session);

  final Session session;

  final SamplesController _samplesController;
  final TagsController _tagsController;

  @override
  Future<Dataset?> getDatasetByName(String name) async =>
      Dataset.db.findFirstRow(
        session,
        where: (t) => t.name.equals(name),
      );

  @override
  Future<Dataset> createDataset(Dataset dataset) {
    assert(dataset.id == null, 'Dataset.id must be null when creating');
    return Dataset.db.insertRow(session, dataset);
  }

  @override
  Future<(Dataset, bool)> updateDataset(
    Dataset dataset,
    FixtureDataset fixtureDataset,
  ) async {
    assert(dataset.id != null, 'Dataset.id must not be null when updating');

    bool isUpdated = false;
    if (dataset.name != fixtureDataset.name) {
      dataset.name = fixtureDataset.name;
      isUpdated = true;
    }
    if (dataset.isActive == false) {
      dataset.isActive = true;
      isUpdated = true;
    }
    return (await Dataset.db.updateRow(session, dataset), isUpdated);
  }

  @override
  Future<Sample?> getSampleByName(String name, String datasetId) async =>
      //
      Sample.db.findFirstRow(
        session,
        where: (t) =>
            t.name.equals(name) &
            t.datasetId.equals(UuidValue.fromString(datasetId)),
      );

  @override
  Future<(Sample, XrefModification)> createSample(
    Sample sample, {
    required List<String> tagNames,
  }) async {
    final savedSample = await _samplesController.create(sample);
    final tags = await _tagsController.createMissingFromNames(tagNames);
    final tagsDelta = await _tagsController.linkToSample(savedSample, tags);
    return (savedSample, tagsDelta);
  }

  @override
  Future<(Sample, bool, XrefModification)> updateSample(
    Sample sample,
    FixtureSample fixtureSample, {
    required List<String> tagNames,
  }) async {
    assert(sample.id != null, 'Sample.id must not be null when updating');
    bool isUpdated = false;
    if (sample.name != fixtureSample.id) {
      sample.name = fixtureSample.id;
      isUpdated = true;
    }
    if (sample.input != fixtureSample.input) {
      sample.input = fixtureSample.input;
      isUpdated = true;
    }
    if (sample.target != fixtureSample.target) {
      sample.target = fixtureSample.target;
      isUpdated = true;
    }
    if (!sample.isActive) {
      sample.isActive = true;
      isUpdated = true;
    }

    final tags = await _tagsController.createMissingFromNames(tagNames);
    final tagsDelta = await _tagsController.linkToSample(sample, tags);

    return (await Sample.db.updateRow(session, sample), isUpdated, tagsDelta);
  }

  @override
  Future<List<Dataset>> deactivateDatasets({
    required Set<String> namesToSave,
  }) async {
    final datasetsToDeactivate = await Dataset.db.find(
      session,
      where: (t) => t.name.notInSet(namesToSave) & t.isActive.equals(true),
    );
    return Dataset.db.updateWhere(
      session,
      columnValues: (t) => [t.isActive(false)],
      where: (t) => t.id.inSet(
        // Only deactivate datasets that are active, so as to not continuously
        // report the same old info on every subsequent operation.
        datasetsToDeactivate.map((d) => d.id!).toSet(),
      ),
    );
  }

  @override
  Future<List<Sample>> deactivateSamples({
    required String datasetId,
    required Set<String> namesToSave,
  }) async {
    final samplesToDeactivate = await Sample.db.find(
      session,
      where: (t) =>
          t.datasetId.equals(UuidValue.fromString(datasetId)) &
          t.name.notInSet(namesToSave) &
          t.isActive.equals(true),
    );
    return Sample.db.updateWhere(
      session,
      columnValues: (t) => [t.isActive(false)],
      where: (t) => t.id.inSet(
        // Only deactivate samples that are active, so as to not continuously
        // report the same old info on every subsequent operation.
        samplesToDeactivate.map((s) => s.id!).toSet(),
      ),
    );
  }
}

/// Test-friendly implementation of [FixturesImporter] that stores datasets
/// in local memory. Useful to test all of the abstract [FixturesImporter],
/// including that the right CRUD methods are invoked. Of course, this does not
/// help with testing the database layer, as that would require integration
/// tests in CI.
class InMemoryFixturesImporter extends FixturesImporter {
  final datasets = <String, Dataset>{};
  final samples = <String, Sample>{};
  int _idCounter = 0;

  UuidValue _generateId() {
    _idCounter++;
    // format: 00000000-0000-0000-0000-000000000001
    final idStr = _idCounter.toString().padLeft(12, '0');
    return UuidValue.fromString('00000000-0000-0000-0000-$idStr');
  }

  @override
  Future<Dataset?> getDatasetByName(String name) async {
    return datasets.values.cast<Dataset?>().firstWhere(
      (d) => d!.name == name,
      orElse: () => null,
    );
  }

  @override
  Future<Dataset> createDataset(Dataset dataset) async {
    assert(dataset.id == null, 'Dataset.id must be null when creating');
    final newDataset = dataset.copyWith(id: _generateId());
    datasets[newDataset.id!.toString()] = newDataset;
    return newDataset;
  }

  @override
  Future<(Dataset, bool)> updateDataset(
    Dataset dataset,
    FixtureDataset fixtureDataset,
  ) async {
    assert(dataset.id != null, 'Dataset.id must not be null when updating');
    bool isUpdated = false;

    if (dataset.name != fixtureDataset.name) {
      dataset.name = fixtureDataset.name;
      isUpdated = true;
    }
    if (!dataset.isActive) {
      dataset.isActive = true;
      isUpdated = true;
    }
    datasets[dataset.id!.toString()] = dataset;
    return (dataset, isUpdated);
  }

  @override
  Future<Sample?> getSampleByName(String name, String datasetId) async {
    return samples.values.cast<Sample?>().firstWhere(
      (s) => s!.name == name && s.datasetId.toString() == datasetId,
      orElse: () => null,
    );
  }

  @override
  Future<(Sample, XrefModification)> createSample(
    Sample sample, {
    required List<String> tagNames,
  }) async {
    assert(sample.id == null, 'Sample.id must be null when creating');
    final newSample = sample.copyWith(id: _generateId());
    samples[newSample.id!.toString()] = newSample;
    return (newSample, XrefModification.zero);
  }

  @override
  Future<(Sample, bool, XrefModification)> updateSample(
    Sample sample,
    FixtureSample fixtureSample, {
    required List<String> tagNames,
  }) async {
    assert(sample.id != null, 'Sample.id must not be null when updating');
    bool isUpdated = false;
    if (sample.name != fixtureSample.id) {
      sample.name = fixtureSample.id;
      isUpdated = true;
    }
    if (sample.input != fixtureSample.input) {
      sample.input = fixtureSample.input;
      isUpdated = true;
    }
    if (sample.target != fixtureSample.target) {
      sample.target = fixtureSample.target;
      isUpdated = true;
    }
    if (!sample.isActive) {
      sample.isActive = true;
      isUpdated = true;
    }
    samples[sample.id!.toString()] = sample;
    return (sample, isUpdated, XrefModification.zero);
  }

  @override
  Future<List<Dataset>> deactivateDatasets({
    required Set<String> namesToSave,
  }) async {
    final deactivated = <Dataset>[];
    for (final id in datasets.keys) {
      final dataset = datasets[id]!;
      if (namesToSave.contains(dataset.name)) {
        continue;
      }
      if (dataset.isActive) {
        final updated = dataset.copyWith(isActive: false);
        datasets[id] = updated;
        deactivated.add(updated);
      }
    }
    return deactivated;
  }

  @override
  Future<List<Sample>> deactivateSamples({
    required String datasetId,
    required Set<String> namesToSave,
  }) async {
    final deactivated = <Sample>[];
    final dsId = UuidValue.fromString(datasetId);

    for (final id in samples.keys) {
      final sample = samples[id]!;
      if (sample.datasetId == dsId && !namesToSave.contains(sample.name)) {
        if (sample.isActive) {
          final updated = sample.copyWith(isActive: false);
          samples[id] = updated;
          deactivated.add(updated);
        }
      }
    }
    return deactivated;
  }
}
