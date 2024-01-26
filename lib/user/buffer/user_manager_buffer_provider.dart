import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/app_global_current_provider.dart';
import 'package:net_test/manager/usecase_provider_manager.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_manager_buffer_provider.g.dart';

enum UserManagerSingletonState {
  waiting,
  running,
  alive,
  error,
}

/// 사용목적
/// 우리는 주소값을 참조하도록 하고싶지만
/// Riverpod는 state에 새로운 값 대입을 기점으로 rebuild를 하기 때문에 주소값이 변경되어버린다.
/// 그래서 singleton의 상태를 파악하기위해 얘를 사용합니다.
/// Singleton 데이터 변화를 감지하려면 이녀석을 watch해야합니다.
@Riverpod(keepAlive: true)
class UserManagerBuffer extends _$UserManagerBuffer {
  @override
  UserManagerSingletonState build() {
    return UserManagerSingletonState.waiting;
  }

  Future<void> fetchData({required String serviceId}) async {
    state = UserManagerSingletonState.running;

    await Future.delayed(AppConst.delay);

    final serviceId =
        ref.watch(currentProvider.select((value) => value.service));

    await ref
        .read(UsecaseProviderManager().loginUseCaseFactoryProvider(serviceId))
        .loginUsers(memberNo: 3)
        .then((value) {
      UserManagerBufferSingleton().addAll(users: value);
      state = UserManagerSingletonState.alive;
    }).catchError((e) {
      state = UserManagerSingletonState.error;
    });
  }
}
