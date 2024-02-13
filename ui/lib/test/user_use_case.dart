import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUsecaseProvider =
    StateNotifierProvider<_UserUseCaseStateNotifier, UserUseCase>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  final repositoryImpl = UserRepositoryImpl(remoteDataSource);
  final userUseCase = UserUseCaseImpl2(repositoryImpl);
  return _UserUseCaseStateNotifier(userUseCase);
});

class _UserUseCaseStateNotifier extends StateNotifier<UserUseCase> {
  _UserUseCaseStateNotifier(super.state);
}
