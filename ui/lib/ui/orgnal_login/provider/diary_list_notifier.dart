import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/orgnal_login/provider/global/data/org_data_provider.dart';

import '../../../test/log.dart';
import '../../diary/data/diary_data.dart';
import '../../diary/data/diary_model.dart';

class DiaryListStateNotifier extends StateNotifier<DiaryListState> {
  final UserUseCase _userUseCase;
  DiaryListStateNotifier(super.state, this._userUseCase) {
    init();
  }

  void init() {
    fetch();
  }

  void add(String content) {
    Log.d('DiaryListStateNotifier Add');
    assert(state is! DiaryListWait);
    assert(state is! DiaryListLoading);
    assert(state is! DiaryListError);
    final pState = state as DiaryListSuccess;
    state = pState.copyWith(
      data: [
        DiaryModel(
            id: 11,
            color: DiaryColor.green,
            date: DateTime.now(),
            content: content,
            fav: false,
            selectedState: false,
            users: [
              DiaryUserModel.jj(),
              DiaryUserModel.gb(),
            ],
            etc: []),
        ...pState.data
      ],
    );
  }

  void fetch() async {
    Log.d('DiaryListStateNotifier Fetch');
    state = DiaryListLoading();
    await Future.delayed(Duration(seconds: 1));
    state = DiaryListSuccess(data: allData.toList());
  }

  void remove() {}
}

sealed class DiaryListState {}

class DiaryListWait extends DiaryListState {}

class DiaryListLoading extends DiaryListState {}

class DiaryListSuccess extends DiaryListState {
  final List<DiaryModel> data;

  DiaryListSuccess({
    required this.data,
  });

  DiaryListSuccess copyWith({
    List<DiaryModel>? data,
  }) {
    return DiaryListSuccess(
      data: data ?? this.data,
    );
  }
}

class DiaryListError extends DiaryListState {}
