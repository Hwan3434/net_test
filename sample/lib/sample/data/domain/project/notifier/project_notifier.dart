import 'package:domain/usecase/result/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/common/usecase_manager.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/domain/project/model/project_state_model.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';
import 'package:sample/sample/data/domain/user/model/user_state_model.dart';

class ProjectStateNotifier extends StateNotifier<ProjectStateModel> {
  final Ref ref;
  final AgentUseCase agentUseCase;
  ProjectStateNotifier(
    super.state, {
    required this.ref,
    required this.agentUseCase,
  }) {
    // init();
  }

  void init() {
    // fetchData(0);
  }

  void fetchProject() async {
    state = state.copyWith(state: ProjectState.loading);
    // final list = await agentUseCase.getProjects();
    await Future.delayed(Duration(seconds: 3));
    state = state.copyWith(
      state: ProjectState.success,
      items: [
        ProjectModel(
            id: 1, name: 'p1', userStateModel: UserStateModel.create()),
        ProjectModel(
            id: 2, name: 'p2', userStateModel: UserStateModel.create()),
      ],
    );
  }

  ProjectModel getProjectById(int projectId) {
    assert(state.state == ProjectState.success);
    return state.items.singleWhere((element) => element.id == projectId);
  }

  void fetchUser({required ProjectModel project}) async {
    final userUseCase = ref.read(UseCaseManager().userUseCaseProvider(project));

    state = state.copyWith(
      items: state.items.map((e) {
        if (e.id == project.id) {
          return e.copyWith(
            userStateModel: e.userStateModel.copyWith(
              state: UserState.loading,
            ),
          );
        }
        return e;
      }).toList(),
    );

    await Future.delayed(Duration(seconds: 3));
    await userUseCase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final data):
          {
            state = state.copyWith(
              items: state.items.map((e) {
                if (project.id == e.id) {
                  return e.copyWith(
                    userStateModel: UserStateModel(
                      state: UserState.success,
                      data: data
                          .map((e) => UserModel.fromUserDataModel(e))
                          .toList(),
                    ),
                  );
                }
                return e;
              }).toList(),
            );
          }
        case ResultError():
          {
            state = state.copyWith(
              items: state.items.map((e) {
                if (project.id == e.id) {
                  return e.copyWith(
                    userStateModel: e.userStateModel.copyWith(
                      state: UserState.error,
                    ),
                  );
                }
                return e;
              }).toList(),
            );
          }
      }
    });
  }

  void updateUser(ProjectModel project, UserModel userModel) {
    state = state.copyWith(
      items: state.items.map(
        (e) {
          if (e.id == project.id) {
            return e.copyWith(
              userStateModel: e.userStateModel.copyWith(
                data: e.userStateModel.data.map((e) {
                  if (e.id == userModel.id) {
                    return userModel;
                  }
                  return e;
                }).toList(),
              ),
            );
          }
          return e;
        },
      ).toList(),
    );
  }

  void addUser(ProjectModel project, UserModel userModel) {
    state = state.copyWith(
      items: state.items.map(
        (e) {
          if (e.id == project.id) {
            return e.copyWith(
              userStateModel: e.userStateModel.copyWith(
                data: [...e.userStateModel.data, userModel],
              ),
            );
          }
          return e;
        },
      ).toList(),
    );
  }

  UserModel getUserById(int projectId, int userId) {
    return state.items
        .singleWhere((element) => element.id == projectId)
        .userStateModel
        .data
        .firstWhere((element) => element.id == userId);
  }
}
