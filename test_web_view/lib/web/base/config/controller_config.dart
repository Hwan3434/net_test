import 'package:webview_flutter/webview_flutter.dart';

class ControllerConfig {
  final JavaScriptMode javaScriptMode;

  const ControllerConfig({
    this.javaScriptMode = JavaScriptMode.disabled,
  });
}
