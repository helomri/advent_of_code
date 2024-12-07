import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024042 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 04, 2);

  bool xmasAmount(List<List<String>> letters, int y, int x) {
    try {
      String topLeft = letters[y - 1][x - 1];
      String topRight = letters[y - 1][x + 1];
      String bottomLeft = letters[y + 1][x - 1];
      String bottomRight = letters[y + 1][x + 1];

      List<List<String>> configs = [
        // M S
        //  A
        // M S
        ['M', 'S', 'M', 'S'],
        // S M
        //  A
        // S M
        [
          'S',
          'M',
          'S',
          'M',
        ],
        // M M
        //  A
        // S S
        ['M', 'M', 'S', 'S'],
        // S S
        //  A
        // M M
        ['S', 'S', 'M', 'M']
      ];

      return configs.any((element) =>
          element.join() ==
          [topLeft, topRight, bottomLeft, bottomRight].join());
    } catch (e) {
      return false;
    }
  }

  @override
  PuzzleOutput run(String input) {
    List<List<String>> letters =
        input.split('\n').map((e) => e.split('')).toList(growable: false);

    int amount = 0;

    int currentY = 0;
    int currentX = 0;
    while (currentY < letters.length) {
      while (currentX < letters[currentY].length) {
        if (letters[currentY][currentX] == 'A') {
          if (xmasAmount(letters, currentY, currentX)) {
            amount++;
          }
        }

        currentX++;
      }

      currentX = 0;

      currentY++;
    }

    return PuzzleOutput(amount.toString());
  }
}
