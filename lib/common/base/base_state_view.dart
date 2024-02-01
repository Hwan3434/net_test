import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/base/consumer_base/base_consumer_stateful_widget.dart';

abstract class BaseStateView<VM> extends BaseConsumerStatefulWidget<VM> {
  BaseStateView({
    super.key,
  });

  @override
  _ViewConsumerState<VM> createState() => _ViewConsumerState();
}

class _ViewConsumerState<VM> extends ConsumerState<BaseStateView> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(widget.viewProvider);
    widget.initializeWidgetMap(ref);
    return OrientationBuilder(builder: (context, orientation) {
      return widget.runBuild(orientation, model);
    });
  }
}
