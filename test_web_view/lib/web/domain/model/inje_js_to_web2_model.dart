import 'package:test_web_view/web/base/models/js_request_model.dart';

class InjeJsToWeb2Model extends JsRequestModel {
  final String message;
  final int message2;

  InjeJsToWeb2Model({
    required this.message,
    required this.message2,
  });

  @override
  String getParam() {
    return '${getStringParam(message)}, ${getIntParam(message2)}';
  }
}
