import 'package:data/common/dio_provider.dart';
import 'package:data/sample/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/sample/user/repository/user_repository.dart';
import 'package:data/sample/user/repository/impl/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userRepositoryFactoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  return UserRepositoryImpl(remoteDataSource);
});