import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024021 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 02, 1);

  @override
  PuzzleOutput run(String input) {
    List<List<int>> reports = input
        .split('\n')
        .map((e) =>
            e.split(' ').map((e) => int.parse(e)).toList(growable: false))
        .toList(growable: false);

    int safeReportAmount = 0;
    for (final report in reports) {
      bool isIncreasing = report.first < report[1];
      for (int i = 1; i < report.length; i++) {
        if (report[i] == report[i - 1]) {
          safeReportAmount--;
          break;
        }

        late int difference;

        if (report[i - 1] < report[i]) {
          if (!isIncreasing) {
            safeReportAmount--;
            break;
          }

          difference = report[i] - report[i - 1];
        }
        if (report[i - 1] > report[i]) {
          if (isIncreasing) {
            safeReportAmount--;
            break;
          }

          difference = report[i - 1] - report[i];
        }

        if (difference > 3) {
          safeReportAmount--;
          break;
        }
      }

      safeReportAmount++;
    }

    return PuzzleOutput(safeReportAmount.toString());
  }
}
