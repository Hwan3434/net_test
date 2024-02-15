import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/screen/sample_screen.dart';

import 'test/log.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Log.d('MyApp 생성자');
  }

  @override
  StatelessElement createElement() {
    Log.d('MyApp Element');
    return super.createElement();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Log.d('MyApp 빌드');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: SampleScreen(),
    );
  }
}
