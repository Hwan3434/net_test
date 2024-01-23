import 'package:data/data/user/datasource/model/response/res_user_model.dart';

abstract interface class UserRepository {
  Future<List<ResUserModel>> getUsers();
}
