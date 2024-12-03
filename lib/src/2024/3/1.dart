import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024031 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_result', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 03, 1);

  String trimUntil(String input, String match) {
    while (!input.startsWith(match) && input.isNotEmpty) {
      input = input.substring(1);
    }

    return input;
  }

  @override
  PuzzleOutput run(String input) {
    int sum = 0;
    while (input.isNotEmpty) {
      input = trimUntil(input, 'mul(');
      if (input.isEmpty) break;
      input = input.substring(4);
      String firstInt = '';

      while (RegExp(r'\d').matchAsPrefix(input[0]) != null) {
        firstInt += input[0];
        input = input.substring(1);
      }
      if (input[0] != ',') {
        continue;
      }

      input = input.substring(1);

      String secondInt = '';
      while (RegExp(r'\d').matchAsPrefix(input[0]) != null) {
        secondInt += input[0];
        input = input.substring(1);
      }

      if (input[0] != ')') {
        continue;
      }

      sum += int.parse(firstInt) * int.parse(secondInt);
    }

    return PuzzleOutput(sum.toString());
  }
}
