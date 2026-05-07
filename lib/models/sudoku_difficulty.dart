import 'package:flutter/material.dart';

enum SudokuDifficulty { easy, medium, hard, expert }

extension SudokuDifficultyX on SudokuDifficulty {
  String get label => switch (this) {
        SudokuDifficulty.easy => 'Easy',
        SudokuDifficulty.medium => 'Medium',
        SudokuDifficulty.hard => 'Hard',
        SudokuDifficulty.expert => 'Expert',
      };

  String get description => switch (this) {
        SudokuDifficulty.easy => 'A softer opening with fewer givens.',
        SudokuDifficulty.medium => 'Balanced puzzle structure for most players.',
        SudokuDifficulty.hard => 'Tighter board with fewer obvious moves.',
        SudokuDifficulty.expert => 'High-pressure layout for experienced players.',
      };

  String get durationHint => switch (this) {
        SudokuDifficulty.easy => '8-12 min',
        SudokuDifficulty.medium => '12-18 min',
        SudokuDifficulty.hard => '18-25 min',
        SudokuDifficulty.expert => '25+ min',
      };

  Color get accent => switch (this) {
        SudokuDifficulty.easy => const Color(0xFF2DD4BF),
        SudokuDifficulty.medium => const Color(0xFF38BDF8),
        SudokuDifficulty.hard => const Color(0xFFF59E0B),
        SudokuDifficulty.expert => const Color(0xFFF97316),
      };
}
