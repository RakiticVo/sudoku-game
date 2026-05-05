import 'dart:math';

import 'sudoku_board.dart';
import 'sudoku_solver.dart';

enum SudokuDifficulty { easy, medium, hard }

class SudokuGenerator {
  SudokuGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  SudokuBoard generate(SudokuDifficulty difficulty) {
    final solved = SudokuBoard.empty();
    SudokuSolver(random: _random).solve(solved);

    final puzzle = solved.copy();
    final targetRemovals = switch (difficulty) {
      SudokuDifficulty.easy => 38,
      SudokuDifficulty.medium => 46,
      SudokuDifficulty.hard => 54,
    };

    final positions = List<int>.generate(SudokuBoard.cellCount, (i) => i)..shuffle(_random);
    final solver = SudokuSolver();
    var removed = 0;

    for (final pos in positions) {
      if (removed >= targetRemovals) break;
      final backup = puzzle.entries[pos];
      puzzle.entries[pos] = 0;
      final probe = SudokuBoard.fromPuzzle(puzzle.entries);
      if (solver.countSolutions(probe, limit: 2) != 1) {
        puzzle.entries[pos] = backup;
      } else {
        removed++;
      }
    }

    return SudokuBoard.fromPuzzle(puzzle.entries);
  }
}
