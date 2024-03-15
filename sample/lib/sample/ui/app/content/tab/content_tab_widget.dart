import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/data/shared/shared_data_manager.dart';
import 'package:sample/sample/ui/app/content/content_view_model.dart';
import 'package:sample/sample/ui/app/content/content_widget.dart';
import 'package:sample/sample/ui/app/content/tab/abc/content_tab_abc_widget.dart';
import 'package:sample/sample/ui/app/content/tab/ac/content_tab_ac_widget.dart';
import 'package:sample/sample/ui/app/content/tab/add/content_tab_add_widget.dart';
import 'package:sample/sample/util/log.dart';
import 'package:sample/sample/widget/base/provider_widget.dart';

import 'automatic_widget.dart';

final List<Widget> widgetBottomMenu = <Widget>[
  AutomaticWidget(child: ContentTabAddWidget()),
  AutomaticWidget(child: ContentTabAcWidget()),
  AutomaticWidget(child: ContentTabAbcWidget()),
];

class ContentTabWidget
    extends ProviderStatefulWidget<ContentViewModelNotifier, ContentViewModel> {
  const ContentTabWidget();

  @override
  ProviderState createState() => _ContentTabWidgetState();

  @override
  AutoDisposeStateNotifierProvider<ContentViewModelNotifier, ContentViewModel>
      get provider => ContentWidget.contentViewModelProvider;
}

class _ContentTabWidgetState extends ProviderState<
    ContentTabWidget,
    ContentViewModelNotifier,
    ContentViewModel> with SingleTickerProviderStateMixin {
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
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
        BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'abc'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit_rounded), label: 'ac'),
      ],
      onTap: (value) {
        setState(() {
          widget.controller.index = value;
        });
      },
    );
  }
}