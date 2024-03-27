abstract interface class JsStorage {
  Future<void> setInt({required String key, required int value});
  Future<void> setString({required String key, required String value});
  Future<String?> getString({required String key});
  Future<int?> getInt({required String key});
}
