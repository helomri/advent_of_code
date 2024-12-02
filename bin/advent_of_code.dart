import 'package:advent_of_code/advent_of_code.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';

const String version = '0.0.1';

ArgParser buildRunParser() {
  return ArgParser()
    ..addOption('year',
        defaultsTo: DateTime.now().year.toString(),
        help: 'The year of release of the puzzle')
    ..addOption('day',
        defaultsTo: (DateTime.now().day % 26).toString(),
        help: 'The day of december of release of the puzzle')
    ..addOption('part',
        defaultsTo: '1', help: 'The part of the puzzle (1 or 2)');
}

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addCommand('run', buildRunParser());
}

void printUsage(ArgParser argParser) {
  print('Usage: dart advent_of_code.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  Logger.root.level = Level.ALL;

  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('AoC answers version: $version');
      return;
    }

    switch (results.command?.name) {
      case 'run':
        {
          int? year = int.tryParse(results.command!.option('year') ?? '');
          int? day = int.tryParse(results.command!.option('day') ?? '');
          int? part = int.tryParse(results.command!.option('part') ?? '');

          if (year == null) {
            print('Could not read puzzle year.');
            return;
          }

          if (day == null) {
            print('Could not read puzzle day.');
            return;
          }

          if (part == null) {
            print('Could not read puzzle part.');
            return;
          }

          final pi = PI(year, day, part);

          final puzzle = puzzleParts
              .cast<PuzzlePart?>()
              .firstWhere((element) => element!.id == pi, orElse: () => null);

          if (puzzle == null) {
            print('Could not find puzzle $pi.');
            return;
          }

          print('Running $pi...');

          final testResults = puzzle.testAll();
          print(
              'Results: ${testResults.passed} passed / ${testResults.failed} failed / ${testResults.skipped} skipped');
        }
      case null:
        {
          printUsage(argParser);
          return;
        }
      default:
        {
          print('Unknown command: ${results.command?.name}');
        }
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
