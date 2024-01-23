import 'package:domain/sample/login/provider/login_usecase_factory_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group("LoginUseCase 테스트", () {
    test('usercase로 로그인 데이터 가져오기', () async {
      final container = ProviderContainer();

      final loginUseCase = container.read(loginUseCaseFactoryProvider);

      final result = await loginUseCase.loginUsers();
      expect(result.length, 10);
    });
  });
}
