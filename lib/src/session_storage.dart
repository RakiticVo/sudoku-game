abstract class SessionStorage {
  Future<void> save(String payload);
  Future<String?> load();
  Future<void> clear();
}

class InMemorySessionStorage implements SessionStorage {
  String? _payload;

  @override
  Future<void> save(String payload) async {
    _payload = payload;
  }

  @override
  Future<String?> load() async => _payload;

  @override
  Future<void> clear() async {
    _payload = null;
  }
}
