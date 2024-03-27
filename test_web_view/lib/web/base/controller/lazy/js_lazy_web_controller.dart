import 'package:test_web_view/web/base/controller/base/js_controller.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:test_web_view/web/base/controller/lazy/js_lazy.dart';
import 'package:test_web_view/web/base/models/js_request_model.dart';
import 'package:test_web_view/web/base/models/js_response_function.dart';

class JsLazyWebController extends JsWebController {
  bool _lazyComplete = false;
  final JsLazy lazy;
  final Set<String> _jsLazyRequestScriptName = {};
  JsLazyWebController(
    this.lazy,
    super.controllerConfig, {
    super.deviceEvents,
    super.jsObserver,
    super.navigationDelegate,
    required super.sendJsFormDelegate,
  }) {
    setJsResponseFunction<LazyModel>(
      funcName: lazy.responseFunctionName,
      function: JsFunction<LazyModel>(
        createModelFunc: (jsonMap) => LazyModel.fromJson(jsonMap),
        jsResponseCallBack: (controller, model) {
          _lazyComplete = model.lazyComplete;
        },
      ),
    );
  }

  bool get getLazyState => _lazyComplete;

  // Lazy 이후 호출 할 수 있는 함수 명
  void addJsLazyRequestScriptName(String scriptName) {
    _jsLazyRequestScriptName.add(scriptName);
  }

  @override
  void sendJavascript<T extends JsRequestBaseModel>({
    required String funcName,
    required T requestModel,
  }) {
    if (lazyValidate(funcName) == false) {
      jsObserver?.onRequestError(funcName, Exception('Lazy is Not Complete!'));
      return;
    }
    super.sendJavascript(
      funcName: funcName,
      requestModel: requestModel,
    );
  }

  bool lazyValidate(String funcName) {
    return !(_lazyComplete == false &&
        _jsLazyRequestScriptName.contains(funcName));
  }

  @override
  Future<JsCallbackResult>
      sendJavascriptCallback<T extends JsRequestBaseModel>({
    required String funcName,
    required T requestModel,
  }) async {
    if (lazyValidate(funcName) == false) {
      final e = Exception('Lazy is Not Complete!');
      jsObserver?.onRequestError(funcName, e);
      return JsError(e: e);
    }
    return super.sendJavascriptCallback(
      funcName: funcName,
      requestModel: requestModel,
    );
  }
}
