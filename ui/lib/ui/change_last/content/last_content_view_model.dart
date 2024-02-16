import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

sealed class LastContentViewModelState {}

class LastContentViewModelLoading extends LastContentViewModelState {}

class LastContentViewModelError extends LastContentViewModelState {}

class LastContentViewModelSuccess extends LastContentViewModelState {
  final List<DiaryModel> diaryItems;
  final LastContentViewUserModelState userModelState;
  LastContentViewModelSuccess({
    required this.diaryItems,
    required this.userModelState,
  });

  LastContentViewModelSuccess copyWith({
    List<DiaryModel>? diaryItems,
    LastContentViewUserModelState? userModelState,
  }) {
    return LastContentViewModelSuccess(
      diaryItems: diaryItems ?? this.diaryItems,
      userModelState: userModelState ?? this.userModelState,
    );
  }
}

sealed class LastContentViewUserModelState {}

class LastContentViewUserModelWait extends LastContentViewUserModelState {}

class LastContentViewUserModelLoading extends LastContentViewUserModelState {}

class LastContentViewUserModelSuccess extends LastContentViewUserModelState {
  final List<UserModel> users;

  LastContentViewUserModelSuccess({
    required this.users,
  });
}

class LastContentViewUserModelError extends LastContentViewUserModelState {
  final String errorMessage;

  LastContentViewUserModelError({
    required this.errorMessage,
  });
}
