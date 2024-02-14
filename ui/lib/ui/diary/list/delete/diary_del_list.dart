import 'package:flutter/material.dart';
import 'package:ui/ui/diary/common/diary_card.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

class DiaryDelList extends StatelessWidget {
  const DiaryDelList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = deleteData;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _DelContainer(item: item);
      },
    );
  }
}

class _DelContainer extends StatelessWidget {
  final DiaryModel item;
  const _DelContainer({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return DiaryCard(
      diaryColor: item.color,
      onTab: () {
        debugPrint('삭제된 List Item Click');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DelTop(
              date: item.date,
              onRevertPressed: () {
                debugPrint('되돌리기');
              },
            ),
            _DelMid(content: item.content),
            _DelBot(users: item.users)
          ],
        ),
      ),
    );
  }
}

class _DelTop extends StatelessWidget {
  final DateTime date;
  final VoidCallback? onRevertPressed;
  const _DelTop({
    required this.date,
    required this.onRevertPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(date.toString())),
        ElevatedButton(
          onPressed: onRevertPressed,
          child: Text('되돌리기'),
        ),
      ],
    );
  }
}

class _DelMid extends StatelessWidget {
  final String content;
  const _DelMid({
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

class _DelBot extends StatelessWidget {
  final List<DiaryUserModel> users;
  const _DelBot({
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Text('만난사람 : ${users.map((e) => e.name).join(',')}');
  }
}
