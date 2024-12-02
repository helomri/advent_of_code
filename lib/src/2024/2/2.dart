import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024022 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_result', 'input': null};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 02, 2);

  @override
  PuzzleOutput run(String input) {
    List<List<int>> reports = input
        .split('\n')
        .map(
            (e) => e.split(' ').map((e) => int.parse(e)).toList(growable: true))
        .toList(growable: false);

    int safeReportAmount = 0;
    for (int reportId = 0; reportId < reports.length; reportId++) {
      List<int> report = reports[reportId];
      print('$report is being tested');
      bool isIncreasing = report.first < report[1];
      bool alreadyRemovedNumber = false;

      for (int i = 1; i < report.length; i++) {
        bool removeIfPossible() {
          if (alreadyRemovedNumber) return false;

          report.removeAt(i);
          alreadyRemovedNumber = true;
          i = 1;

          return true;
        }

        if (report[i] == report[i - 1]) {
          if (!removeIfPossible()) {
            print('$report is incorrect');
            safeReportAmount--;
            break;
          } else {
            continue;
          }
        }

        late int difference;

        if (report[i - 1] < report[i]) {
          if (!isIncreasing) {
            if (!removeIfPossible()) {
              print('$report is incorrect');
              safeReportAmount--;
              break;
            } else {
              continue;
            }
          }

          difference = report[i] - report[i - 1];
        }
        if (report[i - 1] > report[i]) {
          if (isIncreasing) {
            if (!removeIfPossible()) {
              print('$report is incorrect');
              safeReportAmount--;
              break;
            } else {
              continue;
            }
          }

          difference = report[i - 1] - report[i];
        }

        if (difference > 3) {
          if (!removeIfPossible()) {
            print('$report is incorrect');
            safeReportAmount--;
            break;
          }
        }
      }
      print('$report just got tested');
      safeReportAmount++;
    }

    return PuzzleOutput(safeReportAmount.toString());
  }
}
