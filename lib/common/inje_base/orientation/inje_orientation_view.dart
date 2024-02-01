import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/inje_base/comsumer_base/inje_consumer_stateful_widget.dart';

abstract class InjeOrientationView<VM> extends InjeConsumerStatefulWidget<VM> {
  const InjeOrientationView({
    super.key,
  });

  Widget buildPortrait(
    BuildContext context,
    WidgetRef ref,
    VM viewModel,
  );

  Widget buildLandscape(
    BuildContext context,
    WidgetRef ref,
    VM viewModel,
  );

  @override
  _InjeOrientationViewState<VM> createState() => _InjeOrientationViewState();
}

class _InjeOrientationViewState<VM> extends ConsumerState<InjeOrientationView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(widget.viewProvider) as VM;
    return OrientationBuilder(
      builder: (context, orientation) {
        return switch (orientation) {
          Orientation.portrait => widget.buildPortrait(context, ref, viewModel),
          Orientation.landscape =>
            widget.buildLandscape(context, ref, viewModel),
        };
      },
    );
  }
}
