import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'last_view_model.dart';

final lastViewProvider =
    StateNotifierProvider.autoDispose<LastViewNotifier, LastViewModel>((ref) {
  return LastViewNotifier();
});

class LastViewNotifier extends StateNotifier<LastViewModel> {
  LastViewNotifier() : super(LastViewModel(currentTab: LastTabs.content));
  void update(LastTabs tab) {
    state = state.copyWith(currentTab: tab);
  }
}
