import 'package:flutter/material.dart';

class SudokuKeypad extends StatelessWidget {
  const SudokuKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = <_KeypadAction>[
      const _KeypadAction(label: '1'),
      const _KeypadAction(label: '2'),
      const _KeypadAction(label: '3'),
      const _KeypadAction(label: '4'),
      const _KeypadAction(label: '5'),
      const _KeypadAction(label: '6'),
      const _KeypadAction(label: '7'),
      const _KeypadAction(label: '8'),
      const _KeypadAction(label: '9'),
      const _KeypadAction(label: 'Erase', icon: Icons.backspace_outlined),
      const _KeypadAction(label: 'Note', icon: Icons.edit_note),
      const _KeypadAction(label: 'Hint', icon: Icons.lightbulb_outline),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final action in buttons)
          SizedBox(
            width: action.isNumber ? 72 : 112,
            child: FilledButton.tonalIcon(
              onPressed: () {},
              icon: Icon(action.icon, size: 18),
              label: Text(action.label),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _KeypadAction {
  const _KeypadAction({required this.label, this.icon = Icons.circle});

  final String label;
  final IconData icon;

  bool get isNumber => label.length == 1;
}
