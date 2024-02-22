import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_last/base/base_watch_widget.dart';
import 'package:ui/ui/change_last/base/base_widget.dart';
import 'package:ui/ui/change_last/common/last_diary_list_widget.dart';
import 'package:ui/ui/change_last/common/last_user_list_widget.dart';
import 'package:ui/ui/change_last/content/last_content_view_notifier.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

import 'last_content_view_model.dart';

class LastContentView extends BaseStatelessWidget<LastContentViewNotifier,
    LastContentViewModelState> {
  const LastContentView();

  @override
  AutoDisposeStateNotifierProvider<LastContentViewNotifier,
      LastContentViewModelState> get notifierProvider {
    return lastContentViewProvider;
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    Log.w('컨텐츠 - 메인 화면 빌드');
    final viewModel = ref.watch(notifierProvider);
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            final users =
                ref.read(lastContentViewProvider.notifier).fetchUserModels();
          },
          child: Text("Content 유저 가져오기"),
        ),
        _DiaryStateWidget(state: viewModel),
        SizedBox(
          height: 30,
        ),
        _UserStateView(),
      ],
    );
  }
}

class _DiaryStateWidget extends StatelessWidget {
  final LastContentViewModelState state;
  const _DiaryStateWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LastContentViewModelLoading():
        return Text('Loading...');
      case LastContentViewModelError():
        return Text('error');
      case LastContentViewModelSuccess():
        return _DiaryStateView();
    }
  }
}

class _DiaryStateView extends BaseWatchStatelessWidget<List<DiaryModel>> {
  const _DiaryStateView();
  @override
  ProviderListenable<List<DiaryModel>> get watchProvider =>
      lastContentViewProvider.select((value) {
        assert(value is LastContentViewModelSuccess);
        final pState = value as LastContentViewModelSuccess;
        return pState.diaryItems;
      });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    List<DiaryModel> viewModel,
  ) {
    Log.w('컨텐츠 - 다이어리 화면 빌드');
    return LastDiaryListWidget(data: viewModel);
  }
}

class _UserStateView
    extends BaseWatchStatelessWidget<LastContentViewUserModelState> {
  _UserStateView();
  @override
  ProviderListenable<LastContentViewUserModelState> get watchProvider =>
      lastContentViewProvider.select((value) {
        assert(value is LastContentViewModelSuccess);
        final pState = value as LastContentViewModelSuccess;
        return pState.userModelState;
      });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    LastContentViewUserModelState viewModel,
  ) {
    Log.w('컨텐츠 - 사용자 리스트 화면 빌드');
    switch (viewModel) {
      case LastContentViewUserModelWait():
        return Text('사용자 리스트 대기중(Content)');
      case LastContentViewUserModelLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case LastContentViewUserModelSuccess(users: final users):
        return LastUserListWidget(data: users);
      case LastContentViewUserModelError():
        return Text('사용자 불러오기 에러');
    }
  }
}
