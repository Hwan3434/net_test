import 'package:domain/usecase/user/model/response/user_model.dart';

// sealed class UserState {}
//
// class UserStateWait extends UserState {}
//
// class UserStateLoading extends UserState {}
//
// class UserStateSuccess extends UserState {
//   final List<UserModel> data;
//
//   UserStateSuccess({
//     required this.data,
//   });
//
//   UserStateSuccess copyWith({
//     List<UserModel>? data,
//   }) {
//     return UserStateSuccess(
//       data: data ?? this.data,
//     );
//   }
// }
//
// class UserStateError extends UserState {}

enum UserListState { wait, loading, error, success }

class UserListModel {
  final UserListState state;
  final List<UserModel> data;

  const UserListModel({
    required this.state,
    required this.data,
  });

  UserListModel copyWith({
    UserListState? state,
    List<UserModel>? data,
  }) {
    return UserListModel(
      state: state ?? this.state,
      data: data ?? this.data,
    );
  }
}
