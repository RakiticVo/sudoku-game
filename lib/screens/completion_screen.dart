import 'package:flutter/material.dart';

import '../navigation/flow_routes.dart';
import 'difficulty_selection_screen.dart';
import 'main_menu_screen.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _CompletionBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 980;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 28 : 18,
                    vertical: 18,
                  ),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 7,
                              child: _CompletionHero(difficultyLabel: difficultyLabel),
                            ),
                            SizedBox(width: 24),
                            SizedBox(
                              width: 360,
                              child: _CompletionRail(difficultyLabel: difficultyLabel),
                            ),
                          ],
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _CompletionHero(difficultyLabel: difficultyLabel),
                            SizedBox(height: 18),
                            _CompletionRail(difficultyLabel: difficultyLabel),
                          ],
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

class _CompletionHero extends StatelessWidget {
  const _CompletionHero({required this.difficultyLabel});

  final String difficultyLabel;

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
              TextButton.icon(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                icon: const Icon(Icons.home_outlined, size: 16),
                label: const Text('Menu'),
              ),
              const Spacer(),
              const _Pill(label: 'FLOW', value: 'COMPLETE'),
            ],
          ),
          const SizedBox(height: 24),
          const _SuccessMark(),
          const SizedBox(height: 20),
          Text(
            'Puzzle complete',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            '$difficultyLabel difficulty finished',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF39C6A5),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'The approved flow closes with a focused completion state, quick stats, and direct entry points back into the game loop.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.76),
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 24),
          const _CompletionStats(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      flowRoute(const DifficultySelectionScreen()),
                      (route) => route.isFirst,
                    );
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Play again'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      flowRoute(const MainMenuScreen()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Main menu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompletionRail extends StatelessWidget {
  const _CompletionRail({required this.difficultyLabel});

  final String difficultyLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _RailPanel(
          title: 'RUN SUMMARY',
          child: Column(
            children: [
              _MetricRow(label: 'Time', value: '12:48'),
              SizedBox(height: 12),
              _MetricRow(label: 'Mistakes', value: '1'),
              SizedBox(height: 12),
              _MetricRow(label: 'Difficulty', value: difficultyLabel),
            ],
          ),
        ),
        SizedBox(height: 16),
        _RailPanel(
          title: 'NEXT STEP',
          child: Text(
            'Return to the menu or jump back into the difficulty flow for another board.',
          ),
        ),
      ],
    );
  }
}

class _CompletionStats extends StatelessWidget {
  const _CompletionStats();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const [
        _Stat(label: 'Best', value: '03:18'),
        _Stat(label: 'Solved', value: '128'),
        _Stat(label: 'Combo', value: 'x14'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

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

class _SuccessMark extends StatelessWidget {
  const _SuccessMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF39C6A5).withValues(alpha: 0.16),
        border: Border.all(
          color: const Color(0xFF39C6A5).withValues(alpha: 0.55),
          width: 2,
        ),
      ),
      child: const Icon(Icons.check_rounded, color: Color(0xFF39C6A5), size: 44),
    );
  }
}

class _RailPanel extends StatelessWidget {
  const _RailPanel({required this.title, required this.child});

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

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
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

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF102133),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label  $value',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _CompletionBackground extends StatelessWidget {
  const _CompletionBackground();

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
      child: const SizedBox.expand(),
    );
  }
}
