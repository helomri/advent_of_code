import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024012 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PI(2024, 01, 2);

  @override
  PuzzleOutput run(String input) {
    List<int> leftList = [];
    List<int> rightList = [];
    for (String line in input.trim().split('\n')) {
      final parts = line.split(' ').where(
            (element) => element.isNotEmpty,
          );
      assert(parts.length == 2);
      leftList.add(int.parse(parts.first));
      rightList.add(int.parse(parts.last));
    }

    int sum = 0;

    for (final locationId in leftList) {
      sum += locationId *
          rightList.where((element) => element == locationId).length;
    }

    return PuzzleOutput(sum.toString());
  }
}
