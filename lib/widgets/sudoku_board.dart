import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';
import 'sudoku_cell.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({super.key, required this.puzzle});

  final SudokuPuzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF071422),
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color(0xAA000000),
                blurRadius: 30,
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

              return SudokuCell(
                data: cell,
                isThinRightBorder: col != 2 && col != 5,
                isThinBottomBorder: row != 2 && row != 5,
              );
            },
          ),
        ),
      ),
    );
  }
}
