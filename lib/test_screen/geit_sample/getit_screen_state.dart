import 'package:domain/sample/login/model/login_user_model.dart';

sealed class GetItScreenState {}

class GetItScreenStateWait extends GetItScreenState {}

class GetItScreenStateLoading extends GetItScreenState {}

class GetItScreenStateError extends GetItScreenState {
  final String errorMessage;

  GetItScreenStateError({
    required this.errorMessage,
  });
}

class GetItScreenStateSuccess extends GetItScreenState {
  final List<LoginUserModel> loginUserList;

  GetItScreenStateSuccess({
    required this.loginUserList,
  });
}
