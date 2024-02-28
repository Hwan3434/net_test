import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/data_container.dart';
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

    save(projects);

    success(orgName);
  }

  void save(List<OrgProject> projects) {
    /// 메모리 저장소에 저장해야지
    for (var project in projects) {
      LoginDataContainer.instance.getOrgProject().save(project);
    }
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
