import 'dart:isolate';
import 'dart:math';

import 'package:advent_of_code/advent_of_code.dart';

class Puzzle2024052 extends PuzzlePart {
  @override
  Map<String, String?> get dependentTestFiles =>
      {'test_input': 'test_output', 'input': null};

  @override
  PuzzleIdentifier get id => PuzzleIdentifier(2024, 05, 2);

  bool isValid(List<(int, int)> rules, List<int> pageNumbers) {
    for (final rule in rules) {
      if (pageNumbers.contains(rule.$1) && pageNumbers.contains(rule.$2)) {
        final first = pageNumbers.indexOf(rule.$1);
        final second = pageNumbers.indexOf(rule.$2);
        if (first > second) {
          return false;
        }
      }
    }

    return true;
  }

  int factorialRecursive(int n) {
    if (n == 0) {
      return 1;
    }
    return n * factorialRecursive(n - 1);
  }

  List<T> getPermutation<T>(List<T> lst, int arrangementId) {
    int n = lst.length;
    if (!(0 <= arrangementId && arrangementId < factorialRecursive(n))) {
      throw ArgumentError();
    }

    List<T> permutation = [];
    List<T> availableElements = List.from(lst); // Create a copy
    List<int> factoradic = [];

    for (int i = n - 1; i >= 0; i--) {
      int factorialVal = factorialRecursive(i);
      int digit = arrangementId ~/ factorialVal; // Integer division
      factoradic.add(digit);
      arrangementId %= factorialVal;

      permutation.add(availableElements.removeAt(digit));
    }

    return permutation;
  }

  Future<int> tryFor(
      List<int> pageNumbers, List<(int, int)> rules, int id) async {
    rules = rules
        .where(
          (element) =>
              pageNumbers.contains(element.$1) &&
              pageNumbers.contains(element.$2),
        )
        .toList();

    if (isValid(rules, pageNumbers)) return 0;

    int currentCount = 1;
    int possibleArrangements = factorialRecursive(pageNumbers.length);
    while (true) {
      List<int> newPageNumbers = getPermutation(pageNumbers, currentCount);
      currentCount++;

      if (isValid(rules, newPageNumbers)) {
        print('$pageNumbers becomes $newPageNumbers');
        return newPageNumbers[(pageNumbers.length - 1) ~/ 2];
      }

      if (currentCount > possibleArrangements) {
        throw Exception('This can\'t be possible');
      }
    }
  }

  @override
  PuzzleOutput run(String input) {
    print('THIS IS NOT VALID, 2024/05/2 IS NOT YET SOLVED');
    int sum = 0;

    List<(int, int)> pageRules = [];

    final lines = input.split('\n');
    while (lines.first != '') {
      final line = lines.first.split('|');
      pageRules.add((int.parse(line.first), int.parse(line.last)));

      lines.removeAt(0);
    }

    lines.removeAt(0);

    int running = lines.length;

    final toProcess = lines
        .map((e) =>
            e.split(',').map((e) => int.parse(e)).toList(growable: false))
        .toList();
    Future<int> startNew() {
      final current = toProcess.removeAt(0);
      return Isolate.run(() {
        return tryFor(current, pageRules, toProcess.length);
      }).then(
        (value) {
          sum += value;

          running--;

          if (toProcess.isEmpty) {
            return Future.value(0);
          }

          return startNew();
        },
      );
    }

    List.generate(min(toProcess.length, 28), (index) => startNew(),
        growable: false);

    while (toProcess.isNotEmpty && running > 0) {}

    // int current = 0;
    //
    // for (final update in lines) {
    //   current++;
    //   print('Doing $current/${lines.length}');
    //   List<int> pageNumbers =
    //       update.split(',').map((e) => int.parse(e)).toList();
    //
    //   if (isValid(pageRules, pageNumbers)) continue;
    //
    //   Set<List<int>> triedPageNumbers = {pageNumbers};
    //   while (true) {
    //     List<int> newPageNumbers = List.from(pageNumbers)..shuffle();
    //     if (triedPageNumbers.contains(newPageNumbers)) continue;
    //
    //     if (isValid(pageRules, newPageNumbers)) {
    //       print('$pageNumbers becomes $newPageNumbers');
    //       sum += newPageNumbers[(pageNumbers.length - 1) ~/ 2];
    //
    //       break;
    //     }
    //
    //     triedPageNumbers.add(newPageNumbers);
    //   }
    // }

    return PuzzleOutput(sum.toString());
  }
}
