import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/log.dart';
import 'package:ui/test/user_use_case.dart';

import 'original_view_model.dart';
import 'original_view_notifier.dart';

final lifeTestProvider = StateProvider((ref) {
  return 0;
});

class OriginLifeTest extends StatelessWidget {
  OriginLifeTest({super.key}) {
    Log.d('OriginLifeTest 생성자');
  }

  @override
  StatelessElement createElement() {
    Log.d('OriginLifeTest createElement');
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    Log.d('OriginLifeTest 빌드');
    return _LifeTestConsumerWidget();
  }
}

class _LifeTestConsumerWidget extends ConsumerWidget {
  int i = 0;
  _LifeTestConsumerWidget() {
    Log.d('_LifeTestConsumerWidget 생성자');
  }

  @override
  ConsumerStatefulElement createElement() {
    Log.d('_LifeTestConsumerWidget createElement');
    return super.createElement();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('_LifeTestConsumerWidget 빌드');
    i = ref.watch(lifeTestProvider);
    return Center(
      child: MaterialButton(
        child: Text('현재카운트 : $i'),
        onPressed: () {
          ref.read(lifeTestProvider.notifier).update((state) => ++i);
        },
      ),
    );
  }
}

class WraaperOriginWidget extends StatefulWidget {
  WraaperOriginWidget({
    super.key,
  }) {
    Log.d('WraaperOriginWidget 생성자');
  }

  @override
  StatefulElement createElement() {
    return super.createElement();
  }

  @override
  State<WraaperOriginWidget> createState() => _WraaperOriginWidgetState();
}

class _WraaperOriginWidgetState extends State<WraaperOriginWidget> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                i++;
              });
            },
            child: Text('set : $i'),
          ),
          OriginalView()
        ],
      ),
    );
  }
}

final originalViewProvider = StateNotifierProvider.autoDispose<
    OriginalViewNotifier, OriginalViewStateModel>((ref) {
  Log.e('_originalViewProvider call');
  final userUseCase = ref.read(userUsecaseProvider);
  return OriginalViewNotifier(userUseCase);
});

class OriginalView extends ConsumerStatefulWidget {
  OriginalView({
    super.key,
  }) {
    Log.d('OriginalView 생성자');
  }

  @override
  ConsumerStatefulElement createElement() {
    Log.e('createElement ~~~~~ ');
    return super.createElement();
  }

  @override
  ConsumerState<OriginalView> createState() {
    Log.e('CreateState !!!! ');
    return _OriginalViewState();
  }
}

class _OriginalViewState extends ConsumerState<OriginalView> {
  _OriginalViewState() {
    Log.d('OriginalView state 생성자');
  }

  @override
  void initState() {
    super.initState();
    Log.d('OriginalView state InitState');
  }

  @override
  void didUpdateWidget(covariant OriginalView oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.d('OriginalView state didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    Log.d('OriginalView state dispose');
  }

  @override
  void activate() {
    super.activate();
    Log.d('OriginalView state activate');
  }

  @override
  Widget build(BuildContext context) {
    Log.w('OriginalView state 빌드 _ Start');
    final testState = ref.watch(originalViewProvider);

    switch (testState) {
      case OriginalViewStateLoading():
        Log.d('OriginalView state 빌드 _ Loading');
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
      case OriginalViewStateWait():
        Log.d('OriginalView state 빌드 _ Wait');
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'wait',
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(originalViewProvider.notifier).fetchData();
                },
                child: Text('유저 가져오기'),
              )
            ],
          ),
        );
      case OriginalViewStateError(errorMessage: final error):
        Log.d('OriginalView state 빌드 _ Error');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '유저를 불러오는데 실패하였습니다. $error',
              ),
            ),
          ],
        );
      case OriginalViewStateSuccess(data: final user):
        Log.d('OriginalView state 빌드 _ Success');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '가져온 사용자 : \r\n${user.map((e) => 'name : ${e.name}').join(', \r\n')}',
              ),
            ),
          ],
        );
    }
  }
}
