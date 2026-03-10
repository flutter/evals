import 'package:eval_explorer_server/src/business/utils.dart';
import 'package:eval_explorer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TagsController {
  TagsController(this._session);

  final Session _session;

  /// Upserts a list of tags from their names.
  ///
  /// Returns the complete list of tags that were created or already existed.
  Future<List<Tag>> createMissingFromNames(Iterable<String> names) async {
    final allNamesSet = names.toSet();
    final existingTags = await Tag.db.find(
      _session,
      where: (t) => t.name.inSet(allNamesSet),
    );
    if (existingTags.length == allNamesSet.length) {
      return existingTags;
    }

    final existingNamesSet = existingTags.map((t) => t.name).toSet();
    final missingNames = allNamesSet.difference(existingNamesSet);
    final newTags = await Tag.db.insert(
      _session,
      missingNames.map((name) => Tag(name: name)).toList(),
    );
    return [...existingTags, ...newTags];
  }

  /// Links a list of tags to a sample, adding any missing and removing any
  /// stale tags.
  ///
  /// The sample and all tags must already exist in the database.
  Future<XrefModification> linkToSample(Sample sample, List<Tag> tags) async {
    assert(sample.id != null, 'Sample.id must not be null when linking tags');
    assert(
      tags.every((tag) => tag.id != null),
      'All tags must have an id when linking to a sample',
    );

    // Get the current state of this sample's tags.
    final alreadyLinkedTags = await SampleTagXref.db.find(
      _session,
      where: (t) => t.sampleId.equals(sample.id!),
    );
    final alreadyLinkedTagIds = alreadyLinkedTags.map((t) => t.tagId).toSet();

    // Flatten the desired list of Ids.
    final desiredTagIds = tags.map((t) => t.id!).toSet();

    // Get the Ids to link.
    final tagIdsToLink = desiredTagIds.difference(alreadyLinkedTagIds);
    if (tagIdsToLink.isNotEmpty) {
      await SampleTagXref.db.insert(
        _session,
        tagIdsToLink
            .map((tagId) => SampleTagXref(sampleId: sample.id!, tagId: tagId))
            .toList(),
      );
    }

    // Get the Ids to unlink.
    final tagsToUnlink = alreadyLinkedTagIds.difference(desiredTagIds);
    if (tagsToUnlink.isNotEmpty) {
      final deleted = await SampleTagXref.db.deleteWhere(
        _session,
        where: (t) =>
            t.sampleId.equals(sample.id!) & t.tagId.inSet(tagsToUnlink),
      );
      assert(
        deleted.length == tagsToUnlink.length,
        'Unexpectedly unlinked ${deleted.length} tags from sample ${sample.id} '
        'while expected to unlink ${tagsToUnlink.length} tags',
      );
    }

    return XrefModification(
      added: tagIdsToLink.length,
      removed: tagsToUnlink.length,
    );
  }
}
