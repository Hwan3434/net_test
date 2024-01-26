import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/buffer/buffer_page_provider.dart';
import 'package:net_test/test_screen/provider/provider_page_provider.dart';
import 'package:net_test/test_screen/test_screen_model.dart';

class FloatingWidget extends ConsumerWidget {
  final SampleScreen screen;
  final String searchKey;
  const FloatingWidget({
    super.key,
    required this.screen,
    required this.searchKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        switch (screen) {
          case SampleScreen.provider:
            ref.read(providerPageProvider.notifier).fetchData();
            break;
          case SampleScreen.buffer:
            ref.read(bufferPageProvider.notifier).fetchData();
            break;
        }
      },
      child: const Icon(Icons.refresh),
    );
  }
}
