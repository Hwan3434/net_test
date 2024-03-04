import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

final currentProject = StateProvider<TempProject?>((ref) {
  return null;
});

final dataViewProvider =
    StateNotifierProvider.autoDispose<_DataViewNotifier, DataViewModel?>((ref) {
  final org = ref.watch(orgStateProvider);
  final project = ref.watch(currentProject);

  if (org is! OrgLoginSuccess || project == null) {
    return _DataViewNotifier(null);
  }

  final diaryProvider =
      ref.read(orgDataProvider(org.orgName)).diaryListNotifierProvider;
  final diaryState = ref.watch(diaryProvider(project));

  final userProvider =
      ref.read(orgDataProvider(org.orgName)).userListNotifierProvider;
  final userState = ref.watch(userProvider(project));

  return _DataViewNotifier(
    DataViewModel(
      orgName: org.orgName,
      project: project,
      diaryListState: diaryState,
      userListState: userState,
    ),
  );
});

class _DataViewNotifier extends StateNotifier<DataViewModel?> {
  _DataViewNotifier(super.state);
}

class DataViewModel {
  final String orgName;
  final TempProject project;
  final DiaryListState diaryListState;
  final UserListState userListState;

  const DataViewModel({
    required this.orgName,
    required this.project,
    required this.diaryListState,
    required this.userListState,
  });

  DataViewModel copyWith({
    String? orgName,
    TempProject? project,
    DiaryListState? diaryListState,
    UserListState? userListState,
  }) {
    return DataViewModel(
      orgName: orgName ?? this.orgName,
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
