import 'package:webview_flutter/webview_flutter.dart';

class JsControllerConfig {
  final JavaScriptMode javaScriptMode;

  const JsControllerConfig({
    this.javaScriptMode = JavaScriptMode.disabled,
  });
}
