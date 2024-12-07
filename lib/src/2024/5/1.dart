import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024051 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 05, 1);

  @override
  PuzzleOutput run(String input) {
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
          if (pageNumbers.indexOf(rule.$1) > pageNumbers.indexOf(rule.$2)) {
            valid = false;
            break;
          }
        }
      }

      if (valid) {
        sum += pageNumbers[(pageNumbers.length - 1) ~/ 2];
      }
    }

    return PuzzleOutput(sum.toString());
  }
}
