import 'package:flutter/material.dart';

import '../screens/main_menu_screen.dart';

class SudokuGameApp extends StatelessWidget {
  const SudokuGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF39C6A5);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      surface: const Color(0xFF0E1A28),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sudoku Game',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF07111A),
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF102130).withValues(alpha: 0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF102133),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
          labelStyle: const TextStyle(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF13273A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}
