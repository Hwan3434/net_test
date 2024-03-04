import 'package:data/common/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_container.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/widget/data/data_view_provider.dart';
import 'package:ui/ui/orgnal_login/widget/data/original_data_view.dart';
import 'package:ui/ui/orgnal_login/widget/dynamic_editor/original_dynamic_editor_view.dart';
import 'package:ui/ui/orgnal_login/widget/editor/original_editor_view.dart';

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
    final org = ref.watch(orgStateProvider);
    Log.e('org = ${org.runtimeType}');
    switch (org) {
      case OrgNone():
        return Center(
          child: ElevatedButton(
              onPressed: () {
                ref.read(orgStateProvider.notifier).login('조직1');
              },
              child: Text('로그인')),
        );
      case OrgLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case OrgLoginSuccess():
        return OrgProjectWidget(
          success: org,
        );
    }
  }
}

class OrgProjectWidget extends ConsumerWidget {
  final OrgLoginSuccess success;
  const OrgProjectWidget({
    required this.success,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = OrgDataContainer.i.getOrgProject().getList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('현재 조직 명 : ${success.orgName}'),
        ElevatedButton(
          onPressed: () {
            ref.read(orgStateProvider.notifier).logout();
          },
          child: Text('로그아웃'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(orgStateProvider.notifier).change('조직1');
              },
              child: Text('조직변경(조직1)'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(orgStateProvider.notifier).change('조직2');
              },
              child: Text('조직변경(조직2)'),
            ),
          ],
        ),
        if (projects.isNotEmpty)
          Column(
            children: projects.map((e) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('프로젝트 - ${e.name} 상세보기'),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(currentProject.notifier).update((state) => e);
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
