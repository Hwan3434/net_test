import 'package:test_web_view/web/base/observer/js_observer.dart';
import 'package:test_web_view/web/util/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InjeObserver extends JsObserver {
  @override
  void onRequest(String funcName, model) {
    Log.w('JSObserver OnRequest Function : $funcName / ${model.toString()}');
  }

  @override
  void onResponse(String funcName, model) {
    Log.w('JSObserver OnResponse Function : $funcName / ${model.toString()}');
  }

  @override
  void onRequestError(String funcName, Exception e) {
    Log.e('JSObserver OnRequest Function : $funcName / $e');
  }

  @override
  void onResponseError(String funcName, Exception e) {
    Log.e('JSObserver OnResponse Function : $funcName / $e');
  }

  @override
  void onConsoleMessage(JavaScriptConsoleMessage consoleMessage) {
    Log.e(
        'JSObserver level : ${consoleMessage.level} / message : ${consoleMessage.message.replaceAll(', ', '')}');
  }
}
