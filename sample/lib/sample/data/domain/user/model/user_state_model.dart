import 'package:sample/sample/data/domain/user/model/user_model.dart';

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

enum UserState { wait, loading, error, success }

class UserStateModel {
  final UserState state;
  final List<UserModel> data;

  const UserStateModel({
    required this.state,
    required this.data,
  });

  factory UserStateModel.create() => const UserStateModel(
        state: UserState.wait,
        data: [],
      );

  UserStateModel copyWith({
    UserState? state,
    List<UserModel>? data,
  }) {
    return UserStateModel(
      state: state ?? this.state,
      data: data ?? this.data,
    );
  }
}
