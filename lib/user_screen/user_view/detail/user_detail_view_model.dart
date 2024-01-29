import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class UserDetailState {}

class UserDetailWaitState extends UserDetailState {}

class UserDetailLoadingState extends UserDetailState {}

class UserDetailSuccessState extends UserDetailState {
  final UserDetailViewModel viewModel;
  UserDetailSuccessState({required this.viewModel});
}

class UserDetailErrorState extends UserDetailState {}

class UserDetailViewModel {
  final UserModel model;
  UserDetailViewModel({required this.model});
}
