import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';

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
    if (state.pw == 'dddd') {
      return true;
    }
    return false;
  }

  void login({required AgentState state}) {
    this.state = this.state.copyWith(state: state);
  }
}

class LoginViewModel {
  final AgentState state;
  final String id;
  final String pw;

  const LoginViewModel({
    required this.state,
    required this.id,
    required this.pw,
  });

  LoginViewModel copyWith({
    AgentState? state,
    String? id,
    String? pw,
  }) {
    return LoginViewModel(
      state: state ?? this.state,
      id: id ?? this.id,
      pw: pw ?? this.pw,
    );
  }
}
