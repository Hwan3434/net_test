import 'package:data/common/log.dart';
import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_last/common/locator.dart';
import 'package:ui/ui/change_last/data/last_data.dart';

import 'last_setting_view_model.dart';

final lastSettingViewProvider = StateNotifierProvider.autoDispose<
    LastSettingViewNotifier, LastSettingViewModel>((ref) {
  final item = ref.read(lastDiaryDataProvider);
  final userUseCase = locator<UserUseCase>();
  return LastSettingViewNotifier(
    LastSettingViewModel(
      diaryState: LastSettingsViewDiaryModelSuccess(diaryModels: item.toList()),
      userStates: LastSettingsViewUserModelWait(),
    ),
    userUseCase,
  );
});

class LastSettingViewNotifier extends StateNotifier<LastSettingViewModel> {
  final UserUseCase _userUseCase;
  LastSettingViewNotifier(super.state, this._userUseCase);

  void fetchDiary() {}

  void removeDiaryData(int id) {
    assert(state.diaryState is LastSettingsViewDiaryModelSuccess,
        'Not Success Data');
    final pState = state.diaryState as LastSettingsViewDiaryModelSuccess;

    pState.diaryModels.removeWhere((element) => element.id == id);

    state = state.copyWith(
      diaryState: pState.copyWith(
        diaryModels: [
          ...pState.diaryModels,
        ],
      ),
    );
  }

  void fetchUser() async {
    state = state.copyWith(userStates: LastSettingsViewUserModelLoading());

    await Future.delayed(Duration(seconds: 2));

    final list = await _userUseCase.getUsers();
    switch (list) {
      case ResultSuccess(data: final users):
        state = state.copyWith(
          userStates: LastSettingsViewUserModelSuccess(
            users: users,
          ),
        );
      case ResultError(e: final e):
        state = state.copyWith(
          userStates: LastSettingsViewUserModelError(
            errorMessage: e.errorMessage,
          ),
        );
    }
  }
}
