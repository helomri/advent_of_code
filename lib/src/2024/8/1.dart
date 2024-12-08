import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024081 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 08, 1);

  @override
  PuzzleOutput run(String input) {
    Map<String, List<({int y, int x})>> antennas = {};

    final splitInput = input.split('\n');
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

          int newY =
              antennaList[antennaIndex].y - antennaList[matchingAntennaIndex].y;
          int newX =
              antennaList[antennaIndex].x - antennaList[matchingAntennaIndex].x;

          antinodeLocations.add((
            y: antennaList[antennaIndex].y + newY,
            x: antennaList[antennaIndex].x + newX
          ));
        }
      }
    }

    return PuzzleOutput(antinodeLocations
        .where((element) =>
            element.y >= 0 &&
            element.y < splitInput.length &&
            element.x >= 0 &&
            element.x < splitInput.first.length)
        .length
        .toString());
  }
}
