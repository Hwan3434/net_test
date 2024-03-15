import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_model.dart';

class OrgListStateNotifier extends StateNotifier<Set<OrgModel>> {
  OrgListStateNotifier(super.state);

  void addAllOrgModel(List<OrgModel> models) {
    state = {...models, ...state};
  }

  void addOrgModel(OrgModel model) {
    state = {model, ...state};
  }
}
