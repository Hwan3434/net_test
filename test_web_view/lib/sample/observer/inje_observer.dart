import 'package:test_web_view/web/base/observer/js_observer.dart';
import 'package:test_web_view/web/util/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InjeObserver extends JsObserver {
  @override
  void onRequest(String script, model) {
    Log.w('JSObserver OnRequest : $script / ${model.toString()}');
  }

  @override
  void onResponse(String channelName, model) {
    Log.w('JSObserver OnResponse : $channelName / ${model.toString()}');
  }

  @override
  void onRequestError(String script, Exception e) {
    Log.e('JSObserver OnRequest : $script / $e');
  }

  @override
  void onResponseError(String channelName, Exception e) {
    Log.e('JSObserver OnResponse : $channelName / $e');
  }

  @override
  void onConsoleMessage(JavaScriptConsoleMessage consoleMessage) {
    Log.e(
        'JSObserver level : ${consoleMessage.level} / message : ${consoleMessage.message.replaceAll(', ', '')}');
  }

  @override
  void onStorageError(String scriptName, error) {
    Log.e('JSObserver onStorageError : $scriptName / $error');
  }
}
