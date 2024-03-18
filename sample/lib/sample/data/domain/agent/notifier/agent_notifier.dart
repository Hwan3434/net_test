import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

class AgentNotifier extends StateNotifier<AgentModel> {
  final AgentUseCase agentUseCase;
  AgentNotifier(
    super.state, {
    required this.agentUseCase,
  });

  void login(String id, String pw) async {
    state = state.copyWith(
      state: AgentState.loading,
    );
    // final AgentModel = await agentUseCase.login(id: id, pw: pw);
    await Future.delayed(Duration(seconds: 3));
    state = AgentModel(
      state: AgentState.success,
      data: AgentDataModel(
        id: id,
        pw: pw,
        name: '정환',
        age: 24,
        accessToken: 'ACCCCCCCESSSSSTOTOTOTKEN',
        refreshToken: 'RERERERERERREFERESHTOKEN',
      ),
    );
  }

  Future<List<ProjectDataModel>> getProjects() async {
    return [];
  }

  void downloadInit() async {
    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(
      state: AgentState.wait,
    );
  }

  void logout() {
    state = state.copyWith(
      state: AgentState.init,
    );
  }
}
