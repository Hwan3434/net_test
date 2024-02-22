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
    _DataProviderContainerNotifier, DataContainer, OrgProject>((ref, project) {
  Log.e('유저 유스케이스가 변경되었습니다.($project)');
  final dio = ref.watch(dioUrlProvider(project.name));
  final dataSource = RemoteUserDataSourceImpl(dio);
  final repository = UserRepositoryImpl(dataSource);
  final userUseCase = UserUseCaseImpl2(repository);
  final dataProviderContainer = DataContainer(userUseCase: userUseCase);
  return _DataProviderContainerNotifier(dataProviderContainer);
});

class _DataProviderContainerNotifier extends StateNotifier<DataContainer> {
  late final StateNotifierProvider<UserListStateNotifier, UserListState>
      userListNotifierProvider;
  late final StateNotifierProvider<DiaryListStateNotifier, DiaryListState>
      diaryListNotifierProvider;

  _DataProviderContainerNotifier(super.state) {
    Log.e('Data 프로바이더 생성');
    userListNotifierProvider =
        StateNotifierProvider<UserListStateNotifier, UserListState>((ref) {
      return UserListStateNotifier(UserListWait(), state.userUseCase);
    });

    diaryListNotifierProvider =
        StateNotifierProvider<DiaryListStateNotifier, DiaryListState>((ref) {
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
