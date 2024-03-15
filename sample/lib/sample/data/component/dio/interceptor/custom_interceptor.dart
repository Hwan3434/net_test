import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';

class CustomInterceptor extends Interceptor {
  final String organization;
  final Ref ref;
  CustomInterceptor({
    required this.organization,
    required this.ref,
  });

  final accessTokenKey = 'accessToken';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// network checking
    final agent = ref.read(GlobalStateStorage().agentStateProvider);

    if (options.headers[accessTokenKey] == 'true') {
      if (agent.state != AgentState.success &&
          (agent.data?.accessToken ?? '').isEmpty) {
        return handler.reject(
          DioException(
            message: '액세스토큰이 없는데 액세스토큰이 필요한 API를 호출하였습니다.',
            requestOptions: options,
          ),
        );
      }
      options.headers.remove(accessTokenKey);
      options.headers[accessTokenKey] = agent.data?.accessToken;
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
