import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/app_global_current_provider.dart';
import 'package:net_test/manager/usecase_provider_manager.dart';
import 'package:net_test/test_screen/provider/provider_page_model.dart';
import 'package:net_test/test_screen/provider/provider_page_provider.dart';

class ProviderPage extends ConsumerStatefulWidget {
  const ProviderPage({
    super.key,
  });

  @override
  ConsumerState<ProviderPage> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends ConsumerState<ProviderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('ProviderScreen build');
    final testState = ref.watch(providerPageProvider);
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
                    .read(currentProvider.notifier)
                    .update((state) => state.copyWith(service: 'typicode'));

                ref
                    .read(
                        UsecaseProviderManager().usecaseStateProvider.notifier)
                    .update(service: 'typicode');
              },
            ),
          ],
        );
      case ProviderScreenModelSuccess():
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '(복사 후 화면 갱신) 가져온 사용자 : ${testState.loginUserList.length}',
              ),
            ),
            ElevatedButton(
              child: Text('서비스 변경'),
              onPressed: () {
                ref
                    .read(currentProvider.notifier)
                    .update((state) => state.copyWith(service: 'typicode'));

                ref
                    .read(
                        UsecaseProviderManager().usecaseStateProvider.notifier)
                    .update(service: 'typicode');
              },
            ),
          ],
        );
    }
  }
}
