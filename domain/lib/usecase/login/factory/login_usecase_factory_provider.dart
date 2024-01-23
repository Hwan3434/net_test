import 'package:data/data/user/provider/user_repository_factory_provider.dart';
import 'package:domain/usecase/login/impl/login_usercase_impl.dart';
import 'package:domain/usecase/login/login_usecase.dart';
import 'package:riverpod/riverpod.dart';

final loginUseCaseFactoryProvider = Provider<LoginUseCase>((ref) {
  final userRepository = ref.read(userRepositoryFactoryProvider);
  return LoginUseCaseImpl(
    userRepository,
  );
});


