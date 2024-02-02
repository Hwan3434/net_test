import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wrapper_consumer_stateful_widget.dart';

abstract class ProviderStateScreen<VM>
    extends WrapperConsumerStatefulWidget<VM> {
  ProviderStateScreen({
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

class _ScreenConsumerState<VM> extends ConsumerState<ProviderStateScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.initializeWidgetMap(ref);
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(widget.viewProvider) as VM;
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: widget.appbar(context, ref),
        body: SafeArea(
          right: widget.safeRight,
          top: widget.safeTop,
          bottom: widget.safeBottom,
          left: widget.safeLeft,
          child: widget.runBuild(model, orientation),
        ),
        floatingActionButton: widget.floatingActionButton(context, ref),
        bottomNavigationBar: widget.bottomNavigationBar(context, ref),
      );
    });
  }
}
