import 'package:data/data/user/datasource/model/response/res_user_model.dart';

abstract class UserDataSource {
  Future<List<ResUserModel>> users({required int memberNo});
}
