import 'package:domain/sample/login/model/login_user_model.dart';

sealed class GetItScreenModel {}

class GetItScreenModelWait extends GetItScreenModel {}

class GetItScreenModelLoading extends GetItScreenModel {}

class GetItScreenModelError extends GetItScreenModel {
  final String errorMessage;

  GetItScreenModelError({
    required this.errorMessage,
  });
}

class GetItScreenModelSuccess extends GetItScreenModel {
  final List<LoginUserModel> loginUserList;

  GetItScreenModelSuccess({
    required this.loginUserList,
  });
}
