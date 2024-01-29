import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/screen/base_screen.dart';
import 'package:net_test/user_screen/user_component/floating_component.dart';
import 'package:net_test/user_screen/user_view/user_view_model.dart';
import 'package:net_test/user_screen/user_view/user_view_provider.dart';

import 'cache/cache_view.dart';
import 'provider/provider_view.dart';
import 'provider/provider_view_provider.dart';

class UserView extends ConsumerStatefulWidget {
  const UserView({
    super.key,
  });

  @override
  ConsumerState<UserView> createState() => _UserViewState();
}

class _UserViewState extends ConsumerState<UserView> {
  final PageController controller = PageController();
  final Map<UserPageViews, Widget> screenWidgets =
      UserPageViews.values.asMap().map((key, value) {
    switch (value) {
      case UserPageViews.provider:
        return MapEntry(value, const ProviderView());
      case UserPageViews.buffer:
        return MapEntry(value, const CacheView());
    }
  });

  @override
  Widget build(BuildContext context) {
    final screen = ref.watch(userViewProvider);
    final serviceId = ref.watch(
        DataManager().usecaseStateProvider.select((value) => value.service));
    ref.watch(DataManager().loginUseCaseFactoryProvider(serviceId));

    return BaseScreen(
        appBar: AppBar(
          title: Row(
            children: [
              Text('index : ${screen.selectedTab.name}'),
              UsecaseLoadingWidget(),
            ],
          ),
        ),
        view: SafeArea(
          child: PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: screenWidgets.values.toList(),
          ),
        ),
        floatingActionButton: screen.selectedTab.index == 0
            ? FloatingComponent(
                onPressed: () {
                  ref.read(providerViewProvider.notifier).refresh();
                },
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.text_snippet),
              label: UserPageViews.provider.name,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: UserPageViews.buffer.name,
            ),
          ],
          currentIndex: screen.selectedTab.index,
          onTap: (value) {
            controller.jumpToPage(value);
            ref
                .read(userViewProvider.notifier)
                .update(selectedTab: UserPageViews.values[value]);
          },
        ));
  }
}

class UsecaseLoadingWidget extends ConsumerWidget {
  const UsecaseLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch<UseCaseStateModel>(DataManager().usecaseStateProvider);

    return Text(' / s : ' + state.service);
  }
}
