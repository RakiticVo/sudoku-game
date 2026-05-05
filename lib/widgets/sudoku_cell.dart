import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';

class SudokuCell extends StatelessWidget {
  const SudokuCell({
    super.key,
    required this.data,
    required this.isThinRightBorder,
    required this.isThinBottomBorder,
  });

  final SudokuCellData data;
  final bool isThinRightBorder;
  final bool isThinBottomBorder;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasValue = data.value != null;

    final borderColor = data.isSelected
        ? scheme.primary
        : data.isConflict
        ? scheme.error
        : const Color(0xFF294055);

    final backgroundColor = data.isSelected
        ? scheme.primary.withValues(alpha: 0.14)
        : data.isGiven
        ? const Color(0xFF0F1D2B)
        : const Color(0xFF0A1623);

    final valueStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: data.isGiven ? FontWeight.w800 : FontWeight.w700,
      color: data.isGiven
          ? Colors.white
          : data.isSelected
          ? scheme.primary
          : Colors.white.withValues(alpha: 0.9),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: const BorderSide(color: Color(0xFF294055), width: 0.5),
          top: const BorderSide(color: Color(0xFF294055), width: 0.5),
          right: BorderSide(
            color: borderColor,
            width: isThinRightBorder ? 0.5 : 1.8,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: isThinBottomBorder ? 0.5 : 1.8,
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: valueStyle ?? const TextStyle(),
              child: Text(hasValue ? '${data.value}' : ''),
            ),
          ),
          if (data.note != null && !hasValue)
            Positioned(
              right: 6,
              top: 5,
              child: Text(
                data.note!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.2,
                ),
              ),
            ),
          if (data.isGiven)
            Positioned(
              left: 6,
              bottom: 5,
              child: Icon(
                Icons.lock_outline,
                size: 11,
                color: Colors.white.withValues(alpha: 0.22),
              ),
            ),
        ],
      ),
    );
  }
}
