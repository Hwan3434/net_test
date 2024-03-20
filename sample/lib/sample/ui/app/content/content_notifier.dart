import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';

class ContentNotifier extends StateNotifier<ContentViewModel> {
  ContentNotifier(super.state);

  void update({
    int? currentTabIndex,
    String? organization,
    AgentModel? agentModel,
    ProjectProviderModel? project,
    int? currentProjectId,
  }) {
    state = state.copyWith(
      currentTabIndex: currentTabIndex,
      organization: organization,
      agentModel: agentModel,
      project: project,
      currentProjectId: currentProjectId,
    );
  }

  void updateUsers(int projectId, UserStateModel userStateModel) {
    state = state.copyWith(
      project: state.project.copyWith(
        projectStateModel: state.project.projectStateModel.copyWith(
            items: state.project.projectStateModel.items.map((e) {
          if (e.id == projectId) {
            return e.copyWith(
              userStateModel: userStateModel,
            );
          }
          return e;
        }).toList()),
      ),
    );
  }
}

class ContentViewModel {
  final int currentTabIndex;
  final String organization;
  final AgentModel agentModel;
  final int currentProjectId;
  final ProjectProviderModel project;

  const ContentViewModel({
    required this.currentTabIndex,
    required this.organization,
    required this.agentModel,
    required this.project,
    required this.currentProjectId,
  });

  ContentViewModel copyWith({
    int? currentTabIndex,
    String? organization,
    AgentModel? agentModel,
    ProjectProviderModel? project,
    int? currentProjectId,
  }) {
    return ContentViewModel(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      organization: organization ?? this.organization,
      agentModel: agentModel ?? this.agentModel,
      project: project ?? this.project,
      currentProjectId: currentProjectId ?? this.currentProjectId,
    );
  }
}
