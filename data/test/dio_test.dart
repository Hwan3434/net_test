import 'package:data/common/dio_factory_provider.dart';
import 'package:data/data/user/provider/user_repository_factory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Dio 테스트", () {
    test('직접 데이터 가져오기', () async {
      final container = ProviderContainer();

      final dio = container.read(dioFactoryProvider);

      final response = await dio.get(
        '/users',
      );

      expect(response.statusCode, 200);
    });
    test('프로바이더로 데이터 가져오기', () async {
      final container = ProviderContainer();

      final userProvider = container.read(userRepositoryFactoryProvider);

      final res = await userProvider.getUsers();

      expect(res.length, 10);
    });
  });
}
