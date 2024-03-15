// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
// import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
// import 'package:ui/ui/orgnal_login/provider/global/model/organization_model.dart';
// import 'package:ui/ui/orgnal_login/provider/global/model/org_project_model.dart';
// import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
// import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';
//
// // final currentOrg = StateProvider<OrgModel?>((ref) {
// //   return null;
// // });
// // final currentProject = StateProvider<OrgProjectModel?>((ref) {
// //   return null;
// // });
//
// final dataViewProvider =
//     StateNotifierProvider.autoDispose<_DataViewNotifier, DataViewModel?>((ref) {
//   final loginState = ref.watch(LoginStateProvider);
//   final org = ref.watch(currentOrg);
//   final project = ref.watch(currentProject);
//
//   if (loginState is! LoginSuccess || org == null || project == null) {
//     return _DataViewNotifier(null);
//   }
//
//   final diaryProvider = GlobalDataManager.i.get(org).diaryListNotifierProvider;
//   final diaryState = ref.watch(diaryProvider(project));
//
//   final userProvider = GlobalDataManager.i.get(org).userListNotifierProvider;
//   final userState = ref.watch(userProvider(project));
//
//   return _DataViewNotifier(
//     DataViewModel(
//       orgName: org.name,
//       project: project,
//       diaryListState: diaryState,
//       userListState: userState,
//     ),
//   );
// });
//
// class _DataViewNotifier extends StateNotifier<DataViewModel?> {
//   _DataViewNotifier(super.state);
// }
//
// class DataViewModel {
//   final String orgName;
//   final OrgProjectModel project;
//   final DiaryListState diaryListState;
//   final UserListState userListState;
//
//   const DataViewModel({
//     required this.orgName,
//     required this.project,
//     required this.diaryListState,
//     required this.userListState,
//   });
//
//   DataViewModel copyWith({
//     String? orgName,
//     OrgProjectModel? project,
//     DiaryListState? diaryListState,
//     UserListState? userListState,
//   }) {
//     return DataViewModel(
//       orgName: orgName ?? this.orgName,
//       project: project ?? this.project,
//       diaryListState: diaryListState ?? this.diaryListState,
//       userListState: userListState ?? this.userListState,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is DataViewModel &&
//           runtimeType == other.runtimeType &&
//           project == other.project;
//
//   @override
//   int get hashCode => project.hashCode;
// }
