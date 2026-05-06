import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_game/sudoku_game.dart';

void main() {
  runApp(const SudokuApp());
}

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const SudokuPage(),
    );
  }
}

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key});

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  late SudokuStateController _controller;
  late SudokuAppState _state;
  late SharedPreferences _preferences;
  bool _isInitializing = true;
  Timer? _ticker;

  int? _selectedRow;
  int? _selectedCol;

  @override
  void initState() {
    super.initState();
    _controller = SudokuStateController.newGame(
      SudokuDifficulty.medium,
      storage: InMemorySessionStorage(),
    );
    _state = _controller.state;
    unawaited(_initializeController());
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged(SudokuAppState next) {
    if (!mounted) return;
    setState(() => _state = next);
  }

  SessionStorage _storage() => PreferencesSessionStorage(
        key: 'sudoku_session',
        setString: _preferences.setString,
        getString: _preferences.getString,
        remove: _preferences.remove,
      );

  Future<void> _initializeController() async {
    _preferences = await SharedPreferences.getInstance();
    _controller.removeListener(_onStateChanged);
    _controller = SudokuStateController.newGame(
      SudokuDifficulty.medium,
      storage: _storage(),
    );
    _state = _controller.state;
    _controller.addListener(_onStateChanged);
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _controller.tick();
    });
    await _controller.restore();
    if (!mounted) return;
    setState(() {
      _state = _controller.state;
      _isInitializing = false;
    });
  }

  Future<void> _newGame(SudokuDifficulty difficulty) async {
    if (_isInitializing) return;
    final old = _controller;
    old.removeListener(_onStateChanged);
    _controller = SudokuStateController.newGame(
      difficulty,
      storage: _storage(),
    );
    _controller.addListener(_onStateChanged);
    setState(() {
      _state = _controller.state;
      _selectedRow = null;
      _selectedCol = null;
    });
    await _controller.save();
  }

  String _formatSeconds(int totalSeconds) {
    final mins = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final title = 'Sudoku (${_state.difficulty.name})';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          PopupMenuButton<SudokuDifficulty>(
            onSelected: _newGame,
            itemBuilder: (context) => SudokuDifficulty.values
                .map((d) => PopupMenuItem(value: d, child: Text('New ${d.name}')))
                .toList(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time: ${_formatSeconds(_state.elapsedSeconds)}'),
                  if (_state.isComplete)
                    const Text(
                      'Completed',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                    ),
                    itemCount: 81,
                    itemBuilder: (context, index) {
                      final row = index ~/ 9;
                      final col = index % 9;
                      final value = _state.board.at(row, col);
                      final isGiven = _state.board.isGiven(row, col);
                      final isSelected = _selectedRow == row && _selectedCol == col;

                      return GestureDetector(
                        onTap: isGiven
                            ? null
                            : () => setState(() {
                                  _selectedRow = row;
                                  _selectedCol = col;
                                }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.indigo.shade100 : Colors.white,
                            border: Border(
                              left: BorderSide(width: col % 3 == 0 ? 2 : 0.5),
                              right: BorderSide(width: col == 8 ? 2 : 0.5),
                              top: BorderSide(width: row % 3 == 0 ? 2 : 0.5),
                              bottom: BorderSide(width: row == 8 ? 2 : 0.5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              value == 0 ? '' : '$value',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isGiven ? FontWeight.bold : FontWeight.w500,
                                color: isGiven ? Colors.black : Colors.indigo,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int n = 1; n <= 9; n++)
                  SizedBox(
                    width: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_selectedRow == null || _selectedCol == null) return;
                        final changed = _controller.applyMove(_selectedRow!, _selectedCol!, n);
                        if (changed) {
                          await _controller.save();
                        }
                      },
                      child: Text('$n'),
                    ),
                  ),
                SizedBox(
                  width: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectedRow == null || _selectedCol == null) return;
                      final changed = _controller.applyMove(_selectedRow!, _selectedCol!, 0);
                      if (changed) {
                        await _controller.save();
                      }
                    },
                    child: const Text('Clr'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _state.canUndo
                      ? () async {
                          if (_controller.undo()) {
                            await _controller.save();
                          }
                        }
                      : null,
                  child: const Text('Undo'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _state.canRedo
                      ? () async {
                          if (_controller.redo()) {
                            await _controller.save();
                          }
                        }
                      : null,
                  child: const Text('Redo'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await _controller.save();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Session saved')),
                    );
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final restored = await _controller.restore();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(restored ? 'Session restored' : 'No saved session')),
                    );
                  },
                  child: const Text('Load'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
