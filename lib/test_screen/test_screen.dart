import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/main.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_provider.dart';
import 'package:net_test/test_screen/geit_sample/getit_screen.dart';
import 'package:net_test/test_screen/geit_sample/getit_screen_state_view_model.dart';
import 'package:net_test/test_screen/provider_sample/provider_screen.dart';
import 'package:net_test/test_screen/provider_sample/provider_screen_state_view_model.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

const delay = Duration(seconds: 3);

class _TestScreenState extends ConsumerState<TestScreen> {
  final pageController = PageController();

  final Map<SampleScreen, Widget> screenWidgets = SampleScreen.values.asMap().map((key, value) {
    switch(value) {
      case SampleScreen.provider:
        return MapEntry(value, const ProviderScreen());
      case SampleScreen.buffer:
        return MapEntry(value, const BufferScreen());
      case SampleScreen.getIt:
        return MapEntry(value, const GetItScreen());
    }
  });


  @override
  Widget build(BuildContext context) {
    final screen = ref.watch(changedScreen);
    return Scaffold(
      appBar: AppBar(
        title: Text(screen.name),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            debugPrint('hi : $value');
          },
          children: screenWidgets.values.toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (screen) {
            case SampleScreen.provider:
              ref.read(providerScreenProvider.notifier).fetchData();
              break;
            case SampleScreen.buffer:
              ref
                  .read(bufferScreenProvider.notifier)
                  .fetchData(serviceId: searchKey);
              break;
            case SampleScreen.getIt:
              ref.read(getItScreenProvider.notifier).fetchData();
              break;
          }
        },
        child: const Icon(Icons.refresh),
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            label: SampleScreen.getIt.name,
          ),
        ],
        currentIndex: screen.index,
        onTap: (value) {
          pageController.jumpToPage(value);
          ref
              .read(changedScreen.notifier)
              .update((state) => SampleScreen.values[value]);

        },
      ),
    );
  }
}
