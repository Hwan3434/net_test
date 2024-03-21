import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/sample/data/common/usecase_manager.dart';
import 'package:sample/sample/data/domain/agent/model/agent_state_model.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/info/app_info_manager.dart';
import 'package:sample/sample/ui/login/login_view_model.dart';

import 'test_util.dart';

final loginTestProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginViewModel>(
        (ref) {
  final agent = ref.read(GlobalStateStorage().agentStateProvider);
  final agentUseCase = ref.read(UseCaseManager().agentUseCaseProvider);
  return LoginStateNotifier(
    LoginViewModel(
      state: agent.state,
      id: '',
      pw: '',
    ),
    agentUseCase,
  );
});

void main() {
  AppInfoManger().init();

  group('로그인 뷰 모델 테스트', () {
    test('로그인 뷰 모델 초기화 상태 파악', () {
      final lis = Listener<LoginViewModel>();
      final container = createContainer<LoginViewModel>(loginTestProvider, lis);

      expect(container.read(loginTestProvider).state, AgentState.logout);
      expect(container.read(loginTestProvider).id, '');
      expect(container.read(loginTestProvider).pw, '');
    });

    test('로그인 뷰 모델 컨트롤(성공)', () async {
      final lis = Listener<LoginViewModel>();
      final container = createContainer<LoginViewModel>(loginTestProvider, lis);

      /// todo AgentUsecaseMock을 사용해서 무조건 success로 나오게 해야합니다.
      container.listen(GlobalStateStorage().agentStateProvider,
          (previous, next) {
        container.read(loginTestProvider.notifier).login(state: next.state);
      });

      container.read(loginTestProvider.notifier).update(id: 'abc', pw: 'abc');
      expect(container.read(loginTestProvider).id, 'abc');
      expect(container.read(loginTestProvider).pw, 'abc');
      bool validate = container.read(loginTestProvider.notifier).isValidate();
      expect(validate, false);
      container.read(loginTestProvider.notifier).update(id: 'abc', pw: 'dddd');
      validate = container.read(loginTestProvider.notifier).isValidate();
      expect(validate, true);

      await container
          .read(GlobalStateStorage().agentStateProvider.notifier)
          .login('abc', 'dddd');

      expect(container.read(loginTestProvider).state, AgentState.success);
    });
  });
}
