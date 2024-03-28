import 'package:flutter/material.dart';
import 'package:test_web_view/sample/js_model/response/inje_js_aaa_model.dart';
import 'package:test_web_view/sample/js_model/response/inje_js_bbb_model.dart';
import 'package:test_web_view/sample/widget/web_widget.dart';
import 'package:test_web_view/web/base/config/js_controller_config.dart';
import 'package:test_web_view/web/base/controller/lazy/js_lazy.dart';
import 'package:test_web_view/web/base/controller/lazy/js_lazy_web_controller.dart';
import 'package:test_web_view/web/base/event/device_events.dart';
import 'package:test_web_view/web/base/models/js_channel.dart';
import 'package:test_web_view/web/util/log.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../js_model/inje_js_type.dart';
import '../js_model/request/inje_js_to_web_model.dart';
import '../observer/inje_observer.dart';

class SampleWidget extends StatefulWidget {
  const SampleWidget({super.key, required this.title});

  final String title;

  @override
  State<SampleWidget> createState() => _SampleWidgetState();
}

class _SampleWidgetState extends State<SampleWidget> {
  final TextEditingController _textController = TextEditingController();

  late final JsLazyWebController controller;

  @override
  void initState() {
    super.initState();

    controller = JsLazyWebController(
      const JsLazyChannel(
        name: lazyChannel,
      ),
      JsControllerConfig(
        javaScriptMode: JavaScriptMode.unrestricted,
      ),
      jsObserver: InjeObserver(),
      deviceEvents: DeviceEvents(
        androidBackButtonCallBack: (didPop) {
          debugPrint('android back button click : $didPop');
        },
      ),
      sendJsFormDelegate: (channel, paramJson) {
        return '''$channel('$paramJson')''';
        // return '''window.postMessage({type: "message_from_flutter",data: "{action:$channel, data:$paramJson}"});''';
      },
    )
      ..setNavigation(
        NavigationDelegate(
          onPageStarted: (url) {
            Log.d('url : $url');
          },
          onProgress: (progress) {
            Log.d('progress : $progress');
          },
        ),
      )
      ..addJsLazyScript(InjeJsRequestChannel.fromAppToWeb.channelName)
      ..addChannel<InjeJsAAAModel>(
        channelName: InjeJsResponseChannel.toAppAAA.channelName,
        channel: JsChannel(
          createChannelModel: (jsonMap) => InjeJsAAAModel.fromJson(jsonMap),
          channelCallBack: (controller, model) {
            Log.w('First callback :: ${model.dataA} / ${model.dataB}');
          },
        ),
      )
      ..addChannel<InjeJsBBBModel>(
        channelName: InjeJsResponseChannel.toAppBBB.channelName,
        channel: JsChannel(
          createChannelModel: (jsonMap) => InjeJsBBBModel.fromJson(jsonMap),
          channelCallBack: (controller, model) {
            Log.w('First callback :: ${model.dataA} / ${model.dataB}');
          },
        ),
      )
      ..setAgent('agent')
      ..loadRequest(Uri.parse('http://127.0.0.1:5500/web_view_test.html'));
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
            onPressed: () async {
              final int? s = await controller.localStorage.getInt(key: 'bb');
              if (s == null) {
                return;
              }
              controller.sendJavascript<InjeJsToWebModel>(
                scriptName: InjeJsRequestChannel.fromAppToWeb.channelName,
                scriptModel: InjeJsToWebModel(
                  name: _textController.text,
                  email: s.toString(),
                ),
              );
            },
            icon: Icon(
              Icons.save,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.localStorage.setInt(key: 'bb', value: 456);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.localStorage.clear();
            },
            icon: Icon(
              Icons.train_sharp,
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
            child: WebWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
