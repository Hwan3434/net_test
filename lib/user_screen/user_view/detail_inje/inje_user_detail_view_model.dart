enum InjeUserDetailViewModelState {
  wait,
  loading,
  success,
  error;
}

class InjeUserDetailViewModel {
  final InjeUserDetailViewModelState state;
  final int? id;
  final String? name;
  final String? email;
  final String? userName;

  InjeUserDetailViewModel({
    this.state = InjeUserDetailViewModelState.loading,
    this.id,
    this.name,
    this.email,
    this.userName,
  });
}
