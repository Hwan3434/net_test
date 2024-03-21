import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class OrgNotifierStateModel {}

class OrgNotifierStateModelWait extends OrgNotifierStateModel {}

class OrgNotifierStateModelLoading extends OrgNotifierStateModel {}

class OrgNotifierStateModelSuccess extends OrgNotifierStateModel {
  final Set<UserDataModel> data;

  OrgNotifierStateModelSuccess({required this.data});

  OrgNotifierStateModelSuccess copyWith({
    Set<UserDataModel>? data,
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
