import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/main.dart';
import 'package:net_test/test_screen/buffer/buffer_screen_provider.dart';
import 'package:net_test/test_screen/geit/getit_screen_state_view_model.dart';
import 'package:net_test/test_screen/provider/provider_screen_state_view_model.dart';

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
            ref.read(providerScreenProvider.notifier).fetchData();
            break;
          case SampleScreen.buffer:
            ref
                .read(bufferScreenProvider.notifier)
                .fetchData(serviceId: searchKey);
            break;
          case SampleScreen.getIt:
            ref.read(getItScreenProvider.notifier).fetchData();
            break;
        }
      },
      child: const Icon(Icons.refresh),
    );
  }
}
