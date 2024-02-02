import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/wrapper_state_view.dart';
import 'wrapper_view_model.dart';
import 'wrapper_view_provider.dart';

class WrapperView extends WrapperStateView<WrapperStateModel> {
  WrapperView({
    super.key,
  });

  @override
  ProviderListenable<WrapperStateModel> get viewProvider => wrapperViewProvider;

  @override
  void initializeWidgetMap(WidgetRef ref) {
    buildAll(
      'WrapperStateModelWait',
      portraitFunc: (p0, p1) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'wait',
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(wrapperViewProvider.notifier).fetchData();
                },
                child: Text('유저 가져오기'),
              )
            ],
          ),
        );
      },
    );

    buildAll(
      'WrapperStateModelLoading',
      portraitFunc: (p0, p1) {
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
      },
    );

    buildAll(
      'WrapperStateModelError',
      portraitFunc: (ts, p1) {
        final testState = ts as WrapperStateModelError;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '유저를 불러오는데 실패하였습니다. ${testState.errorMessage}',
              ),
            ),
          ],
        );
      },
    );

    buildAll(
      'WrapperStateModelSuccess',
      portraitFunc: (p0, p1) {
        final testState = p0 as WrapperStateModelSuccess;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '가져온 사용자 : ${testState.data} (세로)',
              ),
            ),
          ],
        );
      },
      landscapeFunc: (p0, p1) {
        final testState = p0 as WrapperStateModelSuccess;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '가져온 사용자 : ${testState.data} (가로)',
              ),
            ),
          ],
        );
      },
    );
  }
}
