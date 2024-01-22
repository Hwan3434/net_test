import 'package:data/sample/user/provider/user_repository_provider.dart';
import 'package:domain/provider/usecase/usecase_keys.dart';
import 'package:domain/sample/login/impl/login_usercase_impl.dart';
import 'package:domain/sample/login/login_usecase.dart';
import 'package:riverpod/riverpod.dart';

class UseCaseManager {
  final String serviceId;
  final Map<UseCaseKeys, Provider> providers;

  UseCaseManager({
    required this.serviceId,
    required this.providers,
  });

  Provider getProvider(UseCaseKeys key) {
    if (providers.containsKey(key)) {
      return providers[key]!;
    }
    _createProvider(key);
    return providers[key]!;
  }

  /// autoDispose는 어떻게 관리할껀데
  void _createProvider(UseCaseKeys key) {
    final provider = Provider<LoginUseCase>((ref) {
      final userRepository = ref.read(userRepositoryProvider);
      return LoginUseCaseImpl(
        userRepository,
      );
    });
    providers[key] = provider;
  }
}
