import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('dio onRequest : ${options.uri}}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('dio onResponse : ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('dio onError : ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}
