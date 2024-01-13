import 'package:data/common/dio_provider.dart';
import 'package:data/sample/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/sample/user/repository/base_user_repository.dart';
import 'package:data/sample/user/repository/impl/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
BaseUserRepository userRepository(UserRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  return UserRepositoryImpl(remoteDataSource);
}
