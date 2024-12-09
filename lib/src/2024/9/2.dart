import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024092 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 09, 2);

  @override
  PuzzleOutput run(String input) {
    int sum = 0;

    List<int> parts = [];

    for (int i = 0; i < input.length; i++) {
      final toFill = i % 2 == 0 ? i ~/ 2 : -1;

      parts.addAll(List.filled(int.parse(input[i]), toFill));
    }

    for (int i = parts.length - 1; i > 0; i--) {
      if (parts[i] == -1) continue;

      int current = parts[i];
      int length = parts.where((element) => element == current).length;

      for (int j = 0; j < i; j++) {
        if (parts[j] != -1) continue;
        bool valid = true;
        for (int k = 0; k < length; k++) {
          if (parts[j + k] != -1) {
            valid = false;
            break;
          }
        }

        if (valid) {
          for (int k = 0; k < length; k++) {
            parts[j + k] = current;
            parts[i - k] = -1;
          }
          break;
        }
      }

      i -= length - 1;
    }

    for (int i = 0; i < parts.length; i++) {
      if (parts[i] == -1) continue;
      sum += i * parts[i];
    }

    return PuzzleOutput(sum.toString());
  }
}
