import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wrapper_view_model.dart';

final wrapperViewProvider = StateNotifierProvider.autoDispose<
    _WrapperScreenNotifier, WrapperStateModel>((ref) {
  return _WrapperScreenNotifier();
});

class _WrapperScreenNotifier extends StateNotifier<WrapperStateModel> {
  _WrapperScreenNotifier() : super(WrapperStateModelWait());

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = WrapperStateModelLoading();
    await Future.delayed(Duration(seconds: 3));
    state = WrapperStateModelSuccess(data: 'Test User');
    // state = FuncStateModelError(e.error);
  }
}
