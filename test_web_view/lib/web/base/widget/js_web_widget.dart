import 'package:flutter/material.dart';
import 'package:test_web_view/web/base/controller/js_web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JsWebWidget extends StatefulWidget {
  final bool canPop;
  final JsWebController controller;

  const JsWebWidget({
    super.key,
    this.canPop = true,
    required this.controller,
  });

  @override
  State<JsWebWidget> createState() => _JsWebWidgetState();
}

class _JsWebWidgetState extends State<JsWebWidget> {
  @override
  Widget build(BuildContext context) {
    return _AndroidBackWidget(
      canPop: widget.canPop,
      onPopInvoked: widget.controller.deviceEvents.androidBackButtonCallBack,
      child: WebViewWidget(
        controller: widget.controller.nativeController,
      ),
    );
  }
}

class _AndroidBackWidget extends StatelessWidget {
  final bool canPop;
  final PopInvokedCallback? onPopInvoked;
  final Widget child;

  const _AndroidBackWidget({
    this.canPop = true,
    required this.child,
    this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: child,
    );
  }
}
