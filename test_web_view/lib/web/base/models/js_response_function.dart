import 'package:test_web_view/web/base/controller/js_web_controller.dart';

class JsFunction<T> {
  final CreateModelFunc<T> createModelFunc;
  final JsResponseCallBack<T> jsResponseCallBack;

  const JsFunction({
    required this.createModelFunc,
    required this.jsResponseCallBack,
  });
}
