import 'package:test_web_view/web/base/models/js_request_model.dart';

class InjeJsToWebModel extends JsRequestBaseModel {
  final String name;
  final String email;

  InjeJsToWebModel({
    required this.name,
    required this.email,
  });

  InjeJsToWebModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
