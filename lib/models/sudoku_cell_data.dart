class SudokuCellData {
  const SudokuCellData({
    required this.value,
    required this.isGiven,
    this.isSelected = false,
    this.isConflict = false,
    this.note,
  });

  final int? value;
  final bool isGiven;
  final bool isSelected;
  final bool isConflict;
  final String? note;
}

class SudokuPuzzle {
  const SudokuPuzzle({required this.cells});

  final List<List<SudokuCellData>> cells;

  static const SudokuPuzzle sample = SudokuPuzzle(
    cells: [
      [
        SudokuCellData(value: 5, isGiven: true),
        SudokuCellData(value: 3, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 7, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
      ],
      [
        SudokuCellData(value: 6, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 1, isGiven: true),
        SudokuCellData(value: 9, isGiven: true),
        SudokuCellData(value: 5, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
      ],
      [
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 9, isGiven: true),
        SudokuCellData(value: 8, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 6, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
      ],
      [
        SudokuCellData(value: 8, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 6, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 3, isGiven: true),
      ],
      [
        SudokuCellData(value: 4, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 8, isGiven: true),
        SudokuCellData(
          value: null,
          isGiven: false,
          isSelected: true,
          note: '2 4',
        ),
        SudokuCellData(value: 3, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 1, isGiven: true),
      ],
      [
        SudokuCellData(value: 7, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 2, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 6, isGiven: true),
      ],
      [
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 6, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 2, isGiven: true),
        SudokuCellData(value: 8, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
      ],
      [
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 4, isGiven: true),
        SudokuCellData(value: 1, isGiven: true),
        SudokuCellData(value: 9, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 5, isGiven: true),
      ],
      [
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 8, isGiven: true),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: null, isGiven: false),
        SudokuCellData(value: 7, isGiven: true),
        SudokuCellData(value: 9, isGiven: true),
      ],
    ],
  );
}
