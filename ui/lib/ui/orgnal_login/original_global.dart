import 'package:data/common/log.dart';
import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/dio_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

final dataProvider = StateNotifierProvider.family<
    _DataProviderContainerNotifier, DataContainer, String>((ref, orgName) {
  Log.e('Data 프로바이더 생성');
  final dio = ref.watch(dioUrlProvider(orgName));
  final dataSource = RemoteUserDataSourceImpl(dio);
  final repository = UserRepositoryImpl(dataSource);
  final userUseCase = UserUseCaseImpl2(repository);
  final dataProviderContainer = DataContainer(
    userUseCase: userUseCase,
  );
  return _DataProviderContainerNotifier(dataProviderContainer);
});

class _DataProviderContainerNotifier extends StateNotifier<DataContainer> {
  late final StateNotifierProviderFamily<UserListStateNotifier, UserListState,
      OrgProject> userListNotifierProvider;
  late final StateNotifierProviderFamily<DiaryListStateNotifier, DiaryListState,
      OrgProject> diaryListNotifierProvider;

  _DataProviderContainerNotifier(super.state) {
    userListNotifierProvider = StateNotifierProvider.family<
        UserListStateNotifier, UserListState, OrgProject>((ref, project) {
      return UserListStateNotifier(UserListWait(), state.userUseCase);
    });

    diaryListNotifierProvider = StateNotifierProvider.family<
        DiaryListStateNotifier, DiaryListState, OrgProject>((ref, project) {
      Log.d('ddddddDDD ::::: ${project.hashCode}');
      return DiaryListStateNotifier(DiaryListWait(), state.userUseCase);
    });
  }
}

class DataContainer {
  final UserUseCase userUseCase;
  DataContainer({
    required this.userUseCase,
  });
}
