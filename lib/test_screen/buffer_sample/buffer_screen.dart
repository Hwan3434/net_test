import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state_view_model.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

const searchKey = 'testKey';

class BufferScreen extends ConsumerWidget {
  final String title;

  const BufferScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(bufferScreenViewModelProvider);
    switch(testState){
      case BufferScreenStateError():
        return Center(
          child: Text(
            '데이터를 불러오는데 실패하였습니다.',
          ),
        );
      case BufferScreenStateWait():
        return Center(
          child: Text(
            '💥목표 : tree복사 → tree참조로 → 화면갱신까지💥\r\n플롯팅버튼을 눌러서 사용자데이터를 가져오세요.(${delay.inSeconds}초 딜레이)',
          ),
        );
      case BufferScreenStateLoading():
        return Center(
          child: Text(
            '사용자 데이터를 가져오는 중입니다.',
          ),
        );
      case BufferScreenStateSuccess():
        return Builder(
            builder: (context) {
              final data = UserManagerBufferSingleton().treeManager.data[searchKey]?.children;
              return Center(
                child: Text(
                  '주소 참조 상태 : ${testState.isUserUpdateState} 가져온 사용자 : ${data?.length}',
                ),
              );
            }
        );
    }
  }
}
