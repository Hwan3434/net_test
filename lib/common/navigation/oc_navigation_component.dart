import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:net_test/common/inje_base/inje_view.dart';
import 'package:net_test/user_screen/user_view/user_screen_model.dart';
import 'package:net_test/user_screen/user_view/user_screen_provider.dart';
import 'package:riverpod/src/framework.dart';

class OcBottomNavigationBar extends InjeView<UserPageViews> {
  final ProviderListenable<UserPageViews> provider;

  OcBottomNavigationBar({super.key, required this.provider});

  @override
  ProviderListenable<UserPageViews> get viewProvider => provider;

  @override
  Widget build(BuildContext context, WidgetRef ref, UserPageViews viewModel) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet),
          label: 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Cache',
        ),
      ],
      currentIndex: viewModel.index,
      onTap: (value) {
        final UserPageViews userPageViews = UserPageViews.values[value];
        ref
            .read(userScreenProvider.notifier)
            .update(selectedTab: userPageViews);
      },
    );
  }
}
