import 'package:data/data/user/repository/user_repository.dart';
import 'package:domain/usecase/login/login_usecase.dart';

import '../model/login_user_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final UserRepository _repository;

  LoginUseCaseImpl(this._repository);

  @override
  Future<List<LoginUserModel>> loginUsers() {
    return _repository.getUsers().then((value) {
      return value.map((e) => LoginUserModel.fromDataModel(dataModel: e)).toList();
    }).catchError((error) {
      throw error;
    });
  }
}
