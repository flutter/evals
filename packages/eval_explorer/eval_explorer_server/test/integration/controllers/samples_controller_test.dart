@Tags(['integration'])
library;

import 'package:eval_explorer_server/src/business/controllers/controllers.dart'
    show SamplesController;
import 'package:eval_explorer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test_tools/serverpod_test_tools.dart';

void main() {
  late SamplesController controller;
  late Session session;

  withServerpod(
    'SamplesController should',
    rollbackDatabase: RollbackDatabase.afterEach,
    (final sessionBuilder, final _) {
      setUp(() {
        session = sessionBuilder.build();
        controller = SamplesController(session);
      });

      tearDown(() {
        session.close();
      });

      test('throw when creating an existing sample', () {
        final sample = Sample(
          id: UuidValue.fromString(Uuid().v4()),
          datasetId: UuidValue.fromString(Uuid().v4()),
          name: 'Sample',
          input: '--input--',
          target: '--target--',
          createdAt: DateTime.now(),
        );
        expect(() => controller.create(sample), throwsA(isA<AssertionError>()));
      });

      test('save an sample', () async {
        final dataset = Dataset(name: 'Dataset');
        final savedDataset = await Dataset.db.insertRow(session, dataset);

        final sample = Sample(
          datasetId: savedDataset.id!,
          name: 'Sample',
          input: '--input--',
          target: '--target--',
          createdAt: DateTime.now(),
        );
        final savedSample = await controller.create(sample);
        expect(savedSample, isA<Sample>());
        expect(savedSample.id, isNotNull);
      });
    },
  );
}
