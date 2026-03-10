@Tags(['integration'])
library;

import 'package:eval_explorer_server/src/business/controllers/controllers.dart'
    show SamplesController, TagsController;

import 'package:eval_explorer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test_tools/serverpod_test_tools.dart';

void main() {
  late SamplesController samplesController;
  late TagsController tagsController;
  late Session session;

  withServerpod(
    'TagsController.createMissingFromNames should',
    rollbackDatabase: RollbackDatabase.afterEach,
    (final sessionBuilder, final _) {
      setUp(() {
        session = sessionBuilder.build();
        samplesController = SamplesController(session);
        tagsController = TagsController(session);
      });

      tearDown(() {
        session.close();
      });

      test('create a set of all new tags', () async {
        final result = await tagsController.createMissingFromNames(
          ['tag1', 'tag2'],
        );
        expect(result, isA<List<Tag>>());
        expect(result, hasLength(2));
        expect(
          await Tag.db.findFirstRow(
            session,
            where: (t) => t.name.equals('tag1'),
          ),
          isA<Tag>(),
        );
        expect(
          await Tag.db.findFirstRow(
            session,
            where: (t) => t.name.equals('tag2'),
          ),
          isA<Tag>(),
        );
      });

      test(
        'create a set of partially new tags',
        () async {
          final _ = await tagsController.createMissingFromNames(
            ['asdf1', 'asdf2'],
          );
          final result2 = await tagsController.createMissingFromNames(
            ['asdf2', 'asdf3'],
          );
          expect(result2, isA<List<Tag>>());
          expect(result2, hasLength(2));
          expect(
            await Tag.db.findFirstRow(
              session,
              where: (t) => t.name.equals('asdf2'),
            ),
            isA<Tag>(),
          );
          expect(
            await Tag.db.findFirstRow(
              session,
              where: (t) => t.name.equals('asdf3'),
            ),
            isA<Tag>(),
          );
          // 3 total rows in DB
          expect(await Tag.db.count(session), 3);
        },
      );
    },
  );

  withServerpod(
    'TagsController.linkToSample should',
    (final sessionBuilder, final _) {
      late Dataset dataset;

      setUp(() async {
        session = sessionBuilder.build();
        samplesController = SamplesController(session);
        tagsController = TagsController(session);
        dataset = await Dataset.db.insertRow(
          session,
          Dataset(name: 'test_dataset'),
        );
      });

      tearDown(() {
        session.close();
      });

      test('add a set of tags to a sample which has none', () async {
        final sample = await samplesController.create(
          Sample(
            name: 'sample1',
            datasetId: dataset.id!,
            input: 'prompt',
            target: 'response',
            createdAt: DateTime.now(),
          ),
        );
        final tags = await tagsController.createMissingFromNames([
          'tag1',
          'tag2',
        ]);

        final modification = await tagsController.linkToSample(sample, tags);

        expect(modification.added, 2);
        expect(modification.removed, 0);

        final xrefs = await SampleTagXref.db.find(
          session,
          where: (t) => t.sampleId.equals(sample.id!),
        );
        expect(xrefs, hasLength(2));
      });

      test('add a set of tags to a sample which has some of those', () async {
        final sample = await samplesController.create(
          Sample(
            name: 'sample2',
            datasetId: dataset.id!,
            input: 'prompt',
            target: 'response',
            createdAt: DateTime.now(),
          ),
        );
        final allTags = await tagsController.createMissingFromNames(
          ['tag1', 'tag2', 'tag3'],
        );
        final modification = await tagsController.linkToSample(sample, [
          allTags.first,
        ]);
        expect(modification.added, 1);
        expect(modification.removed, 0);

        final modification2 = await tagsController.linkToSample(
          sample,
          allTags,
        );
        expect(modification2.added, 2);
        expect(modification2.removed, 0);

        final xrefs = await SampleTagXref.db.find(
          session,
          where: (t) => t.sampleId.equals(sample.id!),
        );
        expect(xrefs, hasLength(3));
      });

      test('remove stage tags from a sample', () async {
        final sample = await samplesController.create(
          Sample(
            name: 'sample3',
            datasetId: dataset.id!,
            input: 'prompt',
            target: 'response',
            createdAt: DateTime.now(),
          ),
        );
        final tags = await tagsController.createMissingFromNames([
          'tag1',
          'tag2',
        ]);
        await tagsController.linkToSample(sample, tags);

        final modification = await tagsController.linkToSample(
          sample,
          [tags.first],
        );

        expect(modification.added, 0);
        expect(modification.removed, 1);

        final xrefs = await SampleTagXref.db.find(
          session,
          where: (t) => t.sampleId.equals(sample.id!),
        );
        expect(xrefs, hasLength(1));
        expect(xrefs.first.tagId, tags.first.id);
      });
    },
  );
}
