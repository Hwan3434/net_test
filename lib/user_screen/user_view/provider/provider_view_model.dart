import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class ProviderViewModel {}

class ProviderViewModelWait extends ProviderViewModel {}

class ProviderViewModelLoading extends ProviderViewModel {}

class ProviderViewModelError extends ProviderViewModel {
  final String errorMessage;

  ProviderViewModelError({
    this.errorMessage = '',
  });
}

class ProviderScreenModelSuccess extends ProviderViewModel {
  final List<UserModel> loginUserList;

  ProviderScreenModelSuccess({
    this.loginUserList = const [],
  });
}
