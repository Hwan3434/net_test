import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseWatchStatefulWidget2<NotifierT extends StateNotifier<VM>, VM>
    extends ConsumerStatefulWidget {
  const BaseWatchStatefulWidget2({super.key});

  AutoDisposeStateNotifierProvider<NotifierT, VM> get notifierProvider;

  @override
  BaseWatchState2 createState();
}

abstract class BaseWatchState2<
    T extends BaseWatchStatefulWidget2<NotifierT, VM>,
    NotifierT extends StateNotifier<VM>,
    VM> extends ConsumerState<T> {
  Widget fulBuild(BuildContext context, VM viewModel);

  @override
  Widget build(BuildContext context) {
    final VM viewModel = ref.watch(widget.notifierProvider);
    return fulBuild(context, viewModel);
  }
}

abstract class BaseWatchStatelessWidget2<NotifierT extends StateNotifier<VM>,
    VM> extends BaseWatchStatefulWidget2<NotifierT, VM> {
  const BaseWatchStatelessWidget2({super.key});
  Widget build(BuildContext context, WidgetRef ref, VM viewModel);

  @override
  _BaseWatchStateState2 createState() => _BaseWatchStateState2();
}

class _BaseWatchStateState2<T extends BaseWatchStatelessWidget2<NotifierT, VM>,
        NotifierT extends StateNotifier<VM>, VM>
    extends BaseWatchState2<BaseWatchStatelessWidget2<NotifierT, VM>, NotifierT,
        VM> {
  @override
  Widget fulBuild(BuildContext context, VM viewModel) {
    return widget.build(context, ref, viewModel);
  }
}
