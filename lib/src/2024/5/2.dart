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

      if (!isValid(pageRules, pageNumbers)) {
        print('Got: $pageNumbers');
        pageNumbers.sort((a, b) {
          if (!pageRules.any((element) => element.$1 == a)) {
            return 1;
          }
          if (pageRules.any((element) => element.$1 == a && element.$2 == b)) {
            return -1;
          } else {
            return 1;
          }
        });
        print(isValid(pageRules, pageNumbers));
        sum += pageNumbers[(pageNumbers.length - 1) ~/ 2];
      }
    }

    return PuzzleOutput(sum.toString());
  }
}
