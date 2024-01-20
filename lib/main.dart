import 'package:domain/getit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/geit_sample/getit_sample_screen.dart';
import 'package:net_test/test_screen/provider_sample/provider_other_screen.dart';
import 'package:net_test/test_screen/provider_sample/provider_screen.dart';
import 'package:net_test/test_screen/test_screen.dart';

import 'test_screen/buffer_sample/buffer_screen.dart';

void main() {

  initLocator();

  runApp(
    const ProviderScope(
      observers: [
      ],
      child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: TestScreen(),
    );
  }
}


enum SampleScreen{
  provider,
  buffer,
  getIt,
  otherProvider,
}
final changedScreen = StateProvider((ref) {
  return SampleScreen.provider;
});
