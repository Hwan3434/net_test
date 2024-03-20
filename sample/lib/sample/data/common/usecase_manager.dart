import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/mock_usercase_impl_3.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/component/dio/interceptor/custom_interceptor.dart';
import 'package:sample/sample/data/domain/global_state_storage.dart';
import 'package:sample/sample/data/domain/project/model/project_model.dart';
import 'package:sample/sample/data/flavor/enviroment.dart';
import 'package:sample/sample/data/info/app_info_manager.dart';
import 'package:sample/sample/util/log.dart';

class UseCaseManager {
  static final UseCaseManager _singleton = UseCaseManager._internal();

  factory UseCaseManager() {
    return _singleton;
  }
  UseCaseManager._internal();

  final agentUseCaseProvider = Provider<AgentUseCase>((ref) {
    final Environment env = AppInfoManger().getEnvironment();
    final String organization =
        ref.watch(GlobalStateStorage().loginOrganizationProvider);
    final String baseUrl = 'https://${env.mode}$organization.${env.url}';
    Log.e('UserUseCaseProvider base URL : $baseUrl');
    final dio = Dio(
      BaseOptions(
        // baseUrl: baseUrl,
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    );
    dio.interceptors.add(
      CustomInterceptor(
        organization: organization,
        ref: ref,
      ),
    );
    final dataSource = AgentDataSource(dio: dio);
    final repository = AgentRepository(ds: dataSource);
    final agentUseCaseImpl = AgentUseCaseImpl(repository: repository);
    return agentUseCaseImpl;
  });

  /// todo watch loginOrganizationProvider 하면 사실 존재하던 project도 다 날아가고 없어야할겁니다.
  /// todo 그럼 조직이 변경되었을때 userUseCaseProvider 도 famly들이 모두 초기화되는지 확인해보자.(초기화되어야한다.)
  final userUseCaseProvider =
      Provider.family<UserUseCase, ProjectModel>((ref, project) {
    final Environment env = AppInfoManger().getEnvironment();
    final String organization =
        ref.watch(GlobalStateStorage().loginOrganizationProvider);
    final String baseUrl =
        'https://${env.mode}$organization.${env.url}/${project.name}';
    Log.e('UserUseCaseProvider base URL : $baseUrl');
    final dio = Dio(
      BaseOptions(
        // baseUrl: baseUrl,
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    );
    dio.interceptors.add(
      CustomInterceptor(
        organization: organization,
        ref: ref,
      ),
    );
    final dataSource = RemoteUserDataSourceImpl(dio);
    final repository = UserRepositoryImpl(dataSource);
    final userUseCaseImpl = MockUserCaseImpl3();
    return userUseCaseImpl;
  });
}
