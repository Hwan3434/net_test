import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';
import 'package:sample/sample/ui/app/common/login_check_widget.dart';
import 'package:sample/sample/ui/app/content/content_notifier.dart';
import 'package:sample/sample/ui/app/content/content_view.dart';
import 'package:sample/sample/ui/app/content/tab/abc/content_tab_abc_view.dart';
import 'package:sample/sample/ui/app/content/tab/ac/content_tab_ac_view.dart';
import 'package:sample/sample/ui/app/content/tab/add/content_tab_add_view.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';
import 'package:sample/sample/widget/common/b_tab_button.dart';

import 'keep_alive_widget.dart';

final List<Widget> widgetBottomMenu = <Widget>[
  const LoginCheckWidget(child: KeepAliveWidget(child: ContentTabAddView())),
  const LoginCheckWidget(child: KeepAliveWidget(child: ContentTabAcView())),
  const LoginCheckWidget(child: KeepAliveWidget(child: ContentTabAbcView())),
];

class ContentTabView
    extends ProviderStatefulWidget<ContentNotifier, ContentViewModel> {
  const ContentTabView();

  @override
  ProviderState createState() => _ContentTabWidgetState();

  @override
  AutoDisposeStateNotifierProvider<ContentNotifier, ContentViewModel>
      get provider => ContentView.contentViewModelProvider;
}

class _ContentTabWidgetState
    extends ProviderState<ContentTabView, ContentNotifier, ContentViewModel>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    final index = ref.read(widget.provider).currentTabIndex;
    tabController = TabController(
      length: widgetBottomMenu.length,
      vsync: this,
      initialIndex: index,
    );
    tabController.addListener(() {
      final index = tabController.index;
      SharedDataManger().setCurrentTab(index);
      ref.read(widget.provider.notifier).update(currentTabIndex: index);
    });
  }

  @override
  Widget pBuild(BuildContext context) {
    ref.listen(widget.provider.select((value) => value.currentTabIndex),
        (previous, next) {
      SharedDataManger().setCurrentTab(next);
      tabController.index = next;
    });

    return Scaffold(
      body: SafeArea(
        child: _CurrentContentWidget(
          tabController: tabController,
          children: widgetBottomMenu,
        ),
      ),
      bottomNavigationBar: _CurrentContentBottomNavigationWidget(
        controller: tabController,
      ),
    );
  }
}

class _CurrentContentWidget extends StatelessWidget {
  final TabController tabController;
  final List<Widget> children;
  _CurrentContentWidget({required this.tabController, required this.children});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: children,
    );
  }
}

class _CurrentContentBottomNavigationWidget extends StatefulWidget {
  final TabController controller;
  const _CurrentContentBottomNavigationWidget({
    required this.controller,
  });

  @override
  State<_CurrentContentBottomNavigationWidget> createState() =>
      _CurrentContentBottomNavigationWidgetState();
}

class _CurrentContentBottomNavigationWidgetState
    extends State<_CurrentContentBottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.controller.index,
      items: [
        BTabButton.add(),
        BTabButton.abc(),
        BTabButton.ac(),
      ],
      onTap: (value) {
        setState(() {
          widget.controller.index = value;
        });
      },
    );
  }
}
