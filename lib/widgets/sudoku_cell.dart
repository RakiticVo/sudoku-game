import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';

class SudokuCell extends StatelessWidget {
  const SudokuCell({
    super.key,
    required this.data,
    required this.isSelected,
    required this.isRelated,
    required this.isSectionRight,
    required this.isSectionBottom,
  });

  final SudokuCellData data;
  final bool isSelected;
  final bool isRelated;
  final bool isSectionRight;
  final bool isSectionBottom;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasValue = data.value != null;

    final backgroundColor = isSelected
        ? scheme.primary.withValues(alpha: 0.18)
        : isRelated
            ? scheme.primary.withValues(alpha: 0.07)
            : data.isGiven
                ? const Color(0xFF0E1B29)
                : const Color(0xFF0A1622);

    final borderColor = data.isConflict
        ? scheme.error
        : isSelected
            ? scheme.primary
            : isRelated
                ? scheme.primary.withValues(alpha: 0.42)
                : const Color(0xFF27394A);

    final textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: data.isGiven ? FontWeight.w800 : FontWeight.w700,
          color: data.isGiven
              ? Colors.white
              : isSelected
                  ? scheme.primary
                  : Colors.white.withValues(alpha: 0.9),
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: BorderSide(
            color: const Color(0xFF27394A),
            width: isSectionRight ? 0.5 : 0.45,
          ),
          top: BorderSide(
            color: const Color(0xFF27394A),
            width: isSectionBottom ? 0.5 : 0.45,
          ),
          right: BorderSide(
            color: borderColor,
            width: isSectionRight ? 2.1 : 0.55,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: isSectionBottom ? 2.1 : 0.55,
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: textStyle ?? const TextStyle(),
              child: Text(hasValue ? '${data.value}' : ''),
            ),
          ),
          if (data.note != null && !hasValue)
            Positioned(
              right: 6,
              top: 4,
              child: Text(
                data.note!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.42),
                      letterSpacing: 1.15,
                    ),
              ),
            ),
          if (data.isGiven)
            Positioned(
              left: 6,
              bottom: 4,
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
