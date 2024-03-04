import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

final orgDataProvider = StateNotifierProvider.family<
    _OrgDataProviderContainerNotifier, DataContainer, String>((ref, orgName) {
  final userUseCase = ref.read(userUseCaseProvider(orgName));

  final dataProviderContainer = DataContainer(
    userListNotifierProvider: StateNotifierProvider.family<
        UserListStateNotifier, UserListState, TempProject>((ref, project) {
      return UserListStateNotifier(UserListWait(), userUseCase);
    }),
    diaryListNotifierProvider: StateNotifierProvider.family<
        DiaryListStateNotifier, DiaryListState, TempProject>((ref, project) {
      return DiaryListStateNotifier(DiaryListWait(), userUseCase);
    }),
  );

  return _OrgDataProviderContainerNotifier(ref, dataProviderContainer);
});

class _OrgDataProviderContainerNotifier extends StateNotifier<DataContainer> {
  final Ref ref;
  _OrgDataProviderContainerNotifier(this.ref, super.state);

  void addDiary(TempProject project, String content) {
    ref.read(state.diaryListNotifierProvider(project).notifier).add(content);
  }

  void addUser(TempProject project, String name) {
    ref.read(state.userListNotifierProvider(project).notifier).add(name);
  }
}

class DataContainer {
  final StateNotifierProviderFamily<UserListStateNotifier, UserListState,
      TempProject> userListNotifierProvider;
  final StateNotifierProviderFamily<DiaryListStateNotifier, DiaryListState,
      TempProject> diaryListNotifierProvider;
  DataContainer({
    required this.userListNotifierProvider,
    required this.diaryListNotifierProvider,
  });
}
