import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/agent/model/agent_state_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/organization/organization_widget.dart';
import 'package:sample/sample/ui/splash/splash_body_widget.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';

import 'splash_model.dart';
import 'splash_notifier.dart';

class SplashWidget extends ProviderStatefulWidget<SplashNotifier, SplashModel> {
  static String get path => '/';
  static String get name => 'SplashWidget';

  const SplashWidget();

  static final splashLoadingProvider =
      StateNotifierProvider.autoDispose<SplashNotifier, SplashModel>((ref) {
    return SplashNotifier(SplashModel(count: 0, splashLoading: false));
  });

  @override
  AutoDisposeStateNotifierProvider<SplashNotifier, SplashModel> get provider =>
      splashLoadingProvider;

  @override
  ProviderState<SplashWidget, SplashNotifier, SplashModel> createState() =>
      _SplashWidgetState();
}

class _SplashWidgetState
    extends ProviderState<SplashWidget, SplashNotifier, SplashModel> {
  @override
  void initState() {
    super.initState();
    initDownloadFile();
  }

  void initDownloadFile() async {
    await Future.delayed(Duration(seconds: 1));
    ref.read(GlobalStateStorage().agentStateProvider.notifier).downloadInit();
  }

  @override
  Widget pBuild(BuildContext context) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      if (next.state == AgentState.wait) {
        ref.read(widget.provider.notifier).splashInitTrue();
      }
    });
    ref.listen(widget.provider.select((value) => value.splashLoading),
        (previous, next) {
      if (next) {
        context.goNamed(OrganizationWidget.name);
      }
    });

    return const Scaffold(
      body: Center(child: SplashBodyWidget()),
    );
  }
}
