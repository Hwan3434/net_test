import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/original/original_view_model.dart';

final originalViewProvider = StateNotifierProvider.autoDispose<
    _OriginalViewStateNotifier, OriginalViewStateModel>((ref) {
  return _OriginalViewStateNotifier();
});

class _OriginalViewStateNotifier extends StateNotifier<OriginalViewStateModel> {
  _OriginalViewStateNotifier() : super(OriginalViewStateWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = OriginalViewStateLoading();

    await Future.delayed(Duration(seconds: 3));
    state = OriginalViewStateSuccess(data: 'Test User');
    // state = OriginalViewStateError(errorMessage: e.toString());
  }
}
