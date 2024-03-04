// import 'package:data/common/log.dart';
// import 'package:domain/usecase/user/user_usecase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ui/ui/orgnal_login/provider/admin_model.dart';
//
// class AdminListStateNotifier extends StateNotifier<AdminListState> {
//   final UserUseCase _userUseCase;
//
//   AdminListStateNotifier(super.state, this._userUseCase) {
//     init();
//   }
//
//   void init() {
//     fetch();
//   }
//
//   void add(String content) {
//     Log.d('AdminListStateNotifier Add');
//     assert(state is! AdminListWait);
//     assert(state is! AdminListLoading);
//     assert(state is! AdminListError);
//     final pState = state as AdminListSuccess;
//     state = pState.copyWith(
//       data: [
//         AdminModel(
//           id: 11,
//           name: '정환',
//         ),
//         ...pState.data
//       ],
//     );
//   }
//
//   void fetch() async {
//     Log.d('AdminListStateNotifier Fetch');
//     state = AdminListLoading();
//     await Future.delayed(Duration(seconds: 1));
//
//     final data = _userUseCase.getUsers();
//     state = AdminListSuccess(data: data);
//   }
//
//   void remove() {}
// }
//
// sealed class AdminListState {}
//
// class AdminListWait extends AdminListState {}
//
// class AdminListLoading extends AdminListState {}
//
// class AdminListSuccess extends AdminListState {
//   final List<AdminModel> data;
//
//   AdminListSuccess({
//     required this.data,
//   });
//
//   AdminListSuccess copyWith({
//     List<AdminModel>? data,
//   }) {
//     return AdminListSuccess(
//       data: data ?? this.data,
//     );
//   }
// }
//
// class AdminListError extends AdminListState {}
