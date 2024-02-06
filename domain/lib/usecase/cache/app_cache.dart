class DataCache<T> {
  final Map<int, T?> data = {};
  DataCache();

  void add(String paramKey, T item) {
    data[paramKey.hashCode] = item;
  }

  T? getFromParameter(String paramKey) {
    final key = paramKey.hashCode;
    if (!data.containsKey(key)) {
      return null;
    }
    return data[key];
  }
}
