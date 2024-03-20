import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';

class LoginCheckWidget extends StatelessWidget {
  final Widget child;
  const LoginCheckWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final agent = ref.read(GlobalStateStorage().agentStateProvider);

        if (agent.state != AgentState.success) {
          return Center(
            child: Text('로그인 하지 않음'),
          );
        }

        return child!;
      },
      child: child,
    );
  }
}
