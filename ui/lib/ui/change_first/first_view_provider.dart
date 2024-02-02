import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'first_view_model.dart';

final firstViewProvider =
    StateNotifierProvider.autoDispose<FirstViewStateNotifier, FirstStateModel>(
        (ref) {
  return FirstViewStateNotifier();
});

class FirstViewStateNotifier extends StateNotifier<FirstStateModel> {
  FirstViewStateNotifier() : super(FirstStateModelWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = FirstStateModelLoading();
    await Future.delayed(Duration(seconds: 3));
    state = FirstStateModelSuccess(data: 'Test User');
    // state = ProviderViewModelError(errorMessage: e.toString());
  }
}
