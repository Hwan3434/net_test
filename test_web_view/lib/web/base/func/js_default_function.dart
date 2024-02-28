import 'package:test_web_view/web/base/func/js_function.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';

class JsDefaultFunction implements JsFunction {
  final JsResponseFunc jsResponseFunc;

  const JsDefaultFunction({
    required this.jsResponseFunc,
  });

  @override
  JsResponseFunc createFunction() {
    return jsResponseFunc;
  }
}
