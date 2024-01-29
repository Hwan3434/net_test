import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/cache/list_cache.dart';
import 'package:domain/usecase/user/impl/login_usercase_impl.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  late ListCache<UserModel> userCache;
  late final StateNotifierProvider<TestStateNotifier, UseCaseStateModel>
      usecaseStateProvider;
  late final StateProviderFamily<UserUseCase, String>
      loginUseCaseFactoryProvider;

  DataManager._internal() {
    userCache = ListCache<UserModel>();
    usecaseStateProvider =
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
    loginUseCaseFactoryProvider =
        StateProvider.family<UserUseCase, String>((ref, serviceId) {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.$serviceId.com',
          connectTimeout: 5000,
          receiveTimeout: 3000,
        ),
      );

      final remoteDataSource = RemoteUserDataSourceImpl(dio);
      final repositoryImpl = UserRepositoryImpl(remoteDataSource);
      return UserUseCaseImpl(repositoryImpl, cache: userCache);
    });
  }
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

    ref.invalidate(DataManager().loginUseCaseFactoryProvider);
  }
}

class UseCaseStateModel {
  final String domain;
  final String service;
  final String org;

  UseCaseStateModel({
    this.domain = 'dev',
    required this.org,
    required this.service,
  });

  UseCaseStateModel copyWith({
    String? domain,
    String? org,
    String? service,
  }) {
    return UseCaseStateModel(
      domain: domain ?? this.domain,
      org: org ?? this.org,
      service: service ?? this.service,
    );
  }
}
