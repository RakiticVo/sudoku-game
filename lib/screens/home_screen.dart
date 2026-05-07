import 'package:flutter/material.dart';

import '../models/sudoku_cell_data.dart';
import '../navigation/flow_routes.dart';
import 'completion_screen.dart';
import '../widgets/sudoku_board.dart';
import '../widgets/sudoku_keypad.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.difficultyLabel = 'Medium'});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 1040;
                final content = isWide
                    ? _WideLayout(difficultyLabel: difficultyLabel)
                    : _NarrowLayout(difficultyLabel: difficultyLabel);

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 28 : 18,
                    vertical: 18,
                  ),
                  child: content,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return _WideLayoutBody(difficultyLabel: difficultyLabel);
  }
}

class _WideLayoutBody extends StatelessWidget {
  const _WideLayoutBody({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: _MainColumn(difficultyLabel: difficultyLabel)),
        SizedBox(width: 24),
        SizedBox(width: 360, child: _ControlRail(difficultyLabel: difficultyLabel)),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return _NarrowLayoutBody(difficultyLabel: difficultyLabel);
  }
}

class _NarrowLayoutBody extends StatelessWidget {
  const _NarrowLayoutBody({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _MainColumn(difficultyLabel: difficultyLabel),
        SizedBox(height: 18),
        _ControlRail(difficultyLabel: difficultyLabel),
      ],
    );
  }
}

class _MainColumn extends StatelessWidget {
  const _MainColumn({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopBar(difficultyLabel: difficultyLabel),
        const SizedBox(height: 18),
        _BoardShell(
          child: const SudokuBoard(puzzle: SudokuPuzzle.sample),
        ),
        const SizedBox(height: 14),
        const _HintStrip(),
      ],
    );
  }
}

class _ControlRail extends StatelessWidget {
  const _ControlRail({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StatCard(
          title: 'SESSION',
          child: Column(
            children: const [
              _StatRow(label: 'Timer', value: '12:48'),
              SizedBox(height: 12),
              _StatRow(label: 'Mistakes', value: '1'),
              SizedBox(height: 12),
              _StatRow(label: 'Mode', value: 'Classic'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _StatCard(
          title: 'INPUT',
          child: const SudokuKeypad(),
        ),
        const SizedBox(height: 16),
        _StatCard(
          title: 'BOARD STATE',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BoardSummary(),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    flowRoute(
                      CompletionScreen(difficultyLabel: difficultyLabel),
                    ),
                  );
                },
                child: const Text('Complete puzzle'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF102130),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sudoku Game',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.1,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Centered board, compact controls, and clear puzzle state for focused play.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.76),
                      height: 1.35,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _TopPill(difficultyLabel: difficultyLabel),
      ],
    );
  }
}

class _TopPill extends StatelessWidget {
  const _TopPill({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF102130).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'DIFFICULTY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.55),
                ),
          ),
          const SizedBox(height: 6),
          Text(
            difficultyLabel,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _BoardShell extends StatelessWidget {
  const _BoardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF112334).withValues(alpha: 0.96),
            const Color(0xFF0A1624).withValues(alpha: 0.92),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x8A000000),
            blurRadius: 36,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HintStrip extends StatelessWidget {
  const _HintStrip();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const [
        _Tag(label: 'Highlights row + column'),
        _Tag(label: 'Notes stay compact'),
        _Tag(label: 'Selected cell glows'),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF102030),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.84),
            ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1E2C).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 24,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.56),
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.74),
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _BoardSummary extends StatelessWidget {
  const _BoardSummary();

  @override
  Widget build(BuildContext context) {
    final puzzle = SudokuPuzzle.sample;
    final selected = puzzle.cells.expand((row) => row).where((cell) => cell.isSelected);
    final givens = puzzle.cells.expand((row) => row).where((cell) => cell.isGiven);
    final empty = puzzle.cells.expand((row) => row).where((cell) => cell.value == null);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _SummaryPill(label: 'Selected', value: '${selected.length}'),
        _SummaryPill(label: 'Given', value: '${givens.length}'),
        _SummaryPill(label: 'Empty', value: '${empty.length}'),
      ],
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF102133),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.86),
            ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF050B12),
            Color(0xFF081624),
            Color(0xFF0D2535),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -60,
            child: _Glow(color: const Color(0xFF39C6A5).withValues(alpha: 0.12), size: 240),
          ),
          Positioned(
            top: 120,
            right: -80,
            child: _Glow(color: const Color(0xFF39C6A5).withValues(alpha: 0.08), size: 300),
          ),
          Positioned(
            bottom: -120,
            left: 40,
            child: _Glow(color: const Color(0xFF6D8CFF).withValues(alpha: 0.08), size: 280),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
