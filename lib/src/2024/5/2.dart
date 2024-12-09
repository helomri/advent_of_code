import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024052 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': null};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 05, 2);

  bool isValid(List<(int, int)> rules, List<int> pageNumbers) {
    for (final rule in rules) {
      if (pageNumbers.contains(rule.$1) && pageNumbers.contains(rule.$2)) {
        final first = pageNumbers.indexOf(rule.$1);
        final second = pageNumbers.indexOf(rule.$2);
        if (first > second) {
          return false;
        }
      }
    }

    return true;
  }

  @override
  PuzzleOutput run(String input) {
    print('THIS IS NOT VALID, 2024/05/2 IS NOT YET SOLVED');
    int sum = 0;

    List<(int, int)> pageRules = [];

    final lines = input.split('\n');
    while (lines.first != '') {
      final line = lines.first.split('|');
      pageRules.add((int.parse(line.first), int.parse(line.last)));

      lines.removeAt(0);
    }

    lines.removeAt(0);

    for (final update in lines) {
      List<int> pageNumbers =
          update.split(',').map((e) => int.parse(e)).toList();

      bool valid = true;
      for (final rule in pageRules) {
        if (pageNumbers.contains(rule.$1) && pageNumbers.contains(rule.$2)) {
          final first = pageNumbers.indexOf(rule.$1);
          final second = pageNumbers.indexOf(rule.$2);
          if (first > second) {
            pageNumbers.removeAt(first);

            pageNumbers.insert(0, rule.$1);
            valid = false;
          }
        }
      }

      if (!valid) {
        print('Got: $pageNumbers');
        sum += pageNumbers[(pageNumbers.length - 1) ~/ 2];
      }
    }

    return PuzzleOutput(sum.toString());
  }
}
