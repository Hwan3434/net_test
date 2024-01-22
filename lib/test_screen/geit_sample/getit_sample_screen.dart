import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/geit_sample/getit_screen_state.dart';
import 'package:net_test/test_screen/test_sample/sample_data_model.dart';

class GetItScreen extends ConsumerStatefulWidget {
  const GetItScreen({super.key});

  @override
  ConsumerState<GetItScreen> createState() => _GetItScreenState();
}

class _GetItScreenState extends ConsumerState<GetItScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    ref.read(sampleViewModelProvider.notifier).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final testState = ref.watch(sampleViewModelProvider);

    return Center(
      child: Text(
        '가져온 사용자 : ${testState.title} - ${testState.description}',
      ),
    );

    // switch (testState) {
    //   case GetItScreenStateError():
    //     return Center(
    //       child: Text(
    //         '데이터를 불러오는데 실패하였습니다.',
    //       ),
    //     );
    //   case GetItScreenStateWait():
    //     return Center(
    //       child: Text(
    //         '대기중',
    //       ),
    //     );
    //   case GetItScreenStateLoading():
    //     return Center(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             '사용자 데이터를 가져오는 중입니다.',
    //           ),
    //           CircularProgressIndicator()
    //         ],
    //       ),
    //     );
    //   case GetItScreenStateSuccess():
    //     return Center(
    //       child: Text(
    //         '가져온 사용자 : ${testState.title} - ${testState.description}',
    //       ),
    //     );
    // }
  }
}
