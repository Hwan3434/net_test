import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_first/first_view_provider.dart';

import 'first_view_model.dart';

class FirstView extends ConsumerStatefulWidget {
  const FirstView({
    super.key,
  });

  @override
  _FirstViewState createState() => _FirstViewState();
}

abstract class _BaseState<T extends ConsumerStatefulWidget, M>
    extends ConsumerState<T> {
  final Map<
      Orientation,
      Map<
          String,
          Widget Function(
            M,
            Orientation,
          )>> widgetMap = {
    Orientation.portrait: {},
    Orientation.landscape: {},
  };

  @protected
  void initializeWidgetMap();

  @protected
  void buildAll(
    dynamic model, {
    required Widget Function(
      M,
      Orientation,
    ) portraitFunc,
    Widget Function(
      M,
      Orientation,
    )? landscapeFunc,
  }) {
    widgetMap[Orientation.portrait]![model.runtimeType.toString()] =
        portraitFunc;
    widgetMap[Orientation.landscape]![model.runtimeType.toString()] =
        landscapeFunc ?? portraitFunc;
  }

  @protected
  void setPortrait(
      dynamic model,
      Widget Function(
        M,
        Orientation,
      ) func) {
    widgetMap[Orientation.portrait]![model.runtimeType.toString()] = func;
  }

  @protected
  void setLandscape(
      dynamic model,
      Widget Function(
        M,
        Orientation,
      ) func) {
    widgetMap[Orientation.landscape]![model.runtimeType.toString()] = func;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.initializeWidgetMap();
  }
}

class _FirstViewState extends _BaseState<FirstView, FirstStateModel> {
  @override
  void initializeWidgetMap() {
    buildAll(FirstStateModelWait(), portraitFunc: wait);
    buildAll(FirstStateModelLoading(), portraitFunc: loading);
    buildAll(FirstStateModelError(), portraitFunc: error);
    buildAll(
      FirstStateModelSuccess(),
      portraitFunc: successPortrait,
      landscapeFunc: successLandscape,
    );
  }

  Widget loading(
    FirstStateModel testState,
    Orientation orientation,
  ) {
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

  Widget wait(
    FirstStateModel testState,
    Orientation orientation,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'wait',
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(firstViewProvider.notifier).fetchData();
            },
            child: Text('유저 가져오기'),
          )
        ],
      ),
    );
  }

  Widget error(
    FirstStateModel ts,
    Orientation orientation,
  ) {
    final testState = ts as FirstStateModelError;
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

  Widget successLandscape(
    FirstStateModel ts,
    Orientation orientation,
  ) {
    final testState = ts as FirstStateModelSuccess;
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
  }

  Widget successPortrait(
    FirstStateModel ts,
    Orientation orientation,
  ) {
    final testState = ts as FirstStateModelSuccess;

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
  }

  @override
  Widget build(BuildContext context) {
    final testState = ref.watch(firstViewProvider);
    return OrientationBuilder(
      builder: (context, orientation) {
        return widgetMap[orientation]![testState.runtimeType.toString()]!(
          testState,
          orientation,
        );
        // switch (testState) {
        //   case OriginalViewStateWait():
        //     return wait(testState);
        //   case OriginalViewStateLoading():
        //     return loading(testState);
        //   case OriginalViewStateSuccess():
        //     return success(testState, orientation: orientation);
        //   case OriginalViewStateError():
        //     return error(testState);
        // }
      },
    );
  }
}
