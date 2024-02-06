import 'package:data/data/user/datasource/impl/remote_user_datasource_impl.dart';
import 'package:data/data/user/repository/impl/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/usecase/user/impl/user_usercase_impl_2.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/ui/original/original_view_model.dart';

final originalViewProvider = StateNotifierProvider.autoDispose<
    _OriginalViewStateNotifier, OriginalViewStateModel>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
  final remoteDataSource = RemoteUserDataSourceImpl(dio);
  final repositoryImpl = UserRepositoryImpl(remoteDataSource);
  final userUsecase = UserUseCaseImpl2(repositoryImpl);
  return _OriginalViewStateNotifier(userUsecase);
});

class _OriginalViewStateNotifier extends StateNotifier<OriginalViewStateModel> {
  final UserUseCase _userUsecase;
  _OriginalViewStateNotifier(this._userUsecase)
      : super(OriginalViewStateWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = OriginalViewStateLoading();

    await _userUsecase.getUsers().then((value) {
      state = OriginalViewStateSuccess(data: value);
    }).catchError((onError) {
      state = OriginalViewStateError(errorMessage: onError);
    });
  }
}
