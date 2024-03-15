import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ProviderStatefulWidget<NotifierT extends StateNotifier<VM>, VM>
    extends ConsumerStatefulWidget {
  const ProviderStatefulWidget({super.key});

  ProviderBase<VM> get provider;

  @override
  ProviderState createState();
}

abstract class ProviderState<T extends ProviderStatefulWidget<NotifierT, VM>,
    NotifierT extends StateNotifier<VM>, VM> extends ConsumerState<T> {
  Widget pBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return pBuild(context);
  }
}

abstract class ProviderStatelessWidget<NotifierT extends StateNotifier<VM>, VM>
    extends ProviderStatefulWidget<NotifierT, VM> {
  const ProviderStatelessWidget({super.key});
  Widget pBuild(BuildContext context, WidgetRef ref);

  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState<T extends ProviderStatelessWidget<NotifierT, VM>,
        NotifierT extends StateNotifier<VM>, VM>
    extends ProviderState<ProviderStatelessWidget<NotifierT, VM>, NotifierT,
        VM> {
  @override
  Widget pBuild(BuildContext context) {
    return widget.pBuild(context, ref);
  }
}
