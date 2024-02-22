import 'package:test_web_view/web/base/func/js_function.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';

// class JsFileFunction implements JsFunction {
//   final String filePath;
//
//   const JsDefaultFunction({
//     required this.filePath,
//   });
//
//   @override
//   JsResponseFunc createFunction() {
//     // getJsFile(); -> 이거 비동기라서 문제임 ㅡㅡ;;
//     // file to JsResponseFunc class
//     // return JsResponseFunc();
//     return jsResponseFunc;
//   }
// }

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
