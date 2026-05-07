import 'package:flutter/material.dart';

class SudokuKeypad extends StatelessWidget {
  const SudokuKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.15,
          children: const [
            _KeyTile(label: '1'),
            _KeyTile(label: '2'),
            _KeyTile(label: '3'),
            _KeyTile(label: '4'),
            _KeyTile(label: '5'),
            _KeyTile(label: '6'),
            _KeyTile(label: '7'),
            _KeyTile(label: '8'),
            _KeyTile(label: '9'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(child: _ActionTile(label: 'Erase', icon: Icons.backspace_outlined)),
            SizedBox(width: 10),
            Expanded(child: _ActionTile(label: 'Note', icon: Icons.edit_note_outlined)),
            SizedBox(width: 10),
            Expanded(child: _ActionTile(label: 'Hint', icon: Icons.lightbulb_outline)),
          ],
        ),
      ],
    );
  }
}

class _KeyTile extends StatelessWidget {
  const _KeyTile({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return _BaseTile(
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _BaseTile(
      emphasis: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white.withValues(alpha: 0.92)),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _BaseTile extends StatelessWidget {
  const _BaseTile({required this.child, this.emphasis = false});

  final Widget child;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final background = emphasis
        ? const Color(0xFF13273A)
        : const Color(0xFF102233);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x50000000),
                blurRadius: 14,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
