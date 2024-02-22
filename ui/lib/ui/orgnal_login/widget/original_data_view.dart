import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/original_global.dart';
import 'package:ui/ui/orgnal_login/provider/diary_list_notifier.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_project_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/user_list_notifier.dart';

class OriginalDataView extends ConsumerStatefulWidget {
  final OrgLoginSuccess org;
  final int initProjectId;
  const OriginalDataView({
    required this.org,
    required this.initProjectId,
  });

  @override
  ConsumerState<OriginalDataView> createState() => _OriginalUseCaseViewState();
}

class _OriginalUseCaseViewState extends ConsumerState<OriginalDataView> {
  /// todo 핵심과제 current를 어디서 누가 관리할것인가?
  late int _currentProjectId;
  @override
  void initState() {
    super.initState();
    _currentProjectId = widget.initProjectId;
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.read(orgProjectsProvider(widget.org));
    final currentOrgProject = ref
        .read(orgProjectsProvider(widget.org).notifier)
        .getProject(_currentProjectId);

    void changedProjectFunc() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('서비스변경'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: projects.values.map((e) {
                return ElevatedButton(
                    onPressed: () {
                      if (_currentProjectId != e.id) {
                        setState(() {
                          _currentProjectId = e.id;
                        });
                      }
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
          projects: projects,
          currentProject: currentOrgProject,
          changedFunc: changedProjectFunc,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final diaryProvider = ref
                        .read(dataProvider(currentOrgProject).notifier)
                        .diaryListNotifierProvider;
                    ref.read(diaryProvider.notifier).add();
                  },
                  child: Text('다이어리 추가'),
                );
              },
            ),
            Expanded(
                child: _DiaryListWidget(
              project: currentOrgProject,
            )),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final userProvider = ref
                        .read(dataProvider(currentOrgProject).notifier)
                        .userListNotifierProvider;
                    ref.read(userProvider.notifier).add();
                  },
                  child: Text('사람 추가'),
                );
              },
            ),
            Expanded(
                child: _UserListWidget(
              project: currentOrgProject,
            )),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  final OrgProject currentProject;
  final void Function() changedFunc;
  final Map<int, OrgProject> projects;
  const _AppBarTitleWidget({
    required this.projects,
    required this.currentProject,
    required this.changedFunc,
  });

  @override
  Widget build(BuildContext context) {
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
  const _DiaryListWidget({required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('다이어리 갱신');
    final diaryManagerProvider =
        ref.read(dataProvider(project).notifier).diaryListNotifierProvider;
    final diaryState = ref.watch(diaryManagerProvider);
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
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.e('유저 갱신');
    final userListDataProvider =
        ref.read(dataProvider(project).notifier).userListNotifierProvider;
    final userListState = ref.watch(userListDataProvider);

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
