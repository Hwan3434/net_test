import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/appbar/oc_appbar_component.dart';
import 'package:net_test/common/base/base_state_screen.dart';
import 'package:net_test/common/floating/oc_floating_component.dart';
import 'package:net_test/common/navigation/oc_navigation_component.dart';
import 'package:net_test/user_screen/user_view/list/user_list_view.dart';
import 'package:net_test/user_screen/user_view/user_screen_provider.dart';

import 'user_screen_model.dart';

class UserScreen extends BaseStateScreen<UserScreenModel> {
  UserScreen({
    super.key,
  });

  @override
  ProviderListenable<UserScreenModel> get viewProvider => userScreenProvider;

  /// 상태를 외부에 데이터를 받지않으며 스스로 다른 UI의 상태를 구독하는 방식으로 구현
  @override
  PreferredSizeWidget? appbar(_, __) => OcAppbarComponent(
        systemUiOverlayStyle: SystemUiOverlayStyle.light,
      );

  /// 상태를 외부에 데이터를 받아서 다른 UI의 상태를 구독하는 방식으로 구현
  @override
  Widget? bottomNavigationBar(_, __) => OcBottomNavigationBar(
      provider: viewProvider.select((value) => value.selectedTab));

  @override
  Widget? floatingActionButton(_, __) =>
      OcFloatingComponent(provider: viewProvider);

  @override
  void initializeWidgetMap(WidgetRef ref) {
    buildAll(
      'UserScreenModel',
      portraitFunc: (p0) {
        return switch (p0.selectedTab) {
          UserPageViews.user => UserListView(),
          UserPageViews.cache => Center(child: Text('cache 화면 테스트')),
        };
      },
    );
  }
}
