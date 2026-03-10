import 'dart:io';
import 'package:yaml/yaml.dart';

class FixtureSample {
  final String id;
  final String input;
  final String target;
  final SampleMetadata metadata;

  FixtureSample({
    required this.id,
    required this.input,
    required this.target,
    required this.metadata,
  });

  factory FixtureSample.fromYaml(Map<dynamic, dynamic> yaml) {
    return FixtureSample(
      id: yaml['id'] as String,
      input: yaml['input'] as String,
      target: yaml['target'] as String,
      metadata: SampleMetadata.fromYaml(yaml['metadata'] as Map),
    );
  }
}

class SampleMetadata {
  final String? added;
  final String? tags;
  final String? difficulty;
  final String? estimatedLines;
  final List<String>? requiredWidgets;
  final String? testFile;

  SampleMetadata({
    this.added,
    this.tags,
    this.difficulty,
    this.estimatedLines,
    this.requiredWidgets,
    this.testFile,
  });

  factory SampleMetadata.fromYaml(Map<dynamic, dynamic> yaml) {
    return SampleMetadata(
      added: yaml['added']?.toString(),
      tags: yaml['tags']?.toString(),
      difficulty: yaml['difficulty']?.toString(),
      estimatedLines: yaml['estimated_lines']?.toString(),
      requiredWidgets: (yaml['required_widgets'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      testFile: yaml['test_file']?.toString(),
    );
  }
}

class FixtureDataset {
  final String name;
  final List<FixtureSample> samples;

  FixtureDataset({required this.name, required this.samples});
}

class FixturesParser {
  final String datasetsPath;

  FixturesParser({required this.datasetsPath});

  Future<Iterable<FixtureDataset>> parse() async {
    final datasets = <FixtureDataset>[];
    final dir = Directory(datasetsPath);
    if (!await dir.exists()) {
      throw FileSystemException('Datasets directory not found', datasetsPath);
    }

    await for (final entity in dir.list()) {
      if (entity is File &&
          (entity.path.endsWith('.yaml') || entity.path.endsWith('.yml'))) {
        final content = await entity.readAsString();
        final documents = loadYamlStream(content);
        final samples = <FixtureSample>[];
        for (final doc in documents) {
          if (doc is Map) {
            samples.add(FixtureSample.fromYaml(doc));
          }
        }

        // Extract filename without extension
        final filename = entity.uri.pathSegments.last;
        final name = filename.substring(0, filename.lastIndexOf('.'));

        datasets.add(FixtureDataset(name: name, samples: samples));
      }
    }
    return datasets;
  }
}
