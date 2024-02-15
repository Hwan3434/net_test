import 'package:flutter/material.dart';
import 'package:ui/test/log.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/list/all/diary_all_list.dart';
import 'package:ui/ui/diary/list/delete/diary_del_list.dart';
import 'package:ui/ui/diary/list/fav/diary_fav_list.dart';

import 'data/diary_model.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _selectedIndex == 0 ? _DiaryBody() : _DeleteBody(),
      bottomNavigationBar: _BottomNavigation(
        onChangedTab: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

class _AppBar extends StatefulWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 46.0);

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: DiaryColor.values.length + 1);
    _tabController.addListener(onTabChanged);
  }

  void onTabChanged() {
    Log.d(
        'AppBar Tab Chagned ! ${_tabController.indexIsChanging} / ${_tabController.index}');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('일기'),
      actions: [
        IconButton(
            onPressed: () {
              Log.d('모든 아이템 체크');
            },
            icon: Icon(Icons.check)),
        IconButton(
            onPressed: () {
              Log.d('체크된 아이템 삭제');
            },
            icon: Icon(Icons.delete)),
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: ['all', ...DiaryColor.values.map((e) => e.name).toList()]
            .map(
              (e) => Tab(
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DeleteBody extends StatelessWidget {
  const _DeleteBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: DiaryDelList(),
    );
  }
}

class _DiaryBody extends StatelessWidget {
  const _DiaryBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 100, child: DiaryFavList()),
          Expanded(child: DiaryAllList()),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatefulWidget {
  final ValueChanged<int>? onChangedTab;
  const _BottomNavigation({required this.onChangedTab});

  @override
  State<_BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<_BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (value) {
        Log.d('탭 변경 클릭 : $value');
        setState(() {
          _selectedIndex = value;
          widget.onChangedTab?.call(value);
        });
      },
      items: BottomTabs.values.map(
        (e) {
          switch (e) {
            case BottomTabs.diary:
              return BottomNavigationBarItem(
                  icon: Icon(Icons.note), label: '일기');
            case BottomTabs.delete:
              return BottomNavigationBarItem(
                  icon: Icon(Icons.delete), label: '삭제');
          }
        },
      ).toList(),
    );
  }
}
