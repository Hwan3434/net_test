import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cls_view_model.dart';

final clsViewProvider =
    StateNotifierProvider.autoDispose<ClsViewStateNotifier, ClsStateModel>(
        (ref) {
  return ClsViewStateNotifier();
});

class ClsViewStateNotifier extends StateNotifier<ClsStateModel> {
  ClsViewStateNotifier() : super(ClsStateModelWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = ClsStateModelLoading();
    await Future.delayed(Duration(seconds: 3));
    state = ClsStateModelSuccess(data: 'Test User');
    // state = FuncStateModelError();
  }

  void refresh() {
    fetchData();
  }
}
