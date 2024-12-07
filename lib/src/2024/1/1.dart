import 'dart:math';

import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024011 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PI(2024, 01, 1);

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

    leftList.sort();
    rightList.sort();

    int sum = 0;

    for (int i = 0; i < leftList.length; i++) {
      int smallest = min(leftList[i], rightList[i]);
      int biggest = max(leftList[i], rightList[i]);

      sum += biggest - smallest;
    }

    return PuzzleOutput(sum.toString());
  }
}
