import 'dart:convert';

import 'package:test_web_view/web/base/config/controller_config.dart';
import 'package:test_web_view/web/base/controller/device_events.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';
import 'package:test_web_view/web/base/models/js_request_model.dart';
import 'package:test_web_view/web/base/models/js_response_model.dart';
import 'package:test_web_view/web/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../func/js_function.dart';
import 'js_controller.dart';

typedef CreateAgentDelegate = String Function();

class JsWebController with JsController {
  final ControllerConfig _controllerConfig;
  final DeviceEvents deviceEvents;
  JsResponseFunc? func;
  CreateAgentDelegate? _createAgentDelegate;

  JsWebController(
    this._controllerConfig, {
    String? url,
    String Function()? createAgentDelegate,
    this.deviceEvents = const DeviceEvents(),
    JsFunction? jsFunction,
  }) : _createAgentDelegate = createAgentDelegate {
    if (_createAgentDelegate != null) {
      nativeController.setUserAgent(_createAgentDelegate!.call());
    }
    if (jsFunction != null) {
      func = jsFunction.createFunction();
      for (final jsResponseElement in func!.values) {
        _addResponseJavascript(jsResponseElement);
      }
    }

    nativeController.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) {
        Log.e('error : $error');
      },
      onPageStarted: (url) {
        Log.w('page Started : $url');
      },
    ));

    nativeController.setJavaScriptMode(_controllerConfig.javaScriptMode);
    if (url != null) {
      nativeController.loadRequest(Uri.parse(url));
    }
  }

  void setCreateAgentDelegate(CreateAgentDelegate createAgentDelegate) {
    _createAgentDelegate = createAgentDelegate;
  }

  void onJsResponseCallback<T>(String funcName, ResponseCallBack<T> callback) {
    assert(func != null);
    if (func == null) {
      Log.e('저장된 Javascript가 존재하지않습니다.');
      return;
    }
    assert(func!.containsKey(funcName));
    if (func!.containsKey(funcName)) {
      func![funcName]!.setCallback(
        (model) {
          callback.call(model);
        },
      );
    } else {
      Log.e('정의된 Javascript가 존재하지않습니다.');
    }
  }

  void offJsResponseCallback(String funcName) {
    assert(func != null);
    if (func == null) {
      Log.e('저장된 Javascript가 존재하지않습니다.');
      return;
    }
    func!.removeJsResponse(funcName);
  }

  void _addResponseJavascript(JsResponse response) {
    assert(func != null);
    if (func == null) {
      Log.e('저장된 Javascript가 존재하지않습니다.');
      return;
    }
    nativeController.removeJavaScriptChannel(response.funcName);

    func![response.funcName] = response;
    nativeController.addJavaScriptChannel(
      response.funcName,
      onMessageReceived: (p0) {
        try {
          /// todo 추론안되는 이유는 함수에서 추론을 하지않아서 입니다.
          /// todo 하지만 여기서 response의 타입을 추론은 불가능합니다.(반복문이라서)
          /// todo response.callBack?.call(model); 여기서 callback 생성시 명시해주기때문에 외부에서는 T타입으로 리턴받음
          Log.d('JS response : ${p0.message}');
          final json = jsonDecode(p0.message);
          final model = response.createModelFunc.call(json);
          response.callBack?.call(model);
        } catch (e) {
          Log.e(e.toString());
        }
      },
    );
  }

  void sendJavascript<T extends JsRequestModel>({
    required String funcName,
    required T requestModel,
  }) {
    nativeController.runJavaScript(_getJs(
      funcName,
      requestModel.getParam(),
    ));
  }

  String _getJs(String funcName, String param) {
    final script = '$funcName($param)';
    Log.w('send Js : $script');
    return script;
  }
}
