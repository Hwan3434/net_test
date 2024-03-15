import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'organization_model.dart';

class OrganizationNotifier extends StateNotifier<OrganizationModel> {
  OrganizationNotifier(super.state);

  void update(String org){
    state = state.copyWith(org: org);
  }

}