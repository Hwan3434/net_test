import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/inje_base/inje_view.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/user_screen_model.dart';

class OcFloatingComponent extends InjeView<UserScreenModel> {
  final ProviderListenable<UserScreenModel> provider;

  OcFloatingComponent({
    super.key,
    required this.provider,
  });

  @override
  ProviderListenable<UserScreenModel> get viewProvider => provider;

  @override
  Widget build(BuildContext context, WidgetRef ref, UserScreenModel viewModel) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(DataManager().usecaseStateProvider.notifier).update(
              service: 'typicode',
            );
      },
      child: Icon(Icons.edit),
      elevation: 0, // 떠있는 정도 조절
    );
  }
}
