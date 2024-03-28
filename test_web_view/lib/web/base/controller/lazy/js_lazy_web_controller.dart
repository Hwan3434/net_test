import 'package:test_web_view/web/base/controller/base/js_controller.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:test_web_view/web/base/controller/lazy/js_lazy.dart';
import 'package:test_web_view/web/base/models/js_channel.dart';
import 'package:test_web_view/web/base/models/js_script_model.dart';

class JsLazyWebController extends JsWebController {
  bool _lazyComplete = false;
  final JsLazyChannel lazy;
  final Set<String> _jsLazyScriptName = {};
  JsLazyWebController(
    this.lazy,
    super.controllerConfig, {
    super.deviceEvents,
    super.jsObserver,
    super.navigationDelegate,
    required super.sendJsFormDelegate,
  }) {
    addChannel<LazyModel>(
      channelName: lazy.name,
      channel: JsChannel<LazyModel>(
        createChannelModel: (jsonMap) => LazyModel.fromJson(jsonMap),
        channelCallBack: (controller, model) {
          _lazyComplete = model.lazyComplete;
        },
      ),
    );
  }

  bool get getLazyState => _lazyComplete;

  // Lazy 이후 호출 할 수 있는 함수 명
  void addJsLazyScript(String scriptName) {
    _jsLazyScriptName.add(scriptName);
  }

  @override
  void sendJavascript<T extends JsScriptModel>({
    required String scriptName,
    required T scriptModel,
  }) {
    if (lazyValidate(scriptName) == false) {
      jsObserver?.onRequestError(
          scriptName, Exception('Lazy is Not Complete!'));
      return;
    }
    super.sendJavascript(
      scriptName: scriptName,
      scriptModel: scriptModel,
    );
  }

  bool lazyValidate(String scriptName) {
    return !(_lazyComplete == false && _jsLazyScriptName.contains(scriptName));
  }

  @override
  Future<JsCallbackResult> sendScript<T extends JsScriptModel>({
    required String scriptName,
    required T scriptModel,
  }) async {
    if (lazyValidate(scriptName) == false) {
      final e = Exception('Lazy is Not Complete!');
      jsObserver?.onRequestError(scriptName, e);
      return JsError(e: e);
    }
    return super.sendScript(
      scriptName: scriptName,
      scriptModel: scriptModel,
    );
  }
}
