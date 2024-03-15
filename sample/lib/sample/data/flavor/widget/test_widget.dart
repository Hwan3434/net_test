import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final Widget child;
  const TestWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
