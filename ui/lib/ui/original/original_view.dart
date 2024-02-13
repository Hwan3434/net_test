import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/user_use_case.dart';

import 'original_view_model.dart';
import 'original_view_notifier.dart';

class OriginalView extends ConsumerStatefulWidget {
  OriginalView({
    super.key,
  });

  final _originalViewProvider = StateNotifierProvider.autoDispose<
      OriginalViewNotifier, OriginalViewStateModel>((ref) {
    final userUseCase = ref.read(userUsecaseProvider);
    return OriginalViewNotifier(userUseCase);
  });

  @override
  ConsumerState<OriginalView> createState() => _OriginalViewState();
}

class _OriginalViewState extends ConsumerState<OriginalView> {
  @override
  Widget build(BuildContext context) {
    final testState = ref.watch(widget._originalViewProvider);
    switch (testState) {
      case OriginalViewStateLoading():
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
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'wait',
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(widget._originalViewProvider.notifier).fetchData();
                },
                child: Text('유저 가져오기'),
              )
            ],
          ),
        );
      case OriginalViewStateError(errorMessage: final error):
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
