abstract class CacheConfig<T> {
  final Map<T, bool> cache = {};
  final Duration delay;
  final Duration resetTimer;
  CacheConfig({
    this.delay = const Duration(seconds: 3),
    this.resetTimer = const Duration(hours: 1),
  });
}
