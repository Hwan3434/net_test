import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_container.dart';
import 'package:ui/ui/orgnal_login/provider/global/dio_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';

final userUseCaseProvider =
    StateProvider.family<UserUseCase, String>((ref, orgName) {
  https: //${orgName}.nhncloud.com/
  final dio = ref.read(dioUrlProvider(orgName));
  final dataSource = RemoteUserDataSourceImpl(dio);
  final repository = UserRepositoryImpl(dataSource);
  final userUseCase = UserUseCaseImpl2(repository);
  return userUseCase;
});

final orgStateProvider = StateNotifierProvider<_OrgNotifier, OrgState>((ref) {
  return _OrgNotifier(ref, OrgNone());
});

class _OrgNotifier extends StateNotifier<OrgState> {
  final Ref ref;
  _OrgNotifier(this.ref, super.state);

  void login(String orgName) async {
    state = OrgLoading(orgName: orgName);
    await Future.delayed(Duration(seconds: 1));

    final userUseCase = ref.read(userUseCaseProvider(orgName));

    /// UseCase를 통해서 로그인 하고 서버에서 받아온 프로젝트
    var projects = <TempProject>[];

    /// test code
    if (orgName == '조직1') {
      projects
        ..add(TempProject(id: 1, name: 'project1'))
        ..add(TempProject(id: 2, name: 'project2'))
        ..add(TempProject(id: 3, name: 'project3'))
        ..add(TempProject(id: 4, name: 'project4'))
        ..add(TempProject(id: 5, name: 'project5'));
    } else {
      projects
        ..add(TempProject(id: 1, name: '조직2_project1'))
        ..add(TempProject(id: 2, name: '조직2_project2'))
        ..add(TempProject(id: 3, name: '조직2_project3'))
        ..add(TempProject(id: 4, name: '조직2_project4'));
    }

    orgClear();

    saveAll(projects);

    success(orgName);
  }

  void orgClear() {
    OrgDataContainer.i.getOrgProject().clear();
  }

  void saveAll(List<TempProject> projects) {
    for (var project in projects) {
      save(project);
    }
  }

  void save(TempProject project) {
    OrgDataContainer.i.getOrgProject().save(project);
  }

  void success(String orgName) {
    state = OrgLoginSuccess(orgName: orgName);
  }

  void change(String changeName) {
    login(changeName);
  }

  void logout() async {
    state = OrgLoading(orgName: '');

    /// 서버에 로그아웃 전달
    await Future.delayed(Duration(seconds: 1));
    state = OrgNone();
  }
}

sealed class OrgState {}

class OrgNone extends OrgState {}

class OrgLoading extends OrgState {
  final String orgName;

  OrgLoading({
    required this.orgName,
  });
}

class OrgLoginSuccess extends OrgState {
  final String orgName;

  OrgLoginSuccess({
    required this.orgName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrgLoginSuccess &&
          runtimeType == other.runtimeType &&
          orgName == other.orgName;

  @override
  int get hashCode => orgName.hashCode;
}
