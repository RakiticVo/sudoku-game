import 'sudoku_board.dart';
import 'sudoku_generator.dart';

class SudokuAppState {
  const SudokuAppState({
    required this.board,
    required this.difficulty,
    required this.elapsedSeconds,
    required this.canUndo,
    required this.canRedo,
    required this.isComplete,
  });

  final SudokuBoard board;
  final SudokuDifficulty difficulty;
  final int elapsedSeconds;
  final bool canUndo;
  final bool canRedo;
  final bool isComplete;

  SudokuAppState copyWith({
    SudokuBoard? board,
    SudokuDifficulty? difficulty,
    int? elapsedSeconds,
    bool? canUndo,
    bool? canRedo,
    bool? isComplete,
  }) {
    return SudokuAppState(
      board: board ?? this.board,
      difficulty: difficulty ?? this.difficulty,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      canUndo: canUndo ?? this.canUndo,
      canRedo: canRedo ?? this.canRedo,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
