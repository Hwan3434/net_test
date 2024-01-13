import 'package:data/common/dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// https://jsonplaceholder.typicode.com/todos/1
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
  dio.interceptors.add(DioInterceptor());
  return dio;
});
