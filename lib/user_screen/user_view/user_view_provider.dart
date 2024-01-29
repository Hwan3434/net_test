import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/user_screen/user_view/user_view_model.dart';

final userViewProvider =
    StateNotifierProvider.autoDispose<_UserViewNotifier, UserViewModel>((ref) {
  return _UserViewNotifier();
});

class _UserViewNotifier extends StateNotifier<UserViewModel> {
  _UserViewNotifier()
      : super(UserViewModel(selectedTab: UserPageViews.provider));

  void update({
    UserPageViews? selectedTab,
  }) {
    state = state.copyWith(selectedTab: selectedTab);
  }
}
