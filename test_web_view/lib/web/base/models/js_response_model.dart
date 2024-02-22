typedef CreateModelFunc<T> = T Function(Map<String, dynamic> json);
typedef ResponseCallBack<T> = void Function(T model);

class JsResponse<T> {
  final String funcName;
  final CreateModelFunc<T> createModelFunc;
  ResponseCallBack<T>? callBack;

  JsResponse({
    required this.funcName,
    required this.createModelFunc,
  });

  void setCallback(ResponseCallBack<T> callBack) {
    this.callBack = callBack;
  }
}
