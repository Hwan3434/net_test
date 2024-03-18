import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sample/sample/ui/splash/splash_notifier.dart';
import 'package:sample/sample/ui/splash/splash_widget.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_button.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

import 'splash_model.dart';

class SplashBodyWidget
    extends ProviderStatelessWidget<SplashNotifier, SplashModel> {
  const SplashBodyWidget({super.key});

  @override
  AutoDisposeStateNotifierProvider<SplashNotifier, SplashModel> get provider =>
      SplashWidget.splashLoadingProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final b = ref.read(provider.select((value) => value.splashLoading));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('splash :: $b'),
        _CountWidget(),
        BButton(
            onPressed: () {
              ref.read(provider.notifier).up();
            },
            child: Text('up')),
        BButton(
            onPressed: () {
              ref.read(provider.notifier).down();
            },
            child: Text('down')),
        CircularProgressIndicator(),
      ],
    );
  }
}

class _CountWidget
    extends ProviderStatelessWidget<SplashNotifier, SplashModel> {
  const _CountWidget();

  @override
  AutoDisposeStateNotifierProvider<SplashNotifier, SplashModel> get provider =>
      SplashWidget.splashLoadingProvider;

  @override
  Widget pBuild(BuildContext context, WidgetRef ref) {
    final count = ref.watch(provider.select((value) => value.count));
    return BTextWidget('count : $count');
  }
}
