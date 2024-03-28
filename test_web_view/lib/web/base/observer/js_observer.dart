import 'package:webview_flutter/webview_flutter.dart';

abstract class JsObserver {
  void onRequest(String script, dynamic model);
  void onRequestError(String script, Exception e);
  void onResponse(String channelName, dynamic model);
  void onResponseError(String channelName, Exception e);
  void onConsoleMessage(JavaScriptConsoleMessage consoleMessage);

  void onStorageError(String scriptName, dynamic error);
}
