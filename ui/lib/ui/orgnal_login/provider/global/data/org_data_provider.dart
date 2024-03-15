import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_model.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project_model.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/org_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/project_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

final globalDio = Dio(
  BaseOptions(
    // baseUrl: 'https://$project.typicode.com',
    baseUrl: 'https://jsonplaceholder.typicode.com',
  ),
);

class GlobalDataManager {
  GlobalDataManager._privateConstructor() {
    _create();
  }
  static final GlobalDataManager i = GlobalDataManager._privateConstructor();

  late final DataContainer _dataContainer;

  StateNotifierProvider<LoginNotifier, LoginState> getLoginProvider() {
    return _dataContainer.loginStateProvider;
  }

  StateNotifierProvider<OrgListStateNotifier, Set<OrgModel>>
      getOrgListProvider() {
    return _dataContainer.orgListNotifierProvider;
  }

  StateNotifierProviderFamily<OrgProjectListStateNotifier, ProjectListState,
      OrgModel> getProjectListProvider() {
    return _dataContainer.projectListNotifierProvider;
  }

  StateNotifierProviderFamily<DiaryListStateNotifier, DiaryListState,
      OrgProjectModel> getDiaryListProvider() {
    return _dataContainer.diaryListNotifierProvider;
  }

  StateNotifierProviderFamily<UserListStateNotifier, UserListState,
      OrgProjectModel> getUserListProvider() {
    return _dataContainer.userListNotifierProvider;
  }

  void _create() {
    final userUseCase = UseCaseManager.i.getUseCase;
    _dataContainer = DataContainer(
      orgListNotifierProvider:
          StateNotifierProvider<OrgListStateNotifier, Set<OrgModel>>((ref) {
        return OrgListStateNotifier({});
      }),
      projectListNotifierProvider: StateNotifierProvider.family<
          OrgProjectListStateNotifier,
          ProjectListState,
          OrgModel>((ref, orgModel) {
        return OrgProjectListStateNotifier(ProjectListWait());
      }),
      userListNotifierProvider: StateNotifierProvider.family<
          UserListStateNotifier,
          UserListState,
          OrgProjectModel>((ref, project) {
        return UserListStateNotifier(UserListWait(), userUseCase);
      }),
      diaryListNotifierProvider: StateNotifierProvider.family<
          DiaryListStateNotifier,
          DiaryListState,
          OrgProjectModel>((ref, project) {
        return DiaryListStateNotifier(DiaryListWait(), userUseCase);
      }),
    );
  }
}

class UseCaseManager {
  UseCaseManager._privateConstructor() {
    createUserUseCase();
  }

  static final UseCaseManager i = UseCaseManager._privateConstructor();
  late final UserUseCase _userUseCase;

  UserUseCase get getUseCase => _userUseCase;

  void createUserUseCase() {
    final dataSource = RemoteUserDataSourceImpl(globalDio);
    final repository = UserRepositoryImpl(dataSource);
    final userUseCase = UserUseCaseImpl2(repository);
    _userUseCase = userUseCase;
  }
}

// final orgDataProvider = StateNotifierProvider.family<
//     _OrgDataProviderContainerNotifier, DataContainer, String>((ref, orgName) {
//   // final userUseCase = ref.read(userUseCaseProvider(orgName));
//   final orgDataContainer = OrgDataMapContainer.i.get(orgName);
//
//   final dataProviderContainer = DataContainer(
//     userListNotifierProvider: StateNotifierProvider.family<
//         UserListStateNotifier, UserListState, TempProject>((ref, project) {
//       return UserListStateNotifier(UserListWait(), userUseCase);
//     }),
//     diaryListNotifierProvider: StateNotifierProvider.family<
//         DiaryListStateNotifier, DiaryListState, TempProject>((ref, project) {
//       return DiaryListStateNotifier(DiaryListWait(), userUseCase);
//     }),
//   );
//
//   return _OrgDataProviderContainerNotifier(ref, dataProviderContainer);
// });
//
// class _OrgDataProviderContainerNotifier extends StateNotifier<DataContainer> {
//   final Ref ref;
//   _OrgDataProviderContainerNotifier(this.ref, super.state);
//
//   void addDiary(TempProject project, String content) {
//     ref.read(state.diaryListNotifierProvider(project).notifier).add(content);
//   }
//
//   void addUser(TempProject project, String name) {
//     ref.read(state.userListNotifierProvider(project).notifier).add(name);
//   }
// }

class DataContainer {
  final loginStateProvider =
      StateNotifierProvider<LoginNotifier, LoginState>((ref) {
    return LoginNotifier(ref, LoginNone());
  });

  final StateNotifierProvider<OrgListStateNotifier, Set<OrgModel>>
      orgListNotifierProvider;
  final StateNotifierProviderFamily<OrgProjectListStateNotifier,
      ProjectListState, OrgModel> projectListNotifierProvider;
  final StateNotifierProviderFamily<UserListStateNotifier, UserListState,
      OrgProjectModel> userListNotifierProvider;
  final StateNotifierProviderFamily<DiaryListStateNotifier, DiaryListState,
      OrgProjectModel> diaryListNotifierProvider;
  DataContainer({
    required this.orgListNotifierProvider,
    required this.projectListNotifierProvider,
    required this.userListNotifierProvider,
    required this.diaryListNotifierProvider,
  });
}
