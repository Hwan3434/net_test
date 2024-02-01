import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget screen;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const BaseScreen({
    super.key,
    this.appBar,
    required this.screen,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: screen,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
