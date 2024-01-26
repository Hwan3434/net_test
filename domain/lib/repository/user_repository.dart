import 'package:domain/usecase/login/res_model/login_user_model.dart';

abstract interface class UserRepository {
  Future<List<LoginUserModel>> getUsers({required int memberNo});
}
