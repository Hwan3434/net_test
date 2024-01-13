import 'package:domain/sample/login/model/login_user_model.dart';

abstract interface class LoginUseCase {
  Future<List<LoginUserModel>> loginUsers();
}
