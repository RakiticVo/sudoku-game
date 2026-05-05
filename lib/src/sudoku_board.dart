class SudokuBoard {
  static const int size = 9;
  static const int cellCount = 81;

  final List<int> givens;
  final List<int> entries;

  SudokuBoard._(this.givens, this.entries);

  factory SudokuBoard.empty() => SudokuBoard._(
        List<int>.filled(cellCount, 0),
        List<int>.filled(cellCount, 0),
      );

  factory SudokuBoard.fromPuzzle(List<int> puzzle) {
    _validateCells(puzzle);
    return SudokuBoard._(List<int>.from(puzzle), List<int>.from(puzzle));
  }

  int at(int row, int col) => entries[_index(row, col)];

  bool isGiven(int row, int col) => givens[_index(row, col)] != 0;

  SudokuBoard copy() => SudokuBoard._(List<int>.from(givens), List<int>.from(entries));

  bool setCell(int row, int col, int value) {
    _validateCellValue(value);
    final idx = _index(row, col);
    if (givens[idx] != 0) return false;
    entries[idx] = value;
    return true;
  }

  Map<String, dynamic> toJson() => {
        'givens': givens,
        'entries': entries,
      };

  factory SudokuBoard.fromJson(Map<String, dynamic> json) {
    final givens = List<int>.from(json['givens'] as List<dynamic>);
    final entries = List<int>.from(json['entries'] as List<dynamic>);
    _validateCells(givens);
    _validateCells(entries);
    return SudokuBoard._(givens, entries);
  }

  static int _index(int row, int col) {
    if (row < 0 || row >= size || col < 0 || col >= size) {
      throw ArgumentError('row/col out of range');
    }
    return (row * size) + col;
  }

  static void _validateCellValue(int value) {
    if (value < 0 || value > 9) {
      throw ArgumentError('cell value must be in range 0..9');
    }
  }

  static void _validateCells(List<int> values) {
    if (values.length != cellCount) {
      throw ArgumentError('board must contain 81 cells');
    }
    for (final value in values) {
      _validateCellValue(value);
    }
  }
}
