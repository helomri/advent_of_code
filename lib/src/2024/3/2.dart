import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024032 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 03, 2);

  (String, bool) trimUntil(String input, String match, bool currentCondition) {
    while (!input.startsWith(match) && input.isNotEmpty) {
      input = input.substring(1);

      if (input.startsWith('do()')) {
        currentCondition = true;
      } else if (input.startsWith('don\'t()')) {
        currentCondition = false;
      }
    }

    return (input, currentCondition);
  }

  @override
  PuzzleOutput run(String input) {
    int sum = 0;
    bool isActivated = true;
    while (input.isNotEmpty) {
      var (newInput, shouldRun) = trimUntil(input, 'mul(', isActivated);
      input = newInput;
      isActivated = shouldRun;
      if (input.isEmpty) break;
      input = input.substring(4);
      if (!isActivated) {
        continue;
      }
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
