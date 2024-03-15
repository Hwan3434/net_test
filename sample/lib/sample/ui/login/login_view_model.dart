import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';

class LoginStateNotifier extends StateNotifier<LoginViewModel> {
  final AgentUseCase _agentUseCase;
  LoginStateNotifier(super.state, this._agentUseCase);

  void update({
    String? id,
    String? pw,
  }) {
    state = state.copyWith(
      id: id,
      pw: pw,
    );
  }

  bool isValidate() {
    if(state.pw == 'dddd'){
      return true;
    }
    return false;
  }
}

class LoginViewModel {
  final String id;
  final String pw;

  const LoginViewModel({
    required this.id,
    required this.pw,
  });

  LoginViewModel copyWith({
    String? id,
    String? pw,
  }) {
    return LoginViewModel(
      id: id ?? this.id,
      pw: pw ?? this.pw,
    );
  }
}
