import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/login/impl/login_usercase_impl.dart';
import 'package:domain/usecase/login/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/usecase_state_notifier.dart';

class UsecaseProviderManager {
  static final UsecaseProviderManager _singleton =
      UsecaseProviderManager._internal();

  factory UsecaseProviderManager() {
    return _singleton;
  }

  UsecaseProviderManager._internal();

  final usecaseStateProvider =
      StateNotifierProvider<TestStateNotifier, UseCaseStateModel>((ref) {
    return TestStateNotifier(
      ref,
      UseCaseStateModel(
        domain: 'dev',
        org: '',
        service: '',
      ),
    );
  });

  final loginUseCaseFactoryProvider =
      StateProvider.family<LoginUseCase, String>((ref, serviceId) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.$serviceId.com',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );

    final remoteDataSource = RemoteUserDataSourceImpl(dio);
    final repositoryImpl = UserRepositoryImpl(remoteDataSource);
    return LoginUseCaseImpl(repositoryImpl);
  });
}

class TestStateNotifier extends StateNotifier<UseCaseStateModel> {
  final Ref ref;
  TestStateNotifier(this.ref, UseCaseStateModel state) : super(state);

  void update({
    String? domain,
    String? org,
    String? service,
  }) {
    state = state.copyWith(
      org: org,
      domain: domain,
      service: service,
    );

    ref.invalidate(UsecaseProviderManager().loginUseCaseFactoryProvider);
  }
}
