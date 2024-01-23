import 'package:domain/getit/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/test_screen.dart';

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
}
final changedScreen = StateProvider((ref) {
  return SampleScreen.provider;
});
