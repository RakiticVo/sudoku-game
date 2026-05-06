import 'session_storage.dart';

typedef SetStringValue = Future<void> Function(String key, String value);
typedef GetStringValue = Future<String?> Function(String key);
typedef RemoveValue = Future<void> Function(String key);

/// Key-value backed storage for Sudoku sessions.
///
/// In Flutter mobile apps, wire this to `SharedPreferences` callbacks.
class PreferencesSessionStorage implements SessionStorage {
  PreferencesSessionStorage({
    required this.key,
    required this.setString,
    required this.getString,
    required this.remove,
  });

  final String key;
  final SetStringValue setString;
  final GetStringValue getString;
  final RemoveValue remove;

  @override
  Future<void> save(String payload) => setString(key, payload);

  @override
  Future<String?> load() => getString(key);

  @override
  Future<void> clear() => remove(key);
}
