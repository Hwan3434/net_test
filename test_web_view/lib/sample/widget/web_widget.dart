import 'package:flutter/material.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:test_web_view/web/base/widget/js_web_widget.dart';

class WebWidget extends StatelessWidget {
  final JsWebController controller;
  const WebWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return JsWebWidget(
      canPop: false,
      controller: controller,
    );
  }
}
