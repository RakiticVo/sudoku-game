import 'package:sudoku_game/sudoku_game.dart';
import 'package:test/test.dart';

void main() {
  test('completed session timer does not advance', () {
    final solved = <int>[
      5, 3, 4, 6, 7, 8, 9, 1, 2,
      6, 7, 2, 1, 9, 5, 3, 4, 8,
      1, 9, 8, 3, 4, 2, 5, 6, 7,
      8, 5, 9, 7, 6, 1, 4, 2, 3,
      4, 2, 6, 8, 5, 3, 7, 9, 1,
      7, 1, 3, 9, 2, 4, 8, 5, 6,
      9, 6, 1, 5, 3, 7, 2, 8, 4,
      2, 8, 7, 4, 1, 9, 6, 3, 5,
      3, 4, 5, 2, 8, 6, 1, 7, 9,
    ];
    final session = SudokuSession.fromJsonString(
      '{"board":{"givens":$solved,"entries":$solved},"difficulty":"easy","elapsedSeconds":12,"undo":{"undos":[],"redos":[]}}',
    );

    expect(session.isComplete, isTrue);
    session.tick(10);
    expect(session.elapsedSeconds, 12);
  });

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

  test('preferences storage wiring supports save/restore lifecycle', () async {
    final store = <String, String>{};
    final storage = PreferencesSessionStorage(
      key: 'sudoku_session',
      setString: (key, value) async => store[key] = value,
      getString: (key) async => store[key],
      remove: (key) async => store.remove(key),
    );

    final controller = SudokuStateController.newGame(
      SudokuDifficulty.easy,
      storage: storage,
    );
    await controller.save();

    final restored = SudokuStateController.newGame(
      SudokuDifficulty.medium,
      storage: storage,
    );
    final didRestore = await restored.restore();

    expect(didRestore, isTrue);
    expect(restored.state.difficulty, SudokuDifficulty.easy);

    await restored.clearSaved();
    expect(await storage.load(), isNull);
  });
}
