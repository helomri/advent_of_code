import 'dart:io';

import 'package:advent_of_code/src/2024/1/1.dart';
import 'package:advent_of_code/src/2024/1/2.dart';
import 'package:advent_of_code/src/2024/2/1.dart';
import 'package:advent_of_code/src/2024/2/2.dart';
import 'package:advent_of_code/src/2024/3/1.dart';
import 'package:advent_of_code/src/2024/3/2.dart';
import 'package:advent_of_code/src/2024/4/1.dart';
import 'package:advent_of_code/src/2024/4/2.dart';
import 'package:logging/logging.dart';

typedef PI = PuzzleIdentifier;

class PuzzleIdentifier {
  final int year;
  final int day;
  final int part;

  const PuzzleIdentifier(this.year, this.day, this.part)
      : assert(year >= 2015, 'Invalid year (AoC started in 2015)'),
        assert(day > 0 && day < 26, 'There are only problems from 1 to 25'),
        assert(part == 1 || part == 2, 'There are only two parts to problems');

  @override
  int get hashCode => Object.hash(year, day, part);

  @override
  bool operator ==(Object other) {
    return other is PuzzleIdentifier && other.hashCode == hashCode;
  }

  @override
  String toString() {
    return '$year/$day/$part';
  }

  Logger get logger => Logger('Puzzle ${toString()}');
}

class PuzzleOutput {
  final String output;

  String get humanReadableOutput => _humanReadableOutput ?? output;

  final String? _humanReadableOutput;

  const PuzzleOutput(this.output, {String? humanReadableOutput})
      : _humanReadableOutput = humanReadableOutput;

  @override
  String toString() => humanReadableOutput;
}

abstract class PuzzlePart {
  PuzzleIdentifier get id;

  static Directory getPuzzlePartDirectory(PuzzleIdentifier puzzleId) {
    final s = Platform.pathSeparator;
    return Directory(
        '${Directory.current.absolute.path}${s}assets$s${puzzleId.year}$s${puzzleId.day}$s${puzzleId.part}');
  }

  Map<String, String?> get dependentTestFiles;

  ({int passed, int failed, int skipped}) testAll() {
    id.logger.onRecord.listen((event) {
      print('[${event.level.name}] ${event.message}');
    });
    final testDir = getPuzzlePartDirectory(id);

    int passed = 0;
    int failed = 0;
    int skipped = 0;

    for (final testFilePair in dependentTestFiles.entries) {
      final inputTestFile =
          File(testDir.path + Platform.pathSeparator + testFilePair.key);
      final outputTestFile = testFilePair.value == null
          ? null
          : File(testDir.path + Platform.pathSeparator + testFilePair.value!);

      final result = testOne(inputTestFile, outputTestFile);
      if (result == true) passed++;
      if (result == false) failed++;
      if (result == null) skipped++;
    }

    return (passed: passed, failed: failed, skipped: skipped);
  }

  bool? testOne(File inputTestFile, File? outputTestFile) {
    if (!inputTestFile.existsSync()) {
      id.logger.warning(
          'Skipping test of ${inputTestFile.path} -> ${outputTestFile?.path ?? '(no output)'}, input file does not exist.');
      return null;
    }

    bool outputFileExists = outputTestFile?.existsSync() ?? false;

    if (!outputFileExists) {
      id.logger.info(
          'Output file does not exist for test ${inputTestFile.path} -> ${outputTestFile?.path ?? '(no output)'}. Running blind and printing the result');
    }

    final result = run(inputTestFile.readAsStringSync());

    if (!outputFileExists) {
      id.logger.info(
          'Result for test ${inputTestFile.path} -> ${outputTestFile?.path ?? '(no output)'} is $result');
      return null;
    }

    final expected = outputTestFile!.readAsStringSync();
    final actual = result.output;

    if (actual != expected) {
      id.logger
          .warning('Test failed: $expected (expected) differs from $actual');
    }

    return actual == expected;
  }

  PuzzleOutput run(String input);
}

Set<PuzzlePart> puzzleParts = {
  Puzzle2024011(),
  Puzzle2024012(),
  Puzzle2024021(),
  Puzzle2024022(),
  Puzzle2024031(),
  Puzzle2024032(),
  Puzzle2024041(),
  Puzzle2024042(),
};
