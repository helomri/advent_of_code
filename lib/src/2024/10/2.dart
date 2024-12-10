import 'package:advent_of_code/advent_of_code.dart';

typedef Pos = ({int y, int x});

class Puzzle2024102 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles => {
        'test_input': 'test_output',
        'input': null /*'output'*/
      };

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 10, 2);

  List<Pos> createVariations(Pos base) {
    return [
      (y: base.y + 1, x: base.x),
      (y: base.y - 1, x: base.x),
      (y: base.y, x: base.x + 1),
      (y: base.y, x: base.x - 1),
    ];
  }

  @override
  PuzzleOutput run(String input) {
    List<List<int>> map = input
        .split('\n')
        .map((e) => e.split('').map((e) => int.parse(e)).toList())
        .toList();

    List<List<Pos>> possibleTrails = [];

    for (int y = 0; y < map.length; y++) {
      for (int x = 0; x < map[y].length; x++) {
        if (map[y][x] == 0) {
          possibleTrails.add([(y: y, x: x)]);
        }
      }
    }

    Map<({Pos start, Pos end}), int> positions = {};

    List<List<Pos>> nextPossibleTrails = [];

    int height = map.length;
    int width = map.first.length;

    bool isValidPos(Pos pos) =>
        pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height;

    while (possibleTrails.isNotEmpty) {
      for (final possibleTrail in possibleTrails) {
        if (possibleTrail.length == 10) {
          final trail = (start: possibleTrail.first, end: possibleTrail.last);
          positions[trail] =
              positions.containsKey(trail) ? positions[trail]! + 1 : 1;
          continue;
        }

        final variations = createVariations(possibleTrail.last)
            .where(isValidPos)
            .where(
                (element) => map[element.y][element.x] == possibleTrail.length)
            .toList();

        for (final next in variations) {
          nextPossibleTrails.add([...possibleTrail, next]);
        }
      }

      possibleTrails = nextPossibleTrails;
      nextPossibleTrails = [];
    }

    return PuzzleOutput(positions.values
        .reduce((value, element) => value + element)
        .toString());
  }
}
