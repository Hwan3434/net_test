import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/model/response/user_rres_model.dart';
import 'package:domain/repository/user/model/response/users_rres_model.dart';

abstract interface class UserRepository {
  Future<UserRResModel> getUser({required UserRReqModel request});
  Future<List<UsersRResModel>> getUsers({required UsersRReqModel request});
}
