import 'package:test_web_view/web/base/func/js_function.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';

class InjeFileJsFunction implements JsFunction {
  final String jsFilePath;

  const InjeFileJsFunction({
    required this.jsFilePath,
  });

  @override
  JsResponseFunc createFunction() {
    /// 파일 불러와야하는뎀.. 비동기요~ 어떻게하징?
    /// 이건 실장님한테 여쭤보자 !
    return JsResponseFunc();
  }
}
