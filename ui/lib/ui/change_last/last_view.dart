import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/framework.dart';
import 'package:ui/ui/change_last/base/last_state_view.dart';

import 'last_view_model.dart';
import 'last_view_provider.dart';

class LastView extends LastStateView<LastStateModel> {
  const LastView({super.key});

  @override
  ProviderListenable<LastStateModel> get viewProvider => lastViewProvider;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    LastStateModel viewModel,
  ) {
    switch (viewModel) {
      case LastStateModelWait():
        return _wait(ref);
      case LastStateModelLoading():
        return _loadding();
      case LastStateModelSuccess(data: final name):
        return OrientationBuilder(builder: (context, orientation) {
          return switch (orientation) {
            Orientation.portrait => _successPortrait(name),
            Orientation.landscape => _successLandscape(name),
          };
        });
      case LastStateModelError(errorMessage: final error):
        return _error(error);
    }
  }

  Widget _wait(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'wait',
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(lastViewProvider.notifier).fetchData();
            },
            child: Text('유저 가져오기'),
          )
        ],
      ),
    );
  }

  Widget _loadding() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '사용자 데이터를 가져오는 중입니다.',
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _successPortrait(String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '가져온 사용자 : ${name} (가로)',
          ),
        ),
      ],
    );
  }

  Widget _successLandscape(String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '가져온 사용자 : $name (세로)',
          ),
        ),
      ],
    );
  }

  Widget _error(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '유저를 불러오는데 실패하였습니다. $error',
          ),
        ),
      ],
    );
  }
}
