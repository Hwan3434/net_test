import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wrapper_consumer_stateful_widget.dart';

abstract class WrapperStateView<VM> extends WrapperConsumerStatefulWidget<VM> {
  WrapperStateView({
    super.key,
  });

  @override
  _WrapperViewConsumerState<VM> createState() => _WrapperViewConsumerState();
}

class _WrapperViewConsumerState<VM> extends ConsumerState<WrapperStateView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.initializeWidgetMap(ref);
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(widget.viewProvider);
    return OrientationBuilder(builder: (context, orientation) {
      return widget.runBuild(model, orientation);
    });
  }
}
