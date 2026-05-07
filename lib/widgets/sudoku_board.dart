import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';
import 'sudoku_cell.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({super.key, required this.puzzle});

  final SudokuPuzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final selectedPosition = _selectedPosition(puzzle);

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF08131F),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x8A000000),
                blurRadius: 28,
                offset: Offset(0, 18),
              ),
            ],
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 81,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemBuilder: (context, index) {
              final row = index ~/ 9;
              final col = index % 9;
              final cell = puzzle.cells[row][col];
              final isSelected = cell.isSelected;
              final isRelated = selectedPosition != null &&
                  !isSelected &&
                  (selectedPosition.$1 == row ||
                      selectedPosition.$2 == col ||
                      _sameBox(selectedPosition.$1, selectedPosition.$2, row, col));

              return SudokuCell(
                data: cell,
                isSelected: isSelected,
                isRelated: isRelated,
                isSectionRight: col == 2 || col == 5,
                isSectionBottom: row == 2 || row == 5,
              );
            },
          ),
        ),
      ),
    );
  }

  (int, int)? _selectedPosition(SudokuPuzzle puzzle) {
    for (var row = 0; row < puzzle.cells.length; row++) {
      for (var col = 0; col < puzzle.cells[row].length; col++) {
        if (puzzle.cells[row][col].isSelected) {
          return (row, col);
        }
      }
    }
    return null;
  }

  bool _sameBox(int rowA, int colA, int rowB, int colB) {
    return rowA ~/ 3 == rowB ~/ 3 && colA ~/ 3 == colB ~/ 3;
  }
}
