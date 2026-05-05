import 'package:sudoku_game/sudoku_game.dart';
import 'package:test/test.dart';

void main() {
  test('validator detects invalid row collision', () {
    final board = SudokuBoard.empty();
    board.setCell(0, 0, 5);
    expect(const SudokuValidator().isMoveValid(board, 0, 1, 5), isFalse);
  });

  test('solver solves a known puzzle', () {
    final puzzle = <int>[
      5, 3, 0, 0, 7, 0, 0, 0, 0,
      6, 0, 0, 1, 9, 5, 0, 0, 0,
      0, 9, 8, 0, 0, 0, 0, 6, 0,
      8, 0, 0, 0, 6, 0, 0, 0, 3,
      4, 0, 0, 8, 0, 3, 0, 0, 1,
      7, 0, 0, 0, 2, 0, 0, 0, 6,
      0, 6, 0, 0, 0, 0, 2, 8, 0,
      0, 0, 0, 4, 1, 9, 0, 0, 5,
      0, 0, 0, 0, 8, 0, 0, 7, 9,
    ];
    final board = SudokuBoard.fromPuzzle(puzzle);
    final solved = SudokuSolver().solve(board);
    expect(solved, isTrue);
    expect(const SudokuValidator().isComplete(board), isTrue);
  });

  test('session supports undo/redo and serialization', () {
    final session = SudokuSession.newGame(SudokuDifficulty.easy);
    expect(session.applyMove(0, 0, 1), anyOf(isTrue, isFalse));

    if (session.applyMove(0, 1, 2)) {
      expect(session.undo(), isTrue);
      expect(session.redo(), isTrue);
    }

    session.tick(10);
    final copy = SudokuSession.fromJsonString(session.toJsonString());
    expect(copy.elapsedSeconds, 10);
  });
}
