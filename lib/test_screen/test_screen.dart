import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/app_global_current_provider.dart';
import 'package:net_test/manager/usecase_provider_manager.dart';
import 'package:net_test/manager/usecase_state_notifier.dart';
import 'package:net_test/test_screen/buffer/buffer_page.dart';
import 'package:net_test/test_screen/provider/provider_page.dart';
import 'package:net_test/test_screen/test_common/floating_widget.dart';
import 'package:net_test/test_screen/test_screen_model.dart';
import 'package:net_test/test_screen/test_screen_provider.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  final pageController = PageController();

  final Map<SampleScreen, Widget> screenWidgets =
      SampleScreen.values.asMap().map((key, value) {
    switch (value) {
      case SampleScreen.provider:
        return MapEntry(value, ProviderPage());
      case SampleScreen.buffer:
        return MapEntry(value, BufferPage());
    }
  });

  @override
  Widget build(BuildContext context) {
    final screen = ref.watch(testScreenProvider);

    final serviceId =
        ref.watch(currentProvider.select((value) => value.service));
    ref.watch(UsecaseProviderManager().loginUseCaseFactoryProvider(serviceId));

    debugPrint('TestScreen build :: $serviceId');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(screen.selectedTab.name),
            UsecaseLoadingWidget(),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screenWidgets.values.toList(),
        ),
      ),
      floatingActionButton: FloatingWidget(
        screen: screen.selectedTab,
        searchKey: AppConst.searchKey,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.text_snippet),
            label: SampleScreen.provider.name,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: SampleScreen.buffer.name,
          ),
        ],
        currentIndex: screen.selectedTab.index,
        onTap: (value) {
          pageController.jumpToPage(value);
          ref
              .read(testScreenProvider.notifier)
              .update(selectedTab: SampleScreen.values[value]);
        },
      ),
    );
  }
}

class UsecaseLoadingWidget extends ConsumerWidget {
  const UsecaseLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<UseCaseStateModel>(
        UsecaseProviderManager().usecaseStateProvider);

    return Text(' / s : ' + state.service);
  }
}
