import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String error;
  const ErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}
