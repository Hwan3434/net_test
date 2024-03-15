import 'package:flutter/material.dart';

class AutomaticWidget extends StatefulWidget {
  final Widget child;
  const AutomaticWidget({
    required this.child,
  });

  @override
  State<AutomaticWidget> createState() => _AutomaticWidgetState();
}

class _AutomaticWidgetState extends State<AutomaticWidget>
    with AutomaticKeepAliveClientMixin<AutomaticWidget> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
