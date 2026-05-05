import 'dart:io';

import 'session_storage.dart';

class FileSessionStorage implements SessionStorage {
  FileSessionStorage({required this.filePath});

  final String filePath;

  @override
  Future<void> save(String payload) async {
    final file = File(filePath);
    await file.parent.create(recursive: true);
    await file.writeAsString(payload);
  }

  @override
  Future<String?> load() async {
    final file = File(filePath);
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  @override
  Future<void> clear() async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
