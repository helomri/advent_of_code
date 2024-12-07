import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024072 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_result', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 07, 2);

  int add(int a, int b) => a + b;
  int multiply(int a, int b) => a * b;
  int concatenate(int a, int b) => int.parse(a.toString() + b.toString());

  @override
  PuzzleOutput run(String input) {
    List<({int result, List<int> values})> equations =
        input.split('\n').map((e) {
      final [String result, String rawValues] = e.split(':');

      return (
        result: int.parse(result),
        values: rawValues.trim().split(' ').map((e) => int.parse(e)).toList()
      );
    }).toList();

    int sum = 0;

    for (final equation in equations) {
      List<int Function(int a, int b)> operators =
          List.filled(equation.values.length - 1, add);
      while (true) {
        final newValues = List<int>.from(equation.values);
        int current = newValues.removeAt(0);
        for (int i = 0; i < operators.length; i++) {
          current = operators[i](current, newValues[i]);
        }

        if (current == equation.result) {
          sum += equation.result;
          break;
        }

        if (operators.every((element) => element == multiply)) {
          break;
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == multiply) {
            operators[i] = add;
          } else if (operators[i] == add) {
            operators[i] = concatenate;
            break;
          } else if (operators[i] == concatenate) {
            operators[i] = multiply;
            break;
          }
        }
      }
    }

    return PuzzleOutput(sum.toString());
  }
}
