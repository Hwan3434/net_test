import 'package:test_web_view/web/base/models/js_script_model.dart';

class InjeJsToWeb2Model extends JsScriptModel {
  final String message;
  final int message2;

  InjeJsToWeb2Model({
    required this.message,
    required this.message2,
  });

  InjeJsToWeb2Model.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        message2 = json['message2'];

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
        'message2': message2,
      };
}
