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
    ProjectModel? project,
    int? currentProjectId,
    Map<int, UserListModel>? users,
  }) {
    state = state.copyWith(
      currentTabIndex: currentTabIndex,
      organization: organization,
      agentModel: agentModel,
      project: project,
      currentProjectId: currentProjectId,
      users: users,
    );
  }

  void updateUsers(int projectId, UserListModel userListModel) {
    state.users.addAll({projectId: userListModel});
    state = state.copyWith();
  }
}

class ContentViewModel {
  final int currentTabIndex;
  final String organization;
  final AgentModel agentModel;
  final int currentProjectId;
  final ProjectModel project;
  final Map<int, UserListModel> users;

  const ContentViewModel({
    required this.currentTabIndex,
    required this.organization,
    required this.agentModel,
    required this.project,
    required this.users,
    required this.currentProjectId,
  });

  ContentViewModel copyWith({
    int? currentTabIndex,
    String? organization,
    AgentModel? agentModel,
    ProjectModel? project,
    Map<int, UserListModel>? users,
    int? currentProjectId,
  }) {
    return ContentViewModel(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      organization: organization ?? this.organization,
      agentModel: agentModel ?? this.agentModel,
      project: project ?? this.project,
      users: users ?? this.users,
      currentProjectId: currentProjectId ?? this.currentProjectId,
    );
  }
}