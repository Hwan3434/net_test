import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/provider_sample/provider_screen_state_view_model.dart';
import 'package:net_test/test_screen/test_screen.dart';

class ProviderOtherScreen extends ConsumerStatefulWidget {
  const ProviderOtherScreen({super.key});

  @override
  ConsumerState<ProviderOtherScreen> createState() =>
      _ProviderOtherScreenState();
}

class _ProviderOtherScreenState extends ConsumerState<ProviderOtherScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future:
          ref.read(providerScreenViewModelProvider.notifier).otherFetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              '데이터를 불러오는데 실패하였습니다.',
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n사용자 데이터를 바로 가져옵니다!(${delay.inSeconds}초 딜레이)\r\nfutrueBuilder',
                ),
                CircularProgressIndicator()
              ],
            ),
          );
        }

        return Center(
          child: Text(
            '가져온 사용자 : ${snapshot.requireData.length}',
          ),
        );
      },
    );
  }
}
