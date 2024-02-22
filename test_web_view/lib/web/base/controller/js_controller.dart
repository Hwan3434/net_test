import 'dart:typed_data';

import 'package:webview_flutter/webview_flutter.dart';

mixin JsController {
  final WebViewController _nativeController = WebViewController();
  WebViewController get nativeController => _nativeController;

  Future<String?> currentUrl() {
    return _nativeController.currentUrl();
  }

  Future<bool> canGoBack() {
    return _nativeController.canGoBack();
  }

  Future<bool> canGoForward() {
    return _nativeController.canGoForward();
  }

  Future<void> goBack() {
    return _nativeController.goBack();
  }

  Future<void> goForward() {
    return _nativeController.goForward();
  }

  Future<void> reload() {
    return _nativeController.reload();
  }

  Future<void> loadFile(String absoluteFilePath) {
    return _nativeController.loadFile(absoluteFilePath);
  }

  Future<void> loadHtmlString(String html, {String? baseUrl}) {
    return _nativeController.loadHtmlString(html, baseUrl: baseUrl);
  }

  Future<void> loadRequest(
    Uri uri, {
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
  }) {
    return _nativeController.loadRequest(uri,
        method: method, headers: headers, body: body);
  }

  Future<void> loadFlutterAsset(String key) {
    return _nativeController.loadFlutterAsset(key);
  }
}
