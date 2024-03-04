import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';

class OrgDataContainer {
  OrgDataContainer._privateConstructor();
  static final OrgDataContainer i = OrgDataContainer._privateConstructor();

  /// Org를 변경하면
  _OrgProjectData getOrgProject() {
    return _OrgProjectData.i;
  }
}

class _OrgProjectData {
  _OrgProjectData._privateConstructor();
  static final _OrgProjectData i = _OrgProjectData._privateConstructor();

  Map<int, TempProject> data = {};

  void clear() {
    data.clear();
  }

  void save(TempProject project) {
    data[project.id] = project;
  }

  TempProject? get(int id) {
    return data[id];
  }

  List<TempProject> getList() {
    return data.values.toList();
  }
}
