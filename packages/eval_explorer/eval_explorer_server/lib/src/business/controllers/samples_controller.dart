import 'package:eval_explorer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SamplesController {
  SamplesController(this._session);

  final Session _session;

  /// Persists a new sample to the database.
  Future<Sample> create(Sample sample) {
    assert(sample.id == null, 'Sample.id must be null when creating');
    return Sample.db.insertRow(_session, sample);
  }
}
