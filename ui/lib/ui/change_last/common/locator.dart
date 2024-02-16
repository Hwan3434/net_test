import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<Dio>(() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    );
  });

  locator.registerLazySingleton<UserUseCase>(() {
    final dio = locator<Dio>();
    final dataSource = RemoteUserDataSourceImpl(dio);
    final repository = UserRepositoryImpl(dataSource);
    final userUseCase = UserUseCaseImpl2(repository);
    return userUseCase;
  });
}
