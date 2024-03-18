import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/flavor/enviroment.dart';
import 'package:sample/sample/data/info/app_info_manager.dart';
import 'package:sample/sample/util/log.dart';

final dioProvider = Provider.family<Dio, String>((ref, org) {
  final Environment env = AppInfoManger().getEnvironment();
  final String baseUrl = 'https://${env.mode}$org.${env.url}';
  Log.e('UserUseCaseProvider base URL : $baseUrl');
  return Dio(
    BaseOptions(
      // baseUrl: baseUrl,
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );
});
