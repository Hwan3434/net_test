import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/user_screen/user_view/user_screen_model.dart';

final userScreenProvider =
    StateNotifierProvider.autoDispose<_UserScreenNotifier, UserScreenModel>(
        (ref) {
  return _UserScreenNotifier();
});

class _UserScreenNotifier extends StateNotifier<UserScreenModel> {
  _UserScreenNotifier()
      : super(UserScreenModel(selectedTab: UserPageViews.user));

  void update({
    UserPageViews? selectedTab,
  }) {
    state = state.copyWith(selectedTab: selectedTab);
  }
}
