import 'package:flutter/material.dart';
import 'package:ui/test/log.dart';
import 'package:ui/ui/diary/common/diary_card.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/data/diary_model.dart';
import 'package:ui/ui/diary/detail/diary_detail_view.dart';

class DiaryAllList extends StatelessWidget {
  const DiaryAllList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = allData;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _AllContainer(item: item);
      },
    );
  }
}

class _AllContainer extends StatelessWidget {
  final DiaryModel item;
  const _AllContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    return DiaryCard(
      onTab: () {
        Log.d('List Item Click');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DiaryDetailView(
                id: item.id,
              );
            },
          ),
        );
      },
      diaryColor: item.color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AllTop(
              date: item.date,
              fav: item.fav,
              selected: item.selectedState,
              onDeletePressed: () {
                Log.d('아이템 삭제 클릭');
              },
              onFavPressed: () {
                Log.d('아이템 즐겨찾기 클릭');
              },
              onSelectedPressed: (value) {
                Log.d('아이템 체크박스 클릭');
              },
            ),
            _AllMid(
              content: item.content,
            ),
            _AllBot(
              users: item.users,
            ),
          ],
        ),
      ),
    );
  }
}

class _AllTop extends StatelessWidget {
  final bool fav;
  final bool selected;
  final DateTime date;
  final VoidCallback? onFavPressed;
  final ValueChanged<bool?>? onSelectedPressed;
  final VoidCallback? onDeletePressed;
  const _AllTop({
    required this.fav,
    required this.selected,
    required this.date,
    required this.onDeletePressed,
    required this.onSelectedPressed,
    required this.onFavPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: selected,
          onChanged: onSelectedPressed,
        ),
        Expanded(child: Text(date.toString())),
        ElevatedButton(
          onPressed: onFavPressed,
          child: Text(fav ? '즐찾삭제' : '즐찾추가'),
        ),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: Text('삭제'),
        ),
      ],
    );
  }
}

class _AllMid extends StatelessWidget {
  final String content;
  const _AllMid({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class _AllBot extends StatelessWidget {
  final List<DiaryUserModel> users;
  const _AllBot({
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Text('만난사람 : ${users.map((e) => e.name).join(',')}');
  }
}
