import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'last_view_model.dart';

final lastViewProvider =
    StateNotifierProvider.autoDispose<_LastScreenNotifier, LastStateModel>(
        (ref) {
  return _LastScreenNotifier();
});

class _LastScreenNotifier extends StateNotifier<LastStateModel> {
  _LastScreenNotifier() : super(LastStateModelWait());

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = LastStateModelLoading();
    await Future.delayed(Duration(seconds: 3));
    state = LastStateModelSuccess(data: 'Test User');
    // state = FuncStateModelError(e.error);
  }
}
