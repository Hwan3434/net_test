import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/test_screen_model.dart';
import 'package:net_test/test_screen/test_screen_provider.dart';

class ChangedBtnWidget extends ConsumerWidget {
  const ChangedBtnWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: SampleScreen.values.map((e) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SampleButton(screen: e),
          );
        }).toList(),
      ),
    );
  }
}

class SampleButton extends StatelessWidget {
  final SampleScreen screen;

  const SampleButton({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ElevatedButton(
          onPressed: () {
            ref.read(testScreenProvider.notifier).update(selectedTab: screen);
          },
          child: Text(
            screen.toString(),
          ),
        );
      },
    );
  }
}
