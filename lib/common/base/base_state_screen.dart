import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/base/consumer_base/base_consumer_stateful_widget.dart';

import '../screen/base_screen.dart';

abstract class BaseStateScreen<VM> extends BaseConsumerStatefulWidget<VM> {
  BaseStateScreen({
    super.key,
  });

  @protected
  PreferredSizeWidget? appbar(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? floatingActionButton(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) => null;

  @protected
  bool get safeTop => true;

  @protected
  bool get safeBottom => true;

  @protected
  bool get safeRight => true;

  @protected
  bool get safeLeft => true;

  @override
  _ScreenConsumerState<VM> createState() => _ScreenConsumerState();
}

class _ScreenConsumerState<VM> extends ConsumerState<BaseStateScreen> {
  @override
  Widget build(BuildContext context) {
    final model = ref.read(widget.viewProvider) as VM;
    widget.initializeWidgetMap(ref);
    return OrientationBuilder(builder: (context, orientation) {
      return BaseScreen(
        appBar: widget.appbar(context, ref),
        screen: SafeArea(
          right: widget.safeRight,
          top: widget.safeTop,
          bottom: widget.safeBottom,
          left: widget.safeLeft,
          child: widget.runBuild(orientation, model),
        ),
        floatingActionButton: widget.floatingActionButton(context, ref),
        bottomNavigationBar: widget.bottomNavigationBar(context, ref),
      );
    });
  }
}
