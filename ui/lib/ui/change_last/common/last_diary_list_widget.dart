import 'package:flutter/material.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

class LastDiaryListWidget extends StatelessWidget {
  final List<DiaryModel> data;

  const LastDiaryListWidget({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _LastDiaryItemWidget(data: data[index]);
      },
    );
  }
}

class _LastDiaryItemWidget extends StatelessWidget {
  final DiaryModel data;
  const _LastDiaryItemWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: data.color.getColor(),
      child: Center(
        child: Text(data.content),
      ),
    );
  }
}
