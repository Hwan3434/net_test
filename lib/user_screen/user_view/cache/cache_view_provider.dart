import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/cache/cache_view_model.dart';

final bufferPageProvider =
    StateNotifierProvider.autoDispose<BufferPageStateNotifier, CacheViewModel>(
        (ref) {
  final serviceId = ref.watch(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final loginUseCase =
      ref.read(DataManager().userUseCaseFactoryProvider(serviceId));
  return BufferPageStateNotifier(loginUseCase);
});

class BufferPageStateNotifier extends StateNotifier<CacheViewModel> {
  final UserUseCase _loginUseCase;

  BufferPageStateNotifier(this._loginUseCase)
      : super(
          CacheViewModel(
            data: CacheViewStateWait(),
            bufferUserUpdateState: WaitBufferUpdate(),
          ),
        ) {
    // initLoad();
  }

  void initLoad() async {
    fetchData();
  }

  void fetchData() async {
    state = state.copyWith(bufferUserUpdateState: LoadingBufferUpdate());
    await Future.delayed(AppConst.delay);
    await _loginUseCase.getUsers().then((value) {
      state = state.copyWith(
        data: state.data,
        bufferUserUpdateState: SuccessBufferUpdate(
          data: value,
        ),
      );
    }).catchError((e) {
      state = state.copyWith(
        data: state.data,
        bufferUserUpdateState: FailBufferUpdate(),
      );
    });
  }
}
