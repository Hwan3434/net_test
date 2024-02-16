import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/diary/data/diary_data.dart';
import 'package:ui/ui/diary/data/diary_model.dart';

final lastDiaryDataProvider =
    StateNotifierProvider<_DiaryDataNotifier, Set<DiaryModel>>((ref) {
  return _DiaryDataNotifier(allData.toSet());
});

class _DiaryDataNotifier extends StateNotifier<Set<DiaryModel>> {
  _DiaryDataNotifier(super.state);

  void addItem({required DiaryModel model}) {
    state = {model, ...state};
  }

  void deleteItem(int id) {
    state.removeWhere((element) => element.id == id);
    state = {...state};
  }

  void changedItem({required DiaryModel model}) {
    state = state.map((e) {
      if (e.id == model.id) {
        return model;
      }
      return e;
    }).toSet();
  }
}
