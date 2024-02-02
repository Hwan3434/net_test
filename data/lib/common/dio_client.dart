import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioClient {
  final String baseUrl;
  late final Dio dio;
  DioClient({
    required this.baseUrl,
  }) {
    final options = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    )..interceptors.add(DioCacheInterceptor(options: options));
  }
}
