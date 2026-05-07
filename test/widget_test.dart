import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sudoku_game/app/sudoku_game_app.dart';

void main() {
  testWidgets('renders the four-screen sudoku flow', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 1100));
    addTearDown(() async => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const SudokuGameApp());
    await tester.pumpAndSettle();

    expect(find.text('Sudoku Game'), findsWidgets);
    expect(find.text('Play'), findsOneWidget);

    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    expect(find.text('Select difficulty'), findsOneWidget);
    expect(find.text('Easy'), findsWidgets);

    await tester.tap(find.text('Start').first);
    await tester.pumpAndSettle();

    expect(find.text('Centered board, compact controls, and clear puzzle state for focused play.'), findsWidgets);
    expect(find.text('Complete puzzle'), findsOneWidget);

    await tester.tap(find.text('Complete puzzle'));
    await tester.pumpAndSettle();

    expect(find.text('Puzzle complete'), findsOneWidget);
    expect(find.text('Play again'), findsOneWidget);
    expect(find.text('Main menu'), findsOneWidget);
  });
}
