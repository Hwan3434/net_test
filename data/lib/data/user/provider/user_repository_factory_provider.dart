import 'package:data/common/dio_factory_provider.dart';
import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/user_repository.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userRepositoryFactoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioFactoryProvider);
  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  return UserRepositoryImpl(remoteDataSource);
});