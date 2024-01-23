import 'package:domain/usecase/login/model/login_user_model.dart';

class UserContainer {
  final String serviceId;
  final Set<LoginUserModel> children;

  UserContainer(this.serviceId, this.children);

  UserContainer copyWith({
    String? serviceId,
    Set<LoginUserModel>? children,
  }) {
    return UserContainer(
      serviceId ?? this.serviceId,
      children ?? this.children,
    );
  }

}