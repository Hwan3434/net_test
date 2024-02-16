import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

class LastSettingViewModel {
  final LastSettingsViewDiaryModelState diaryState;
  final LastSettingsViewUserModelState userStates;

  const LastSettingViewModel({
    required this.diaryState,
    required this.userStates,
  });

  LastSettingViewModel copyWith({
    LastSettingsViewDiaryModelState? diaryState,
    LastSettingsViewUserModelState? userStates,
  }) {
    return LastSettingViewModel(
      diaryState: diaryState ?? this.diaryState,
      userStates: userStates ?? this.userStates,
    );
  }
}

sealed class LastSettingsViewDiaryModelState {}

class LastSettingsViewDiaryModelWait extends LastSettingsViewDiaryModelState {}

class LastSettingsViewDiaryModelLoading
    extends LastSettingsViewDiaryModelState {}

class LastSettingsViewDiaryModelSuccess
    extends LastSettingsViewDiaryModelState {
  final List<DiaryModel> diaryModels;

  LastSettingsViewDiaryModelSuccess({
    required this.diaryModels,
  });

  LastSettingsViewDiaryModelSuccess copyWith({
    List<DiaryModel>? diaryModels,
  }) {
    return LastSettingsViewDiaryModelSuccess(
      diaryModels: diaryModels ?? this.diaryModels,
    );
  }
}

class LastSettingsViewDiaryModelError extends LastSettingsViewDiaryModelState {}

///

sealed class LastSettingsViewUserModelState {}

class LastSettingsViewUserModelWait extends LastSettingsViewUserModelState {}

class LastSettingsViewUserModelLoading extends LastSettingsViewUserModelState {}

class LastSettingsViewUserModelSuccess extends LastSettingsViewUserModelState {
  final List<UserModel> users;

  LastSettingsViewUserModelSuccess({
    required this.users,
  });
}

class LastSettingsViewUserModelError extends LastSettingsViewUserModelState {
  final String errorMessage;

  LastSettingsViewUserModelError({
    required this.errorMessage,
  });
}
