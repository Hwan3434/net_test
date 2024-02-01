import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/user_screen/user_view/user_screen.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        // Logger(),
      ],
      child: MyApp(),
    ),
  );
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    debugPrint('''
      "provider": "${provider.name ?? provider.runtimeType}"
    ''');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    debugPrint('''
    {
      "provider:" "${provider.name ?? provider.runtimeType}",
      "value": "$value"
    }
    ''');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: UserScreen(),
    );
  }
}
