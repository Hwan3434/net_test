import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/test_screen/test_screen_state.dart';
import 'package:net_test/test_screen/test_screen_state_container.dart';

class TestScreen extends ConsumerWidget {
  final String title;
  const TestScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Builder(builder: (context) {
        final testState = ref.watch(testScreenStateContainerProvider);

        if (testState is TestScreenStateError) {
          return const Center(
            child: Text(
              '데이터를 불러오는데 실패하였습니다.',
            ),
          );
        }
        if (testState is TestScreenStateWait) {
          return const Center(
            child: Text(
              '플롯팅버튼을 눌러서 사용자데이터를 가져오세요.',
            ),
          );
        }

        if (testState is TestScreenStateLoading) {
          return const Center(
            child: Text(
              '사용자 데이터를 가져오는 중입니다.',
            ),
          );
        }

        if (testState is TestScreenStateSuccess) {
          return Center(
            child: Text(
              '가져온 사용자 : ${testState.loginUserList.length}',
            ),
          );
        }

        throw Exception('존재 할 수 없는 상태입니다. : ${testState.runtimeType}');
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('플로팅버튼 클릭');
          ref.read(testScreenStateContainerProvider.notifier).fetchData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
