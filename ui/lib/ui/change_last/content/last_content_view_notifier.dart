import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_last/base/base_widget.dart';
import 'package:ui/ui/change_last/common/locator.dart';
import 'package:ui/ui/change_last/content/last_content_view_model.dart';
import 'package:ui/ui/change_last/data/last_data.dart';

final lastContentViewProvider = CreateBaseProvider.createViewNotifierProvider<
    LastContentViewNotifier, LastContentViewModelState>((ref) {
  final item = ref.watch(lastDiaryDataProvider);
  final userUseCase = locator<UserUseCase>();
  return LastContentViewNotifier(
    LastContentViewModelSuccess(
      diaryItems: item.toList(),
      userModelState: LastContentViewUserModelWait(),
    ),
    userUseCase,
  );
});

class LastContentViewNotifier extends StateNotifier<LastContentViewModelState> {
  final UserUseCase _userUseCase;
  LastContentViewNotifier(super.state, this._userUseCase);

  void fetchUserModels() async {
    assert(state is LastContentViewModelSuccess);
    final pState = state as LastContentViewModelSuccess;

    state = pState.copyWith(userModelState: LastContentViewUserModelLoading());

    await Future.delayed(Duration(seconds: 2));

    final list = await _userUseCase.getUsers();
    switch (list) {
      case ResultSuccess(data: final users):
        state = pState.copyWith(
          userModelState: LastContentViewUserModelSuccess(
            users: users,
          ),
        );
      case ResultError(e: final e):
        state = pState.copyWith(
          userModelState: LastContentViewUserModelError(
            errorMessage: e.errorMessage,
          ),
        );
    }
  }
}
