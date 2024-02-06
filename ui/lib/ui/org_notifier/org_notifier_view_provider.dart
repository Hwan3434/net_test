import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/get_it.dart';
import 'package:ui/test/user_data_provider.dart';

import 'org_notifier_view_model.dart';

final orgNotifierViewProvider = StateNotifierProvider.autoDispose<
    _OrgNotifierViewNotifier, OrgNotifierStateModel>((ref) {
  return _OrgNotifierViewNotifier();
});

class _OrgNotifierViewNotifier extends StateNotifier<OrgNotifierStateModel> {
  final _userUsecase = locator<UserUseCase>();
  final _userDataNotifier = locator<UserDataNotifier>();
  _OrgNotifierViewNotifier() : super(OrgNotifierStateModelWait()) {
    _init();
  }

  void _init() {
    _userDataNotifier.addListener(_updateState);
    if (_userDataNotifier.size != 0) {
      state = OrgNotifierStateModelSuccess(data: _userDataNotifier.data);
    } else {
      callUsers();
    }
  }

  void _updateState() {
    state = OrgNotifierStateModelSuccess(data: _userDataNotifier.data);
  }

  void callUsers() async {
    state = OrgNotifierStateModelLoading();
    await Future.delayed(const Duration(seconds: 2));
    final users = await _userUsecase.getUsers();
    _userDataNotifier.addAll(users);
  }

  void delete(int i) async {
    _userDataNotifier.delete(i);
  }

  @override
  void dispose() {
    super.dispose();
    _userDataNotifier.removeListener(_updateState);
  }
}
