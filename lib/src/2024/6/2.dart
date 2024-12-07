import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024062 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_result', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 06, 2);

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

  bool tryWithAdditionalObstruction(List<List<String>> originalMap,
      ({int y, int x}) newObstruction, ({int y, int x}) startingPosition) {
    var (y: y, x: x) = startingPosition;
    ({int y, int x}) direction = (y: -1, x: 0);

    Set<({({int y, int x}) position, ({int y, int x}) direction})> directions =
        {};

    final newMap = List.from(originalMap.map((e) => List.from(e)));

    newMap[newObstruction.y][newObstruction.x] = '#';

    while (true) {
      final isOutsideHeight = y == -1 || y == newMap.length;
      final isOutsideWidth = x == -1 || x == newMap.first.length;
      if (isOutsideHeight || isOutsideWidth) {
        y = y - direction.y;
        x = x - direction.x;
        return false;
      }

      final currentChar = newMap[y][x];
      if (currentChar == '#') {
        y = y - direction.y;
        x = x - direction.x;
        direction = rotateDirection(direction);
      }

      final state = (position: (y: y, x: x), direction: direction);

      if (directions.contains(state)) {
        return true;
      }

      directions.add(state);

      y += direction.y;
      x += direction.x;
    }
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

    final originalPosition = (y: y, x: x);

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

    int sum = 0;

    for (final possibleNewObstruction in directions) {
      if (possibleNewObstruction == originalPosition) {
        continue;
      }

      if (tryWithAdditionalObstruction(
          map, possibleNewObstruction, originalPosition)) {
        sum++;
      }
    }

    return PuzzleOutput(sum.toString());
  }
}
