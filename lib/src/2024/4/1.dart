import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024041 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_result', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 04, 1);

  int xmasAmount(List<List<String>> letters, int y, int x) {
    List<String> right() {
      return [letters[y][x + 1], letters[y][x + 2], letters[y][x + 3]];
    }

    List<String> left() {
      return [letters[y][x - 1], letters[y][x - 2], letters[y][x - 3]];
    }

    List<String> down() {
      return [letters[y + 1][x], letters[y + 2][x], letters[y + 3][x]];
    }

    List<String> up() {
      return [letters[y - 1][x], letters[y - 2][x], letters[y - 3][x]];
    }

    List<String> downRight() {
      return [
        letters[y - 1][x + 1],
        letters[y - 2][x + 2],
        letters[y - 3][x + 3]
      ];
    }

    List<String> downLeft() {
      return [
        letters[y - 1][x - 1],
        letters[y - 2][x - 2],
        letters[y - 3][x - 3]
      ];
    }

    List<String> upRight() {
      return [
        letters[y + 1][x + 1],
        letters[y + 2][x + 2],
        letters[y + 3][x + 3]
      ];
    }

    List<String> upLeft() {
      return [
        letters[y + 1][x - 1],
        letters[y + 2][x - 2],
        letters[y + 3][x - 3]
      ];
    }

    return [right, left, down, up, downRight, downLeft, upRight, upLeft]
        .map(
          (e) {
            try {
              return e();
            } catch (e) {
              return [];
            }
          },
        )
        .where((element) => element.join() == 'MAS')
        .length;
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
        if (letters[currentY][currentX] == 'X') {
          amount += xmasAmount(letters, currentY, currentX);
        }

        currentX++;
      }

      currentX = 0;

      currentY++;
    }

    return PuzzleOutput(amount.toString());
  }
}
