import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/original/original_view_model.dart';

class OriginalViewNotifier extends StateNotifier<OriginalViewStateModel> {
  final UserUseCase _userUseCase;
  OriginalViewNotifier(this._userUseCase) : super(OriginalViewStateWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = OriginalViewStateLoading();
    await _userUseCase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final successData):
          state = OriginalViewStateSuccess(data: successData);
        case ResultError(e: final error):
          state = OriginalViewStateError(errorMessage: error.toString());
      }
    });
  }
}
