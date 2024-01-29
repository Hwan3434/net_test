import 'package:data/data/user/datasource/user_datasource.dart';
import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/model/response/user_rres_model.dart';
import 'package:domain/repository/user/model/response/users_rres_model.dart';
import 'package:domain/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  UserRepositoryImpl(this._dataSource);

  @override
  Future<UserRResModel> getUser({required UserRReqModel request}) async {
    return await _dataSource.user(request.userId).then((value) {
      return UserRResModel(
        id: value.id,
        name: value.name,
        username: value.username,
        email: value.email,
      );
    }).catchError((onError, stack) {
      /// Result 클래스로 바꾸면 해결
      return UserRResModel(
        id: 0,
        name: '',
        username: '',
        email: '',
      );
    });
  }

  @override
  Future<List<UsersRResModel>> getUsers(
      {required UsersRReqModel request}) async {
    return await _dataSource.users().then((value) {
      return value.map((e) => UsersRResModel(id: e.id, name: e.name)).toList();
    }).catchError((onError) {
      return (List.empty() as List<UsersRResModel>);
    });
  }
}
