import 'package:domain/sample/login/model/login_user_model.dart';

sealed class TestScreenState {}

class TestScreenStateWait extends TestScreenState {}

class TestScreenStateLoading extends TestScreenState {}

class TestScreenStateError extends TestScreenState {
  final String errorMessage;

  TestScreenStateError({
    required this.errorMessage,
  });
}

class TestScreenStateSuccess extends TestScreenState {
  final List<LoginUserModel> loginUserList;

  TestScreenStateSuccess({
    required this.loginUserList,
  });
}
