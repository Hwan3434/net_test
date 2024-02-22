import 'package:flutter/material.dart';
import 'package:test_web_view/getit/locator.dart';
import 'package:test_web_view/web/base/config/controller_config.dart';
import 'package:test_web_view/web/base/controller/device_events.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:test_web_view/web/base/func/js_default_function.dart';
import 'package:test_web_view/web/base/models/js_config_model.dart';
import 'package:test_web_view/web/base/models/js_response_model.dart';
import 'package:test_web_view/web/base/widget/o_js_web_widget.dart';
import 'package:test_web_view/web/domain/inje_js_type.dart';
import 'package:test_web_view/web/domain/model/inje_js_bbb_model.dart';
import 'package:test_web_view/web/domain/model/inje_js_to_web_model.dart';
import 'package:test_web_view/web/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web/domain/model/inje_js_aaa_model.dart';

void main() {
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  late final JsWebController controller;

  @override
  void initState() {
    super.initState();

    controller = JsWebController(
      ControllerConfig(
        javaScriptMode: JavaScriptMode.unrestricted,
      ),
      deviceEvents: DeviceEvents(
        androidBackButtonCallBack: (didPop) {
          Log.e('ㅇㅏㄴ뇽! 1 : $didPop');
        },
      ),
      jsFunction: JsDefaultFunction(
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
            JsResponse<InjeJsBBBModel>(
              funcName: InjeJsResponseType.toAppBBB.funcName,
              createModelFunc: (json) => InjeJsBBBModel.fromJson(json),
            ),
          ),
      ),
    );

    controller.loadFlutterAsset('assets/web_view_test.html');

    controller.onJsResponseCallback<InjeJsAAAModel>(
      InjeJsResponseType.toAppAAA.funcName,
      (model) async {
        Log.e('Callbask :: ${model.dataA} / ${model.dataB}');
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              controller.sendJavascript<InjeJsToWebModel>(
                funcName: InjeJsRequestType.fromAppToWeb.funcName,
                requestModel: InjeJsToWebModel(
                  name: _textController.text,
                  email: 'hard-code-email',
                ),
              );
            },
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
          ),
          Expanded(
            child: OjsWebWidget(
              canPop: false,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
