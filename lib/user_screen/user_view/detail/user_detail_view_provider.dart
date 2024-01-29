import 'package:collection/collection.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/model/response/user_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_view_model.dart';

final userDetailViewProvider = StateNotifierProvider.autoDispose
    .family<_UserDetailViewStateNotifier, UserDetailState, int>((ref, userId) {
  final serviceId = ref.watch(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final userUseCase =
      ref.read(DataManager().loginUseCaseFactoryProvider(serviceId));
  return _UserDetailViewStateNotifier(userUseCase, userId: userId);
});

class _UserDetailViewStateNotifier extends StateNotifier<UserDetailState> {
  final int userId;
  final UserUseCase _userUseCase;

  _UserDetailViewStateNotifier(
    this._userUseCase, {
    required this.userId,
  }) : super(UserDetailWaitState()) {
    init();
  }

  void init() {
    final user = DataManager()
        .userCache
        .data
        .singleWhereOrNull((element) => userId == element.id);

    if (user != null) {
      debugPrint('캐시에서 긁어옴');
      state =
          UserDetailSuccessState(viewModel: UserDetailViewModel(model: user));
    }

    if (user is UserDetailModel) {
      return;
    }

    state = UserDetailLoadingState();
    _userUseCase.getUser(userId: userId).then((value) {
      debugPrint('웹에서 긁어옴');
      state =
          UserDetailSuccessState(viewModel: UserDetailViewModel(model: value));
    }).catchError((onError) {
      debugPrint('에러 : ${onError.toString()}');
      state = UserDetailErrorState();
    });
  }
}
