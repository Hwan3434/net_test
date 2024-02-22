import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/framework.dart';
import 'package:ui/ui/change_last/setting/last_setting_view.dart';

import 'base/base_watch_widget.dart';
import 'content/last_content_view.dart';
import 'last_view_model.dart';
import 'last_view_notifier.dart';

class LastView extends BaseWatchStatelessWidget<LastViewModel> {
  LastView({super.key});

  @override
  ProviderListenable<LastViewModel> get watchProvider => lastViewProvider;

  final List<Widget> _widgetOptions = <Widget>[
    LastContentView(),
    LastSettingView(),
  ];

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    LastViewModel viewModel,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('테스트앱'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(lastViewProvider.notifier).removeDiaryData(1, ref);
            },
            icon: Icon(Icons.abc),
          ),
        ],
      ),
      body: IndexedStack(
        index: viewModel.currentTab.index,
        children: _widgetOptions,
      ),
      bottomNavigationBar: LastBottomNavigationBar(
        currentTab: viewModel.currentTab,
      ),
    );
  }
}

class LastBottomNavigationBar extends ConsumerWidget {
  final LastTabs currentTab;
  const LastBottomNavigationBar({super.key, required this.currentTab});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      onTap: (value) {
        ref.read(lastViewProvider.notifier).update(LastTabs.values[value]);
      },
      items: LastTabs.values.map((e) {
        switch (e) {
          case LastTabs.content:
            return BottomNavigationBarItem(
                icon: Icon(Icons.note), label: e.name);
          case LastTabs.setting:
            return BottomNavigationBarItem(
                icon: Icon(Icons.delete), label: e.name);
        }
      }).toList(),
    );
  }
}
