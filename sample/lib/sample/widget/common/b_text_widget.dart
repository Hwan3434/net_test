import 'package:flutter/material.dart';

class BTextWidget extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color color;
  const BTextWidget(
    this.text, {
    this.overflow = TextOverflow.fade,
    this.color = Colors.blue,
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
      maxLines: 1,
    );
  }
}
