import 'package:dart_cli_project/sort.dart';
import 'package:test/test.dart';

void main() {
  group('sortIntegers', () {
    test('sorts an unsorted list', () {
      expect(sortIntegers([3, 1, 4, 1, 5]), equals([1, 1, 3, 4, 5]));
    });

    test('handles an already sorted list', () {
      expect(sortIntegers([1, 2, 3, 4, 5]), equals([1, 2, 3, 4, 5]));
    });

    test('handles a reverse-sorted list', () {
      expect(sortIntegers([5, 4, 3, 2, 1]), equals([1, 2, 3, 4, 5]));
    });

    test('preserves duplicates', () {
      expect(sortIntegers([2, 2, 2, 1, 1]), equals([1, 1, 2, 2, 2]));
    });

    test('handles empty list', () {
      expect(sortIntegers([]), equals([]));
    });

    test('handles single element', () {
      expect(sortIntegers([42]), equals([42]));
    });

    test('preserves all duplicates in a large list', () {
      final input = [5, 3, 5, 3, 5, 3, 1, 1];
      final result = sortIntegers(input);
      expect(result.length, equals(input.length));
      expect(result, equals([1, 1, 3, 3, 3, 5, 5, 5]));
    });
  });

  group('topN', () {
    test('returns top 3 from a list with duplicates', () {
      expect(topN([1, 5, 3, 5, 2], 3), equals([5, 5, 3]));
    });

    test('returns top 1', () {
      expect(topN([10, 20, 30], 1), equals([30]));
    });

    test('handles n larger than list length', () {
      expect(topN([1, 2], 5), equals([2, 1]));
    });
  });
}
