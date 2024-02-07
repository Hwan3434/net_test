import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/user_use_case.dart';
import 'package:ui/ui/original/original_view_model.dart';

final originalViewProvider = StateNotifierProvider.autoDispose<
    _OriginalViewStateNotifier, OriginalViewStateModel>((ref) {
  final userUseCase = ref.read(userUsecaseProvider);
  return _OriginalViewStateNotifier(userUseCase);
});

class _OriginalViewStateNotifier extends StateNotifier<OriginalViewStateModel> {
  final UserUseCase _userUseCase;
  _OriginalViewStateNotifier(this._userUseCase)
      : super(OriginalViewStateWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = OriginalViewStateLoading();
    await _userUseCase.getUsers().then((value) {
      state = OriginalViewStateSuccess(data: value);
    }).catchError((onError) {
      state = OriginalViewStateError(errorMessage: onError);
    });
  }
}
