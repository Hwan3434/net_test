import 'package:dio/dio.dart';

import 'model/response/user_dres_model.dart';
import 'model/response/users_dres_model.dart';

abstract class UserDataSource {
  Future<UserDResModel> user(Options options, int userId);
  Future<List<UsersDResModel>> users();
}
