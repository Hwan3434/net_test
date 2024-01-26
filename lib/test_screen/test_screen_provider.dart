import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/test_screen_model.dart';

final testScreenProvider =
    StateNotifierProvider.autoDispose<TestScreenNotifier, TestScreenModel>(
        (ref) {
  return TestScreenNotifier();
});

class TestScreenNotifier extends StateNotifier<TestScreenModel> {
  TestScreenNotifier()
      : super(TestScreenModel(selectedTab: SampleScreen.provider));

  void update({
    SampleScreen? selectedTab,
  }) {
    state = state.copyWith(selectedTab: selectedTab);
  }
}
