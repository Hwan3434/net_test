import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/change_last/base/base_widget.dart';
import 'package:ui/ui/change_last/data/last_data.dart';
import 'package:ui/ui/change_last/setting/last_setting_view_notifier.dart';

import 'last_view_model.dart';

final lastViewProvider = CreateBaseProvider.createViewNotifierProvider<
    LastViewNotifier, LastViewModel>((ref) {
  return LastViewNotifier();
});

class LastViewNotifier extends StateNotifier<LastViewModel> {
  LastViewNotifier() : super(LastViewModel(currentTab: LastTabs.content));
  void update(LastTabs tab) {
    state = state.copyWith(currentTab: tab);
  }

  void removeDiaryData(int id, WidgetRef ref) {
    ref.read(lastSettingViewProvider.notifier).removeDiaryData(1); // 복사본을 삭제
    ref.read(lastDiaryDataProvider.notifier).deleteItem(1); // 원본을 삭제
  }
}
