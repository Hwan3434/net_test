import 'package:get_it/get_it.dart';
import 'package:test_web_view/web/base/func/js_default_function.dart';
import 'package:test_web_view/web/base/func/js_function.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';
import 'package:test_web_view/web/base/models/js_response_model.dart';
import 'package:test_web_view/web/domain/inje_js_type.dart';
import 'package:test_web_view/web/domain/model/inje_js_aaa_model.dart';
import 'package:test_web_view/web/domain/model/inje_js_bbb_model.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<JsFunction>(() {
    return JsDefaultFunction(
      jsResponseFunc: JsResponseFunc()
        ..addJsResponse(
          InjeJsResponseType.toAppAAA.funcName,
          JsResponse<InjeJsAAAModel>(
            funcName: InjeJsResponseType.toAppAAA.funcName,
            createModelFunc: (json) => InjeJsAAAModel.fromJson(json),
          ),
        )
        ..addJsResponse(
          InjeJsResponseType.toAppBBB.funcName,
          JsResponse(
            funcName: InjeJsResponseType.toAppBBB.funcName,
            createModelFunc: (json) => InjeJsBBBModel.fromJson(json),
          ),
        ),
    );
  });

  // locator.registerLazySingleton<JsFunction>(() {
  //   return InjeFileJsFunction(jsFilePath: 'path');
  // });
}
