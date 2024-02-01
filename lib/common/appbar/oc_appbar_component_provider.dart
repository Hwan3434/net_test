import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/appbar/oc_appbar_component_model.dart';
import 'package:net_test/user_screen/user_view/user_screen_provider.dart';

final ocAppbarComponentProvider = StateNotifierProvider.autoDispose<
    _OcAppbarViewNotifier, OcAppbarComponentModel>((ref) {
  final tab =
      ref.watch(userScreenProvider.select((value) => value.selectedTab));
  final tabName = tab.name;
  return _OcAppbarViewNotifier(name: tabName);
});

class _OcAppbarViewNotifier extends StateNotifier<OcAppbarComponentModel> {
  final String name;
  _OcAppbarViewNotifier({
    required this.name,
  }) : super(OcAppbarComponentModel(name: name));

  void update({
    String? name,
  }) {
    state = state.copyWith(name: name);
  }
}
