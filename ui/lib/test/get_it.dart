import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/test/user_data_provider.dart';

final locator = GetIt.I;
void setupLocator() {
  final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  final repositoryImpl = UserRepositoryImpl(remoteDataSource);
  final userUseCase = UserUseCaseImpl2(repositoryImpl);

  locator.registerSingleton<UserUseCase>(userUseCase);
  locator.registerSingleton<UserDataNotifier>(UserDataNotifier());
}
