import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/org_provider.dart';
import 'package:ui/ui/orgnal_login/widget/original_data_view.dart';

class OrgLoginWidget extends ConsumerWidget {
  const OrgLoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: OrgLoginStateWidget(),
    );
  }
}

class OrgLoginStateWidget extends ConsumerWidget {
  const OrgLoginStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final org = ref.watch(orgProvider);
    switch (org) {
      case OrgNone():
        return Center(
          child: ElevatedButton(
              onPressed: () {
                ref.read(orgProvider.notifier).login('로그인');
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('현재 조직 명 : ${success.orgName}'),
        ElevatedButton(
          onPressed: () {
            ref.read(orgProvider.notifier).logout();
          },
          child: Text('로그아웃'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(orgProvider.notifier).change('로그인2');
          },
          child: Text('조직변경'),
        ),
        Column(
          children: success.project.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('프로젝트 - ${e.name} 상세보기'),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OriginalDataView(
                          org: success,
                          initProjectId: e.id,
                        );
                      },
                    ));
                  },
                  child: Text('이동'),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
