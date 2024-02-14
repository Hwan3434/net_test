import 'package:flutter/material.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

class DiaryCard extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTab;
  final DiaryColor diaryColor;
  const DiaryCard({
    super.key,
    required this.child,
    required this.diaryColor,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: diaryColor.getColor(),
      child: InkWell(
        onTap: onTab,
        child: child,
      ),
    );
  }
}
