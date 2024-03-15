import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

class ProjectStateNotifier extends StateNotifier<ProjectModel> {
  final AgentUseCase agentUseCase;
  ProjectStateNotifier(super.state, {required this.agentUseCase}) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = state.copyWith(
      state: ProjectState.loading,
    );
    // final list = await agentUseCase.getProjects();

    await Future.delayed(Duration(seconds: 3));

    state = state.copyWith(
      state: ProjectState.success,
      items: [
        ProjectDataModel(id: 1, name: 'p1'),
        ProjectDataModel(id: 2, name: 'p2'),
      ],
    );
  }
}
