import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/agent/model/agent_model.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';

class ContentViewModelNotifier extends StateNotifier<ContentViewModel> {
  ContentViewModelNotifier(super.state);

  void update({
    int? currentTabIndex,
    String? organization,
    AgentModel? agentModel,
    ProjectModel? project,
    UserListModel? users,
    int? currentProjectId,
  }) {
    state = state.copyWith(
      currentTabIndex: currentTabIndex,
      organization: organization,
      agentModel: agentModel,
      project: project,
      users: users,
      currentProjectId: currentProjectId,
    );
  }
}

class ContentViewModel {
  final int currentTabIndex;
  final String organization;
  final AgentModel agentModel;
  final ProjectModel project;
  final UserListModel users;
  final int currentProjectId;

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
    UserListModel? users,
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
