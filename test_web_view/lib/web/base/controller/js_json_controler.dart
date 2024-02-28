import 'dart:convert';

import 'package:test_web_view/web/base/controller/js_controller.dart';
import 'package:test_web_view/web/base/models/js_response_model.dart';
import 'package:test_web_view/web/domain/model/inje_js_aaa_model.dart';
import 'package:test_web_view/web/log.dart';

/// Json 으로 만들어진 controller A
/// 이 mixin 파일을 with로 JsWebController에 삽입해서 사용
mixin JsJsonController on JsController {
  void addCallbackAAA({
    required JsResponse<InjeJsAAAModel> response,
  }) {
    nativeController.addJavaScriptChannel(
      response.funcName,
      onMessageReceived: (p0) {
        try {
          final json = jsonDecode(p0.message);
          response.callBack?.call(InjeJsAAAModel.fromJson(json));
        } catch (e) {
          Log.e(e.toString());
        }
      },
    );
  }

  void sendApp1(String a, String b) {
    nativeController.runJavaScript(_getJs('app1', '\'$a\', \'$b\''));
  }

  void sendApp2(String a, int b) {
    nativeController.runJavaScript(_getJs('app2', '\'$a\', $b'));
  }

  String _getJs(String funcName, String param) {
    final script = '$funcName($param)';
    return script;
  }
}
