import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/main.dart';

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
            switch (screen) {
              case SampleScreen.provider:
                ref
                    .read(changedScreen.notifier)
                    .update((state) => SampleScreen.provider);
                break;
              case SampleScreen.buffer:
                ref
                    .read(changedScreen.notifier)
                    .update((state) => SampleScreen.buffer);
                break;
              case SampleScreen.getIt:
                ref
                    .read(changedScreen.notifier)
                    .update((state) => SampleScreen.getIt);
                break;
            }
          },
          child: Text(screen.toString()),
        );
      },
    );
  }
}
