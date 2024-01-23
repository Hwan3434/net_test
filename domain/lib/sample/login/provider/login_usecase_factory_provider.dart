import 'package:data/sample/user/provider/user_repository_factory_provider.dart';
import 'package:domain/sample/login/impl/login_usercase_impl.dart';
import 'package:domain/sample/login/login_usecase.dart';
import 'package:riverpod/riverpod.dart';

final loginUseCaseFactoryProvider = Provider<LoginUseCase>((ref) {
  final userRepository = ref.read(userRepositoryFactoryProvider);
  return LoginUseCaseImpl(
    userRepository,
  );
});


