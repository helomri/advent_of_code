import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024082 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 08, 2);

  @override
  PuzzleOutput run(String input) {
    Map<String, List<({int y, int x})>> antennas = {};

    final splitInput = input.split('\n');

    bool withinBounds(({int y, int x}) bounds) =>
        bounds.y >= 0 &&
        bounds.y < splitInput.length &&
        bounds.x >= 0 &&
        bounds.x < splitInput.first.length;

    for (int y = 0; y < splitInput.length; y++) {
      for (int x = 0; x < splitInput[y].length; x++) {
        final char = splitInput[y][x];
        if (char == '.') continue;

        assert(RegExp(r'[\da-zA-Z]').hasMatch(char),
            'Invalid antenna name: $char');

        if (!antennas.containsKey(char)) {
          antennas[char] = [];
        }

        antennas[char]!.add((y: y, x: x));
      }
    }

    Set<({int y, int x})> antinodeLocations = {};

    for (final antennaList in antennas.values) {
      for (int antennaIndex = 0;
          antennaIndex < antennaList.length;
          antennaIndex++) {
        for (int matchingAntennaIndex = 0;
            matchingAntennaIndex < antennaList.length;
            matchingAntennaIndex++) {
          if (matchingAntennaIndex == antennaIndex) continue;

          int differenceY =
              antennaList[antennaIndex].y - antennaList[matchingAntennaIndex].y;
          int differenceX =
              antennaList[antennaIndex].x - antennaList[matchingAntennaIndex].x;

          int newY = antennaList[antennaIndex].y;
          int newX = antennaList[antennaIndex].x;

          while (withinBounds((y: newY, x: newX))) {
            antinodeLocations.add((y: newY, x: newX));

            newY = newY + differenceY;
            newX = newX + differenceX;
          }
        }
      }
    }

    return PuzzleOutput(antinodeLocations
        .where((element) => withinBounds(element))
        .length
        .toString());
  }
}
