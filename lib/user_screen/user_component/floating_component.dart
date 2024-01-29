import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingComponent extends ConsumerWidget {
  final VoidCallback? onPressed;
  const FloatingComponent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.refresh),
    );
  }
}
