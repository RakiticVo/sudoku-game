import 'session_storage.dart';
import 'sudoku_app_state.dart';
import 'sudoku_generator.dart';
import 'sudoku_session.dart';

class SudokuStateController {
  SudokuStateController({
    required SudokuSession session,
    SessionStorage? storage,
  })  : _session = session,
        _storage = storage;

  SudokuSession _session;
  final SessionStorage? _storage;
  final List<void Function(SudokuAppState)> _listeners = <void Function(SudokuAppState)>[];

  SudokuAppState get state => _toState(_session);

  static SudokuStateController newGame(
    SudokuDifficulty difficulty, {
    SudokuGenerator? generator,
    SessionStorage? storage,
  }) {
    final session = SudokuSession.newGame(difficulty, generator: generator);
    return SudokuStateController(session: session, storage: storage);
  }

  void addListener(void Function(SudokuAppState) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(SudokuAppState) listener) {
    _listeners.remove(listener);
  }

  bool applyMove(int row, int col, int value) {
    final changed = _session.applyMove(row, col, value);
    if (changed) _emit();
    return changed;
  }

  bool undo() {
    final changed = _session.undo();
    if (changed) _emit();
    return changed;
  }

  bool redo() {
    final changed = _session.redo();
    if (changed) _emit();
    return changed;
  }

  void tick([int seconds = 1]) {
    final before = _session.elapsedSeconds;
    _session.tick(seconds);
    if (_session.elapsedSeconds != before) {
      _emit();
    }
  }

  Future<void> save() async {
    if (_storage == null) return;
    await _storage.save(_session.toJsonString());
  }

  Future<bool> restore() async {
    if (_storage == null) return false;
    final payload = await _storage.load();
    if (payload == null || payload.isEmpty) return false;
    _session = SudokuSession.fromJsonString(payload);
    _emit();
    return true;
  }

  Future<void> clearSaved() async {
    await _storage?.clear();
  }

  void _emit() {
    final snapshot = state;
    for (final listener in List<void Function(SudokuAppState)>.from(_listeners)) {
      listener(snapshot);
    }
  }

  SudokuAppState _toState(SudokuSession session) {
    return SudokuAppState(
      board: session.board.copy(),
      difficulty: session.difficulty,
      elapsedSeconds: session.elapsedSeconds,
      canUndo: session.canUndo,
      canRedo: session.canRedo,
      isComplete: session.isComplete,
    );
  }
}
