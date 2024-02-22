import 'js_response_model.dart';

class JsResponseFunc {
  final Map<String, JsResponse> _jsResponseMpa = {};

  void addJsResponse(String funcName, JsResponse jsResponse) {
    _jsResponseMpa[funcName] = jsResponse;
  }

  void removeJsResponse(String funcName) {
    _jsResponseMpa.remove(funcName);
  }

  JsResponse? operator [](String key) => _jsResponseMpa[key];
  bool containsKey(String key) => _jsResponseMpa.containsKey(key);
  Iterable<JsResponse> get values => _jsResponseMpa.values;
  void operator []=(String key, JsResponse value) {
    _jsResponseMpa[key] = value;
  }
}
