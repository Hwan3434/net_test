import 'package:domain/usecase/login/model/login_user_model.dart';

abstract interface class LoginUseCase {
  Future<List<LoginUserModel>> loginUsers();
}
