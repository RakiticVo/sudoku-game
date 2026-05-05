import 'dart:convert';

import 'sudoku_board.dart';
import 'sudoku_generator.dart';
import 'sudoku_validator.dart';
import 'undo_stack.dart';

class SudokuSession {
  SudokuSession._({
    required this.board,
    required this.difficulty,
    required this.elapsedSeconds,
    required UndoStack undoStack,
    SudokuValidator? validator,
  })  : _undoStack = undoStack,
        _validator = validator ?? const SudokuValidator();

  factory SudokuSession.newGame(SudokuDifficulty difficulty, {SudokuGenerator? generator}) {
    final puzzle = (generator ?? SudokuGenerator()).generate(difficulty);
    return SudokuSession._(
      board: puzzle,
      difficulty: difficulty,
      elapsedSeconds: 0,
      undoStack: UndoStack(),
    );
  }

  final SudokuBoard board;
  final SudokuDifficulty difficulty;
  int elapsedSeconds;
  final UndoStack _undoStack;
  final SudokuValidator _validator;

  bool get isComplete => _validator.isComplete(board);
  bool get canUndo => _undoStack.canUndo;
  bool get canRedo => _undoStack.canRedo;

  bool applyMove(int row, int col, int value) {
    final before = board.at(row, col);
    if (!_validator.isMoveValid(board, row, col, value)) return false;
    if (!board.setCell(row, col, value)) return false;
    _undoStack.push(MoveAction(row: row, col: col, before: before, after: value));
    return true;
  }

  bool undo() {
    final action = _undoStack.undo();
    if (action == null) return false;
    board.setCell(action.row, action.col, action.before);
    return true;
  }

  bool redo() {
    final action = _undoStack.redo();
    if (action == null) return false;
    board.setCell(action.row, action.col, action.after);
    return true;
  }

  void tick([int seconds = 1]) {
    if (seconds < 0) {
      throw ArgumentError('seconds must be >= 0');
    }
    elapsedSeconds += seconds;
  }

  String toJsonString() => jsonEncode({
        'board': board.toJson(),
        'difficulty': difficulty.name,
        'elapsedSeconds': elapsedSeconds,
        'undo': _undoStack.toJson(),
      });

  factory SudokuSession.fromJsonString(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    final difficulty = SudokuDifficulty.values.firstWhere((e) => e.name == map['difficulty']);
    return SudokuSession._(
      board: SudokuBoard.fromJson(map['board'] as Map<String, dynamic>),
      difficulty: difficulty,
      elapsedSeconds: map['elapsedSeconds'] as int,
      undoStack: UndoStack.fromJson(map['undo'] as Map<String, dynamic>),
    );
  }
}
