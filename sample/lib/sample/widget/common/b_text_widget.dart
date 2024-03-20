import 'package:flutter/material.dart';

class BTextWidget extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final int? maxLines;
  const BTextWidget(
    this.text, {
    this.overflow = TextOverflow.fade,
    this.color,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        overflow: overflow,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      maxLines: maxLines,
    );
  }
}
