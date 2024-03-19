import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/splash/splash_widget.dart';

class LoginLoadingWidget extends ConsumerWidget {
  static String get path => '/Loading';
  static String get name => 'LoadingWidget';
  const LoginLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      if (next.state == AgentState.wait) {
        context.goNamed(SplashWidget.name);
      }
      if (next.state == AgentState.success) {
        context.goNamed(ContentWidget.name);
      }
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
