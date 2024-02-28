import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';

class LoginDataContainer {
  LoginDataContainer._privateConstructor();
  static final LoginDataContainer instance =
      LoginDataContainer._privateConstructor();

  _OrgProjectData getOrgProject() {
    return _OrgProjectData.instance;
  }
}

class _OrgProjectData {
  _OrgProjectData._privateConstructor();
  static final _OrgProjectData instance = _OrgProjectData._privateConstructor();

  Map<int, OrgProject> data = {};

  void save(OrgProject project) {
    data[project.id] = project;
  }

  OrgProject? get(int id) {
    return data[id];
  }

  List<OrgProject> getList() {
    return data.values.toList();
  }
}
