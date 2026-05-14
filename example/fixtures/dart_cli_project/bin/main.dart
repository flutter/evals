import 'package:dart_cli_project/sort.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart run bin/main.dart <number> [numbers...]');
    return;
  }

  final numbers = args.map(int.parse).toList();
  final sorted = sortIntegers(numbers);
  print('Sorted: $sorted');

  if (numbers.length >= 3) {
    final top = topN(numbers, 3);
    print('Top 3: $top');
  }
}
