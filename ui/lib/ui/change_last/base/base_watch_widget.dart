import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// statefulWidget
abstract class BaseWatchStatefulWidget<VM> extends ConsumerStatefulWidget {
  const BaseWatchStatefulWidget({super.key});

  ProviderListenable<VM> get watchProvider;

  @override
  BaseWatchState createState();
}

abstract class BaseWatchState<V extends BaseWatchStatefulWidget<VM>, VM>
    extends ConsumerState<V> {
  Widget fulBuild(BuildContext context, VM viewModel);

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(widget.watchProvider);
    return fulBuild(context, viewModel);
  }
}

/// StatelessWidget
abstract class BaseWatchStatelessWidget<VM>
    extends BaseWatchStatefulWidget<VM> {
  const BaseWatchStatelessWidget({super.key});
  Widget build(BuildContext context, WidgetRef ref, VM viewModel);

  @override
  _BaseStateState createState() => _BaseStateState();
}

class _BaseStateState<VM>
    extends BaseWatchState<BaseWatchStatelessWidget<VM>, VM> {
  @override
  Widget fulBuild(BuildContext context, VM viewModel) {
    return widget.build(context, ref, viewModel);
  }
}
