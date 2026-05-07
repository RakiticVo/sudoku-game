import 'package:flutter/material.dart';

import '../models/sudoku_difficulty.dart';
import '../navigation/flow_routes.dart';
import 'difficulty_selection_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MenuBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final isWide = maxWidth >= 980;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 28 : 18,
                    vertical: 18,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 36),
                    child: IntrinsicHeight(
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Expanded(flex: 7, child: _MenuHero()),
                                SizedBox(width: 24),
                                SizedBox(width: 360, child: _MenuRail()),
                              ],
                            )
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _MenuHero(),
                                SizedBox(height: 18),
                                _MenuRail(),
                              ],
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuHero extends StatelessWidget {
  const _MenuHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF112233).withValues(alpha: 0.96),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _TopBadge(
                label: 'DAILY',
                value: '4-LEVEL FLOW',
                color: const Color(0xFF39C6A5),
              ),
              const Spacer(),
              _TopBadge(
                label: 'STREAK',
                value: '12 DAYS',
                color: const Color(0xFF38BDF8),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Sudoku Game',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'A four-screen puzzle flow built around a focused board, readable controls, and a clean completion moment.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.76),
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 24),
          const _HeroBoardPreview(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      flowRoute(const DifficultySelectionScreen()),
                    );
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Play'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      flowRoute(
                        DifficultySelectionScreen(
                          startingDifficulty: SudokuDifficulty.medium,
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Choose difficulty'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuRail extends StatelessWidget {
  const _MenuRail();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MenuPanel(
          title: 'MODES',
          child: Column(
            children: const [
              _ModeRow(label: 'Classic', value: 'Board-first'),
              SizedBox(height: 12),
              _ModeRow(label: 'Daily', value: 'Timed challenge'),
              SizedBox(height: 12),
              _ModeRow(label: 'Practice', value: 'No pressure'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _MenuPanel(
          title: 'FLOW',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _FlowStep(index: '1', label: 'Pick a difficulty'),
              SizedBox(height: 12),
              _FlowStep(index: '2', label: 'Solve the puzzle'),
              SizedBox(height: 12),
              _FlowStep(index: '3', label: 'Review completion'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _MenuPanel(
          title: 'PLAYER STATS',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _StatPill(label: 'Best', value: '03:18'),
              _StatPill(label: 'Mistakes', value: '4'),
              _StatPill(label: 'Solved', value: '128'),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopBadge extends StatelessWidget {
  const _TopBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  letterSpacing: 1.8,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _MenuPanel extends StatelessWidget {
  const _MenuPanel({required this.title, required this.child});

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

class _ModeRow extends StatelessWidget {
  const _ModeRow({required this.label, required this.value});

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
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.72),
              ),
        ),
      ],
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({required this.index, required this.label});

  final String index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF13273A),
            shape: BoxShape.circle,
          ),
          child: Text(
            index,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.55),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _HeroBoardPreview extends StatelessWidget {
  const _HeroBoardPreview();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF0A1624),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 16,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final isAccent = index == 5 || index == 10;
            return Container(
              decoration: BoxDecoration(
                color: isAccent
                    ? const Color(0xFF39C6A5).withValues(alpha: 0.16)
                    : const Color(0xFF102030),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isAccent
                      ? const Color(0xFF39C6A5).withValues(alpha: 0.45)
                      : Colors.white.withValues(alpha: 0.05),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MenuBackground extends StatelessWidget {
  const _MenuBackground();

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
