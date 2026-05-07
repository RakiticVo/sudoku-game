import 'package:flutter/material.dart';

import '../models/sudoku_difficulty.dart';
import '../navigation/flow_routes.dart';
import 'home_screen.dart';

class DifficultySelectionScreen extends StatelessWidget {
  const DifficultySelectionScreen({super.key, this.startingDifficulty});

  final SudokuDifficulty? startingDifficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _DifficultyBackground(),
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
                          children: const [
                            Expanded(flex: 7, child: _DifficultyHero()),
                            SizedBox(width: 24),
                            SizedBox(width: 360, child: _DifficultyRail()),
                          ],
                        )
                      : const ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _DifficultyHero(),
                            SizedBox(height: 18),
                            _DifficultyRail(),
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

class _DifficultyHero extends StatelessWidget {
  const _DifficultyHero();

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
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                label: const Text('Back'),
              ),
              const Spacer(),
              _Pill(label: 'CHOOSE', value: 'DIFFICULTY'),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Select difficulty',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'The approved flow starts here. Pick a challenge level, then enter the focused board screen.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.76),
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: SudokuDifficulty.values.map((difficulty) {
              final isDefault = startingDifficulty == difficulty;
              return _DifficultyCard(
                difficulty: difficulty,
                isDefault: isDefault,
                onTap: () {
                  Navigator.of(context).push(
                    flowRoute(
                      HomeScreen(difficultyLabel: difficulty.label),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DifficultyRail extends StatelessWidget {
  const _DifficultyRail();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RailPanel(
          title: 'FLOW NOTES',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Step(index: '1', label: 'Choose a level'),
              SizedBox(height: 12),
              _Step(index: '2', label: 'Play the puzzle'),
              SizedBox(height: 12),
              _Step(index: '3', label: 'Complete the run'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _RailPanel(
          title: 'DIFFICULTY METRICS',
          child: Column(
            children: const [
              _Metric(label: 'Easy', value: '8-12 min'),
              SizedBox(height: 12),
              _Metric(label: 'Hard', value: '18-25 min'),
              SizedBox(height: 12),
              _Metric(label: 'Expert', value: '25+ min'),
            ],
          ),
        ),
      ],
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  const _DifficultyCard({
    required this.difficulty,
    required this.isDefault,
    required this.onTap,
  });

  final SudokuDifficulty difficulty;
  final bool isDefault;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF102130).withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDefault
                    ? difficulty.accent.withValues(alpha: 0.65)
                    : Colors.white.withValues(alpha: 0.06),
              ),
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
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: difficulty.accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      difficulty.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  difficulty.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.74),
                        height: 1.45,
                      ),
                ),
                const SizedBox(height: 14),
                _Pill(label: 'EST.', value: difficulty.durationHint),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onTap,
                    child: const Text('Start'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

class _Step extends StatelessWidget {
  const _Step({required this.index, required this.label});

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

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

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

class _DifficultyBackground extends StatelessWidget {
  const _DifficultyBackground();

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
