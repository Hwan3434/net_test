import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'last_consumer_stateful_widget.dart';

// LastStatefulView<VM> 만들어
abstract class LastStateView<VM> extends LastConsumerStatefulWidget<VM> {
  const LastStateView({
    super.key,
  });

  Widget build(
    BuildContext context,
    WidgetRef ref,
    VM viewModel,
  );

  @override
  _LastStateViewState<VM> createState() => _LastStateViewState();
}

class _LastStateViewState<VM> extends ConsumerState<LastStateView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(widget.viewProvider);
    return widget.build(context, ref, viewModel);
  }
}
