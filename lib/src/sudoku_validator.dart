import 'sudoku_board.dart';

class SudokuValidator {
  const SudokuValidator();

  bool isMoveValid(SudokuBoard board, int row, int col, int value) {
    if (value == 0) return true;
    for (var c = 0; c < SudokuBoard.size; c++) {
      if (c != col && board.at(row, c) == value) return false;
    }
    for (var r = 0; r < SudokuBoard.size; r++) {
      if (r != row && board.at(r, col) == value) return false;
    }
    final boxRow = (row ~/ 3) * 3;
    final boxCol = (col ~/ 3) * 3;
    for (var r = boxRow; r < boxRow + 3; r++) {
      for (var c = boxCol; c < boxCol + 3; c++) {
        if ((r != row || c != col) && board.at(r, c) == value) return false;
      }
    }
    return true;
  }

  bool isBoardValid(SudokuBoard board) {
    for (var r = 0; r < SudokuBoard.size; r++) {
      for (var c = 0; c < SudokuBoard.size; c++) {
        final value = board.at(r, c);
        if (value != 0 && !isMoveValid(board, r, c, value)) {
          return false;
        }
      }
    }
    return true;
  }

  bool isComplete(SudokuBoard board) {
    for (final value in board.entries) {
      if (value == 0) return false;
    }
    return isBoardValid(board);
  }
}
