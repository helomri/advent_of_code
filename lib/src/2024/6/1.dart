import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024061 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 06, 1);

  ({int y, int x}) rotateDirection(({int y, int x}) input) {
    // var (y: y, x: x) = input;
    if (input == (y: -1, x: 0)) {
      return (y: 0, x: 1);
    }
    if (input == (y: 0, x: 1)) {
      return (y: 1, x: 0);
    }
    if (input == (y: 1, x: 0)) {
      return (y: 0, x: -1);
    }
    if (input == (y: 0, x: -1)) {
      return (y: -1, x: 0);
    }

    throw ArgumentError('Unknown vector: $input');
  }

  @override
  PuzzleOutput run(String input) {
    List<List<String>> map = input.split('\n').map((e) => e.split('')).toList();

    int y = -1;
    int x = -1;

    for (int i = 0; i < map.length; i++) {
      if (map[i].contains('^')) {
        y = i;
        x = map[i].indexOf('^');
      }
    }

    ({int y, int x}) direction = (y: -1, x: 0);
    Set<({int y, int x})> directions = {};

    while (true) {
      final isOutsideHeight = y == -1 || y == map.length;
      final isOutsideWidth = x == -1 || x == map.first.length;
      if (isOutsideHeight || isOutsideWidth) {
        y = y - direction.y;
        x = x - direction.x;
        break;
      }

      final currentChar = map[y][x];
      if (currentChar == '#') {
        y = y - direction.y;
        x = x - direction.x;
        direction = rotateDirection(direction);
      }

      directions.add((y: y, x: x));

      y += direction.y;
      x += direction.x;
    }

    return PuzzleOutput(directions.length.toString());
  }
}
