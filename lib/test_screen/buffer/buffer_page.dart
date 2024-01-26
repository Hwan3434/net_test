import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/test_screen/buffer/buffer_page_model.dart';
import 'package:net_test/test_screen/buffer/buffer_page_provider.dart';

class BufferPage extends ConsumerStatefulWidget {
  const BufferPage({super.key});

  @override
  ConsumerState<BufferPage> createState() => _BufferScreenState();
}

class _BufferScreenState extends ConsumerState<BufferPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DataStateWidget(),
        BufferStateWidget(),
      ],
    );
  }
}

class DataStateWidget extends ConsumerWidget {
  const DataStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState =
        ref.watch(bufferPageProvider.select((value) => value.data));
    switch (testState) {
      case BufferPageStateWait():
        return Center(
          child: Text(
            '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${AppConst.delay.inSeconds}초 딜레이)\r\nbuffer',
          ),
        );
      case BufferPageStateLoading():
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
      case BufferPageStateError():
        return const Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.',
          ),
        );
      case BufferPageStateSuccess():
        return const Center(
          child: Text(
            '데이터 문제 없음',
          ),
        );
    }
  }
}

class BufferStateWidget extends ConsumerWidget {
  const BufferStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(
        bufferPageProvider.select((value) => value.bufferUserUpdateState));
    debugPrint('SuccessWidget call!');
    switch (testState) {
      case WaitBufferUpdate():
        return Center(
          child: Text("Wait !!"),
        );
      case SuccessBufferUpdate(data: final data):
        return Center(
          child: Text(
            '(참조 화면갱신 - Flag변수) 가져온 사용자 : ${data.length}',
          ),
        );
      case FailBufferUpdate():
        return Center(
          child: Text("Faill!!"),
        );
      case LoadingBufferUpdate():
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
