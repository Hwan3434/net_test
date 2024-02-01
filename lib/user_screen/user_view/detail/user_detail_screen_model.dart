import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class UserDetailScreenStateModel {}

class UserDetailScreenStateModelWait extends UserDetailScreenStateModel {
  static String key = 'UserDetailWaitState';
}

class UserDetailScreenStateModelLoading extends UserDetailScreenStateModel {
  static String key = 'UserDetailLoadingState';
}

class UserDetailScreenStateModelSuccess extends UserDetailScreenStateModel {
  static String key = 'UserDetailSuccessState';
  final UserDetailScreenDataModel viewModel;
  UserDetailScreenStateModelSuccess({required this.viewModel});
}

class UserDetailScreenStateModelError extends UserDetailScreenStateModel {
  static String key = 'UserDetailErrorState';
}

class UserDetailScreenDataModel {
  final UserModel model;
  UserDetailScreenDataModel({required this.model});
}
