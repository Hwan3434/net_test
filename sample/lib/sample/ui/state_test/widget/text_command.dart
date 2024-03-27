import 'package:flutter/material.dart';

class TextCommandWidget extends StatelessWidget {
  final String s;
  const TextCommandWidget(this.s, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(s);
  }
}
