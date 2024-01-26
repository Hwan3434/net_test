import 'package:domain/usecase/login/res_model/login_user_model.dart';

abstract interface class LoginUseCase {
  Future<List<LoginUserModel>> loginUsers({
    required int memberNo,
  });
}
