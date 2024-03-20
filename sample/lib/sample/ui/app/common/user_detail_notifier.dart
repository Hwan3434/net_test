import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';

class UserDetailNotifier extends StateNotifier<UserDetailModel> {
  UserDetailNotifier(super.state);

  void update({
    ProjectModel? project,
    UserModel? userModel,
  }) {
    state = state.copyWith(
      project: project,
      userModel: userModel,
    );
  }
}

class UserDetailModel {
  final ProjectModel project;
  final UserModel userModel;

  const UserDetailModel({
    required this.project,
    required this.userModel,
  });

  UserDetailModel copyWith({
    ProjectModel? project,
    UserModel? userModel,
  }) {
    return UserDetailModel(
      project: project ?? this.project,
      userModel: userModel ?? this.userModel,
    );
  }
}
