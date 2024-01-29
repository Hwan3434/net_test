import 'app_cache.dart';

final class ListCache<T> extends AppCache<T> {
  final List<T> data = [];

  @override
  void delete(T data) {
    this.data.remove(data);
  }

  @override
  void save(T data) {
    this.data.add(data);
  }
}
