import 'package:data/common/log.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioUrlProvider = StateProvider.family<Dio, String>((ref, domain) {
  Log.w('Dio URL = $domain');
  return Dio(
    BaseOptions(
      // baseUrl: 'https://$project.typicode.com',
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );
});
