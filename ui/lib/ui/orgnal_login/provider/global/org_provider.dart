import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';

final orgProvider = StateNotifierProvider<_OrgNotifier, OrgState>((ref) {
  return _OrgNotifier(OrgNone());
});

class _OrgNotifier extends StateNotifier<OrgState> {
  _OrgNotifier(super.state);

  void login(String orgName) async {
    state = OrgLoading(orgName: orgName);
    await Future.delayed(Duration(seconds: 2));

    /// 서버에서 받아온 프로젝트
    final projects = [
      OrgProject(id: 1, name: 'project1'),
      OrgProject(id: 2, name: 'project2'),
    ];
    success(orgName, projects);
  }

  void success(String orgName, List<OrgProject> projects) {
    state = OrgLoginSuccess(orgName: orgName, project: projects);
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
  final List<OrgProject> project;

  OrgLoginSuccess({
    required this.orgName,
    required this.project,
  });
}
