import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';
import '../widgets/sudoku_board.dart';
import '../widgets/sudoku_keypad.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF06111B), Color(0xFF0A1A27), Color(0xFF123B43)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final content = isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 7, child: _BoardColumn()),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 4,
                          child: _SideColumn(puzzle: SudokuPuzzle.sample),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      children: const [
                        _HeroHeader(),
                        SizedBox(height: 20),
                        _BoardColumn(),
                        SizedBox(height: 20),
                        _SideColumn(puzzle: SudokuPuzzle.sample),
                      ],
                    );

              if (isWide) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: content,
                );
              }

              return content;
            },
          ),
        ),
      ),
    );
  }
}

class _BoardColumn extends StatelessWidget {
  const _BoardColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _HeroHeader(),
        const SizedBox(height: 20),
        const SudokuBoard(puzzle: SudokuPuzzle.sample),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _MetricChip(label: 'Streak', value: '12'),
            _MetricChip(label: 'Mistakes', value: '1'),
            _MetricChip(label: 'Mode', value: 'Classic'),
          ],
        ),
      ],
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn({required this.puzzle});

  final SudokuPuzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 12),
                const _ProgressRow(label: 'Solved', value: '48%'),
                const SizedBox(height: 10),
                const _ProgressRow(label: 'Focus', value: 'High'),
                const SizedBox(height: 10),
                const _ProgressRow(label: 'Timer', value: '12:48'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Controls',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 16),
                const SudokuKeypad(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Board state',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'This branch ships the visual Sudoku shell. Logic wiring can now plug into the board, keypad, and session summary without changing the route structure.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.78),
                  ),
                ),
                const SizedBox(height: 14),
                _BoardLegend(puzzle: puzzle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sudoku Game',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Runnable Flutter UI shell with a focused board, keypad, and room for solver logic.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.76),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      backgroundColor: const Color(0xFF102234),
      label: Text('$label: $value'),
      labelStyle: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _BoardLegend extends StatelessWidget {
  const _BoardLegend({required this.puzzle});

  final SudokuPuzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final selected = puzzle.cells
        .expand((row) => row)
        .where((cell) => cell.isSelected)
        .toList(growable: false);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _LegendPill(
          label: 'Selected',
          value: selected.isNotEmpty ? '${selected.length}' : '0',
        ),
        const _LegendPill(label: 'Given', value: '25'),
        const _LegendPill(label: 'Empty', value: '56'),
      ],
    );
  }
}

class _LegendPill extends StatelessWidget {
  const _LegendPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1D2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
