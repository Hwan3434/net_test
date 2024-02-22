import 'package:data/common/log.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';

final dioUrlProvider = StateProvider.family<Dio, String>((ref, project) {
  final org = ref.watch(orgProvider);
  Log.e('프로젝트가 변경되었습니다. : $org, $project');
  return Dio(
    BaseOptions(
      // baseUrl: 'https://$project.typicode.com',
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );
});
