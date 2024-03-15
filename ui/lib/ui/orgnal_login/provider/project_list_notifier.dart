import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project_model.dart';

class OrgProjectListStateNotifier extends StateNotifier<ProjectListState> {
  final UserUseCase _userUseCase = UseCaseManager.i.getUseCase;
  OrgProjectListStateNotifier(super.state) {
    init();
  }

  void init() {
    fetch();
  }

  void fetch() async {
    state = ProjectListLoading();
    await _userUseCase.getUsers();
    state = ProjectListSuccess(data: {
      OrgProjectModel(id: 1, name: 'p1'),
      OrgProjectModel(id: 2, name: 'p2'),
    });
  }
}

sealed class ProjectListState {}

class ProjectListWait extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}

class ProjectListSuccess extends ProjectListState {
  final Set<OrgProjectModel> data;

  ProjectListSuccess({
    required this.data,
  });
}

class ProjectListError extends ProjectListState {}
