import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';

typedef LoginStateCallback = void Function(AgentState state);

class LoginLoadingWidget extends ConsumerWidget {
  static String get path => '/Loading';
  static String get name => 'LoadingWidget';
  final LoginStateCallback callback;
  const LoginLoadingWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(GlobalStateStorage().agentStateProvider, (previous, next) {
      callback(next.state);
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
