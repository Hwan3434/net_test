import 'package:data/common/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_last/base/base_watch_widget.dart';
import 'package:ui/ui/change_last/common/last_diary_list_widget.dart';
import 'package:ui/ui/change_last/common/last_user_list_widget.dart';

import '../base/base_widget.dart';
import 'last_setting_view_model.dart';
import 'last_setting_view_notifier.dart';

class LastSettingView
    extends BaseStatelessWidget<LastSettingViewNotifier, LastSettingViewModel> {
  const LastSettingView({super.key});

  @override
  AutoDisposeStateNotifierProvider<LastSettingViewNotifier,
      LastSettingViewModel> get notifierProvider => lastSettingViewProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.i('세팅 - 전체화면 화면 빌드');
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () {
                ref.read(notifierProvider.notifier).fetchUser();
              },
              child: Text("Setting 유저 가져오기"),
            );
          },
        ),
        _DiaryStateView(),
        SizedBox(
          height: 30,
        ),
        _UserStateView()
      ],
    );
  }
}

class _DiaryStateView
    extends BaseWatchStatelessWidget<LastSettingsViewDiaryModelState> {
  const _DiaryStateView();

  @override
  ProviderListenable<LastSettingsViewDiaryModelState> get watchProvider =>
      lastSettingViewProvider.select((value) => value.diaryState);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    LastSettingsViewDiaryModelState viewModel,
  ) {
    Log.i('세팅 - 다이어리 리스트 화면 빌드');
    switch (viewModel) {
      case LastSettingsViewDiaryModelWait():
        return Text('LastSettingsViewDiaryModelWait 1');
      case LastSettingsViewDiaryModelLoading():
        return Text('LastSettingsViewDiaryModelLoading 2');
      case LastSettingsViewDiaryModelSuccess(diaryModels: final data):
        return LastDiaryListWidget(data: data);
      case LastSettingsViewDiaryModelError():
        return Text('LastSettingsViewDiaryModelError 4');
    }
  }
}

class _UserStateView
    extends BaseWatchStatelessWidget<LastSettingsViewUserModelState> {
  const _UserStateView();

  @override
  ProviderListenable<LastSettingsViewUserModelState> get watchProvider =>
      lastSettingViewProvider.select((value) => value.userStates);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
    LastSettingsViewUserModelState viewModel,
  ) {
    Log.i('세팅 - 사용자 리스트 화면 빌드');
    switch (viewModel) {
      case LastSettingsViewUserModelWait():
        return Text('사용자 리스트 대기중(Setting)');
      case LastSettingsViewUserModelLoading():
        return Center(
          child: CircularProgressIndicator(),
        );
      case LastSettingsViewUserModelSuccess(users: final users):
        return LastUserListWidget(data: users);
      case LastSettingsViewUserModelError():
        return Text('사용자 불러오기 에러');
    }
  }
}
