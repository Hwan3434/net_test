import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/cls_base_state.dart';
import 'cls_view_model.dart';
import 'cls_view_provider.dart';

class ClsView extends ConsumerStatefulWidget {
  const ClsView({
    super.key,
  });

  @override
  _ClsViewState createState() => _ClsViewState();
}

class _ClsViewState extends ClsBaseState<ClsView, ClsStateModel> {
  @override
  void initializeWidgetMap() {
    buildAll(
      'ClsStateModelWait',
      portraitFunc: (p0, p1) {
        return _WaitWidget(testState: p0);
      },
    );
    buildAll(
      'ClsStateModelLoading',
      portraitFunc: (p0, p1) {
        return _LoadingWidget(testState: p0);
      },
    );
    buildAll(
      'ClsStateModelSuccess',
      portraitFunc: (p0, p1) {
        return _SuccessPortraitWidget(ts: p0);
      },
      landscapeFunc: (p0, p1) {
        return _SuccessLandscapeWidget(ts: p0);
      },
    );
    buildAll(
      'ClsStateModelError',
      portraitFunc: (p0, p1) {
        return _ErrorWidget(ts: p0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final testState = ref.watch(clsViewProvider);
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: runBuild(testState, orientation),
        );
      },
    );
  }
}

class _WaitWidget extends ConsumerWidget {
  final ClsStateModel testState;

  const _WaitWidget({
    required this.testState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'wait',
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(clsViewProvider.notifier).fetchData();
            },
            child: Text('유저 가져오기'),
          )
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final ClsStateModel testState;

  const _LoadingWidget({
    required this.testState,
  });

  @override
  Widget build(BuildContext context) {
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
}

class _SuccessPortraitWidget extends StatelessWidget {
  final ClsStateModel ts;

  const _SuccessPortraitWidget({
    required this.ts,
  });

  @override
  Widget build(BuildContext context) {
    final testState = ts as ClsStateModelSuccess;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '가져온 사용자 : ${testState.data} - 세로',
          ),
        ),
      ],
    );
  }
}

class _SuccessLandscapeWidget extends StatelessWidget {
  final ClsStateModel ts;

  const _SuccessLandscapeWidget({
    required this.ts,
  });

  @override
  Widget build(BuildContext context) {
    final testState = ts as ClsStateModelSuccess;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '가져온 사용자 : ${testState.data} - 가로',
          ),
        ),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final ClsStateModel ts;

  const _ErrorWidget({
    required this.ts,
  });

  @override
  Widget build(BuildContext context) {
    final testState = ts as ClsStateModelError;
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
  }
}
