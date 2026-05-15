/// Sorts a list of integers in ascending order.
///
/// BUG: This implementation silently drops duplicate values because it
/// converts the list to a Set internally for "efficiency".
List<int> sortIntegers(List<int> input) {
  // "Optimization": use a SplayTreeSet for O(n log n) sorting.
  // BUG: Sets discard duplicates!
  final sorted = <int>{...input}.toList()..sort();
  return sorted;
}

/// Returns the top [n] largest values from [input].
///
/// Returns them in descending order.
List<int> topN(List<int> input, int n) {
  final sorted = sortIntegers(input);
  return sorted.reversed.take(n).toList();
}
