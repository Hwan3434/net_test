import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';

///todo 여기에 조직명이 들어가는게 맞을까 ??
final orgProjectsProvider = StateNotifierProvider.family<_OrgProjectsNotifier,
    Map<int, OrgProject>, OrgLoginSuccess>((ref, org) {
  final projects =
      org.project.asMap().map((key, value) => MapEntry(value.id, value));
  return _OrgProjectsNotifier(projects);
});

class _OrgProjectsNotifier extends StateNotifier<Map<int, OrgProject>> {
  _OrgProjectsNotifier(super.state);

  OrgProject getProject(int id) {
    assert(state.containsKey(id));
    return state[id]!;
  }
}
