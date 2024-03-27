import 'dart:convert';

import 'package:test_web_view/web/base/config/js_controller_config.dart';
import 'package:test_web_view/web/base/controller/base/js_controller.dart';
import 'package:test_web_view/web/base/event/device_events.dart';
import 'package:test_web_view/web/base/models/js_request_model.dart';
import 'package:test_web_view/web/base/models/js_response_function.dart';
import 'package:test_web_view/web/base/observer/js_observer.dart';
import 'package:test_web_view/web/base/storage/web_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef CreateAgentDelegate = String Function();
typedef CreateModelFunc<T> = T Function(Map<String, dynamic> jsonMap);
typedef JsResponseCallBack<T> = void Function(
    WebViewController controller, T model);

class JsWebController with JsController {
  final JsControllerConfig _controllerConfig;
  final DeviceEvents deviceEvents;
  final JsObserver? jsObserver;
  final String Function(String funcName, String paramJson) sendJsFormDelegate;
  late final WebStorage localStorage;

  JsWebController(
    this._controllerConfig, {
    this.deviceEvents = const DeviceEvents(),
    this.jsObserver,
    NavigationDelegate? navigationDelegate,
    required this.sendJsFormDelegate,
  }) {
    localStorage = WebStorage(nativeController);
    initController(
      navigationDelegate: navigationDelegate,
    );
  }

  void initController({
    NavigationDelegate? navigationDelegate,
  }) {
    setNavigation(navigationDelegate);

    nativeController.setJavaScriptMode(_controllerConfig.javaScriptMode);
    nativeController.setOnConsoleMessage((message) {
      jsObserver?.onConsoleMessage(message);
    });
  }

  void setNavigation(NavigationDelegate? navigation) {
    if (navigation != null) {
      nativeController.setNavigationDelegate(navigation);
    }
  }

  void setJsResponseFunction<T>({
    required String funcName,
    required JsFunction<T> function,
  }) {
    nativeController.removeJavaScriptChannel(funcName);
    nativeController.addJavaScriptChannel(
      funcName,
      onMessageReceived: (p0) {
        try {
          final json = jsonDecode(p0.message);
          final model = function.createModelFunc(json);
          function.jsResponseCallBack(nativeController, model);
          jsObserver?.onResponse(funcName, model);
        } on Exception catch (e) {
          jsObserver?.onResponseError(funcName, e);
        }
      },
    );
  }

  @override
  void sendJavascript<T extends JsRequestBaseModel>({
    required String funcName,
    required T requestModel,
  }) {
    try {
      final func = sendJsFormDelegate!(
        funcName,
        requestModel.toJson().toString(),
      );
      nativeController.runJavaScript(func);
      jsObserver?.onRequest(funcName, requestModel);
    } on Exception catch (e) {
      jsObserver?.onRequestError(funcName, e);
    }
  }

  @override
  Future<JsCallbackResult>
      sendJavascriptCallback<T extends JsRequestBaseModel>({
    required String funcName,
    required T requestModel,
  }) async {
    try {
      final func = sendJsFormDelegate(
        funcName,
        requestModel.toJson().toString(),
      );
      final result = await nativeController.runJavaScriptReturningResult(func);
      jsObserver?.onRequest(funcName, requestModel);
      return JsSuccess(data: result);
    } on Exception catch (e) {
      jsObserver?.onRequestError(funcName, e);
      return JsError(e: e);
    }
  }
}
