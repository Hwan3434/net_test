import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/test_screen/provider/provider_screen_model.dart';
import 'package:net_test/test_screen/provider/provider_screen_state_view_model.dart';
import 'package:net_test/test_screen/test_screen.dart';

class ProviderScreen extends ConsumerStatefulWidget {

  const ProviderScreen({
    super.key,
  });

  @override
  ConsumerState<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends ConsumerState<ProviderScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final testState = ref.watch(providerScreenProvider);
    switch (testState) {
      case ProviderScreenModelLoading():
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
      case ProviderScreenModelWait():
        return Center(
          child: Text(
            '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${AppConst.delay.inSeconds}초 딜레이)\r\nProvider',
          ),
        );
      case ProviderScreenModelError():
        return const Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.',
          ),
        );
      case ProviderScreenModelSuccess():
        return Center(
          child: Text(
            '(복사 후 화면 갱신) 가져온 사용자 : ${testState.loginUserList.length}',
          ),
        );
    }
  }
}
