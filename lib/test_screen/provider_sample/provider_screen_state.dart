import 'package:domain/sample/login/model/login_user_model.dart';

sealed class ProviderScreenState {}

class ProviderScreenStateWait extends ProviderScreenState {}

class ProviderScreenStateLoading extends ProviderScreenState {}

class ProviderScreenStateError extends ProviderScreenState {
  final String errorMessage;

  ProviderScreenStateError({
    required this.errorMessage,
  });
}

class ProviderScreenStateSuccess extends ProviderScreenState {
  final List<LoginUserModel> loginUserList;

  ProviderScreenStateSuccess({
    required this.loginUserList,
  });
}
