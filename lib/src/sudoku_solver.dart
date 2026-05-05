import 'dart:math';

import 'sudoku_board.dart';
import 'sudoku_validator.dart';

class SudokuSolver {
  SudokuSolver({SudokuValidator? validator, Random? random})
      : _validator = validator ?? const SudokuValidator(),
        _random = random;

  final SudokuValidator _validator;
  final Random? _random;

  bool solve(SudokuBoard board) {
    final index = _nextEmpty(board.entries);
    if (index == -1) return true;

    final row = index ~/ SudokuBoard.size;
    final col = index % SudokuBoard.size;
    final candidates = List<int>.generate(9, (i) => i + 1);
    if (_random != null) candidates.shuffle(_random);

    for (final value in candidates) {
      if (!_validator.isMoveValid(board, row, col, value)) continue;
      board.entries[index] = value;
      if (solve(board)) return true;
      board.entries[index] = 0;
    }

    return false;
  }

  int countSolutions(SudokuBoard board, {int limit = 2}) {
    var count = 0;

    void search() {
      if (count >= limit) return;
      final index = _nextEmpty(board.entries);
      if (index == -1) {
        count++;
        return;
      }

      final row = index ~/ SudokuBoard.size;
      final col = index % SudokuBoard.size;
      for (var value = 1; value <= 9; value++) {
        if (!_validator.isMoveValid(board, row, col, value)) continue;
        board.entries[index] = value;
        search();
        board.entries[index] = 0;
      }
    }

    search();
    return count;
  }

  int _nextEmpty(List<int> entries) {
    for (var i = 0; i < entries.length; i++) {
      if (entries[i] == 0) return i;
    }
    return -1;
  }
}
