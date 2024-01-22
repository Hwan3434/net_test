import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state_view_model.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

const searchKey = 'testKey';

class BufferScreen extends ConsumerStatefulWidget {
  const BufferScreen({super.key});

  @override
  ConsumerState<BufferScreen> createState() => _BufferScreenState();
}

class _BufferScreenState extends ConsumerState<BufferScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    /// select하면 좋은데 중요한건 어미의 상태 변화는 읽지못함 !
    final testState = ref.watch(bufferScreenViewModelProvider
        .select((value) => value.treeState));
    switch (testState) {
      case WaitBufferUpdate():
        return Center(
          child: Text(
            '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${delay.inSeconds}초 딜레이)\r\nbuffer',
          ),
        );
      case SuccessBufferUpdate():
        return Builder(builder: (context) {
          final treeData = testState.tree
              .treeManager
              .data[searchKey]
              ?.children;
          return Center(
            child: Text(
              '(참조 화면갱신 - Flag변수) 가져온 사용자 : ${treeData?.length}\r\nFlag State - ${testState.toString()}',
            ),
          );
        });
      case FailBufferUpdate():
        return const Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.',
          ),
        );
    }
  }
}
