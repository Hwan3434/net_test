import 'package:flutter/material.dart';

class BButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const BButton({
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.black,
        ),
        foregroundColor: MaterialStateProperty.all(
          Colors.red,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
