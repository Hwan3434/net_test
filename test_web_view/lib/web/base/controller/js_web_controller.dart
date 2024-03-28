import 'dart:convert';

import 'package:test_web_view/web/base/config/js_controller_config.dart';
import 'package:test_web_view/web/base/controller/base/js_controller.dart';
import 'package:test_web_view/web/base/event/device_events.dart';
import 'package:test_web_view/web/base/models/js_channel.dart';
import 'package:test_web_view/web/base/models/js_script_model.dart';
import 'package:test_web_view/web/base/observer/js_observer.dart';
import 'package:test_web_view/web/base/storage/web_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef CreateAgentDelegate = String Function();
typedef CreateChannelModel<T> = T Function(Map<String, dynamic> jsonMap);
typedef JsChannelCallBack<T> = void Function(
    WebViewController controller, T model);

class JsWebController with JsController {
  final JsControllerConfig _controllerConfig;
  final DeviceEvents deviceEvents;
  final JsObserver? jsObserver;
  final String Function(String channel, String paramJson) sendJsFormDelegate;
  late final WebStorage localStorage;

  JsWebController(
    this._controllerConfig, {
    this.deviceEvents = const DeviceEvents(),
    this.jsObserver,
    NavigationDelegate? navigationDelegate,
    required this.sendJsFormDelegate,
  }) {
    localStorage = WebStorage(nativeController, observer: jsObserver);
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

  void addChannel<T>({
    required String channelName,
    required JsChannel<T> channel,
  }) {
    nativeController.removeJavaScriptChannel(channelName);
    nativeController.addJavaScriptChannel(
      channelName,
      onMessageReceived: (p0) {
        try {
          final json = jsonDecode(p0.message);
          final model = channel.createChannelModel(json);
          channel.channelCallBack(nativeController, model);
          jsObserver?.onResponse(channelName, model);
        } on Exception catch (e) {
          jsObserver?.onResponseError(channelName, e);
        }
      },
    );
  }

  @override
  void sendJavascript<T extends JsScriptModel>({
    required String scriptName,
    required T scriptModel,
  }) {
    try {
      final func = sendJsFormDelegate!(
        scriptName,
        scriptModel.toJson().toString(),
      );
      nativeController.runJavaScript(func);
      jsObserver?.onRequest(scriptName, scriptModel);
    } on Exception catch (e) {
      jsObserver?.onRequestError(scriptName, e);
    }
  }

  @override
  Future<JsCallbackResult> sendScript<T extends JsScriptModel>({
    required String scriptName,
    required T scriptModel,
  }) async {
    try {
      final script = sendJsFormDelegate(
        scriptName,
        scriptModel.toJson().toString(),
      );
      final result =
          await nativeController.runJavaScriptReturningResult(script);
      jsObserver?.onRequest(scriptName, scriptModel);
      return JsSuccess(data: result);
    } on Exception catch (e) {
      jsObserver?.onRequestError(scriptName, e);
      return JsError(e: e);
    }
  }
}
