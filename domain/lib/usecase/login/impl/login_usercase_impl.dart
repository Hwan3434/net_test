import 'package:domain/repository/user_repository.dart';
import 'package:domain/usecase/login/login_usecase.dart';
import 'package:domain/usecase/login/res_model/login_user_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final UserRepository _repository;

  LoginUseCaseImpl(this._repository);

  @override
  Future<List<LoginUserModel>> loginUsers({
    required int memberNo,
  }) {
    return _repository.getUsers(memberNo: 3).then((value) {
      return value;
    }).catchError((error) {
      throw error;
    });
  }
}
