import 'package:webview_flutter/webview_flutter.dart';

abstract class JsObserver {
  void onRequest(String funcName, dynamic model);
  void onRequestError(String funcName, Exception e);
  void onResponse(String funcName, dynamic model);
  void onResponseError(String funcName, Exception e);
  void onConsoleMessage(JavaScriptConsoleMessage consoleMessage);
}
