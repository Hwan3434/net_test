import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project_model.dart';
import 'package:ui/ui/orgnal_login/provider/project_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';
import 'package:ui/ui/orgnal_login/widget/original_login_view.dart';

class OriginalDataView extends ConsumerWidget {
  const OriginalDataView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final org = ref.read(currentOrgProvider);
    if (org == null) {
      return const Scaffold(
        body: Center(
          child: Text('조직선택 안함'),
        ),
      );
    }
    final projectProvider = GlobalDataManager.i.getProjectListProvider();
    final projects = ref.watch(projectProvider(org));

    if (projects is! ProjectListSuccess) {
      return const Scaffold(
        body: Center(
          child: Text('프로젝트가 존재하지 않음'),
        ),
      );
    }

    final currentProject = ref.watch(currentOrgProjectProvider);
    if (currentProject == null) {
      return const Scaffold(
        body: Center(
          child: Text('프로젝트 선택 안함'),
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
              children: [null, ...projects.data].map((e) {
                if (e == null) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('선택해제'),
                  );
                }

                return ElevatedButton(
                    onPressed: () {
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
          orgName: org.name,
          projects: projects.data.toList(),
          currentProject: currentProject,
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
                          final d = GlobalDataManager.i.getDiaryListProvider();
                          ref
                              .read(d(currentProject).notifier)
                              .add(controller.text);
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
              project: currentProject,
            )),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {},
                  child: Text('사람 추가'),
                );
              },
            ),
            Expanded(
                child: _UserListWidget(
              project: currentProject,
            )),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  final String orgName;
  final List<OrgProjectModel> projects;
  final OrgProjectModel? currentProject;
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
  final OrgProjectModel project;

  const _DiaryListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('다이어리 갱신');

    final diaryProvider = GlobalDataManager.i.getDiaryListProvider();
    final diaryState = ref.watch(diaryProvider(project));

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
  final OrgProjectModel project;

  const _UserListWidget({
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('유저 갱신');

    final userProvider = GlobalDataManager.i.getUserListProvider();

    final userListState = ref.watch(userProvider(project));

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
