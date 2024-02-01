class DataCache<T> {
  final Map<int, T?> data = {};
  DataCache();

  int createHashCode(List<dynamic> param) {
    int hash = 0;
    for (int i = 0; i < param.length; i++) {
      int variableHash = param[i].hashCode;
      hash = hash ^ (variableHash * i);
    }
    return hash;
  }

  void add(List<dynamic> param, T item) {
    data[createHashCode(param)] = item;
  }

  T? getFromParameter(List<dynamic> param) {
    final key = createHashCode(param);
    if (!data.containsKey(key)) {
      return null;
    }
    return data[key];
  }
}
