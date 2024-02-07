import 'package:domain/usecase/user/model/response/user_model.dart';

enum OrgNotifierViewState { wait, loading, success, error }

class OrgNotifierViewModel {
  final OrgNotifierViewState state;
  final Set<UserModel> data;

  OrgNotifierViewModel({
    required this.state,
    required this.data,
  });

  OrgNotifierViewModel copyWith({
    OrgNotifierViewState? state,
    Set<UserModel>? data,
  }) {
    return OrgNotifierViewModel(
      state: state ?? this.state,
      data: data ?? this.data,
    );
  }
}
