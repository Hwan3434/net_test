import 'package:test_web_view/web/base/observer/js_observer.dart';
import 'package:test_web_view/web/util/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'js_storage.dart';

const _setLocalStorage = 'window.localStorage.setItem';
const _getLocalStorage = 'window.localStorage.getItem';

class WebStorage implements JsStorage {
  final WebViewController _nativeController;
  final JsObserver? observer;
  WebStorage(
    this._nativeController, {
    this.observer,
  });

  @override
  Future<void> setInt({required String key, required int value}) async {
    final script = '$_setLocalStorage("$key", $value)';
    _nativeController.runJavaScript(script);
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    final script = '$_setLocalStorage("$key", "$value")';
    _nativeController.runJavaScript(script);
  }

  @override
  Future<int?> getInt({required String key}) async {
    try {
      final result = await _nativeController
          .runJavaScriptReturningResult('$_getLocalStorage("$key")');
      return int.parse(result as String);
    } catch (e) {
      Log.e('e : $e');
      observer?.onStorageError(key, e);
      return null;
    }
  }

  @override
  Future<String?> getString({required String key}) async {
    try {
      return await _nativeController
          .runJavaScriptReturningResult('$_getLocalStorage("$key")') as String;
    } catch (e) {
      Log.e('e : $e');
      observer?.onStorageError(key, e);
      return null;
    }
  }

  Future<void> clear() async {
    await _nativeController.clearLocalStorage();
  }
}
