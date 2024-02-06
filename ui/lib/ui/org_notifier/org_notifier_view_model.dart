import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class OrgNotifierStateModel {}

class OrgNotifierStateModelWait extends OrgNotifierStateModel {}

class OrgNotifierStateModelLoading extends OrgNotifierStateModel {}

class OrgNotifierStateModelSuccess extends OrgNotifierStateModel {
  final Set<UserModel> data;
  OrgNotifierStateModelSuccess({required this.data});

  OrgNotifierStateModelSuccess copyWith({
    Set<UserModel>? data,
  }) {
    return OrgNotifierStateModelSuccess(
      data: data ?? this.data,
    );
  }
}

class OrgNotifierStateModelError extends OrgNotifierStateModel {
  final String error;
  OrgNotifierStateModelError({required this.error});
}
