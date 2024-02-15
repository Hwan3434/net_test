import 'package:flutter/material.dart';
import 'package:ui/test/log.dart';
import 'package:ui/ui/diary/common/diary_card.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/data/diary_model.dart';
import 'package:ui/ui/diary/detail/diary_detail_view.dart';

class DiaryFavList extends StatelessWidget {
  const DiaryFavList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = allData.where((element) => element.fav).toList();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _FavContainer(item: item);
      },
    );
  }
}

class _FavContainer extends StatelessWidget {
  final DiaryModel item;
  const _FavContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: DiaryCard(
        onTab: () {
          Log.d('즐겨찾기 List Item Click');
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
            children: [
              _FavTop(
                value: item.selectedState,
                date: item.date,
                onChanged: (value) {
                  Log.d('누름 : $value');
                },
              ),
              Flexible(child: _FavContent(content: item.content)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavTop extends StatelessWidget {
  final bool value;
  final DateTime date;
  final ValueChanged<bool?>? onChanged;

  const _FavTop({
    required this.value,
    required this.date,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(
          child: Text(
            date.toIso8601String(),
            style: TextStyle(fontSize: 6),
          ),
        )
      ],
    );
  }
}

class _FavContent extends StatelessWidget {
  final String content;
  const _FavContent({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 8,
      ),
    );
  }
}
