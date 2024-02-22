abstract class JsRequestModel {
  String getParam();

  String getStringParam(String param) {
    return '\'$param\'';
  }

  String getIntParam(int param) {
    return '$param';
  }
}
