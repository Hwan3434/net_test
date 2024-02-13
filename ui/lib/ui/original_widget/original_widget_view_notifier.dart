import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/user_use_case.dart';

import 'original_widget_view_model.dart';

final originalWidgetViewProvider = StateNotifierProvider.autoDispose<
    _OriginalWidgetViewStateNotifier, OriginalWidgetViewModel>((ref) {
  final userUseCase = ref.read(userUsecaseProvider);
  return _OriginalWidgetViewStateNotifier(userUseCase);
});

class _OriginalWidgetViewStateNotifier
    extends StateNotifier<OriginalWidgetViewModel> {
  final UserUseCase _userUseCase;
  _OriginalWidgetViewStateNotifier(this._userUseCase)
      : super(OriginalWidgetViewModel(count: 0, text: ''));

  void updateStateCount() {
    state = state.copyWith(count: state.count + 1);
  }

  void updateState({required String text}) async {
    /// server test = asdasdasdasd
    state = state.copyWith(text: text);
  }
}
