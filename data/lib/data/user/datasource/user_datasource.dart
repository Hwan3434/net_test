import 'model/response/user_dres_model.dart';
import 'model/response/users_dres_model.dart';

abstract class UserDataSource {
  Future<UserDResModel> user(int userId);
  Future<List<UsersDResModel>> users();
}
