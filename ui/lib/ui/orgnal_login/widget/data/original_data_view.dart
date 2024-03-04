import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_container.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';
import 'package:ui/ui/orgnal_login/widget/data/data_view_provider.dart';

class OriginalDataView extends ConsumerWidget {
  const OriginalDataView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = OrgDataContainer.i.getOrgProject().getList();

    final orgName =
        ref.watch(dataViewProvider.select((value) => value?.orgName));

    final project =
        ref.watch(dataViewProvider.select((value) => value?.project));

    if (orgName == null || project == null) {
      return const Scaffold(
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
              children: [null, ...projects].map((e) {
                if (e == null) {
                  return ElevatedButton(
                    onPressed: () {
                      ref.read(currentProject.notifier).update((state) => null);
                      Navigator.pop(context);
                    },
                    child: Text('선택해제'),
                  );
                }

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
        title: _AppBarTitleWidget(
          orgName: orgName,
          projects: projects,
          currentProject: project,
          changedFunc: changedProjectFunc,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Builder(builder: (context) {
              final controller = TextEditingController();
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ElevatedButton(
                        onPressed: () {
                          ref
                              .read(orgDataProvider(orgName).notifier)
                              .addDiary(project, controller.text);
                          controller.clear();
                        },
                        child: Text('다이어리 추가'),
                      );
                    },
                  ),
                ],
              );
            }),
            Expanded(
                child: _DiaryListWidget(
              project: project,
            )),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    ref
                        .read(orgDataProvider(orgName).notifier)
                        .addUser(project, "UserA");
                  },
                  child: Text('사람 추가'),
                );
              },
            ),
            Expanded(
                child: _UserListWidget(
              project: project,
            )),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  final String orgName;
  final List<TempProject> projects;
  final TempProject? currentProject;
  final void Function() changedFunc;

  const _AppBarTitleWidget({
    required this.orgName,
    required this.projects,
    required this.currentProject,
    required this.changedFunc,
  });

  @override
  Widget build(BuildContext context) {
    Log.e('$orgName : 앱바 갱신');
    return ElevatedButton(
      onPressed: () {
        changedFunc.call();
      },
      child: Text(
        '$orgName(${currentProject?.name})',
      ),
    );
  }
}

class _DiaryListWidget extends ConsumerWidget {
  final TempProject project;

  const _DiaryListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('다이어리 갱신');

    final diaryState =
        ref.watch(dataViewProvider.select((value) => value?.diaryListState));

    if (diaryState == null) {
      return Center(
        child: Text('다이어리 널'),
      );
    }

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
  final TempProject project;

  const _UserListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('유저 갱신');

    final userListState =
        ref.watch(dataViewProvider.select((value) => value?.userListState));

    if (userListState == null) {
      return Center(
        child: Text('유저 널'),
      );
    }

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
