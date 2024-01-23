import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/login/impl/login_usercase_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<Dio>(() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
  });

  locator.registerLazySingleton<LoginUseCaseImpl>(() {
    final dio = locator<Dio>();
    if(kDebugMode){
      /// mock server or use mock dataSource;
      /// return LoginUseCaseImpl(MockUserRepositoryImpl());
    }
    final remoteDataSource = RemoteUserDataSourceImpl(dio);
    final result =  UserRepositoryImpl(remoteDataSource);
    return LoginUseCaseImpl(result);
  });
}
