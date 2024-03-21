import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class UserListViewStateModel {}

class UserListViewStateWait extends UserListViewStateModel {}

class UserListViewStateLoading extends UserListViewStateModel {}

class UserListViewStateSuccess extends UserListViewStateModel {
  final List<UserDataModel> loginUserList;
  UserListViewStateSuccess(this.loginUserList);
}

class UserListViewStateError extends UserListViewStateModel {
  final String errorMessage;

  UserListViewStateError({
    this.errorMessage = '',
  });
}
