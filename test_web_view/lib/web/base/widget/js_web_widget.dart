import 'package:flutter/material.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JsWebWidget extends StatelessWidget {
  final bool canPop;
  final JsWebController controller;

  const JsWebWidget({
    super.key,
    this.canPop = true,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: controller.deviceEvents.androidBackButtonCallBack,
      child: WebViewWidget(
        controller: controller.nativeController,
      ),
    );
  }
}
