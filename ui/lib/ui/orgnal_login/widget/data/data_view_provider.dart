import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/original_global.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

final currentProject = StateProvider<OrgProject?>((ref) {
  return null;
});

final dataViewProvider =
    StateNotifierProvider.autoDispose<_DataViewNotifier, DataViewModel>((ref) {
  final org = ref.watch(orgProvider) as OrgLoginSuccess;
  final project = ref.watch(currentProject)!;

  final diaryManagerProvider =
      ref.read(dataProvider(org.orgName).notifier).diaryListNotifierProvider;
  final diaryState = ref.watch(diaryManagerProvider(project));

  final userManagerProvider =
      ref.read(dataProvider(org.orgName).notifier).userListNotifierProvider;
  final userState = ref.watch(userManagerProvider(project));

  return _DataViewNotifier(
    DataViewModel(
      project: project,
      diaryListState: diaryState,
      userListState: userState,
    ),
  );
});

class _DataViewNotifier extends StateNotifier<DataViewModel> {
  _DataViewNotifier(super.state);
}

class DataViewModel {
  final OrgProject? project;
  final DiaryListState diaryListState;
  final UserListState userListState;

  const DataViewModel({
    required this.project,
    required this.diaryListState,
    required this.userListState,
  });

  DataViewModel copyWith({
    OrgProject? project,
    DiaryListState? diaryListState,
    UserListState? userListState,
  }) {
    return DataViewModel(
      project: project ?? this.project,
      diaryListState: diaryListState ?? this.diaryListState,
      userListState: userListState ?? this.userListState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataViewModel &&
          runtimeType == other.runtimeType &&
          project == other.project;

  @override
  int get hashCode => project.hashCode;
}
