import 'package:data/sample/user/repository/base_user_repository.dart';
import 'package:domain/sample/login/login_usecase.dart';
import 'package:domain/sample/login/model/login_user_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final BaseUserRepository _repository;

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
