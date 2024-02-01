import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/inje_base/comsumer_base/inje_consumer_stateful_widget.dart';

abstract class InjeView<VM> extends InjeConsumerStatefulWidget<VM> {
  const InjeView({
    super.key,
  });

  Widget build(
    BuildContext context,
    WidgetRef ref,
    VM viewModel,
  );

  @override
  _InjeViewState<VM> createState() => _InjeViewState();
}

class _InjeViewState<VM> extends ConsumerState<InjeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(widget.viewProvider) as VM;
    return widget.build(context, ref, viewModel);
  }
}
