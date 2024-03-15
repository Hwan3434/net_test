import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = StateProvider<Dio>((ref) {
  return Dio(
    BaseOptions(
      // baseUrl: 'https://$project.typicode.com',
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );
});
