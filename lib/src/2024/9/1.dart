import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024091 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 09, 1);

  @override
  PuzzleOutput run(String input) {
    int sum = 0;

    List<int> parts = [];

    for (int i = 0; i < input.length; i++) {
      final toFill = i % 2 == 0 ? i ~/ 2 : -1;

      parts.addAll(List.filled(int.parse(input[i]), toFill));
    }

    print(
        'Before swap: ${parts.map((e) => e == -1 ? '.' : e.toString()).join()}');

    for (int i = parts.length - 1; i > 0; i--) {
      final toSwap = parts.indexOf(-1);

      if (toSwap == -1 || toSwap >= i) {
        break;
      }

      parts[toSwap] = parts[i];
      parts[i] = -1;
    }

    print(
        'After swap: ${parts.map((e) => e == -1 ? '.' : e.toString()).join()}');

    for (int i = 0; i < parts.length; i++) {
      if (parts[i] == -1) continue;
      sum += i * parts[i];
    }

    return PuzzleOutput(sum.toString());
  }
}
