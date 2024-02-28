import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/original_global.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/data_container.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';
import 'package:ui/ui/orgnal_login/widget/data/data_view_provider.dart';

class OriginalDataView extends ConsumerWidget {
  const OriginalDataView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = LoginDataContainer.instance.getOrgProject().getList();
    final dataViewModel = ref.read(dataViewProvider);

    if (dataViewModel.project == null) {
      return Scaffold(
        body: Center(
          child: Text('선택된 프로젝트가 없음'),
        ),
      );
    }

    void changedProjectFunc() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('프로젝트 변경'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: projects.map((e) {
                return ElevatedButton(
                    onPressed: () {
                      ref.read(currentProject.notifier).update((state) => e);
                      Navigator.pop(context);
                    },
                    child: Text(e.name));
              }).toList(),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                changedProjectFunc.call();
              },
              icon: Icon(Icons.refresh))
        ],
        title: Builder(builder: (context) {
          final currentProject =
              ref.watch(dataViewProvider.select((value) => value.project))!;
          return _AppBarTitleWidget(
            projects: projects,
            currentProject: currentProject,
            changedFunc: changedProjectFunc,
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final org = ref.read(orgProvider);
                    final pOrg = org as OrgLoginSuccess;
                    final diaryProvider = ref
                        .read(dataProvider(pOrg.orgName).notifier)
                        .diaryListNotifierProvider;

                    ref
                        .read(diaryProvider(dataViewModel.project!).notifier)
                        .add();
                  },
                  child: Text('다이어리 추가'),
                );
              },
            ),
            Expanded(
                child: _DiaryListWidget(
              project: dataViewModel.project!,
            )),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final org = ref.read(orgProvider);
                    final pOrg = org as OrgLoginSuccess;
                    final userProvider = ref
                        .read(dataProvider(pOrg.orgName).notifier)
                        .userListNotifierProvider;
                    ref
                        .read(userProvider(dataViewModel.project!).notifier)
                        .add();
                  },
                  child: Text('사람 추가'),
                );
              },
            ),
            Expanded(
                child: _UserListWidget(
              project: dataViewModel.project!,
            )),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  final List<OrgProject> projects;
  final OrgProject currentProject;
  final void Function() changedFunc;

  const _AppBarTitleWidget({
    required this.projects,
    required this.currentProject,
    required this.changedFunc,
  });

  @override
  Widget build(BuildContext context) {
    Log.e('앱바 갱신');
    return ElevatedButton(
      onPressed: () {
        changedFunc.call();
      },
      child: Text(
        currentProject.name,
      ),
    );
  }
}

class _DiaryListWidget extends ConsumerWidget {
  final OrgProject project;

  const _DiaryListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('다이어리 갱신');

    final diaryState =
        ref.watch(dataViewProvider.select((value) => value.diaryListState));

    switch (diaryState) {
      case DiaryListWait():
        return Text('UserListWait');
      case DiaryListLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case DiaryListError():
        return Text('error');
      case DiaryListSuccess(data: final data):
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                  onTap: () {
                    Log.d('유저아이디 클릭');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data[index].content),
                  )),
            );
          },
        );
    }
  }
}

class _UserListWidget extends ConsumerWidget {
  final OrgProject project;

  const _UserListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('유저 갱신');

    final userListState =
        ref.watch(dataViewProvider.select((value) => value.userListState));

    switch (userListState) {
      case UserListWait():
        return Text('UserListWait');
      case UserListLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case UserListError():
        return Text('error');
      case UserListSuccess(data: final data):
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                  onTap: () {
                    Log.d('유저아이디 클릭');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data[index].name),
                  )),
            );
          },
        );
    }
  }
}
