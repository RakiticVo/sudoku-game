import 'session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SetStringValue = Future<void> Function(String key, String value);
typedef GetStringValue = Future<String?> Function(String key);
typedef RemoveValue = Future<void> Function(String key);

/// Key-value backed storage for Sudoku sessions.
///
/// In Flutter mobile apps, wire this to `SharedPreferences` callbacks.
class PreferencesSessionStorage implements SessionStorage {
  static const String _defaultKey = 'sudoku_session';

  PreferencesSessionStorage({
    required this.key,
    required this.setString,
    required this.getString,
    required this.remove,
  });

  factory PreferencesSessionStorage.instance({String key = _defaultKey}) {
    return PreferencesSessionStorage(
      key: key,
      setString: (k, value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(k, value);
      },
      getString: (k) async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString(k);
      },
      remove: (k) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(k);
      },
    );
  }

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
