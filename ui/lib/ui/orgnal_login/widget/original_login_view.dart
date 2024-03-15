import 'package:data/common/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_model.dart';
import 'package:ui/ui/orgnal_login/provider/global/model/org_project_model.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/provider/project_list_notifier.dart';
import 'package:ui/ui/orgnal_login/widget/data/original_data_view.dart';
import 'package:ui/ui/orgnal_login/widget/dynamic_editor/original_dynamic_editor_view.dart';
import 'package:ui/ui/orgnal_login/widget/editor/original_editor_view.dart';

final currentOrgProvider = StateProvider.autoDispose<OrgModel?>((ref) {
  return null;
});

final currentOrgProjectProvider = StateProvider<OrgProjectModel?>((ref) {
  return null;
});

class OrgLoginWidget extends ConsumerWidget {
  const OrgLoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('kD : $kDebugMode');
    return Scaffold(
      body: OrgLoginStateWidget(),
    );
  }
}

class OrgLoginStateWidget extends ConsumerWidget {
  const OrgLoginStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = GlobalDataManager.i.getLoginProvider();
    final loginState = ref.watch(loginProvider);
    Log.e('loginState = ${loginState.runtimeType}');

    /// globalMangaer.getUser().getOrg().getProject().getDiary();

    switch (loginState) {
      case LoginNone():
        Log.d('일로 LoginNone');
        return Center(
          child: ElevatedButton(
              onPressed: () {
                ref.read(loginProvider.notifier).login('userId', 'pw123');
              },
              child: Text('로그인')),
        );
      case LoginLogout():
        Log.d('일로 LoginLogout');
        return Center(child: Text('로그아웃 진행중...'));
      case LoginLoading():
        Log.d('일로 LoginLoading');
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoginSuccess():
        Log.d('일로 안옴');
        final orgModel = ref.watch(currentOrgProvider);
        final orgModels = ref.watch(GlobalDataManager.i.getOrgListProvider());
        if (orgModel == null) {
          return _NotCurrentOrgWidget(
            list: orgModels.toList(),
          );
        }
        return OrgProjectWidget(
          currentOrgModel: orgModel,
          orgModels: orgModels.toList(),
        );
    }
  }
}

class _NotCurrentOrgWidget extends ConsumerWidget {
  final List<OrgModel> list;
  const _NotCurrentOrgWidget({
    required this.list,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('선택된 조직이 없음 : list Size : ${list.length}'),
          ...list.map((e) {
            return ElevatedButton(
                onPressed: () {
                  ref.read(currentOrgProvider.notifier).update((state) => e);
                },
                child: Text(e.name));
          })
        ],
      ),
    );
  }
}

class OrgProjectWidget extends ConsumerWidget {
  final OrgModel currentOrgModel;
  final List<OrgModel> orgModels;
  OrgProjectWidget({
    required this.currentOrgModel,
    required this.orgModels,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(GlobalDataManager.i.getLoginProvider().notifier).logout();
          },
          child: Text('로그아웃'),
        ),
        Text('현재 조직 명 : ${currentOrgModel.name}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  ref.read(currentOrgProvider.notifier).update((state) => null);
                },
                child: Text('null')),
            ...orgModels.map((e) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(currentOrgProvider.notifier).update((state) => e);
                },
                child: Text(e.name),
              );
            }),
          ],
        ),
        _OrgProjectWidget(
          currentOrgModel: currentOrgModel,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return OriginalEditorView();
              },
            ));
          },
          child: Text('에디터뷰'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return OriginalDynamicEditorView();
              },
            ));
          },
          child: Text('동적 에디터뷰'),
        ),
      ],
    );
  }
}

class _OrgProjectWidget extends ConsumerWidget {
  final OrgModel currentOrgModel;
  const _OrgProjectWidget({
    required this.currentOrgModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectListState = ref
        .watch(GlobalDataManager.i.getProjectListProvider()(currentOrgModel));
    switch (projectListState) {
      case ProjectListWait():
        return Center(
          child: Text("Project Wait"),
        );
      case ProjectListLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case ProjectListSuccess(data: final data):
        if (data.isEmpty) {
          return Center(
            child: Text('존재하는 프로젝트가 없습니다.'),
          );
        }
        return Column(
          children: data.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('프로젝트 - ${e.name} 상세보기'),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(currentOrgProjectProvider.notifier)
                        .update((state) => e);

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OriginalDataView();
                      },
                    ));
                  },
                  child: Text('이동'),
                ),
              ],
            );
          }).toList(),
        );
      case ProjectListError():
        return Center(
          child: Text('프로젝트를 가져오기 실패'),
        );
    }
  }
}
