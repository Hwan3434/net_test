import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CreateNotifier<NotifierT extends StateNotifier<VM>, VM, R extends Ref>
    = NotifierT Function(R ref);

class CreateBaseProvider {
  static AutoDisposeStateNotifierProvider<NotifierT, VM>
      createViewNotifierProvider<NotifierT extends StateNotifier<VM>, VM>(
    CreateNotifier<NotifierT, VM,
            AutoDisposeStateNotifierProviderRef<NotifierT, VM>>
        create,
  ) {
    return StateNotifierProvider.autoDispose<NotifierT, VM>(
      (ref) {
        return create(ref);
      },
    );
  }
}

abstract class BaseStatefulWidget<NotifierT extends StateNotifier<VM>, VM>
    extends ConsumerStatefulWidget {
  const BaseStatefulWidget({
    super.key,
  });

  AutoDisposeStateNotifierProvider<NotifierT, VM> get notifierProvider;

  @override
  BaseState createState();
}

abstract class BaseState<T extends BaseStatefulWidget<NotifierT, VM>,
    NotifierT extends StateNotifier<VM>, VM> extends ConsumerState<T> {
  Widget fulBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return fulBuild(context);
  }
}

abstract class BaseStatelessWidget<NotifierT extends StateNotifier<VM>, VM>
    extends BaseStatefulWidget<NotifierT, VM> {
  const BaseStatelessWidget({super.key});

  Widget build(BuildContext context, WidgetRef ref);

  @override
  _BaseStateState createState() => _BaseStateState();
}

class _BaseStateState<
    T extends BaseStatelessWidget<NotifierT, VM>,
    NotifierT extends StateNotifier<VM>,
    VM> extends BaseState<BaseStatelessWidget<NotifierT, VM>, NotifierT, VM> {
  @override
  Widget fulBuild(BuildContext context) {
    return widget.build(context, ref);
  }
}
