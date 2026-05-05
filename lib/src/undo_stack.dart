class MoveAction {
  MoveAction({required this.row, required this.col, required this.before, required this.after});

  final int row;
  final int col;
  final int before;
  final int after;
}

class UndoStack {
  UndoStack();

  final List<MoveAction> _undo = <MoveAction>[];
  final List<MoveAction> _redo = <MoveAction>[];

  bool get canUndo => _undo.isNotEmpty;
  bool get canRedo => _redo.isNotEmpty;

  void push(MoveAction action) {
    _undo.add(action);
    _redo.clear();
  }

  MoveAction? undo() {
    if (_undo.isEmpty) return null;
    final action = _undo.removeLast();
    _redo.add(action);
    return action;
  }

  MoveAction? redo() {
    if (_redo.isEmpty) return null;
    final action = _redo.removeLast();
    _undo.add(action);
    return action;
  }

  void clear() {
    _undo.clear();
    _redo.clear();
  }

  Map<String, dynamic> toJson() => {
        'undo': _undo
            .map((e) => {'row': e.row, 'col': e.col, 'before': e.before, 'after': e.after})
            .toList(),
        'redo': _redo
            .map((e) => {'row': e.row, 'col': e.col, 'before': e.before, 'after': e.after})
            .toList(),
      };

  factory UndoStack.fromJson(Map<String, dynamic> json) {
    final stack = UndoStack();
    stack._undo.addAll(_readActions(json['undo'] as List<dynamic>));
    stack._redo.addAll(_readActions(json['redo'] as List<dynamic>));
    return stack;
  }

  static List<MoveAction> _readActions(List<dynamic> source) {
    return source
        .map((e) => e as Map<String, dynamic>)
        .map(
          (e) => MoveAction(
            row: e['row'] as int,
            col: e['col'] as int,
            before: e['before'] as int,
            after: e['after'] as int,
          ),
        )
        .toList();
  }
}
