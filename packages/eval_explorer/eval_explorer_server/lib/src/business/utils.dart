/// The result of a set operation on a cross reference table.
class XrefModification {
  const XrefModification({
    required this.added,
    required this.removed,
  });

  /// Stub value for tests non-database tests that do not evaluate cross
  /// references.
  static const XrefModification zero = XrefModification(added: 0, removed: 0);

  /// Number of added cross references from a set operation.
  final int added;

  /// Number of removed cross references from a set operation.
  final int removed;
}
