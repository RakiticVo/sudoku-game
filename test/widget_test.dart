import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_game/main.dart';

void main() {
  testWidgets('renders Sudoku app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const SudokuApp());

    expect(find.textContaining('Sudoku'), findsWidgets);
    expect(find.text('Undo'), findsOneWidget);
    expect(find.text('Redo'), findsOneWidget);
  });
}
