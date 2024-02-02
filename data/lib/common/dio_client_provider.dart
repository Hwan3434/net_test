import 'package:data/common/dio_client.dart';
import 'package:data/common/domain/baseUrlProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

final dioClientProvider =
    StateNotifierProvider<_DioClientNotifier, DioClient>((ref) {
  String domain = ref.watch(baseUrlProvider);
  debugPrint('dio의 주소가 바뀝니다. :: $domain');
  return _DioClientNotifier(DioClient(baseUrl: domain));
});

class _DioClientNotifier extends StateNotifier<DioClient> {
  _DioClientNotifier(super.state);
}
