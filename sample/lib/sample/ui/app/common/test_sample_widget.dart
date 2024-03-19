import 'package:flutter/material.dart';
import 'package:sample/sample/widget/common/b_text_widget.dart';

class TestSampleWidget extends StatelessWidget {
  static String get path => 'TestSampleWidget/:ts';
  static String get name => 'TestSampleWidget';
  final String ts;
  const TestSampleWidget({
    required this.ts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestSample'),
      ),
      body: Center(child: BTextWidget(ts)),
    );
  }
}
