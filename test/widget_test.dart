import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku_game/app/sudoku_game_app.dart';
import 'package:sudoku_game/widgets/sudoku_board.dart';
import 'package:sudoku_game/widgets/sudoku_keypad.dart';

void main() {
  testWidgets('renders sudoku shell', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 1100));
    addTearDown(() async => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const SudokuGameApp());
    await tester.pumpAndSettle();

    expect(find.text('Sudoku Game'), findsWidgets);
    expect(
      find.text(
        'Runnable Flutter UI shell with a focused board, keypad, and room for solver logic.',
      ),
      findsWidgets,
    );
    expect(find.text('Session'), findsOneWidget);
    expect(find.text('Controls'), findsOneWidget);
    expect(find.byType(SudokuBoard), findsOneWidget);
    expect(find.byType(SudokuKeypad), findsOneWidget);
  });
}
