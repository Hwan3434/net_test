import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_view.dart';
import 'package:net_test/user_screen/user_view/provider/provider_view_model.dart';
import 'package:net_test/user_screen/user_view/provider/provider_view_provider.dart';

class ProviderView extends ConsumerStatefulWidget {
  const ProviderView({
    super.key,
  });

  @override
  ConsumerState<ProviderView> createState() => _ProviderViewState();
}

abstract class BaseView<T extends ConsumerStatefulWidget, M>
    extends ConsumerState<T> {
  late final Map<
      Orientation,
      Map<
          String,
          Widget Function(
            M,
            Orientation,
          )>> _widgetMap = {
    Orientation.portrait: {},
    Orientation.landscape: {}
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
    _widgetMap[Orientation.portrait]![model.runtimeType.toString()] =
        portraitFunc;
    _widgetMap[Orientation.landscape]![model.runtimeType.toString()] =
        landscapeFunc ?? portraitFunc;
  }

  @protected
  void setPortrait(
      dynamic model,
      Widget Function(
        M,
        Orientation,
      ) func) {
    _widgetMap[Orientation.portrait]![model.runtimeType.toString()] = func;
  }

  @protected
  void setLandscape(
      dynamic model,
      Widget Function(
        M,
        Orientation,
      ) func) {
    _widgetMap[Orientation.landscape]![model.runtimeType.toString()] = func;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.initializeWidgetMap();
  }
}

class _ProviderViewState extends BaseView<ProviderView, ProviderViewModel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initializeWidgetMap() {
    buildAll(ProviderViewModelWait(), portraitFunc: wait);
    buildAll(ProviderViewModelLoading(), portraitFunc: loading);
    buildAll(ProviderViewModelError(), portraitFunc: error);
    buildAll(ProviderScreenModelSuccess(),
        portraitFunc: successPortrait, landscapeFunc: success);
  }

  Widget loading(
    ProviderViewModel testState,
    Orientation orientation,
  ) {
    return Center(
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
    ProviderViewModel testState,
    Orientation orientation,
  ) {
    return Center(
      child: Text(
        '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${AppConst.delay.inSeconds}초 딜레이)\r\nProvider',
      ),
    );
  }

  Widget error(
    ProviderViewModel testState,
    Orientation orientation,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.',
          ),
        ),
        ElevatedButton(
          child: Text('서비스 변경'),
          onPressed: () {
            ref
                .read(DataManager().usecaseStateProvider.notifier)
                .update(service: 'typicode');
          },
        ),
      ],
    );
  }

  Widget success(
    ProviderViewModel ts,
    Orientation orientation,
  ) {
    final testState = ts as ProviderScreenModelSuccess;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: testState.loginUserList.length,
        itemBuilder: (context, index) {
          final item = testState.loginUserList[index];
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return UserDetailView(userId: item.id);
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '(id: ${item.id}) ${item.name} 가로',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget successPortrait(
    ProviderViewModel ts,
    Orientation orientation,
  ) {
    final testState = ts as ProviderScreenModelSuccess;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: testState.loginUserList.length,
        itemBuilder: (context, index) {
          final item = testState.loginUserList[index];
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return UserDetailView(userId: item.id);
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '(id: ${item.id}) ${item.name}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final testState = ref.watch(providerViewProvider);

    return OrientationBuilder(
      builder: (context, orientation) {
        return _widgetMap[orientation]![testState.runtimeType.toString()]!(
          testState,
          orientation,
        );
        // switch (testState) {
        //   case ProviderViewModelLoading():
        //     return loading(testState);
        //   case ProviderViewModelWait():
        //     return wait(testState);
        //   case ProviderViewModelError():
        //     return error(testState);
        //   case ProviderScreenModelSuccess():
        //     return success(testState, orientation: orientation);
        // }
      },
    );
  }
}
