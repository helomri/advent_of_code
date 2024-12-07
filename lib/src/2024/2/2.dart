import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024022 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': 'output'};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 02, 2);

  @override
  PuzzleOutput run(String input) {
    List<List<int>> reports = input
        .split('\n')
        .map((e) =>
            e.split(' ').map((e) => int.parse(e)).toList(growable: false))
        .toList(growable: false);

    int safeReportAmount = 0;
    for (final report in reports) {
      for (int toDelete = -1; toDelete < report.length; toDelete++) {
        late List<int> currentReport;
        if (toDelete == -1) {
          currentReport = report;
        } else {
          currentReport = List.from(report)..removeAt(toDelete);
        }

        bool isCorrect = true;
        bool isIncreasing = currentReport.first < currentReport[1];
        for (int i = 1; i < currentReport.length; i++) {
          if (currentReport[i] == currentReport[i - 1]) {
            isCorrect = false;
            break;
          }

          late int difference;

          if (currentReport[i - 1] < currentReport[i]) {
            if (!isIncreasing) {
              isCorrect = false;
              break;
            }

            difference = currentReport[i] - currentReport[i - 1];
          }
          if (currentReport[i - 1] > currentReport[i]) {
            if (isIncreasing) {
              isCorrect = false;
              break;
            }

            difference = currentReport[i - 1] - currentReport[i];
          }

          if (difference > 3) {
            isCorrect = false;
            break;
          }
        }
        if (isCorrect) {
          safeReportAmount++;
          break;
        }
      }
    }

    return PuzzleOutput(safeReportAmount.toString());
  }
}
