import 'package:domain/usecase/user/model/response/user_model.dart';

sealed class OriginalViewStateModel {}

class OriginalViewStateLoading extends OriginalViewStateModel {}

class OriginalViewStateWait extends OriginalViewStateModel {}

class OriginalViewStateSuccess extends OriginalViewStateModel {
  final List<UserModel> data;
  OriginalViewStateSuccess({required this.data});
}

class OriginalViewStateError extends OriginalViewStateModel {
  final String errorMessage;
  OriginalViewStateError({required this.errorMessage});
}
