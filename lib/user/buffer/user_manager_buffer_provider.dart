import 'package:domain/sample/login/provider/login_usecase_provider.dart';
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

    await Future.delayed(const Duration(seconds: 3));

    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      UserManagerBufferSingleton().addAll(serviceId: serviceId, users: value);
      state = UserManagerSingletonState.alive;
    }).catchError((e) {
      state = UserManagerSingletonState.error;
    });


  }
}