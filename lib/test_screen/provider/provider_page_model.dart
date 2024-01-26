import 'package:domain/usecase/login/res_model/login_user_model.dart';

sealed class ProviderScreenModel {}

class ProviderScreenModelWait extends ProviderScreenModel {}

class ProviderScreenModelLoading extends ProviderScreenModel {}

class ProviderScreenModelError extends ProviderScreenModel {
  final String errorMessage;

  ProviderScreenModelError({
    required this.errorMessage,
  });
}

class ProviderScreenModelSuccess extends ProviderScreenModel {
  final List<LoginUserModel> loginUserList;

  ProviderScreenModelSuccess({
    required this.loginUserList,
  });
}
